from flask import Flask, jsonify, render_template, request
import os
import psycopg2
from psycopg2.extras import RealDictCursor

app = Flask(__name__)
app.config['TEMPLATES_AUTO_RELOAD'] = True

def get_db_connection():
    try:
        conn = psycopg2.connect(
            host=os.getenv("DB_HOST", "localhost"),
            port=os.getenv("DB_PORT", "5432"),
            database=os.getenv("DB_NAME", "tarea1"),
            user=os.getenv("DB_USER", "postgres"),
            password=os.getenv("DB_PASSWORD", "postgres"),
            cursor_factory=RealDictCursor
        )
        return conn
    except Exception as e:
        print(f"Error conectando a la base de datos: {e}")
        return None

@app.route('/')
@app.route('/index')
def index():
    return render_template('index.html')

@app.route('/search')
def datos():
    data =  request.args.get('data')
    if data == None:
        return render_template('search.html', lista_datos=None)
    
    conn = get_db_connection()
    with conn:
        with conn.cursor() as cur:
            cur.execute('''
                        SELECT DISTINCT E.nombre, E.fecha_creacion, E.capitan, ET.nombre_torneo
                        FROM EQUIPO E JOIN ESTA_EN_TORNEO ET ON E.nombre = ET.nombre_equipo
                        WHERE E.nombre = %s;''',(data,))
            datos_db = cur.fetchall()
            if datos_db ==[]:
    
                cur.execute('''
                            SELECT DISTINCT J.gamertag , J.nombre, E.nombre AS nombre_equipo, 
                                CASE
                                    WHEN J.gamertag = E.capitan THEN 1
                                    ELSE 0
                                END AS es_capitan, J.fecha_nacimiento, J.email, J.pais_origen
                            FROM JUGADOR J NATURAL JOIN ES_DEL_EQUIPO JE, EQUIPO E
                            WHERE JE.NOMBRE_EQUIPO = E.NOMBRE AND (J.gamertag = %s OR J.pais_origen = %s);''',(data,data))
                datos_db = cur.fetchall()
            if datos_db == []:
                datos_db = "DATA NOT FOUND"
    
    conn.close() 
    return render_template('search.html', lista_datos=datos_db)

@app.route('/Tournaments')
def torneos():
    conn = get_db_connection()
    if conn is None:
        return "Error de conexión a la base de datos", 500
    
    with conn:
        with conn.cursor() as cur:
            cur.execute('SELECT * FROM torneo;')
            datos_db = cur.fetchall()
            
    
    conn.close() 
    return render_template('torneo.html', lista_datos=datos_db)

@app.route('/torneos/<string:id_torneo>')
def torneo(id_torneo):
    conn = get_db_connection()
    with conn.cursor() as cur:
        cur.execute('''
                    SELECT P."id", P.nombre_equipo1, P.puntaje_equipo1, P.nombre_equipo2, P.puntaje_equipo2, P.inicio
                    FROM Partida AS P 
                    WHERE P.nombre_torneo = %s; ''', (id_torneo,))
        datos_partidas = cur.fetchall()
        cur.execute('''
                    SELECT E.nombre AS Equipos_Inscritos, E.capitan AS Capitan, E.fecha_creacion
                    FROM Esta_en_torneo AS ET
                    JOIN Equipo AS E ON ET.nombre_equipo = E.nombre
                    WHERE ET.nombre_torneo = %s;''', (id_torneo,))
        datos_inscritos = cur.fetchall()
        cur.execute('''
                    SELECT ST.nombre_sponsor, ST.monto AS Monto_aportado, S.industria
                    FROM Sponsor_del_torneo AS ST
                    JOIN Sponsor AS S ON ST.nombre_sponsor = S.nombre
                    WHERE ST.nombre_torneo = %s;''',(id_torneo,))
        datos_sponsors = cur.fetchall()
        
        cur.execute('''
                    SELECT
                        ROW_NUMBER() OVER(PARTITION BY fase ORDER BY puntaje_total DESC) AS ranking,
                        fase,
                        equipo,
                        partidas_jugadas,
                        ganadas,
                        empatadas,
                        perdidas,
                        puntaje_total
                    FROM(
                        SELECT 
                            fase, 
                            equipo,
                            COUNT(*) AS partidas_jugadas,
                            SUM(CASE WHEN puntos_partida = 3 THEN 1 ELSE 0 END) AS ganadas,
                            SUM(CASE WHEN puntos_partida = 1 THEN 1 ELSE 0 END) AS empatadas,
                            SUM(CASE WHEN puntos_partida = 0 THEN 1 ELSE 0 END) AS perdidas,
                            SUM(puntos_partida) AS puntaje_total
                        FROM(
                            SELECT 
                                fase, 
                                nombre_equipo1 AS equipo, 
                                puntaje_equipo1 AS puntos_partida
                            FROM Partida
                            WHERE nombre_torneo = %s AND fase IN ('Grupo A', 'Grupo B')

                            UNION ALL

                            SELECT 
                                fase, 
                                nombre_equipo2 AS equipo, 
                                puntaje_equipo2 AS puntos_partida
                            FROM Partida
                            WHERE nombre_torneo = %s AND fase IN ('Grupo A', 'Grupo B')
                        ) as Resultados
                        GROUP BY fase, equipo
                    ) AS Tabla_intermedia
                    ORDER BY fase, ranking;
                ''', (id_torneo, id_torneo))
        datos_posiciones= cur.fetchall()
    conn.close()
    
    return render_template('basicos.html', partidas=datos_partidas,inscritos=datos_inscritos,sponsors = datos_sponsors, posiciones=datos_posiciones)
@app.route('/stats/<string:id_torneo>')
def stats(id_torneo):
    nombre_equipo = request.args.get('equipo')
    
    conn = get_db_connection()
    with conn.cursor() as cur:

        cur.execute('''
            SELECT nombre_equipo 
            FROM esta_en_torneo 
            WHERE nombre_torneo = %s;
        ''', (id_torneo,))
        lista_equipos = cur.fetchall()
        datos_evolucion = None
        if nombre_equipo:
            cur.execute('''
                        SELECT 
                            EE.gamertag,
                            GRP.kos_grupo, ELI.kos_eliminatorias,
                            GRP.restarts_grupo, ELI.restarts_eliminatorias,
                            GRP.assists_grupo, ELI.assists_eliminatorias
                        FROM es_del_equipo EE 
                            LEFT OUTER JOIN (
                                SELECT EP.gamertag, ROUND(AVG(EP.kos), 2) AS kos_grupo,
                                ROUND(AVG(EP.restarts), 2) AS restarts_grupo,
                                ROUND(AVG(EP.assists), 2) AS assists_grupo
                                FROM partida PTD 
                                JOIN estadisticas_en_partida EP ON EP.id_partida = PTD.id
                                WHERE PTD.fase LIKE '%%Grupo%%' AND PTD.nombre_torneo = %s
                                GROUP BY EP.gamertag
                            ) GRP ON GRP.gamertag = EE.gamertag
                        LEFT OUTER JOIN (
                            SELECT EP.gamertag, ROUND(AVG(EP.kos), 2) AS kos_eliminatorias,
                                ROUND(AVG(EP.restarts), 2) AS restarts_eliminatorias,
                                ROUND(AVG(EP.assists), 2) AS assists_eliminatorias
                            FROM partida PTD 
                            JOIN estadisticas_en_partida EP ON EP.id_partida = PTD.id
                            WHERE (PTD.fase LIKE '%%Semifinal%%' OR PTD.fase LIKE '%%Final%%') 
                            AND PTD.nombre_torneo = %s
                            GROUP BY EP.gamertag
                        ) ELI ON EE.gamertag = ELI.gamertag
                        WHERE EE.nombre_equipo = %s;
                        ''', (id_torneo, id_torneo, nombre_equipo))
            datos_evolucion = cur.fetchall()
            
        cur.execute('''
                    SELECT 
                        EP.gamertag, 
                        EE.nombre_equipo,
                        SUM(EP.kos) AS total_kos,
                        SUM(EP.restarts) AS total_restarts,
                        SUM(EP.assists) AS total_assists,
                        CASE
                            WHEN SUM(EP.restarts) <> 0 THEN ROUND(SUM(EP.kos * 1.0) / SUM(EP.restarts), 2)
                            ELSE 2 * ROUND(SUM(EP.kos * 1.0), 2)
                        END AS ratio
                    FROM es_del_equipo EE, estadisticas_en_partida EP JOIN (
                        SELECT "id"
                        FROM  partida
                        WHERE nombre_torneo = %s
                    ) PTD ON PTD.id = EP.id_partida
                    WHERE EE.gamertag = EP.gamertag
                    GROUP BY EP.gamertag, EE.nombre_equipo
                    HAVING COUNT(*) > 1
                    ORDER BY ratio DESC
                    ''', (id_torneo,)) 
    
        datos_ranking = cur.fetchall()
    conn.close()
    
    return render_template('stats.html', torneo=id_torneo, equipos=lista_equipos, jugadores=datos_evolucion, equipo_seleccionado=nombre_equipo, ranking=datos_ranking)

@app.route('/inscripcion',methods=['GET','POST'])
def inscribirse():
    if request.method == 'GET':
        return render_template('inscribete.html')

    torneo = request.form.get('tournament')
    equipo = request.form.get('team_name')
        
    conn = get_db_connection()
    with conn:
        with conn.cursor() as cur:
            if request.method ==  'POST':
                cur.execute('SELECT max_equipos, fecha_inicio FROM torneo WHERE nombre = %s', (torneo,))
                maxi = cur.fetchone()
                
                if maxi == None:
                    mensaje = "El torneo indicado no existe"
                else:
                    fecha_torneo = maxi['fecha_inicio']
                    cur.execute('SELECT 1 FROM esta_en_torneo WHERE nombre_equipo = %s AND nombre_torneo = %s;',(equipo,torneo))
                    inscrito = cur.fetchone()
                    if inscrito:
                        mensaje = f"El equipo '{equipo}' ya se encuentra inscrito en el torneo por lo que no es posible incribirlo de nuevo '{torneo}'."
                    else:   
                        capacidad = maxi['max_equipos']
                        cur.execute('SELECT COUNT(*) AS total_inscritos FROM esta_en_torneo WHERE nombre_torneo = %s;', (torneo,))
                        resultado = cur.fetchone()
                        inscritos_actuales = resultado['total_inscritos']
                        if inscritos_actuales >= capacidad:
                            mensaje = f"¡Lo sentimos! El torneo '{torneo}' ya alcanzó su límite de {capacidad} equipos."
                        else:
                            cur.execute('INSERT INTO esta_en_torneo VALUES (%s, %s,%s)',(equipo,torneo,fecha_torneo))
                            mensaje = "¡Inscripcion realizada con exito!"
    conn.close()
        
    return render_template('inscribete.html',mensaje=mensaje)
    
@app.route('/videojuegos')
def videojuegos():
    conn = get_db_connection()
    with conn.cursor() as cur:
        cur.execute('SELECT videojuego FROM torneo')
        juego = cur.fetchall()
    conn.close()
    
    return render_template('videojuegos.html', juegos=juego)

@app.route('/sponsors/<string:id_juego>')
def sponsor(id_juego):
    conn = get_db_connection()
    with conn.cursor() as cur:
        cur.execute('''
                    SELECT S2.NOMBRE, S2.INDUSTRIA, SUM(ST2.MONTO) AS monto
                    FROM SPONSOR_DEL_TORNEO AS ST2 JOIN (
                        SELECT S.NOMBRE, S.INDUSTRIA
                        FROM SPONSOR AS S
                        WHERE NOT EXISTS (
                            SELECT 1
                            FROM TORNEO AS TN
                            WHERE TN.VIDEOJUEGO = %s AND NOT EXISTS (
                                 SELECT 1
                                FROM SPONSOR_DEL_TORNEO AS ST
                                WHERE ST.NOMBRE_TORNEO = TN.NOMBRE AND ST.NOMBRE_SPONSOR = S.NOMBRE
                            )
                        )) AS S2 ON ST2.NOMBRE_SPONSOR = S2.NOMBRE 
                    GROUP BY S2.NOMBRE, S2.INDUSTRIA;''', (id_juego,))
        datos_db = cur.fetchall()
    conn.close()
    #falta sponsorhtml y la consulta
    return render_template('sponsors.html', info=datos_db)
    


if __name__ == "__main__":
    print("Servidor corriendo en http://127.0.0.1:8000")
    app.run(host="127.0.0.1", port=8000, debug=True)
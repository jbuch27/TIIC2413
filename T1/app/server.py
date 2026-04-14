from flask import Flask, jsonify, render_template, request
import psycopg2
from psycopg2.extras import RealDictCursor

app = Flask(__name__)
app.config['TEMPLATES_AUTO_RELOAD'] = True

def get_db_connection():
    try:
        conn = psycopg2.connect(
            host="localhost",
            database="tarea1",
            user="postgres",
            password="Fd078bk3!?",
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
                        SELECT DISTINCT E.nombre, E.fecha_creacion, E.capitan, ET.nombre_torneo, ET.fecha_inicio_torneo
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
        
    conn.close()
    
    return render_template('basicos.html', partidas=datos_partidas,inscritos=datos_inscritos,sponsors = datos_sponsors)
@app.route('/stats/<string:id_torneo>')
def stats(id_torneo):
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
        
    conn.close()
    
    return render_template('basicos.html', partidas=datos_partidas,inscritos=datos_inscritos,sponsors = datos_sponsors)

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
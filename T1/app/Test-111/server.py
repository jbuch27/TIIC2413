from flask import Flask, jsonify, render_template, request
from waitress import serve
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
    name = request.args.get('player')
    conn = get_db_connection()
    if conn is None:
        return "Error de conexión a la base de datos", 500
    
    with conn:
        with conn.cursor() as cur:
            cur.execute('SELECT * FROM test;')
            datos_db = cur.fetchall()
    
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

@app.route('/stats/<string:id_torneo>')
def stats(id_torneo):
    conn = get_db_connection()
    with conn.cursor() as cur:
        cur.execute('SELECT * FROM test WHERE columna2= %s;', (id_torneo,))
        datos_especificos = cur.fetchall()
    conn.close()
    
    return render_template('stats.html', info=datos_especificos)

@app.route('/inscripcion')
def inscribirse():
    return render_template('inscribete.html')

@app.route('/videojuegos')
def videojuegos():
    conn = get_db_connection()
    with conn.cursor() as cur:
        cur.execute('SELECT videojuego FROM torneo')
        juego = cur.fetchall()
    conn.close()
    
    return render_template('videojuegos.html', juegos=juego)

@app.route('/videojuegos/<string:id_juego>')
def sponsor(id_juego):
    conn = get_db_connection()
    with conn.cursor() as cur:
        cur.execute('SELECT * FROM test WHERE columna2= %s;', (id_juego,))
        datos_especificos = cur.fetchall()
    conn.close()
    #falta sponsorhtml y la consulta
    return render_template('sponsors.html', info=datos_especificos)
    


if __name__ == "__main__":
    print("Servidor corriendo en http://127.0.0.1:8000")
    #serve(app, host="127.0.0.1", port=8000)
    app.run(host="127.0.0.1", port=8000, debug=True)
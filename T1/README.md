# Tarea 1 - IIC2413 Bases de Datos

## Integrantes
- **Josefa Buch Soto** - 2464692J
- **Matías Salinas Duarte** - 24643459
- **Constanza Venegas** - 24641251

---

## Instrucciones para ejecutar la aplicación

Después de descomprimir el archivo, sigue estos pasos:

### 1. Preparar la Base de Datos (obligatorio)
Asegúrate de haber creado y poblado la base de datos `tarea1` en PostgreSQL:

```bash
createdb -U postgres tarea1
psql -U postgres -d tarea1 -f schema.sql
psql -U postgres -d tarea1 -f data.sql
```
### 2. Crear y activar el entorno virtual (recomendado)
```bash
# Crear el entorno virtual
python -m venv venv
# Activar el entorno virtual:
# → En Windows:
venv\Scripts\activate
# → En Linux / macOS:
# source venv/bin/activate
```

### 3. Ir a la carpeta de la aplicación
```bash
cd .\app\
```

### 4. Ejecutar la aplicación:
```bash
python server.py 
```
### 5. Entrar a la página web
Entrar a http://127.0.0.1:8000 (hacer Ctr + Click o  entrando directamente desde el navegador y escribiendo localhost:8000)
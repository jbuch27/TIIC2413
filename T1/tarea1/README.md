# Tarea 1 - IIC2413 Bases de Datos

## Integrantes
- **Josefa Buch Soto** - 2464692J
- **Matías Salinas Duarte** - 24643459
- **Constanza Venegas** - 24641251

---

## Instrucciones para ejecutar la aplicación

Después de descomprimir el archivo, sigue estos pasos:

### 1. Preparar la Base de Datos
Asegúrate de haber creado y poblado la base de datos `tarea1` en PostgreSQL y ejecutar `schema.sql` y `data.sql`. 
### 2. Ir a la carpeta de la aplicación
```bash
cd tarea1\app\
```

### 3. Descargar librerías
```bash
pip install -r requirements.txt
```
### 4. Configurar la PostgreSQL (en caso de que sea distinta a "postgres")
```bash
# Windows (Command Prompt)
set DB_PASSWORD=tu_contraseña_real

# Windows (PowerShell)
$env:DB_PASSWORD="tu_contraseña_real"

# Linux / macOS
export DB_PASSWORD="tu_contraseña_real"
```

### 5. Ejecutar la aplicación:
```bash
python server.py 
```
Entrar a http://127.0.0.1:8000 (hacer Ctr + Click o  entrando directamente desde el navegador y escribiendo localhost:8000)

## Variables de entorno necesarias
- DB_HOST: localhost
- DB_PORT: 5432
- DB_USER: postgres
- DB_PASSWORD: postgres
- DB_NAME: tarea1
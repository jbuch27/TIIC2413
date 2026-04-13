-- 1. Listar todos los torneos con su información básica
SELECT nombre, videojuego, fecha_inicio, fecha_termino, pozo 
FROM Torneo;


-- 1.1. Tabla de posiciones de la fase de grupos
-- ME FALTA ESTA CONSULTA, DUDA LA MANDÉ A WHATSAPP JIJI

-- 1.2 Partidas (del torneo) jugadas con sus resultados
SELECT P."id", P.nombre_equipo1, P.puntaje_obtenido1, P.nombre_equipo2, P.puntaje_obtenido2, P.inicio
FROM Partida AS P 
WHERE P.nombre_torneo = %s; -- AQUÍ VA LA VARIABLE DEL NOMBRE DEL TORNEO 


-- 1.3.1 Equipos inscritos en el torneo 
-- DEPENDE DEL TORNEO (INPUT) seleccionado
SELECT E.nombre AS Equipos_Inscritos, E.capitan AS Capitan, E.fecha_creacion
FROM Esta_en_torneo AS ET
JOIN Equipo AS E ON ET.nombre_equipo = E.nombre
WHERE ET.nombre_torneo = %s; -- AQUÍ VA LA VARIABLE DEL NOMBRE DEL TORNEO


-- 1.3.2 Sponsors del torneo
-- DEPENDE DEL TORNEO (INPUT) seleccionado
SELECT ST.nombre_sponsor, ST.monto AS Monto_aportado, S.industria
FROM Sponsor_del_torneo AS ST
JOIN Sponsor AS S ON ST.nombre_sponsor = S.nombre
WHERE ST.nombre_torneo = %s; -- AQUÍ VA LA VARIABLE DEL NOMBRE DEL TORNEO
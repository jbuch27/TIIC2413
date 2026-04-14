-- 1. Listar todos los torneos con su información básica
SELECT nombre, videojuego, fecha_inicio, fecha_termino, pozo 
FROM Torneo;


-- 1.1. Tabla de posiciones de la fase de grupos
-- Esta tabla contiene la Fase A/B, #partidas jugadas, #wins, #empates, #derrotas, puntaje_total
-- Quedan juntos por fase, y por grupo

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
        SUM(CASE WHEN puntos_partida = 1 THEN 1 ELSE 0 END) AS empates,
        SUM(CASE WHEN puntos_partida = 0 THEN 1 ELSE 0 END) AS perdidas,
        SUM(puntos_partida) AS puntaje_total
    FROM(
        -- Vista como equipo 1:
        SELECT 
            fase, 
            nombre_equipo1 AS equipo, 
            puntaje_equipo1 AS puntos_partida,

        FROM Partida
        WHERE nombre_torneo = %s AND fase IN ('Grupo A', 'Grupo B')

        UNION ALL

        -- Vista como equipo 2:
        SELECT 
            fase, 
            nombre_equipo2 AS equipo, 
            puntaje_equipo2 AS puntos_partida
        FROM Partida
        WHERE nombre_torneo = %s AND fase IN ('Grupo A', 'Grupo B')) as Resultados
    GROUP BY fase, equipo) AS Tabla_intermedia
    ORDER BY fase, ranking;

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
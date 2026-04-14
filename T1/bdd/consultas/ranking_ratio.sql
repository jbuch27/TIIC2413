-- Dado un torneo, mostrar:

--      Ranking de jugadores ordenado por ratio KOs / restarts, 
--      considerando solo jugadores con al menos 2 partidas en ese torneo.
--      Mostrar gamertag, equipo, total de KOs, restarts, assists y el ratio.

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
    WHERE nombre_torneo = 'T1'
) PTD ON PTD.id = EP.id_partida

WHERE EE.gamertag = EP.gamertag

GROUP BY EP.gamertag, EE.nombre_equipo
HAVING COUNT(*) > 1

ORDER BY ratio DESC
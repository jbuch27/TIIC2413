-- selecciona todos los sponsors que auspician los torneos del juego seleccionado
-- juego sera reemplazado por el juego seleccionado por el usuario

SELECT S2.NOMBRE, S2.INDUSTRIA, SUM(ST2.MONTO)
FROM SPONSOR_DEL_TORNEO AS ST2 JOIN (
    SELECT S.NOMBRE, S.INDUSTRIA
    FROM SPONSOR AS S
    WHERE NOT EXISTS (
        SELECT 1
        FROM TORNEO AS TN
        WHERE TN.VIDEOJUEGO = '%(juego)s' AND NOT EXISTS (
            SELECT 1
            FROM SPONSOR_DEL_TORNEO AS ST
            WHERE ST.NOMBRE_TORNEO = TN.NOMBRE AND ST.NOMBRE_SPONSOR = S.NOMBRE
        )
    )) AS S2 ON ST2.NOMBRE_SPONSOR = S2.NOMBRE 
GROUP BY S2.NOMBRE, S2.INDUSTRIA;
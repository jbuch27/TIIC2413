-- caso busqueda por gamertag
-- atributo puede valer gamertag o pais_origen
-- valor sera el gamertag o  pais_origen por buscar

SELECT J.gamertag , J.nombre, E.nombre AS nombre_equipo, 
    CASE
        WHEN J.gamertag = E.capitan THEN 1
        ELSE 0
    END AS es_capitan, J.fecha_nacimiento, J.email, J.pais_origen
FROM JUGADOR J NATURAL JOIN ES_DEL_EQUIPO JE, EQUIPO E
WHERE JE.NOMBRE_EQUIPO = E.NOMBRE AND J.{atributo} = '%(valor)s' 
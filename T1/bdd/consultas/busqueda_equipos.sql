-- caso buqueda por nombre equipo
-- equipo sera remplazado por el nombre del equipo que queremos buscar

SELECT E.nombre, E.fecha_creacion, E.capitan, ET.nombre_torneo, ET.fecha_inicio_torneo
FROM EQUIPO E JOIN ESTA_EN_TORNEO ET ON E.nombre = ET.nombre_equipo
WHERE E.nombre = '%(equipo)s'
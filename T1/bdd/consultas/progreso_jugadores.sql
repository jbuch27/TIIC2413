-- Dado un torneo, mostrar:

--      Evolucion por fase de un equipo seleccionable: 
--      comparar las estadisticas promedio por jugador (KOs, restarts, assists)
--      en fase de grupos vs. fases eliminatorias (semifinal + final).

-- gamertag, kos grupos, kos eliminatorias, restarts grupos, restarts eliminatorias, assists grupos, assists eliminatorias

SELECT 
	EE.gamertag,
	GRP.kos_grupo,
	ELI.kos_eliminatorias,
	GRP.restarts_grupo,
	ELI.restarts_eliminatorias,
	GRP.assists_grupo,
	ELI.assists_eliminatorias

FROM es_del_equipo EE 
	LEFT OUTER JOIN (
		SELECT 
			EP.gamertag,
			ROUND(AVG(EP.kos), 2) AS kos_grupo,
			ROUND(AVG(EP.restarts), 2) AS restarts_grupo,
			ROUND(AVG(EP.assists), 2) AS assists_grupo

		FROM 
			partida PTD 
			JOIN estadisticas_en_partida EP 
			ON EP.id_partida = PTD.id

		WHERE 
			PTD.fase LIKE '%Grupo%'
			AND PTD.nombre_torneo LIKE 'T1'
		
		GROUP BY 
			EP.gamertag
	) GRP ON GRP.gamertag = EE.gamertag
	
	LEFT OUTER JOIN (
		SELECT 
			EP.gamertag,
			ROUND(AVG(EP.kos), 2) AS kos_eliminatorias,
			ROUND(AVG(EP.restarts), 2) AS restarts_eliminatorias,
			ROUND(AVG(EP.assists), 2) AS assists_eliminatorias

		FROM 
			partida PTD 
			JOIN estadisticas_en_partida EP 
			ON EP.id_partida = PTD.id

		WHERE 
			(PTD.fase LIKE '%Semifinal%' OR PTD.fase LIKE '%Final%')
			AND PTD.nombre_torneo LIKE 'T1'
		
		GROUP BY 
			EP.gamertag
		
		) ELI ON EE.gamertag = ELI.gamertag

WHERE EE.nombre_equipo LIKE 'E2'
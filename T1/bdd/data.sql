-- 1. Inserción de Jugadores (50 jugadores, J1 a J50)
INSERT INTO Jugador (gamertag, nombre, email, fecha_nacimiento, pais_origen) VALUES
('J1', 'Nombre 1', 'j1@mail.com', '2000-01-01', 'Chile'),
('J2', 'Nombre 2', 'j2@mail.com', '2000-01-02', 'Chile'),
('J3', 'Nombre 3', 'j3@mail.com', '2000-01-03', 'Chile'),
('J4', 'Nombre 4', 'j4@mail.com', '2000-01-04', 'Chile'),
('J5', 'Nombre 5', 'j5@mail.com', '2000-01-05', 'Chile'),
('J6', 'Nombre 6', 'j6@mail.com', '2000-01-06', 'Brasil'),
('J7', 'Nombre 7', 'j7@mail.com', '2000-01-07', 'Brasil'),
('J8', 'Nombre 8', 'j8@mail.com', '2000-01-08', 'Brasil'),
('J9', 'Nombre 9', 'j9@mail.com', '2000-01-09', 'Brasil'),
('J10', 'Nombre 10', 'j10@mail.com', '2000-01-10', 'Brasil'),
('J11', 'Nombre 11', 'j11@mail.com', '2000-01-11', 'Argentina'),
('J12', 'Nombre 12', 'j12@mail.com', '2000-01-12', 'Argentina'),
('J13', 'Nombre 13', 'j13@mail.com', '2000-01-13', 'Argentina'),
('J14', 'Nombre 14', 'j14@mail.com', '2000-01-14', 'Argentina'),
('J15', 'Nombre 15', 'j15@mail.com', '2000-01-15', 'Argentina'),
('J16', 'Nombre 16', 'j16@mail.com', '2000-01-16', 'Peru'),
('J17', 'Nombre 17', 'j17@mail.com', '2000-01-17', 'Peru'),
('J18', 'Nombre 18', 'j18@mail.com', '2000-01-18', 'Peru'),
('J19', 'Nombre 19', 'j19@mail.com', '2000-01-19', 'Peru'),
('J20', 'Nombre 20', 'j20@mail.com', '2000-01-20', 'Peru'),
('J21', 'Nombre 21', 'j21@mail.com', '2000-01-21', 'Colombia'),
('J22', 'Nombre 22', 'j22@mail.com', '2000-01-22', 'Colombia'),
('J23', 'Nombre 23', 'j23@mail.com', '2000-01-23', 'Colombia'),
('J24', 'Nombre 24', 'j24@mail.com', '2000-01-24', 'Colombia'),
('J25', 'Nombre 25', 'j25@mail.com', '2000-01-25', 'Colombia'),
('J26', 'Nombre 26', 'j26@mail.com', '2000-01-26', 'Mexico'),
('J27', 'Nombre 27', 'j27@mail.com', '2000-01-27', 'Mexico'),
('J28', 'Nombre 28', 'j28@mail.com', '2000-01-28', 'Mexico'),
('J29', 'Nombre 29', 'j29@mail.com', '2000-01-29', 'Mexico'),
('J30', 'Nombre 30', 'j30@mail.com', '2000-01-30', 'Mexico'),
('J31', 'Nombre 31', 'j31@mail.com', '2000-01-31', 'Uruguay'),
('J32', 'Nombre 32', 'j32@mail.com', '2000-02-01', 'Uruguay'),
('J33', 'Nombre 33', 'j33@mail.com', '2000-02-02', 'Uruguay'),
('J34', 'Nombre 34', 'j34@mail.com', '2000-02-03', 'Uruguay'),
('J35', 'Nombre 35', 'j35@mail.com', '2000-02-04', 'Uruguay'),
('J36', 'Nombre 36', 'j36@mail.com', '2000-02-05', 'Paraguay'),
('J37', 'Nombre 37', 'j37@mail.com', '2000-02-06', 'Paraguay'),
('J38', 'Nombre 38', 'j38@mail.com', '2000-02-07', 'Paraguay'),
('J39', 'Nombre 39', 'j39@mail.com', '2000-02-08', 'Paraguay'),
('J40', 'Nombre 40', 'j40@mail.com', '2000-02-09', 'Paraguay'),
('J41', 'Nombre 41', 'j41@mail.com', '2000-02-10', 'Ecuador'),
('J42', 'Nombre 42', 'j42@mail.com', '2000-02-11', 'Ecuador'),
('J43', 'Nombre 43', 'j43@mail.com', '2000-02-12', 'Ecuador'),
('J44', 'Nombre 44', 'j44@mail.com', '2000-02-13', 'Ecuador'),
('J45', 'Nombre 45', 'j45@mail.com', '2000-02-14', 'Ecuador'),
('J46', 'Nombre 46', 'j46@mail.com', '2000-02-15', 'Bolivia'),
('J47', 'Nombre 47', 'j47@mail.com', '2000-02-16', 'Bolivia'),
('J48', 'Nombre 48', 'j48@mail.com', '2000-02-17', 'Bolivia'),
('J49', 'Nombre 49', 'j49@mail.com', '2000-02-18', 'Bolivia'),
('J50', 'Nombre 50', 'j50@mail.com', '2000-02-19', 'Bolivia');

-- 2. Inserción de Equipos (10 equipos, E1 a E10 con capitanes asignados)
INSERT INTO Equipo (nombre, fecha_creacion, capitan) VALUES
('E1', '2025-01-01', 'J1'),
('E2', '2025-01-02', 'J6'),
('E3', '2025-01-03', 'J11'),
('E4', '2025-01-04', 'J16'),
('E5', '2025-01-05', 'J21'),
('E6', '2025-01-06', 'J26'),
('E7', '2025-01-07', 'J31'),
('E8', '2025-01-08', 'J36'),
('E9', '2025-01-09', 'J41'),
('E10', '2025-01-10', 'J46');

-- 3. Inserción de la relación Es_del_equipo (5 jugadores por equipo)
INSERT INTO Es_del_equipo (gamertag, nombre_equipo) VALUES
('J1', 'E1'), ('J2', 'E1'), ('J3', 'E1'), ('J4', 'E1'), ('J5', 'E1'),
('J6', 'E2'), ('J7', 'E2'), ('J8', 'E2'), ('J9', 'E2'), ('J10', 'E2'),
('J11', 'E3'), ('J12', 'E3'), ('J13', 'E3'), ('J14', 'E3'), ('J15', 'E3'),
('J16', 'E4'), ('J17', 'E4'), ('J18', 'E4'), ('J19', 'E4'), ('J20', 'E4'),
('J21', 'E5'), ('J22', 'E5'), ('J23', 'E5'), ('J24', 'E5'), ('J25', 'E5'),
('J26', 'E6'), ('J27', 'E6'), ('J28', 'E6'), ('J29', 'E6'), ('J30', 'E6'),
('J31', 'E7'), ('J32', 'E7'), ('J33', 'E7'), ('J34', 'E7'), ('J35', 'E7'),
('J36', 'E8'), ('J37', 'E8'), ('J38', 'E8'), ('J39', 'E8'), ('J40', 'E8'),
('J41', 'E9'), ('J42', 'E9'), ('J43', 'E9'), ('J44', 'E9'), ('J45', 'E9'),
('J46', 'E10'), ('J47', 'E10'), ('J48', 'E10'), ('J49', 'E10'), ('J50', 'E10');

-- 4. Inserción de Sponsors
INSERT INTO Sponsor (nombre, industria) VALUES
('S1', 'Hardware'),
('S2', 'Bebidas Energeticas'),
('S3', 'Telecomunicaciones'),
('S4', 'Indumentaria Deportiva'),
('S5', 'Perifericos');

-- 5. Inserción de Torneos (T1 con cupo de 8, T2 con 16, T3 con 4)
INSERT INTO Torneo (nombre, fecha_inicio, videojuego, fecha_termino, pozo, max_equipos) VALUES
('T1', '2026-05-01', 'Juego A', '2026-05-15', 50000.00, 8),
('T2', '2026-06-01', 'Juego B', '2026-06-15', 25000.00, 16),
('T3', '2026-07-01', 'Juego C', '2026-07-15', 10000.00, 4);

-- 6. Inserción de Sponsor_del_torneo
INSERT INTO Sponsor_del_torneo (nombre_sponsor, nombre_torneo, fecha_inicio_torneo, monto) VALUES
('S1', 'T1', '2026-05-01', 15000),
('S2', 'T1', '2026-05-01', 10000),
('S3', 'T2', '2026-06-01', 12000),
('S4', 'T3', '2026-07-01', 5000),
('S5', 'T1', '2026-05-01', 20000);

-- 7. Inserción de Equipos en Torneos
INSERT INTO Esta_en_torneo (nombre_equipo, nombre_torneo, fecha_inicio_torneo) VALUES
('E1', 'T1', '2026-05-01'),
('E2', 'T1', '2026-05-01'),
('E3', 'T1', '2026-05-01'),
('E4', 'T1', '2026-05-01'),
('E5', 'T1', '2026-05-01'),
('E6', 'T1', '2026-05-01'),
('E7', 'T1', '2026-05-01'),
('E8', 'T1', '2026-05-01'),
('E1', 'T2', '2026-06-01'),
('E10', 'T2', '2026-06-01');

-- CASO BORDE SOLICITADO: Equipo E9 intenta inscribirse en T1, que ya alcanzó su max_equipos = 8.
-- Falla de Correctitud en modelo: La instrucción pasará en BD porque no existe un trigger que valide `max_equipos`.
INSERT INTO Esta_en_torneo (nombre_equipo, nombre_torneo, fecha_inicio_torneo) VALUES
('E9', 'T1', '2026-05-01'); 

-- 8. Inserción de Partidas del Torneo T1 (Fase de Grupos -> Semifinales -> Final)
-- Grupo A: E1, E2, E3, E4. Grupo B: E5, E6, E7, E8.
INSERT INTO Partida ("id", nombre_torneo, fecha_inicio_torneo, nombre_equipo1, nombre_equipo2, inicio, puntaje_equipo1, puntaje_equipo2, fase) VALUES
(1, 'T1', '2026-05-01', 'E1', 'E2', '2026-05-02 10:00:00', 3, 0, 'Grupo A'),
(2, 'T1', '2026-05-01', 'E3', 'E4', '2026-05-02 12:00:00', 0, 3, 'Grupo A'),
(3, 'T1', '2026-05-01', 'E1', 'E3', '2026-05-03 10:00:00', 3, 0, 'Grupo A'),
(4, 'T1', '2026-05-01', 'E2', 'E4', '2026-05-03 12:00:00', 0, 3, 'Grupo A'),
(5, 'T1', '2026-05-01', 'E1', 'E4', '2026-05-04 10:00:00', 1, 1, 'Grupo A'),
(6, 'T1', '2026-05-01', 'E2', 'E3', '2026-05-04 12:00:00', 3, 0, 'Grupo A'),
(7, 'T1', '2026-05-01', 'E5', 'E6', '2026-05-05 10:00:00', 3, 0, 'Grupo B'),
(8, 'T1', '2026-05-01', 'E7', 'E8', '2026-05-05 12:00:00', 1, 1, 'Grupo B'),
(9, 'T1', '2026-05-01', 'E5', 'E7', '2026-05-06 10:00:00', 3, 0, 'Grupo B'),
(10, 'T1', '2026-05-01', 'E6', 'E8', '2026-05-06 12:00:00', 3, 0, 'Grupo B'),
(11, 'T1', '2026-05-01', 'E5', 'E8', '2026-05-07 10:00:00', 1, 1, 'Grupo B'),
(12, 'T1', '2026-05-01', 'E6', 'E7', '2026-05-07 12:00:00', 3, 0, 'Grupo B'),
-- Clasifican de Grupos: 1A=E1, 2A=E4 | 1B=E5, 2B=E6
(13, 'T1', '2026-05-01', 'E1', 'E6', '2026-05-09 15:00:00', 3, 0, 'Semifinal'),
(14, 'T1', '2026-05-01', 'E5', 'E4', '2026-05-09 18:00:00', 3, 0, 'Semifinal'),
-- Final: Ganadores de Semi
(15, 'T1', '2026-05-01', 'E1', 'E5', '2026-05-11 20:00:00', 3, 0, 'Final');

-- 9. Inserción de Estadísticas en Partida
-- Se asignan valores a los 10 jugadores (5 por equipo) involucrados en cada una de las 15 partidas.
INSERT INTO Estadisticas_en_partida (gamertag, id_partida, KOs, restarts, assists) VALUES
-- Partida 1: E1 vs E2
('J1', 1, 10, 2, 5), ('J2', 1, 8, 3, 7), ('J3', 1, 5, 1, 10), ('J4', 1, 7, 2, 4), ('J5', 1, 2, 4, 12),
('J6', 1, 6, 5, 3), ('J7', 1, 4, 4, 2), ('J8', 1, 9, 3, 1), ('J9', 1, 1, 6, 8), ('J10', 1, 3, 2, 4),
-- Partida 2: E3 vs E4
('J11', 2, 2, 5, 3), ('J12', 2, 3, 4, 2), ('J13', 2, 4, 3, 4), ('J14', 2, 1, 6, 5), ('J15', 2, 2, 2, 3),
('J16', 2, 11, 1, 6), ('J17', 2, 9, 2, 5), ('J18', 2, 7, 1, 8), ('J19', 2, 6, 3, 4), ('J20', 2, 8, 2, 2),
-- Partida 3: E1 vs E3
('J1', 3, 12, 1, 4), ('J2', 3, 9, 2, 6), ('J3', 3, 6, 1, 9), ('J4', 3, 8, 2, 3), ('J5', 3, 3, 3, 11),
('J11', 3, 4, 6, 2), ('J12', 3, 5, 5, 1), ('J13', 3, 3, 4, 3), ('J14', 3, 2, 7, 4), ('J15', 3, 1, 4, 2),
-- Partida 4: E2 vs E4
('J6', 4, 5, 4, 4), ('J7', 4, 3, 5, 3), ('J8', 4, 7, 4, 2), ('J9', 4, 2, 6, 6), ('J10', 4, 4, 3, 5),
('J16', 4, 10, 2, 5), ('J17', 4, 8, 3, 4), ('J18', 4, 6, 2, 7), ('J19', 4, 7, 3, 3), ('J20', 4, 9, 2, 2),
-- Partida 5: E1 vs E4
('J1', 5, 9, 2, 5), ('J2', 5, 7, 3, 6), ('J3', 5, 5, 2, 8), ('J4', 5, 6, 3, 4), ('J5', 5, 4, 4, 10),
('J16', 5, 8, 3, 4), ('J17', 5, 6, 4, 5), ('J18', 5, 5, 3, 6), ('J19', 5, 7, 2, 3), ('J20', 5, 6, 3, 2),
-- Partida 6: E2 vs E3
('J6', 6, 8, 3, 5), ('J7', 6, 6, 4, 4), ('J8', 6, 10, 2, 3), ('J9', 6, 3, 5, 7), ('J10', 6, 5, 3, 6),
('J11', 6, 3, 5, 2), ('J12', 6, 4, 4, 1), ('J13', 6, 2, 5, 3), ('J14', 6, 1, 6, 4), ('J15', 6, 2, 3, 2),
-- Partida 7: E5 vs E6
('J21', 7, 10, 2, 6), ('J22', 7, 8, 3, 5), ('J23', 7, 6, 2, 9), ('J24', 7, 7, 3, 4), ('J25', 7, 4, 4, 11),
('J26', 7, 9, 3, 4), ('J27', 7, 7, 4, 3), ('J28', 7, 5, 3, 6), ('J29', 7, 8, 2, 4), ('J30', 7, 6, 3, 2),
-- Partida 8: E7 vs E8
('J31', 8, 4, 5, 3), ('J32', 8, 5, 4, 2), ('J33', 8, 3, 6, 4), ('J34', 8, 2, 5, 5), ('J35', 8, 4, 3, 3),
('J36', 8, 9, 2, 5), ('J37', 8, 7, 3, 6), ('J38', 8, 8, 2, 4), ('J39', 8, 6, 3, 7), ('J40', 8, 5, 4, 2),
-- Partida 9: E5 vs E7
('J21', 9, 11, 1, 5), ('J22', 9, 9, 2, 4), ('J23', 9, 7, 1, 8), ('J24', 9, 8, 2, 3), ('J25', 9, 5, 3, 10),
('J31', 9, 2, 6, 2), ('J32', 9, 3, 5, 1), ('J33', 9, 1, 7, 3), ('J34', 9, 2, 6, 4), ('J35', 9, 3, 4, 2),
-- Partida 10: E6 vs E8
('J26', 10, 8, 2, 5), ('J27', 10, 7, 3, 4), ('J28', 10, 6, 2, 7), ('J29', 10, 9, 1, 3), ('J30', 10, 5, 3, 2),
('J36', 10, 6, 4, 4), ('J37', 10, 5, 5, 5), ('J38', 10, 4, 3, 3), ('J39', 10, 3, 4, 6), ('J40', 10, 4, 4, 1),
-- Partida 11: E5 vs E8
('J21', 11, 9, 2, 6), ('J22', 11, 7, 3, 5), ('J23', 11, 6, 2, 7), ('J24', 11, 8, 3, 3), ('J25', 11, 5, 4, 9),
('J36', 11, 5, 4, 3), ('J37', 11, 4, 5, 4), ('J38', 11, 6, 3, 2), ('J39', 11, 4, 4, 5), ('J40', 11, 3, 3, 2),
-- Partida 12: E6 vs E7
('J26', 12, 10, 1, 4), ('J27', 12, 8, 2, 3), ('J28', 12, 7, 2, 6), ('J29', 12, 9, 1, 5), ('J30', 12, 6, 2, 2),
('J31', 12, 3, 5, 2), ('J32', 12, 4, 4, 1), ('J33', 12, 2, 6, 3), ('J34', 12, 1, 5, 4), ('J35', 12, 3, 4, 2),
-- Partida 13: E1 vs E6 (Semifinal 1)
('J1', 13, 10, 2, 5), ('J2', 13, 8, 3, 6), ('J3', 13, 5, 2, 9), ('J4', 13, 7, 3, 4), ('J5', 13, 3, 4, 10),
('J26', 13, 6, 4, 4), ('J27', 13, 5, 5, 3), ('J28', 13, 4, 3, 5), ('J29', 13, 7, 3, 3), ('J30', 13, 4, 4, 2),
-- Partida 14: E5 vs E4 (Semifinal 2)
('J21', 14, 9, 2, 6), ('J22', 14, 8, 3, 5), ('J23', 14, 6, 2, 8), ('J24', 14, 7, 3, 4), ('J25', 14, 4, 4, 11),
('J16', 14, 7, 4, 4), ('J17', 14, 6, 5, 3), ('J18', 14, 5, 3, 6), ('J19', 14, 6, 4, 3), ('J20', 14, 5, 3, 2),
-- Partida 15: E1 vs E5 (Final)
('J1', 15, 11, 2, 6), ('J2', 15, 9, 3, 5), ('J3', 15, 6, 2, 10), ('J4', 15, 8, 3, 3), ('J5', 15, 4, 4, 12),
('J21', 15, 8, 4, 5), ('J22', 15, 7, 5, 4), ('J23', 15, 5, 3, 7), ('J24', 15, 6, 4, 4), ('J25', 15, 3, 5, 9);
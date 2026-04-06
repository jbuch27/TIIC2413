CREATE TABLE Torneo(
nombre varchar(30) PRIMARY KEY,
fecha_inicio date PRIMARY KEY, -- por torneos periodicos
videojuego varchar(30),
fecha_termino date,
pozo decimal(10,2),
max_equipos smallint
)

CREATE TABLE Equipo(
nombre varchar(30) PRIMARY KEY,
fecha_creacion date,
capitan varchar(30), -- Ref a Jugador(gamertag)
FOREIGN KEY(capitan) REFERENCES Jugador(gamertag) -- el capitan sera un jugador
)

CREATE TABLE Jugador(
gamertag varchar(30) PRIMARY KEY,
nombre varchar(30),
email varchar(30) UNIQUE, -- el correo es unico aunque un mismo jugador puede tener varios
fecha_nacimiento date,
pais_origen varchar(30)
)

CREATE TABLE Sponsor(
nombre varchar(30) PRIMARY KEY,
industria varchar(30)
)

------------------------------------------------------ Relaciones ----------------------------------------------------------

CREATE TABLE Es_del_equipo(
gamertag varchar(30) PRIMARY KEY, -- Ref Jugador(gamertag)
nombre_equipo varchar(30), -- Ref Equipo(nombre)
FOREIGN KEY (gamertag) REFERENCES Jugador(gamertag),
FOREIGN KEY (nombre_equipo) REFERENCES Equipo(nombre)
)

CREATE TABLE Esta_en_torneo(
nombre_equipo varchar(30) PRIMARY KEY,
nombre_torneo varchar(30) PRIMARY KEY,
fecha_inicio_torneo date PRIMARY KEY,
FOREIGN KEY (nombre_equipo) REFERENCES Equipo(nombre),
FOREIGN KEY (nombre_torneo, fecha_inicio_torneo) REFERENCES Torneo(nombre, fecha_inicio)
)

CREATE TABLE Partida(
"id" int PRIMARY KEY,
nombre_torneo varchar(30),
fecha_inicio_torneo date,
nombre_equipo1 varchar(30),
nombre_equipo2 varchar(30),
inicio timestamp,
puntaje_equipo1 smallint,
puntaje_equipo2 smallint,
fase varchar(30),
FOREIGN KEY (nombre_torneo) REFERENCES Torneo(nombre),
FOREIGN KEY (fecha_inicio_torneo) REFERENCES Torneo(fecha_inicio),
FOREIGN KEY (nombre_equipo1) REFERENCES Equipo(nombre),
FOREIGN KEY (nombre_equipo2) REFERENCES Equipo(nombre) --RESTRINGIR QUE NO SEA EL MISMO TEAM VS EL MISMO TEAM
)

CREATE TABLE Estadisticas_en_partida(
gamertag varchar(30) PRIMARY KEY,
id_partida int PRIMARY KEY,
KOs smallint,
restarts smallint,
assists smallint,
FOREIGN KEY (gamertag) REFERENCES Jugador(gamertag),
FOREIGN KEY (id_partida) REFERENCES Partida("id")
)

CREATE TABLE Sponsor_del_torneo(
nombre_sponsor varchar(30) PRIMARY KEY,
nombre_torneo varchar(30) PRIMARY KEY,
fecha_inicio_torneo date PRIMARY KEY,
monto int, -- Mantenemos el monto en la relación, ya que depende del torneo específico
FOREIGN KEY (nombre_sponsor) REFERENCES Sponsor(nombre),
FOREIGN KEY (nombre_torneo, fecha_inicio_torneo) REFERENCES Torneo(nombre, fecha_inicio)
)
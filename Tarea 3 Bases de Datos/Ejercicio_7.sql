CREATE DATABASE Ejercicio_7

USE Ejercicio_7

CREATE TABLE DtosJugador
( 
	IdJugador            varchar(20)  NOT NULL ,
	Email                varchar(20)  NOT NULL 
)
go

ALTER TABLE DtosJugador
	ADD  PRIMARY KEY  CLUSTERED (IdJugador ASC,Email ASC)
go

CREATE TABLE Jugador
( 
	IdJugador            varchar(20)  NOT NULL ,
	Nombre               varchar(20)  NULL ,
	Premios              varchar(20)  NULL ,
	Nacionalidad         varchar(20)  NULL 
)
go

ALTER TABLE Jugador
	ADD  PRIMARY KEY  CLUSTERED (IdJugador ASC)
go

CREATE TABLE Jugdor_Entrenador
( 
	IdJugador            varchar(20)  NOT NULL ,
	IdEntrenador         varchar(20)  NOT NULL 
)
go

ALTER TABLE Jugdor_Entrenador
	ADD  PRIMARY KEY  CLUSTERED (IdJugador ASC,IdEntrenador ASC)
go

CREATE TABLE Partido
( 
	IdPartido            varchar(20)  NOT NULL ,
	Ganador              varchar(20)  NULL ,
	Albitro              char(18)  NULL ,
	Premio               integer  NULL ,
	PremioConsolacion    integer  NULL ,
	Ronda                varchar(20)  NULL ,
	IdJugador            varchar(20)  NULL 
)
go

ALTER TABLE Partido
	ADD  PRIMARY KEY  CLUSTERED (IdPartido ASC)
go

CREATE TABLE Partido
( 
	IdPartido            varchar(20)  NOT NULL ,
	PremioConsolacion    integer  NULL ,
	Ronda                varchar(20)  NULL ,
	IdTorneo             varchar(20)  NULL ,
	IdJugador            varchar(20)  NULL 
)
go

ALTER TABLE Partido
	ADD  PRIMARY KEY  CLUSTERED (IdPartido ASC)
go

CREATE TABLE Partido
( 
	IdPartido            varchar(20)  NOT NULL ,
	Ganador              varchar(20)  NULL ,
	Albitro              char(18)  NULL ,
	Premio               integer  NULL 
)
go

ALTER TABLE Partido
	ADD  PRIMARY KEY  CLUSTERED (IdPartido ASC)
go

CREATE TABLE Torneo
( 
	IdTorneo             varchar(20)  NOT NULL ,
	Año                  datetime  NULL ,
	Pais                 varchar(20)  NULL ,
	Lugar                varchar(20)  NULL ,
	Modalidad            varchar(20)  NULL 
)
go

ALTER TABLE Torneo
	ADD  PRIMARY KEY  CLUSTERED (IdTorneo ASC)
go

CREATE TABLE Torneo_Partido
( 
	IdTorneo             varchar(20)  NOT NULL ,
	IdPartido            varchar(20)  NOT NULL ,
	Marcador             varchar(20)  NULL ,
	CantidadPartidos     varchar(20)  NULL ,
	Estadio              varchar(20)  NULL ,
	Equipo               varchar(20)  NULL 
)
go

ALTER TABLE Torneo_Partido
	ADD  PRIMARY KEY  CLUSTERED (IdTorneo ASC,IdPartido ASC)
go


ALTER TABLE DtosJugador
	ADD  FOREIGN KEY (IdJugador) REFERENCES Jugador(IdJugador)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Jugdor_Entrenador
	ADD  FOREIGN KEY (IdJugador) REFERENCES Jugador(IdJugador)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Partido
	ADD  FOREIGN KEY (IdJugador) REFERENCES Jugador(IdJugador)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Partido
	ADD  FOREIGN KEY (IdPartido) REFERENCES Partido(IdPartido)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Partido
	ADD  FOREIGN KEY (IdPartido) REFERENCES Partido(IdPartido)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Torneo_Partido
	ADD  FOREIGN KEY (IdTorneo) REFERENCES Torneo(IdTorneo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE Torneo_Partido
	ADD  FOREIGN KEY (IdPartido) REFERENCES Partido(IdPartido)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

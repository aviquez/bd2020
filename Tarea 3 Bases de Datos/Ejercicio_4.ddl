
CREATE TABLE Aeropuerto
( 
	IdAeropuerto         varchar(20)  NOT NULL ,
	Nombre               varchar(20)  NULL ,
	Aterrizaje           varchar(20)  NULL ,
	Despeje              varchar(20)  NULL 
)
go

ALTER TABLE Aeropuerto
	ADD  PRIMARY KEY  CLUSTERED (IdAeropuerto ASC)
go

CREATE TABLE Avion
( 
	IdAvion              varchar(20)  NOT NULL ,
	Capacidad            integer  NULL ,
	Modelo               varchar(20)  NULL 
)
go

ALTER TABLE Avion
	ADD  PRIMARY KEY  CLUSTERED (IdAvion ASC)
go

CREATE TABLE Avion
( 
	IdAvion              varchar(20)  NOT NULL ,
	Capacidad            palabraCorta 
)
go

ALTER TABLE Avion
	ADD  PRIMARY KEY  CLUSTERED (IdAvion ASC)
go

CREATE TABLE Avion
( 
	IdAvion              varchar(20)  NOT NULL ,
	Modelo               varchar(20)  NULL 
)
go

ALTER TABLE Avion
	ADD  PRIMARY KEY  CLUSTERED (IdAvion ASC)
go

CREATE TABLE Avion_Aeropuerto
( 
	IdAvion              varchar(20)  NOT NULL ,
	IdAeropuerto         varchar(20)  NOT NULL ,
	DuracionVuelo        integer  NULL 
)
go

ALTER TABLE Avion_Aeropuerto
	ADD  PRIMARY KEY  CLUSTERED (IdAvion ASC,IdAeropuerto ASC)
go

CREATE TABLE Escala
( 
	IdEscala             varchar(20)  NOT NULL ,
	IdProgramaVuelo      varchar(20)  NULL ,
	NumEscalas           integer  NULL ,
	NumOrden             integer  NULL ,
	SubenPasajeros       integer  NULL ,
	BajanPasajeros       integer  NULL ,
	IdAeropuerto         varchar(20)  NULL 
)
go

ALTER TABLE Escala
	ADD  PRIMARY KEY  CLUSTERED (IdEscala ASC)
go

CREATE TABLE Pais
( 
	IdPais               char(18)  NOT NULL ,
	IdAeropuerto         varchar(20)  NOT NULL ,
	Ciudad               varchar(20)  NULL ,
	Continente           varchar(20)  NULL 
)
go

ALTER TABLE Pais
	ADD  PRIMARY KEY  CLUSTERED (IdPais ASC,IdAeropuerto ASC)
go

CREATE TABLE Programa_Vuelo
( 
	IdProgramaVuelo      varchar(20)  NOT NULL ,
	IdAeropuerto         varchar(20)  NOT NULL ,
	LineaAerea           varchar(20)  NULL ,
	DiasDisponibles      varchar(20)  NULL ,
	LugarDespeje         varchar(20)  NULL ,
	LugarLlegada         varchar(20)  NULL 
)
go

ALTER TABLE Programa_Vuelo
	ADD  PRIMARY KEY  CLUSTERED (IdProgramaVuelo ASC,IdAeropuerto ASC)
go

CREATE TABLE Vuelo
( 
	IdVuelo              varchar(20)  NOT NULL ,
	Plazas               varchar(20)  NULL ,
	Fecha                datetime  NULL ,
	IdProgramaVuelo      varchar(20)  NULL ,
	IdAeropuerto         varchar(20)  NULL 
)
go

ALTER TABLE Vuelo
	ADD  PRIMARY KEY  CLUSTERED (IdVuelo ASC)
go


ALTER TABLE Avion
	ADD  FOREIGN KEY (IdAvion) REFERENCES Avion(IdAvion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Avion
	ADD  FOREIGN KEY (IdAvion) REFERENCES Avion(IdAvion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Avion_Aeropuerto
	ADD  FOREIGN KEY (IdAvion) REFERENCES Avion(IdAvion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE Avion_Aeropuerto
	ADD  FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto(IdAeropuerto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Escala
	ADD  FOREIGN KEY (IdProgramaVuelo,IdAeropuerto) REFERENCES Programa_Vuelo(IdProgramaVuelo,IdAeropuerto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Pais
	ADD  FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto(IdAeropuerto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Programa_Vuelo
	ADD  FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto(IdAeropuerto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Vuelo
	ADD  FOREIGN KEY (IdProgramaVuelo,IdAeropuerto) REFERENCES Programa_Vuelo(IdProgramaVuelo,IdAeropuerto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

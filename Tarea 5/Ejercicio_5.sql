CREATE DATABASE Ejercicio_5

USE Ejercicio_5

CREATE TABLE Comisario
( 
	IdComisario          varchar(20)  NOT NULL ,
	Juez                 varchar(20)  NULL ,
	Observador           varchar(20)  NULL 
)
go


insert into Comisario(IdComisario,Juez,Observador)
values('0001', 'Angel Madriz Gamboa', 'Allan Viquez')
go

insert into Comisario(IdComisario,Juez,Observador)
values('0002', 'Deiby Torres Melendez', 'Iveth gamboa Fonseca')
go

UPDATE Comisario SET Juez = 'Luis Garro' WHERE IdComisario='0002';

DELETE FROM Comisario WHERE Juez = 'Angel Madriz Gamboa';

ALTER TABLE Comisario
	ADD  PRIMARY KEY  CLUSTERED (IdComisario ASC)
go

CREATE TABLE Complejo
( 
	IdComplejo           varchar(20)  NOT NULL ,
	Jefe                 integer  NULL ,
	Ubicacion            varchar(20)  NULL ,
	AreaTotal            varchar(20)  NULL ,
	IdUni                varchar(20)  NULL ,
	IdPol                varchar(20)  NULL 
)
go

ALTER TABLE Complejo
	ADD  PRIMARY KEY  CLUSTERED (IdComplejo ASC)
go

CREATE TABLE ComplejoEvento
( 
	IdComplejo           varchar(20)  NOT NULL ,
	IdEvento             varchar(20)  NOT NULL ,
	Pais                 varchar(20)  NULL ,
	Ciudad               varchar(20)  NULL ,
	UbicacionExacta      varchar(20)  NULL 
)
go

ALTER TABLE ComplejoEvento
	ADD  PRIMARY KEY  CLUSTERED (IdComplejo ASC,IdEvento ASC)
go

CREATE TABLE Evento
( 
	IdEvento             varchar(20)  NOT NULL ,
	Fecha                datetime  NULL ,
	Duracion             integer  NULL ,
	IdComisario          varchar(20)  NULL 
)
go

ALTER TABLE Evento
	ADD  PRIMARY KEY  CLUSTERED (IdEvento ASC)
go

CREATE TABLE NumParticipantes
( 
	IdEvento             varchar(20)  NOT NULL ,
	NumParticipantes     integer  NOT NULL 
)
go

ALTER TABLE NumParticipantes
	ADD  PRIMARY KEY  CLUSTERED (IdEvento ASC,NumParticipantes ASC)
go

CREATE TABLE Polideportivo
( 
	IdPol                varchar(20)  NOT NULL ,
	Delegacion           varchar(20)  NULL ,
	Ubicacion            varchar(20)  NULL 
)
go

ALTER TABLE Polideportivo
	ADD  PRIMARY KEY  CLUSTERED (IdPol ASC)
go

CREATE TABLE SEDE
( 
	IdSede               varchar(20)  NOT NULL ,
	Presupuesto          integer  NULL ,
	NumComplejos         integer  NULL 
)
go

ALTER TABLE SEDE
	ADD  PRIMARY KEY  CLUSTERED (IdSede ASC)
go

CREATE TABLE Sede_Complejo
( 
	IdSede               varchar(20)  NOT NULL ,
	IdComplejo           varchar(20)  NOT NULL 
)
go

ALTER TABLE Sede_Complejo
	ADD  PRIMARY KEY  CLUSTERED (IdSede ASC,IdComplejo ASC)
go

CREATE TABLE SedeNumComplejos
( 
	IdSede               varchar(20)  NOT NULL ,
	NumComplejos         integer  NULL 
)
go

ALTER TABLE SedeNumComplejos
	ADD  PRIMARY KEY  CLUSTERED (IdSede ASC)
go

CREATE TABLE SedePresupusto
( 
	IdSede               varchar(20)  NOT NULL ,
	Presupuesto          integer  NULL 
)
go

ALTER TABLE SedePresupusto
	ADD  PRIMARY KEY  CLUSTERED (IdSede ASC)
go

CREATE TABLE Unideportivo
( 
	IdUni                varchar(20)  NOT NULL 
)
go

ALTER TABLE Unideportivo
	ADD  PRIMARY KEY  CLUSTERED (IdUni ASC)
go


ALTER TABLE Complejo
	ADD  FOREIGN KEY (IdUni) REFERENCES Unideportivo(IdUni)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE Complejo
	ADD  FOREIGN KEY (IdPol) REFERENCES Polideportivo(IdPol)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE ComplejoEvento
	ADD  FOREIGN KEY (IdComplejo) REFERENCES Complejo(IdComplejo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE ComplejoEvento
	ADD  FOREIGN KEY (IdEvento) REFERENCES Evento(IdEvento)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Evento
	ADD  FOREIGN KEY (IdComisario) REFERENCES Comisario(IdComisario)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE NumParticipantes
	ADD  FOREIGN KEY (IdEvento) REFERENCES Evento(IdEvento)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Sede_Complejo
	ADD  FOREIGN KEY (IdSede) REFERENCES SEDE(IdSede)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE Sede_Complejo
	ADD  FOREIGN KEY (IdComplejo) REFERENCES Complejo(IdComplejo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE SedeNumComplejos
	ADD  FOREIGN KEY (IdSede) REFERENCES SEDE(IdSede)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE SedePresupusto
	ADD  FOREIGN KEY (IdSede) REFERENCES SEDE(IdSede)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

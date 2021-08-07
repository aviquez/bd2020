Create database Ejercicio03

use Ejercicio03

CREATE TABLE Carretera
( 
	IdCarretera          varchar(20)  NOT NULL ,
	Nombre               varchar(20)  NULL 
)
go
------------------------------------------------------------------------------------------------------------------------

insert into Carretera(IdCarretera,Nombre) values(00312,'General Cañas')

update Carretera set Nombre='Autopista de Sol' where Nombre='General Cañas'

delete from Carretera where IdCarretera = 00312

------------------------------------------------------------------------------------------------------------------------
ALTER TABLE Carretera
	ADD  PRIMARY KEY  CLUSTERED (IdCarretera ASC)
go

CREATE TABLE Categoria
( 
	Categoria            varchar(20)  NOT NULL ,
	IdCarretera          varchar(20)  NOT NULL 
)
go

ALTER TABLE Categoria
	ADD  PRIMARY KEY  CLUSTERED (Categoria ASC,IdCarretera ASC)
go

CREATE TABLE Comuna
( 
	IdComuna             varchar(20)  NOT NULL ,
	Nombre               varchar(20)  NULL ,
	InicioKm             varchar(20)  NULL ,
	FinKm                varchar(20)  NULL 
)
go

ALTER TABLE Comuna
	ADD  PRIMARY KEY  CLUSTERED (IdComuna ASC)
go

CREATE TABLE Tramo
( 
	IdTramo              varchar(20)  NOT NULL ,
	InicioCarretera      varchar(20)  NULL ,
	FinCarretera         varchar(20)  NULL 
)
go

ALTER TABLE Tramo
	ADD  PRIMARY KEY  CLUSTERED (IdTramo ASC)
go

CREATE TABLE tramo
( 
	IdTramo              varchar(20)  NOT NULL ,
	InicioCarretera      varchar(20)  NULL 
)
go

ALTER TABLE tramo
	ADD  PRIMARY KEY  CLUSTERED (IdTramo ASC)
go

CREATE TABLE tramo
( 
	IdTramo              varchar(20)  NOT NULL ,
	FinCarretera         varchar(20)  NULL 
)
go

ALTER TABLE tramo
	ADD  PRIMARY KEY  CLUSTERED (IdTramo ASC)
go

CREATE TABLE Tramo_Carrtera
( 
	IdCarretera          varchar(20)  NOT NULL ,
	IdTramo              varchar(20)  NOT NULL ,
	Distancia            integer  NULL 
)
go

ALTER TABLE Tramo_Carrtera
	ADD  PRIMARY KEY  CLUSTERED (IdCarretera ASC,IdTramo ASC)
go

CREATE TABLE Tramo_comuna
( 
	IdTramo              varchar(20)  NOT NULL ,
	IdComuna             varchar(20)  NOT NULL 
)
go

ALTER TABLE Tramo_comuna
	ADD  PRIMARY KEY  CLUSTERED (IdTramo ASC,IdComuna ASC)
go


ALTER TABLE Categoria
	ADD  FOREIGN KEY (IdCarretera) REFERENCES Carretera(IdCarretera)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE tramo
	ADD  FOREIGN KEY (IdTramo) REFERENCES Tramo(IdTramo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE tramo
	ADD  FOREIGN KEY (IdTramo) REFERENCES Tramo(IdTramo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Tramo_Carrtera
	ADD  FOREIGN KEY (IdTramo) REFERENCES Tramo(IdTramo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE Tramo_Carrtera
	ADD  FOREIGN KEY (IdCarretera) REFERENCES Carretera(IdCarretera)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Tramo_comuna
	ADD  FOREIGN KEY (IdTramo) REFERENCES Tramo(IdTramo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE Tramo_comuna
	ADD  FOREIGN KEY (IdComuna) REFERENCES Comuna(IdComuna)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go



CREATE TABLE Articulos
( 
	IdArticulo           integer  NOT NULL ,
	Descripcion          varchar(50)  NULL ,
	IDFabrica            varchar(20)  NULL ,
	Color                varchar(20)  NULL ,
	Tamano               varchar(20)  NULL ,
	Modelo               varchar(20)  NULL 
)
go

ALTER TABLE Articulos
	ADD  PRIMARY KEY  CLUSTERED (IdArticulo ASC)
go

CREATE TABLE Articulos
( 
	IdArticulo           integer  NOT NULL ,
	Color                varchar(20)  NULL ,
	Tamano               varchar(20)  NULL 
)
go

ALTER TABLE Articulos
	ADD  PRIMARY KEY  CLUSTERED (IdArticulo ASC)
go

CREATE TABLE Articulos
( 
	IdArticulo           integer  NOT NULL ,
	Modelo               varchar(20)  NULL ,
	Descripcion          varchar(20)  NULL 
)
go

ALTER TABLE Articulos
	ADD  PRIMARY KEY  CLUSTERED (IdArticulo ASC)
go

CREATE TABLE Articulos_PEDIDOS
( 
	ID                   varchar(20)  NOT NULL ,
	IdArticulo           integer  NOT NULL ,
	Precio               integer  NULL 
)
go

ALTER TABLE Articulos_PEDIDOS
	ADD  PRIMARY KEY  CLUSTERED (ID ASC,IdArticulo ASC)
go

CREATE TABLE Clintes
( 
	Cedula               varchar(20)  NOT NULL ,
	Direccion            varchar(20)  NULL ,
	Saldo                integer  NULL ,
	LimiteCredito        integer  NULL ,
	Descuento            integer  NULL 
)
go

ALTER TABLE Clintes
	ADD  PRIMARY KEY  CLUSTERED (Cedula ASC)
go

CREATE TABLE Clintes_Pedidos
( 
	ID                   varchar(20)  NOT NULL ,
	Cedula               varchar(20)  NOT NULL 
)
go

ALTER TABLE Clintes_Pedidos
	ADD  PRIMARY KEY  CLUSTERED (ID ASC,Cedula ASC)
go

CREATE TABLE Fabrica
( 
	IDFabrica            varchar(20)  NOT NULL ,
	CantidadArticulos    integer  NULL 
)
go

ALTER TABLE Fabrica
	ADD  PRIMARY KEY  CLUSTERED (IDFabrica ASC)
go

CREATE TABLE Pedidos
( 
	ID                   varchar(20)  NOT NULL ,
	Fabrica              varchar(20)  NULL ,
	Cantidad             integer  NULL 
)
go

ALTER TABLE Pedidos
	ADD  PRIMARY KEY  CLUSTERED (ID ASC)
go

CREATE TABLE Telefono
( 
	Telefono             varchar(20)  NOT NULL ,
	IDFabrica            varchar(20)  NOT NULL 
)
go

ALTER TABLE Telefono
	ADD  PRIMARY KEY  CLUSTERED (Telefono ASC,IDFabrica ASC)
go


ALTER TABLE Articulos
	ADD  FOREIGN KEY (IDFabrica) REFERENCES Fabrica(IDFabrica)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Articulos
	ADD  FOREIGN KEY (IdArticulo) REFERENCES Articulos(IdArticulo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Articulos
	ADD  FOREIGN KEY (IdArticulo) REFERENCES Articulos(IdArticulo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Articulos_PEDIDOS
	ADD  FOREIGN KEY (ID) REFERENCES Pedidos(ID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE Articulos_PEDIDOS
	ADD  FOREIGN KEY (IdArticulo) REFERENCES Articulos(IdArticulo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Clintes_Pedidos
	ADD  FOREIGN KEY (ID) REFERENCES Pedidos(ID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE Clintes_Pedidos
	ADD  FOREIGN KEY (Cedula) REFERENCES Clintes(Cedula)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Telefono
	ADD  FOREIGN KEY (IDFabrica) REFERENCES Fabrica(IDFabrica)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

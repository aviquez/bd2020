Create database Ejercicio02 
use Ejercicio02


CREATE TABLE Cliente
( 
	Cedula               varchar(20)  NOT NULL ,
	Rut                  varchar(20)  NULL ,
	Nombre               varchar(20)  NULL ,
	IdDireccion          varchar(20)  NULL 
)
go
------------------------------------------------------------------------------------------------------------------------

insert into Cliente(Cedula,Rut,Nombre,IdDireccion) values(30387654,'Interamericana Sur','Allan Viquez Monge',20201110)

update Cliente set Nombre='Angel Madriz Gamboa' where Nombre='Allan Viquez Monge'

delete from Cliente where Cedula = 30387654

------------------------------------------------------------------------------------------------------------------------
ALTER TABLE Cliente
	ADD  PRIMARY KEY  CLUSTERED (Cedula ASC)
go

CREATE TABLE Direccion
( 
	IdDireccion          varchar(20)  NOT NULL ,
	Calle                varchar(20)  NULL ,
	Numero               varchar(20)  NULL ,
	Comuna               varchar(20)  NULL ,
	Ciudad               varchar(20)  NULL 
)
go

ALTER TABLE Direccion
	ADD  PRIMARY KEY  CLUSTERED (IdDireccion ASC)
go

CREATE TABLE Producto
( 
	IDProducto           varchar(20)  NOT NULL ,
	stock                varchar(20)  NULL ,
	Nombre               varchar(20)  NULL ,
	Precio               integer  NULL ,
	Descripcion          varchar(20)  NULL 
)
go

ALTER TABLE Producto
	ADD  PRIMARY KEY  CLUSTERED (IDProducto ASC)
go

CREATE TABLE Producto
( 
	IDProducto           varchar(20)  NOT NULL ,
	stock                varchar(20)  NULL ,
	Nombre               varchar(20)  NULL 
)
go

ALTER TABLE Producto
	ADD  PRIMARY KEY  CLUSTERED (IDProducto ASC)
go

CREATE TABLE Proveedor
( 
	IdProveedor          varchar(20)  NOT NULL ,
	Telefono             varchar(20)  NULL ,
	Rut                  varchar(20)  NULL ,
	Nombre               varchar(20)  NULL ,
	Web                  varchar(20)  NULL ,
	IdDireccion          varchar(20)  NULL 
)
go

ALTER TABLE Proveedor
	ADD  PRIMARY KEY  CLUSTERED (IdProveedor ASC)
go

CREATE TABLE Proveedor_Producto
( 
	IdProveedor          varchar(20)  NOT NULL ,
	IDProducto           varchar(20)  NOT NULL 
)
go

ALTER TABLE Proveedor_Producto
	ADD  PRIMARY KEY  CLUSTERED (IdProveedor ASC,IDProducto ASC)
go

CREATE TABLE Telefono
( 
	Telefono             varchar(20)  NOT NULL ,
	Cedula               varchar(20)  NOT NULL 
)
go

ALTER TABLE Telefono
	ADD  PRIMARY KEY  CLUSTERED (Telefono ASC,Cedula ASC)
go

CREATE TABLE Venta_Compra
( 
	Id                   varchar(20)  NOT NULL ,
	Fecha                datetime  NULL ,
	montoFinal           integer  NULL ,
	Descuento            integer  NULL ,
	Cantidad             integer  NULL ,
	IDProducto           varchar(20)  NULL ,
	Cedula               varchar(20)  NULL 
)
go

ALTER TABLE Venta_Compra
	ADD  PRIMARY KEY  CLUSTERED (Id ASC)
go


ALTER TABLE Cliente
	ADD  FOREIGN KEY (IdDireccion) REFERENCES Direccion(IdDireccion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Producto
	ADD  FOREIGN KEY (IDProducto) REFERENCES Producto(IDProducto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Proveedor
	ADD  FOREIGN KEY (IdDireccion) REFERENCES Direccion(IdDireccion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Proveedor_Producto
	ADD  FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE Proveedor_Producto
	ADD  FOREIGN KEY (IDProducto) REFERENCES Producto(IDProducto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Telefono
	ADD  FOREIGN KEY (Cedula) REFERENCES Cliente(Cedula)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Venta_Compra
	ADD  FOREIGN KEY (IDProducto) REFERENCES Producto(IDProducto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE Venta_Compra
	ADD  FOREIGN KEY (Cedula) REFERENCES Cliente(Cedula)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

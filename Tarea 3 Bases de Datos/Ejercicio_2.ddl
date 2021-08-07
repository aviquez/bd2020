
CREATE TABLE Cliente
( 
	Cedula               varchar(20)  NOT NULL ,
	Rut                  varchar(20)  NULL ,
	Nombre               varchar(20)  NULL ,
	IdDireccion          varchar(20)  NULL 
)
go

ALTER TABLE Cliente
	ADD CONSTRAINT XPKCliente PRIMARY KEY  CLUSTERED (Cedula ASC)
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
	ADD CONSTRAINT XPKDireccion PRIMARY KEY  CLUSTERED (IdDireccion ASC)
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
	ADD CONSTRAINT XPKProducto PRIMARY KEY  CLUSTERED (IDProducto ASC)
go

CREATE TABLE Producto
( 
	IDProducto           varchar(20)  NOT NULL ,
	stock                varchar(20)  NULL ,
	Nombre               varchar(20)  NULL 
)
go

ALTER TABLE Producto
	ADD CONSTRAINT XPKProducto PRIMARY KEY  CLUSTERED (IDProducto ASC)
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
	ADD CONSTRAINT XPKProveedor PRIMARY KEY  CLUSTERED (IdProveedor ASC)
go

CREATE TABLE Proveedor_Producto
( 
	IdProveedor          varchar(20)  NOT NULL ,
	IDProducto           varchar(20)  NOT NULL 
)
go

ALTER TABLE Proveedor_Producto
	ADD CONSTRAINT XPKProveedor_Producto PRIMARY KEY  CLUSTERED (IdProveedor ASC,IDProducto ASC)
go

CREATE TABLE Telefono
( 
	Telefono             varchar(20)  NOT NULL ,
	Cedula               varchar(20)  NOT NULL 
)
go

ALTER TABLE Telefono
	ADD CONSTRAINT XPKTelefono PRIMARY KEY  CLUSTERED (Telefono ASC,Cedula ASC)
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
	ADD CONSTRAINT XPKVenta_Compra PRIMARY KEY  CLUSTERED (Id ASC)
go


ALTER TABLE Cliente
	ADD CONSTRAINT R_2 FOREIGN KEY (IdDireccion) REFERENCES Direccion(IdDireccion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Producto
	ADD CONSTRAINT R_9 FOREIGN KEY (IDProducto) REFERENCES Producto(IDProducto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Proveedor
	ADD CONSTRAINT R_1 FOREIGN KEY (IdDireccion) REFERENCES Direccion(IdDireccion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Proveedor_Producto
	ADD CONSTRAINT R_11 FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE Proveedor_Producto
	ADD CONSTRAINT R_12 FOREIGN KEY (IDProducto) REFERENCES Producto(IDProducto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Telefono
	ADD CONSTRAINT R_7 FOREIGN KEY (Cedula) REFERENCES Cliente(Cedula)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Venta_Compra
	ADD CONSTRAINT R_5 FOREIGN KEY (IDProducto) REFERENCES Producto(IDProducto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE Venta_Compra
	ADD CONSTRAINT R_6 FOREIGN KEY (Cedula) REFERENCES Cliente(Cedula)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


CREATE TRIGGER tD_Cliente ON Cliente FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Cliente */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Cliente  Telefono on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000303ec", PARENT_OWNER="", PARENT_TABLE="Cliente"
    CHILD_OWNER="", CHILD_TABLE="Telefono"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="Cedula" */
    IF EXISTS (
      SELECT * FROM deleted,Telefono
      WHERE
        /*  %JoinFKPK(Telefono,deleted," = "," AND") */
        Telefono.Cedula = deleted.Cedula
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Cliente because Telefono exists.'
      GOTO error
    END

    /* ERwin Builtin Trigger */
    /* Cliente 1 Venta_Compra on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Cliente"
    CHILD_OWNER="", CHILD_TABLE="Venta_Compra"
    P2C_VERB_PHRASE="1", C2P_VERB_PHRASE="n", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="Cedula" */
    IF EXISTS (
      SELECT * FROM deleted,Venta_Compra
      WHERE
        /*  %JoinFKPK(Venta_Compra,deleted," = "," AND") */
        Venta_Compra.Cedula = deleted.Cedula
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Cliente because Venta_Compra exists.'
      GOTO error
    END

    /* ERwin Builtin Trigger */
    /* Direccion 1 Cliente on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Direccion"
    CHILD_OWNER="", CHILD_TABLE="Cliente"
    P2C_VERB_PHRASE="1", C2P_VERB_PHRASE="1", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="IdDireccion" */
    IF EXISTS (SELECT * FROM deleted,Direccion
      WHERE
        /* %JoinFKPK(deleted,Direccion," = "," AND") */
        deleted.IdDireccion = Direccion.IdDireccion AND
        NOT EXISTS (
          SELECT * FROM Cliente
          WHERE
            /* %JoinFKPK(Cliente,Direccion," = "," AND") */
            Cliente.IdDireccion = Direccion.IdDireccion
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Cliente because Direccion exists.'
      GOTO error
    END


    /* ERwin Builtin Trigger */
    RETURN
error:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Cliente ON Cliente FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Cliente */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCedula varchar(20),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* ERwin Builtin Trigger */
  /* Cliente  Telefono on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00038f4a", PARENT_OWNER="", PARENT_TABLE="Cliente"
    CHILD_OWNER="", CHILD_TABLE="Telefono"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="Cedula" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Cedula)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Telefono
      WHERE
        /*  %JoinFKPK(Telefono,deleted," = "," AND") */
        Telefono.Cedula = deleted.Cedula
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Cliente because Telefono exists.'
      GOTO error
    END
  END

  /* ERwin Builtin Trigger */
  /* Cliente 1 Venta_Compra on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Cliente"
    CHILD_OWNER="", CHILD_TABLE="Venta_Compra"
    P2C_VERB_PHRASE="1", C2P_VERB_PHRASE="n", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="Cedula" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Cedula)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Venta_Compra
      WHERE
        /*  %JoinFKPK(Venta_Compra,deleted," = "," AND") */
        Venta_Compra.Cedula = deleted.Cedula
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Cliente because Venta_Compra exists.'
      GOTO error
    END
  END

  /* ERwin Builtin Trigger */
  /* Direccion 1 Cliente on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Direccion"
    CHILD_OWNER="", CHILD_TABLE="Cliente"
    P2C_VERB_PHRASE="1", C2P_VERB_PHRASE="1", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="IdDireccion" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdDireccion)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Direccion
        WHERE
          /* %JoinFKPK(inserted,Direccion) */
          inserted.IdDireccion = Direccion.IdDireccion
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.IdDireccion IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Cliente because Direccion does not exist.'
      GOTO error
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
error:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Direccion ON Direccion FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Direccion */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Direccion 1 Cliente on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001e71c", PARENT_OWNER="", PARENT_TABLE="Direccion"
    CHILD_OWNER="", CHILD_TABLE="Cliente"
    P2C_VERB_PHRASE="1", C2P_VERB_PHRASE="1", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="IdDireccion" */
    IF EXISTS (
      SELECT * FROM deleted,Cliente
      WHERE
        /*  %JoinFKPK(Cliente,deleted," = "," AND") */
        Cliente.IdDireccion = deleted.IdDireccion
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Direccion because Cliente exists.'
      GOTO error
    END

    /* ERwin Builtin Trigger */
    /* Direccion 1 Proveedor on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Direccion"
    CHILD_OWNER="", CHILD_TABLE="Proveedor"
    P2C_VERB_PHRASE="1", C2P_VERB_PHRASE="1", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="IdDireccion" */
    IF EXISTS (
      SELECT * FROM deleted,Proveedor
      WHERE
        /*  %JoinFKPK(Proveedor,deleted," = "," AND") */
        Proveedor.IdDireccion = deleted.IdDireccion
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Direccion because Proveedor exists.'
      GOTO error
    END


    /* ERwin Builtin Trigger */
    RETURN
error:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Direccion ON Direccion FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Direccion */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdDireccion varchar(20),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* ERwin Builtin Trigger */
  /* Direccion 1 Cliente on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00022a07", PARENT_OWNER="", PARENT_TABLE="Direccion"
    CHILD_OWNER="", CHILD_TABLE="Cliente"
    P2C_VERB_PHRASE="1", C2P_VERB_PHRASE="1", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="IdDireccion" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdDireccion)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Cliente
      WHERE
        /*  %JoinFKPK(Cliente,deleted," = "," AND") */
        Cliente.IdDireccion = deleted.IdDireccion
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Direccion because Cliente exists.'
      GOTO error
    END
  END

  /* ERwin Builtin Trigger */
  /* Direccion 1 Proveedor on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Direccion"
    CHILD_OWNER="", CHILD_TABLE="Proveedor"
    P2C_VERB_PHRASE="1", C2P_VERB_PHRASE="1", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="IdDireccion" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdDireccion)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Proveedor
      WHERE
        /*  %JoinFKPK(Proveedor,deleted," = "," AND") */
        Proveedor.IdDireccion = deleted.IdDireccion
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Direccion because Proveedor exists.'
      GOTO error
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
error:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Producto ON Producto FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Producto */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Producto  Proveedor_Producto on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002eacd", PARENT_OWNER="", PARENT_TABLE="Producto"
    CHILD_OWNER="", CHILD_TABLE="Proveedor_Producto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="IDProducto" */
    IF EXISTS (
      SELECT * FROM deleted,Proveedor_Producto
      WHERE
        /*  %JoinFKPK(Proveedor_Producto,deleted," = "," AND") */
        Proveedor_Producto.IDProducto = deleted.IDProducto
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Producto because Proveedor_Producto exists.'
      GOTO error
    END

    /* ERwin Builtin Trigger */
    /* Producto  Producto on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Producto"
    CHILD_OWNER="", CHILD_TABLE="Producto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="IDProducto" */
    IF EXISTS (
      SELECT * FROM deleted,Producto
      WHERE
        /*  %JoinFKPK(Producto,deleted," = "," AND") */
        Producto.IDProducto = deleted.IDProducto
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Producto because Producto exists.'
      GOTO error
    END

    /* ERwin Builtin Trigger */
    /* Producto n Venta_Compra on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Producto"
    CHILD_OWNER="", CHILD_TABLE="Venta_Compra"
    P2C_VERB_PHRASE="n", C2P_VERB_PHRASE="1", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="IDProducto" */
    IF EXISTS (
      SELECT * FROM deleted,Venta_Compra
      WHERE
        /*  %JoinFKPK(Venta_Compra,deleted," = "," AND") */
        Venta_Compra.IDProducto = deleted.IDProducto
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Producto because Venta_Compra exists.'
      GOTO error
    END


    /* ERwin Builtin Trigger */
    RETURN
error:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Producto ON Producto FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Producto */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIDProducto varchar(20),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* ERwin Builtin Trigger */
  /* Producto  Proveedor_Producto on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00032c5b", PARENT_OWNER="", PARENT_TABLE="Producto"
    CHILD_OWNER="", CHILD_TABLE="Proveedor_Producto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="IDProducto" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IDProducto)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Proveedor_Producto
      WHERE
        /*  %JoinFKPK(Proveedor_Producto,deleted," = "," AND") */
        Proveedor_Producto.IDProducto = deleted.IDProducto
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Producto because Proveedor_Producto exists.'
      GOTO error
    END
  END

  /* ERwin Builtin Trigger */
  /* Producto  Producto on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Producto"
    CHILD_OWNER="", CHILD_TABLE="Producto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="IDProducto" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IDProducto)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Producto
      WHERE
        /*  %JoinFKPK(Producto,deleted," = "," AND") */
        Producto.IDProducto = deleted.IDProducto
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Producto because Producto exists.'
      GOTO error
    END
  END

  /* ERwin Builtin Trigger */
  /* Producto n Venta_Compra on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Producto"
    CHILD_OWNER="", CHILD_TABLE="Venta_Compra"
    P2C_VERB_PHRASE="n", C2P_VERB_PHRASE="1", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="IDProducto" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IDProducto)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Venta_Compra
      WHERE
        /*  %JoinFKPK(Venta_Compra,deleted," = "," AND") */
        Venta_Compra.IDProducto = deleted.IDProducto
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Producto because Venta_Compra exists.'
      GOTO error
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
error:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Producto ON Producto FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Producto */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Producto  Producto on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00012272", PARENT_OWNER="", PARENT_TABLE="Producto"
    CHILD_OWNER="", CHILD_TABLE="Producto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="IDProducto" */
    IF EXISTS (SELECT * FROM deleted,Producto
      WHERE
        /* %JoinFKPK(deleted,Producto," = "," AND") */
        deleted.IDProducto = Producto.IDProducto AND
        NOT EXISTS (
          SELECT * FROM Producto
          WHERE
            /* %JoinFKPK(Producto,Producto," = "," AND") */
            Producto.IDProducto = Producto.IDProducto
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Producto because Producto exists.'
      GOTO error
    END


    /* ERwin Builtin Trigger */
    RETURN
error:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Producto ON Producto FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Producto */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIDProducto varchar(20),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* ERwin Builtin Trigger */
  /* Producto  Producto on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000152b7", PARENT_OWNER="", PARENT_TABLE="Producto"
    CHILD_OWNER="", CHILD_TABLE="Producto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="IDProducto" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IDProducto)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Producto
        WHERE
          /* %JoinFKPK(inserted,Producto) */
          inserted.IDProducto = Producto.IDProducto
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Producto because Producto does not exist.'
      GOTO error
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
error:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Proveedor ON Proveedor FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Proveedor */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Proveedor  Proveedor_Producto on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00023b43", PARENT_OWNER="", PARENT_TABLE="Proveedor"
    CHILD_OWNER="", CHILD_TABLE="Proveedor_Producto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="IdProveedor" */
    IF EXISTS (
      SELECT * FROM deleted,Proveedor_Producto
      WHERE
        /*  %JoinFKPK(Proveedor_Producto,deleted," = "," AND") */
        Proveedor_Producto.IdProveedor = deleted.IdProveedor
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Proveedor because Proveedor_Producto exists.'
      GOTO error
    END

    /* ERwin Builtin Trigger */
    /* Direccion 1 Proveedor on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Direccion"
    CHILD_OWNER="", CHILD_TABLE="Proveedor"
    P2C_VERB_PHRASE="1", C2P_VERB_PHRASE="1", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="IdDireccion" */
    IF EXISTS (SELECT * FROM deleted,Direccion
      WHERE
        /* %JoinFKPK(deleted,Direccion," = "," AND") */
        deleted.IdDireccion = Direccion.IdDireccion AND
        NOT EXISTS (
          SELECT * FROM Proveedor
          WHERE
            /* %JoinFKPK(Proveedor,Direccion," = "," AND") */
            Proveedor.IdDireccion = Direccion.IdDireccion
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Proveedor because Direccion exists.'
      GOTO error
    END


    /* ERwin Builtin Trigger */
    RETURN
error:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Proveedor ON Proveedor FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Proveedor */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdProveedor varchar(20),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* ERwin Builtin Trigger */
  /* Proveedor  Proveedor_Producto on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00029e6d", PARENT_OWNER="", PARENT_TABLE="Proveedor"
    CHILD_OWNER="", CHILD_TABLE="Proveedor_Producto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="IdProveedor" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdProveedor)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Proveedor_Producto
      WHERE
        /*  %JoinFKPK(Proveedor_Producto,deleted," = "," AND") */
        Proveedor_Producto.IdProveedor = deleted.IdProveedor
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Proveedor because Proveedor_Producto exists.'
      GOTO error
    END
  END

  /* ERwin Builtin Trigger */
  /* Direccion 1 Proveedor on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Direccion"
    CHILD_OWNER="", CHILD_TABLE="Proveedor"
    P2C_VERB_PHRASE="1", C2P_VERB_PHRASE="1", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="IdDireccion" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdDireccion)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Direccion
        WHERE
          /* %JoinFKPK(inserted,Direccion) */
          inserted.IdDireccion = Direccion.IdDireccion
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.IdDireccion IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Proveedor because Direccion does not exist.'
      GOTO error
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
error:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Proveedor_Producto ON Proveedor_Producto FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Proveedor_Producto */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Producto  Proveedor_Producto on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00029345", PARENT_OWNER="", PARENT_TABLE="Producto"
    CHILD_OWNER="", CHILD_TABLE="Proveedor_Producto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="IDProducto" */
    IF EXISTS (SELECT * FROM deleted,Producto
      WHERE
        /* %JoinFKPK(deleted,Producto," = "," AND") */
        deleted.IDProducto = Producto.IDProducto AND
        NOT EXISTS (
          SELECT * FROM Proveedor_Producto
          WHERE
            /* %JoinFKPK(Proveedor_Producto,Producto," = "," AND") */
            Proveedor_Producto.IDProducto = Producto.IDProducto
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Proveedor_Producto because Producto exists.'
      GOTO error
    END

    /* ERwin Builtin Trigger */
    /* Proveedor  Proveedor_Producto on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Proveedor"
    CHILD_OWNER="", CHILD_TABLE="Proveedor_Producto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="IdProveedor" */
    IF EXISTS (SELECT * FROM deleted,Proveedor
      WHERE
        /* %JoinFKPK(deleted,Proveedor," = "," AND") */
        deleted.IdProveedor = Proveedor.IdProveedor AND
        NOT EXISTS (
          SELECT * FROM Proveedor_Producto
          WHERE
            /* %JoinFKPK(Proveedor_Producto,Proveedor," = "," AND") */
            Proveedor_Producto.IdProveedor = Proveedor.IdProveedor
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Proveedor_Producto because Proveedor exists.'
      GOTO error
    END


    /* ERwin Builtin Trigger */
    RETURN
error:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Proveedor_Producto ON Proveedor_Producto FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Proveedor_Producto */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdProveedor varchar(20), 
           @insIDProducto varchar(20),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* ERwin Builtin Trigger */
  /* Producto  Proveedor_Producto on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002c620", PARENT_OWNER="", PARENT_TABLE="Producto"
    CHILD_OWNER="", CHILD_TABLE="Proveedor_Producto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="IDProducto" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IDProducto)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Producto
        WHERE
          /* %JoinFKPK(inserted,Producto) */
          inserted.IDProducto = Producto.IDProducto
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Proveedor_Producto because Producto does not exist.'
      GOTO error
    END
  END

  /* ERwin Builtin Trigger */
  /* Proveedor  Proveedor_Producto on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Proveedor"
    CHILD_OWNER="", CHILD_TABLE="Proveedor_Producto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="IdProveedor" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdProveedor)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Proveedor
        WHERE
          /* %JoinFKPK(inserted,Proveedor) */
          inserted.IdProveedor = Proveedor.IdProveedor
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Proveedor_Producto because Proveedor does not exist.'
      GOTO error
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
error:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Telefono ON Telefono FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Telefono */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Cliente  Telefono on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="000124d5", PARENT_OWNER="", PARENT_TABLE="Cliente"
    CHILD_OWNER="", CHILD_TABLE="Telefono"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="Cedula" */
    IF EXISTS (SELECT * FROM deleted,Cliente
      WHERE
        /* %JoinFKPK(deleted,Cliente," = "," AND") */
        deleted.Cedula = Cliente.Cedula AND
        NOT EXISTS (
          SELECT * FROM Telefono
          WHERE
            /* %JoinFKPK(Telefono,Cliente," = "," AND") */
            Telefono.Cedula = Cliente.Cedula
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Telefono because Cliente exists.'
      GOTO error
    END


    /* ERwin Builtin Trigger */
    RETURN
error:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Telefono ON Telefono FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Telefono */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insTelefono varchar(20), 
           @insCedula varchar(20),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* ERwin Builtin Trigger */
  /* Cliente  Telefono on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00013f29", PARENT_OWNER="", PARENT_TABLE="Cliente"
    CHILD_OWNER="", CHILD_TABLE="Telefono"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="Cedula" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Cedula)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Cliente
        WHERE
          /* %JoinFKPK(inserted,Cliente) */
          inserted.Cedula = Cliente.Cedula
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Telefono because Cliente does not exist.'
      GOTO error
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
error:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Venta_Compra ON Venta_Compra FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Venta_Compra */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Cliente 1 Venta_Compra on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00025256", PARENT_OWNER="", PARENT_TABLE="Cliente"
    CHILD_OWNER="", CHILD_TABLE="Venta_Compra"
    P2C_VERB_PHRASE="1", C2P_VERB_PHRASE="n", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="Cedula" */
    IF EXISTS (SELECT * FROM deleted,Cliente
      WHERE
        /* %JoinFKPK(deleted,Cliente," = "," AND") */
        deleted.Cedula = Cliente.Cedula AND
        NOT EXISTS (
          SELECT * FROM Venta_Compra
          WHERE
            /* %JoinFKPK(Venta_Compra,Cliente," = "," AND") */
            Venta_Compra.Cedula = Cliente.Cedula
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Venta_Compra because Cliente exists.'
      GOTO error
    END

    /* ERwin Builtin Trigger */
    /* Producto n Venta_Compra on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Producto"
    CHILD_OWNER="", CHILD_TABLE="Venta_Compra"
    P2C_VERB_PHRASE="n", C2P_VERB_PHRASE="1", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="IDProducto" */
    IF EXISTS (SELECT * FROM deleted,Producto
      WHERE
        /* %JoinFKPK(deleted,Producto," = "," AND") */
        deleted.IDProducto = Producto.IDProducto AND
        NOT EXISTS (
          SELECT * FROM Venta_Compra
          WHERE
            /* %JoinFKPK(Venta_Compra,Producto," = "," AND") */
            Venta_Compra.IDProducto = Producto.IDProducto
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Venta_Compra because Producto exists.'
      GOTO error
    END


    /* ERwin Builtin Trigger */
    RETURN
error:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Venta_Compra ON Venta_Compra FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Venta_Compra */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insId varchar(20),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* ERwin Builtin Trigger */
  /* Cliente 1 Venta_Compra on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002d32e", PARENT_OWNER="", PARENT_TABLE="Cliente"
    CHILD_OWNER="", CHILD_TABLE="Venta_Compra"
    P2C_VERB_PHRASE="1", C2P_VERB_PHRASE="n", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="Cedula" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Cedula)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Cliente
        WHERE
          /* %JoinFKPK(inserted,Cliente) */
          inserted.Cedula = Cliente.Cedula
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Cedula IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Venta_Compra because Cliente does not exist.'
      GOTO error
    END
  END

  /* ERwin Builtin Trigger */
  /* Producto n Venta_Compra on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Producto"
    CHILD_OWNER="", CHILD_TABLE="Venta_Compra"
    P2C_VERB_PHRASE="n", C2P_VERB_PHRASE="1", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="IDProducto" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IDProducto)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Producto
        WHERE
          /* %JoinFKPK(inserted,Producto) */
          inserted.IDProducto = Producto.IDProducto
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.IDProducto IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Venta_Compra because Producto does not exist.'
      GOTO error
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
error:
    raiserror @errno @errmsg
    rollback transaction
END

go



create database Proyecto_BD


use Proyecto_BD


--3
create table Empleados(
Id_empleado varchar(4) primary key,
Nombre varchar(50),
Apellidos varchar(50),
Fecha_nacimiento date,
Fecha_ingreso date,
Id_area varchar(4)  foreign key (Id_area) references  Empresa(Id_area)
)

 
insert into Empleados values ('001','Angel','Gambo','1994-05-17','2020-01-02','1001')
insert into Empleados values ('002','Fabian','Sanch', '1990-02-14','2019-02-23','1002')
insert into Empleados values ('003','Allan','Vique', '1980-12-25','2010-12-13','1003' )


select * from Empleados


--2
create table Empresa(
Id_area varchar(4) primary key,
Id_pais integer foreign key (Id_pais) references  Pais(Id_pais),
Nombre_area varchar(50)
)

 
insert into Empresa values ('1001',505,'RRHH')
insert into Empresa values ('1002',506,'TI')
insert into Empresa values ('1003',507,'Produccion')

 
select * from empresa


--1
create table Pais(
Id_pais integer primary key,
Pais varchar(50),
)

 
insert into pais values('506','CR')
insert into pais values('507','PN')
insert into pais values('505','NC')


select * from Pais


--6
create table Feriados(
Id_feriado integer primary key,
Id_pais integer foreign key(Id_pais) references  Pais(Id_pais),
Num_mes datetime,
Dia_mes integer,
Nombre_feriad varchar(50)
)
 

insert into feriados values (1 , 506 , 09 , 22, 'Dia de Angel')
insert into Feriados values (2 , 505 , 02 , 20, 'Navidad')                            
insert into Feriados values (3 , 506 , 04 , 23, 'Dia de la Independencia')


select * from Feriados
 

--4
create table Solicitud_vacaciones(
Id_solicitud integer primary key,
Fecha_inicial datetime,
Fecha_final datetime,
Estado integer,
Id_empleado varchar(4)  foreign key (Id_empleado) references  Empleados(Id_empleado)
)

 
insert into Solicitud_vacaciones values ('1','2020-09-22', '2020-09-24','0','001')
insert into Solicitud_vacaciones values ('2', '2020-12-22', '2020-12-24','0','002')
insert into Solicitud_vacaciones values ('3', '2020-01-13', '2020-01-19','0', '003')
---------ALLAN----------
insert into Solicitud_vacaciones values ('4', '2020-02-13', '2020-02-19','1', '003')
insert into Solicitud_vacaciones values ('5','2020-10-22', '2020-10-24','1','001')
insert into Solicitud_vacaciones values ('6', '2020-11-22', '2020-11-24','1','002')


select * from Solicitud_Vacaciones


--5
create table Acreditacion_Vacaciones(
Id_acreditacion integer primary key,
Ano_acreditacion integer ,
Id_empleado varchar(4) foreign key(Id_empleado) references Empleados (Id_empleado),
Dias_acreditados integer
)

 
insert into  Acreditacion_Vacaciones values  ('1','2020', '001','2')
insert into  Acreditacion_Vacaciones values  ('2','2020', '003','3')
insert into  Acreditacion_Vacaciones values  ('3','2020', '002','2')
---------------------ALLAN------------------------
insert into  Acreditacion_Vacaciones values  ('4','2019', '002','5')


select * from Acreditacion_Vacaciones

	--------------------------------------------------------------------------------------------------------------------------------------------------

    --Requerimiento 2
 

      select (DATEDIFF(dd, '2020-09-22', '2020-10-28') + 1)
     -(DATEDIFF(wk, '2020-09-22', '2020-09-27') * 2)
     -(CASE WHEN DATENAME(dw, '2020-09-22') = 'Sunday' THEN 1 ELSE 0 END)
     -(CASE WHEN DATENAME(dw, '2020-10-28') = 'Saturday' THEN 1 ELSE 0 END)
     -(CASE WHEN DATENAME(DD,  '09-28') = (select  concat(f.Num_mes,'-',f.Dia_mes) from Feriados f where f.Id_pais = 505) then 1 else 0 end)

    -------------------------------------------------------------------------------------------------------------------------------------------------

    --Requerimiento 3


    Declare @Var Int
    Declare @dias int
    set @Var=0
    set @Var= (cast(datediff(dd,'1999-09-22',GETDATE()) / 365.25 as int)) 
    set @dias=@Var
    -case when @var<=3 then  10  
     when @Var>3 and @Var <=6 then 13 
     when @Var>6 and  @Var <= 11 then 15
     when @Var>11 then 20 end
    select @Var-@dias

    
    -------------------------------------------------------------------------------------------------------------------------------------------------

    --Requerimiento 4


	declare @diasAcreditados int
	set @diasAcreditados = (select a.Dias_acreditados from Acreditacion_Vacaciones a where a.Id_empleado = '001' )
	declare @diasAprov int 
	set @diasAprov = (select a.Estado from Solicitud_vacaciones a where a.Estado = '1')
	Declare @Variable Int
	Declare @diasVacac int
	set @Variable=0
	set @Variable= (cast(datediff(dd,'',GETDATE()) / 365.25 as int)) 
	set @diasVacac=@Variable
	-case 
	when @Variable<=3 then  10  
	when @Variable>3 and @Variable <=6 then 13 
	when @Variable>6 and  @Variable <= 11 then 15
	when @Variable>11 then 20 end
	declare @resul int
	set @resul = (@Variable-@diasVacac)
	select @resul - @diasAcreditados


    -------------------------------------------------------------------------------------------------------------------------------------------------

    --Requerimiento 5

	Declare @Variables Int
    Declare @dia int
    declare @idempleado date
    set @Variables=0
    set @idempleado = (select a.Fecha_ingreso from Empleados a where a.Id_empleado = '001')
    set @Variables =  (cast(datediff(dd,'',GETDATE()) / 365.25 as int)) 
    set @dia=@Variables
    -case 
     when @Variables<=3 then  10  
     when @Variables>3 and @Variables <=6 then 13 
     when @Variables>6 and  @Variables <= 11 then 15
     when @Variables>11 then 20 end
    select @Variables-@dia

	
    -------------------------------------------------------------------------------------------------------------------------------------------------

    --Requerimiento 6

	SELECT emp.Id_empleado,
	       emp.Nombre+' '+emp.Apellidos AS nombre_completo,
		   cal.total_acreditos,
		   cal.Dias_aprobados,
		   cal.Diferiencia_Aprob_Acredi,
		   (DATEDIFF (MONTH, emp.Fecha_ingreso , GETDATE())-1 ) -
		   (cal.total_acreditos + cal.Dias_aprobados) AS Dias_Dispo_vacaciones
	  FROM Empleados emp
	     FULL OUTER JOIN (SELECT a.id_empleado,
							 SUM(a.Dias_acreditados) AS total_acreditos,
							 COALESCE(b.Dias_aprobados, 0) AS Dias_aprobados,
							 CASE
								 WHEN SUM(a.Dias_acreditados) >= COALESCE(b.Dias_aprobados, 0) THEN
									 (SUM(a.Dias_acreditados) - COALESCE(b.Dias_aprobados, 0))
								 ELSE
									 (COALESCE(b.Dias_aprobados, 0) - SUM(a.Dias_acreditados) )
							 END AS Diferiencia_Aprob_Acredi
						 FROM Acreditacion_Vacaciones a 
						   FULL OUTER JOIN (SELECT Id_empleado,
											 DATEDIFF (DAY, fecha_inicial , fecha_final ) AS Dias_aprobados
										FROM Solicitud_Vacaciones
									   WHERE estado = 1
									  )b on a.Id_empleado = b.Id_empleado
						 GROUP BY a.id_empleado,b.Dias_aprobados)cal ON emp.Id_empleado = cal.Id_empleado

    -------------------------------------------------------------------------------------------------------------------------------------------------

    --Requerimiento 7

	SELECT p.id_pais,
	       p.pais,
	       total.Total_Dias_Dispo_vacaciones
	  FROM Pais p
	  INNER JOIN Empresa em ON p.Id_pais = em.Id_pais
	  INNER JOIN (SELECT emp.Id_area,
		                 SUM((DATEDIFF (MONTH, emp.Fecha_ingreso , GETDATE())-1 ) -
						(cal.total_acreditos + cal.Dias_aprobados)) AS Total_Dias_Dispo_vacaciones
					FROM Empleados emp
						FULL OUTER JOIN (SELECT a.id_empleado,
												SUM(a.Dias_acreditados) AS total_acreditos,
												COALESCE(b.Dias_aprobados, 0) AS Dias_aprobados,
												CASE
												WHEN SUM(a.Dias_acreditados) >= COALESCE(b.Dias_aprobados, 0) THEN
													(SUM(a.Dias_acreditados) - COALESCE(b.Dias_aprobados, 0))
												ELSE
													(COALESCE(b.Dias_aprobados, 0) - SUM(a.Dias_acreditados) )
												END AS Diferiencia_Aprob_Acredi
										FROM Acreditacion_Vacaciones a 
												FULL OUTER JOIN (SELECT Id_empleado,
																		DATEDIFF (DAY, fecha_inicial , fecha_final ) AS Dias_aprobados
																FROM Solicitud_Vacaciones
																WHERE estado = 1
															)b on a.Id_empleado = b.Id_empleado
									GROUP BY a.id_empleado,b.Dias_aprobados)cal ON emp.Id_empleado = cal.Id_empleado
				GROUP BY emp.Id_area) total ON em.Id_area = total.Id_area
				ORDER BY total.Total_Dias_Dispo_vacaciones DESC

    -------------------------------------------------------------------------------------------------------------------------------------------------

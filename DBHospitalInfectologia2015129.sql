create database DBHospitalInfectologia2015129;
use DBHospitalInfectologia2015129;
 
create table Medicos(
codigoMedico int not null primary key auto_increment,
licenciaMedica int(10),
nombre varchar(50),
apellidos varchar(50),
horaEntrada datetime,
haraSalida datetime,
sexo varchar(15)
 );
 create table telefonosMedico(
 codigoTelefonoMedico int not null auto_increment,
 telefonoPersonal varchar(15) not null,
 telefonoTrabajo varchar(15) not null,
 codigoMedico int,
 primary key pk_codigoTelefonoMedico(codigoTelefonoMedico),
 foreign key fk_telefonosMedico_Medicos(codigoMedico)references Medicos(codigoMedico)
 );
 create table especialidades(
 codigoEspecialidad int not null auto_increment,
 nombreEspecialidad varchar(45) not null,
 primary key pk_codigoEspecialidad(codigoEspecialidad)
 );
 create table horario(
 codigoHorario int not null auto_increment,
 horarioInicio datetime not null,
 horarioSalida datetime not null,
 lunes tinyint,
 martes tinyint,
 miercoles tinyint,
 jueves tinyint,
 viernes tinyint,
 primary key pk_codigoHorario(codigoHorario)
 );
 create table especialidadMedicos(
 codigoEspecialidadMedicos int not null auto_increment,
 codigoMedico int not null,
 codigoEspecialidad int not null,
 codigoHorario int not null,
 primary key pk_codigoEspecialidadMedicos(codigoEspecialidadMedicos),
 foreign key fk_especialidadMedicos_Medicos(codigoMedico)references Medicos(codigoMedico),
 foreign key fk_especialidadMedicos_especialidades(codigoEspecialidad)references especialidades(codigoEspecialidad),
 foreign key fk_especialidadMedicos_horario(codigoHorario)references horario(codigoHorario)
 );
 create table areas (
 codigoArea int not null auto_increment,
 nombreArea varchar(45) not null,
primary key pk_codigoArea(codigoArea)
 );
 create table cargos(
 codigoCargo int not null auto_increment,
 nombreCargo varchar(45) not null,
 primary key pk_codigoCargo(codigoCargo)
 );
 select * from cargos;
 create table responsableTurno(
 codigoResponsableTurno int not null auto_increment,
 nombreResponsable varchar(45)not null,
 apellidosResponsable varchar(45) not null,
 telefonoPersonal varchar(10) not null,
 codigoArea int not null,
 codigoCargo int not null,
 primary key pk_codigoResponsableTurno(codigoResponsableTurno),
 foreign key fk_responsableTurno_areas(codigoArea)references areas(codigoArea),
 foreign key fk_responsableTurno_cargos(codigoCargo)references cargos(codigoCargo)
 );
 create table pacientes(
 codigoPaciente int not null auto_increment,
 DPI varchar(20)  not null,
 apellidos varchar (50) not null,
 nombres varchar (50) not null,
 fechaNacimiento date not null,
 edad int not null,
 direccion varchar (150),
 ocupacion varchar (50),
 sexo varchar (15),
 primary key pk_codigoPaciente(codigoPaciente)
 );
 create table contactoUrgencia(
 codigoContactoUrgencia int not null auto_increment,
 nombres varchar(50) not null,
 apellidos varchar(50) not null,
 numeroContacto varchar(10) not null,
 codigoPaciente int,
 primary key pk_codigoContactoUrgencia(codigoContactoUrgencia),
 foreign key fk_contactoUrgencia_pacientes(codigoPaciente)references pacientes(codigoPaciente)
 );
 
 create table turno(
 codigoTurno int not null auto_increment,
 fechaTurno date not null,
 fechaCita date not null,
 valorCita  double  not null,
 codigoEspecialidadMedicos int not null ,
 codigoResponsableTurno int not null,
 codigoPaciente int not null,
 primary key pk_codigoTurno(codigoTurno),
 foreign key fk_turno_especialidadMedicos(codigoEspecialidadMedicos)references especialidadMedicos(codigoEspecialidadMedicos),
 foreign key fk_turno_responsableTurno(codigoResponsableTurno)references responsableTurno(codigoResponsableTurno),
 foreign key fk_turno_pacientes(codigoPaciente)references pacientes(codigoPaciente)
 );
 create table ControlCitas(
 codigoControlCita int not null auto_increment,
 fecha date not null,
 horaInicio varchar(45) not null,
 horaFin varchar(45) not null,
 codigoMedico int not null,
 codigoPaciente int not null,
 primary key pk_codigoControlCita(codigoControlCita),
 foreign key fk_ControlCitas_Medicos(codigoMedico)references Medicos(codigoMedico) on delete cascade,
 foreign key fk_ControlCitas_pacientes(codigoPaciente)references pacientes(codigoPaciente)on delete cascade
 );
 create table Recetas(
 codigoReceta int not null auto_increment,
 descripcionReceta varchar(45),
 codigoControlCita int not null,
 primary key pk_codigoReceta(codigoReceta),
 foreign key fk_Recetas_ControlCitas(codigoControlCita)references ControlCitas(codigoControlCita) on delete cascade
 );
 ------------------------------------------------------------------# Procesos de Agregar #-------------------------------------------------------------------------------------------------------------------------------------
 
 /* Medicos*/----------------------------------------------
Delimiter $$
create procedure sp_AgregarMedicos(p_licenciaMedica int(10), p_nombre varchar(50),p_apellidos varchar(50), p_horaEntrada datetime, p_haraSalida datetime,  p_sexo varchar(10))
begin
  insert into Medicos (licenciaMedica, nombre ,apellidos, horaEntrada,haraSalida,  sexo)
		values (p_licenciaMedica,p_nombre ,p_apellidos,p_horaEntrada,p_haraSalida,p_sexo);
end$$
call sp_AgregarMedicos(44525345,'Roberto','Garcia','2019-05-01 06:00:00','2019-05-01 16:00:00', 'Masculino');
call sp_AgregarMedicos(445253123,'Billy', 'Garcia','2019-04-25 05:00:00', '2019-04-25 20:00:00', 'Masculino');
call sp_AgregarMedicos(543123128,'Alejandro','Hernandez','2019-06-03 06:00:00','2019-06-03 18:00:00', 'Masculino');

 /* Telefonos Medicos */------------------------------------------
Delimiter $$
create procedure sp_AgregarTelefonosMedico(p_telefonoPersonal varchar(15),p_telefonoTrabajo varchar(15), codigoMedico int)
begin
	insert into telefonosMedico(telefonoPersonal,telefonoTrabajo,codigoMedico)
		values(p_telefonoPersonal,p_telefonoTrabajo,codigoMedico);
 end$$
 call sp_AgregarTelefonosMedico('5643-2049','2439-0508',1);
 call sp_AgregarTelefonosMedico('4189-0932','2408-4560',2);
 call sp_AgregarTelefonosMedico('4156-8032','2578-4589',3);
 
 /*  Agregar especialidades */----------------------------------------
Delimiter $$
create procedure sp_AgregarEspecialidades(p_nombreEspecialidad varchar(45))
begin
	insert into especialidades(nombreEspecialidad)
		values(p_nombreEspecialidad);
end$$
call sp_AgregarEspecialidades('Pediatra');
call sp_AgregarEspecialidades('Cardiología');
call sp_AgregarEspecialidades('Dermatología');
call sp_AgregarEspecialidades('Hematología');
call sp_AgregarEspecialidades('Hepatología');

/* Agreagar horario */-----------------------------------
Delimiter $$ 
create procedure sp_AgregarHorario(p_horarioInicio datetime, p_horarioSalida datetime, p_lunes tinyint,p_martes tinyint, p_miercoles tinyint,p_jueves tinyint,p_viernes tinyint)
begin
	insert into horario(horarioInicio,horarioSalida,lunes,martes,miercoles,jueves,viernes)
		values(p_horarioInicio,p_horarioSalida,p_lunes,p_martes,p_miercoles,p_jueves,p_viernes);
end$$
call sp_AgregarHorario('2019-05-01 06:00:00','2019-05-01 16:00:00',1,2,3,4,5);
call sp_AgregarHorario('2019-05-02 06:00:00','2019-05-01 15:00:00',8,9,10,11,12);
call sp_AgregarHorario('2019-05-02 06:00:00','2019-05-01 14:00:00',15,16,17,18,19);

/* Agregar EspecialidadMedicos */---------------------------------------------------
 Delimiter $$
 create procedure sp_AgregarEspecialidadMedicos(p_codigoMedico int, p_codigoEspecialidad int, p_codigoHorario int)
 begin
	insert into especialidadMedicos(codigoMedico,codigoEspecialidad,codigoHorario)
		values(p_codigoMedico,p_codigoEspecialidad,p_codigoHorario);
end$$
call sp_AgregarEspecialidadMedicos(1,1,1);
call sp_AgregarEspecialidadMedicos(1,1,1);
call sp_AgregarEspecialidadMedicos(3,3,3);

/* Agreagar Areas */-----------------------------------
Delimiter $$
create procedure sp_AgreparAreas(p_nombreArea varchar(45))
begin
	insert into areas (nombreArea)
		values(p_nombreArea);
end$$
call sp_AgreparAreas('Urgencia');
call sp_AgreparAreas('Rehabilitación');
call sp_AgreparAreas('Farmacia');
call sp_AgreparAreas('Cirugia general y digestiva');
call sp_AgreparAreas('Cuidados intensivo');
call sp_AgreparAreas('Laboratorios clínicos');

/* Agregar cargos */----------------------------------
Delimiter $$
create procedure sp_AgregarCargos(p_nombreCargo varchar(45))
begin
	insert into cargos(nombreCargo)
		values(p_nombreCargo);
end$$
call sp_AgregarCargos('Consejo consultivo');
call sp_AgregarCargos('Comite tecnico');
call sp_AgregarCargos('Director');

/* Agregar responsableTurno */------------------------------
Delimiter $$
create procedure sp_AgregarResponsableTurno(p_nombreResponsable varchar(45),p_apellidosResponsable varchar(45),p_telefonoPersonal varchar(10),p_codigoArea int,p_codigoCargo int)
begin
	insert into responsableTurno(nombreResponsable,apellidosResponsable,telefonoPersonal,codigoArea,codigoCargo)
		values(p_nombreResponsable,p_apellidosResponsable,p_telefonoPersonal,p_codigoArea,p_codigoCargo);
end$$
 call sp_AgregarResponsableTurno('Alejandro','Alvarez','5817-0809',1,1);
 call sp_AgregarResponsableTurno('Jessica','Gonzalez','4109-3455',2,2);
 call sp_AgregarResponsableTurno('María','García','2980-3940',3,3);
 
 /* Agregar pacientes */--------------------------------------
 Delimiter $$
 create procedure sp_AgregarPacientes(p_DPI varchar(20),p_apellidos varchar(50),p_nombres varchar(50),p_fechaNacimiento date,p_edad int,p_direccion varchar (150), p_ocupacion varchar (50),p_sexo varchar (15))
 begin
	insert into pacientes(DPI,apellidos,nombres,fechaNacimiento,edad,direccion,ocupacion,sexo)
		values(p_DPI,p_apellidos,p_nombres,p_fechaNacimiento,p_edad,p_direccion,p_ocupacion,p_sexo);
end$$
call sp_AgregarPacientes('232055980101','Gonzalez','Luisa','1986-08-08',33,'13av 31-05 col Bethania zona7','Contadora','Femenino');
call sp_AgregarPacientes('432509230101','Ramos','Abner','1986-01-18',33,'3av 12calle 08-12 zona1','Ingeniero','Masculino');
call sp_AgregarPacientes('892302480101','Contreras','Arturo','1947-06-03',72,'1av 14calle 13-51 zona1','Jardinero','Masculino');

 /* Agregar contactoUrgencia*/---------------------------------
 Delimiter $$
 create procedure sp_AgregarContactourgencia(p_nombres varchar(50),p_apellidos varchar(50),p_numeroContacto varchar(10),p_codigoPaciente int)
 begin
	insert into contactoUrgencia (nombres,apellidos,numeroContacto,codigoPaciente)
		values(p_nombres,p_apellidos,p_numeroContacto,p_codigoPaciente);
end$$
  call sp_AgregarContactourgencia('Martin','Martinez','5639-9890',1);
  call sp_AgregarContactourgencia('Juena','Duarte','3245-9876',2);
  
  /* Agregar turno*/------------------------------------
  Delimiter $$
  create procedure sp_AgregarTurno(p_fechaTurno date,p_fechaCita date,p_valorCita double ,p_codigoEspecialidadMedicos int,
  p_codigoResponsableTurno int,p_codigoPaciente int)
  begin
	insert into turno(fechaTurno,fechaCita,valorCita,codigoEspecialidadMedicos,codigoResponsableTurno,codigoPaciente)
		values(p_fechaTurno,p_fechaCita,p_valorCita,p_codigoEspecialidadMedicos,p_codigoResponsableTurno,p_codigoPaciente);
end$$
 call sp_AgregarTurno('2019-06-01','2019-08-04',250,2,2,1);
 call sp_AgregarTurno('2019-06-02','2019-08-06',300,3,1,2);
 call sp_AgregarTurno('2019-06-03','2019-08-11',200,1,2,2);
 /*Agregar ControlCitas */-------------------------------------------------------------------------------------------------------------------------------------------
 Delimiter $$
 create procedure sp_AgregarControlCitas(p_fecha date, p_horaInicio varchar(45),p_horaFin varchar(45),codigoMedico int, codigoPaciente int)
 begin
	insert into ControlCitas( fecha, horaInicio, horaFin,codigoMedico,codigoPaciente)
		values(p_fecha,p_horaInicio,p_horaFin,codigoMedico,codigoPaciente);
 end$$
 call sp_AgregarControlCitas('2019-07-02','06:30 AM','07:10 AM',1,1);
 call sp_AgregarControlCitas('2019-07-2','07:15 AM','07:45 AM',2,2);
 call sp_AgregarControlCitas('2019-07-2','07:15 AM','07:45 AM',1,1);
 
 select * from controlcitas;
 /*Agregar Recetas */------------------------------------------------------------------------------------------------------------------------
 Delimiter $$
 create procedure sp_AgregarRecetas(p_descripcionReceta varchar(45),p_codigoControlCita varchar(45))
 begin
	insert into Recetas(descripcionReceta,codigoControlCita)
		values(p_descripcionReceta,p_codigoControlCita);
 end$$
 call sp_AgregarRecetas('Paracetamol,Acetaminofen',2);
 call sp_AgregarRecetas('Eutirox',3);
 -------------------------------------------------------# Procesos Modificar #------------------------------------------------------------------------------
 /* Modificar Medicos*/--------------------
  Delimiter $$
 create procedure sp_ModificarMedicos (p_codigoMedico int(10), p_licenciaMedica int(10), p_nombre varchar(50), p_apellidos varchar(50), p_horaEntrada datetime, p_haraSalida datetime ,p_sexo varchar(15))
 begin 
	update Medicos
	set 
		licenciaMedica= p_licenciaMedica,
		nombre = p_nombre,
		apellidos= p_apellidos,
		horaEntrada =p_horaEntrada,
		haraSalida= p_haraSalida,
		sexo=p_sexo
			where codigoMedico = p_codigoMedico;
 end$$
call sp_ModificarMedicos(1,44525445, 'Alberto','Cárdenas', '2019-05-01 06:00:00', '2019-05-01 16:00:00','Masculino');
call sp_ModificarMedicos(2,34455922,'Cristel','García','2019-05-01 06:00:00','2019-05-01 16:00:0','Femenino');



update Medicos
	set 
		licenciaMedica= 5245,
		nombre = 'Joel',
		apellidos= 'Rodas',
		horaEntrada ='2019-03-01 01:01:00',
		haraSalida= '2019-03-01 06:01:00',
		sexo='Masculino'
			where codigoMedico = 1;
            


/* Modificar telefonosMedico */---------------------------
Delimiter $$
create procedure sp_ModificarTelefonosMedico(p_codigoTelefonoMedico int,p_telefonoPersonal varchar(15),p_telefonoTrabajo varchar(15),p_codigoMedico int)
begin
	update telefonosMedico
    set
	telefonoPersonal = 	p_telefonoPersonal,
    telefonoTrabajo = p_telefonoTrabajo,
    codigoMedico = p_codigoMedico
		where codigoTelefonoMedico=  p_codigoTelefonoMedico ;
end$$
 call sp_ModificarTelefonosMedico(2,'5643-2049','2439-0508',1);
 call sp_ModificarTelefonosMedico(1,'4189-0932','2408-4560',2);
 
 /* Modificar especialidades */-------------------------
 Delimiter $$
 create procedure sp_ModificarEspecialidades(p_codigoEspecialidad int,p_nombreEspecialidad varchar(45))
 begin
	update especialidades
    set
    nombreEspecialidad = p_nombreEspecialidad
		where codigoEspecialidad = p_codigoEspecialidad;
 end$$
 call sp_ModificarEspecialidades(5,'Cirugia general');
 
 /* Modificar horario */-------------------------
 Delimiter $$
 create procedure sp_ModificarHorario(p_codigoHorario int,p_horarioInicio datetime,p_horarioSalida datetime,p_lunes tinyint, p_martes tinyint, p_miercoles tinyint,p_jueves tinyint, p_viernes tinyint)
 begin
	update horario
		set
     horarioInicio = p_horarioInicio,
     horarioSalida = p_horarioSalida,
     lunes = p_lunes,
     martes= p_martes,
     miercoles =p_miercoles,
     jueves=p_jueves,
     viernes =p_viernes
			where codigoHorario=p_codigoHorario;
end$$
call sp_ModificarHorario(2,'2019-05-02 07:00:00','2019-05-01 15:00:00',8,9,10,11,12);
 /* Modificar  especialidadMedicos */-------------------------------------
 Delimiter $$
 create procedure sp_ModificarEspecialidadMedicos(p_codigoEspecialidadMedicos int,p_codigoMedico int,p_codigoEspecialidad int,p_codigoHorario int)
 begin
 update especialidadMedicos
	set
    codigoMedico=p_codigoMedico,
    codigoEspecialidad=p_codigoEspecialidad,
    codigoHorario=p_codigoHorario
    where codigoEspecialidadMedicos= p_codigoEspecialidadMedicos;
 end$$
 call sp_ModificarEspecialidadMedicos(2,1,2,1);
 
 /* Modificar areas */------------------------------------------------------
 Delimiter $$
 create procedure sp_ModificarAreas(p_codigoArea int,p_nombreArea varchar(45))
 begin
 update areas
	set
		nombreArea = p_nombreArea
	where codigoArea = p_codigoArea;
 end$$
call sp_ModificarAreas(6,'Laboratorio');


/* Modificar cargos*/--------------------------------------------------
Delimiter $$
create procedure sp_ModificarCargos(p_codigoCargo int, p_nombreCargo varchar(45))
begin
update cargos
	set
    nombreCargo=p_nombreCargo
    where codigoCargo= p_codigoCargo ;
end$$
call sp_ModificarCargos(1,'Consejo');
 
 
 /* Modificar responsableTurno */----------------------------------------------------------
 Delimiter $$
 create procedure sp_ModificarResponsableTurno(p_codigoResponsableTurno int ,p_nombreResponsable varchar(45),p_apellidosResponsable varchar(45),p_telefonoPersonal varchar(10),p_codigoArea int, p_codigoCargo int)
 begin
 update responsableTurno
	set
    nombreResponsable=p_nombreResponsable,
    apellidosResponsable=p_apellidosResponsable,
    telefonoPersonal=p_telefonoPersonal,
    codigoArea=p_codigoArea,
    codigoCargo=p_codigoCargo
		where codigoResponsableTurno=p_codigoResponsableTurno;
 end$$
 call sp_ModificarResponsableTurno(1,'Alejandro','Alvarez','5818-1809',1,1);
 
 
 
 /* Modificar pacientes */-----------------------------------------------------
 Delimiter $$
 create procedure sp_ModificarPacientes(p_codigoPaciente int,p_DPI varchar(20),p_apellidos varchar(50),p_nombres varchar(50),p_fechaNacimiento date,p_edad int,p_direccion varchar(150),p_ocupacion varchar(50),p_sexo varchar(15))
 begin
 update pacientes
	set
    DPI=p_DPI,
    apellidos=p_apellidos,
    nombres=p_nombres,
    fechaNacimiento=p_fechaNacimiento,
    edad=p_edad,
    direccion=p_direccion,
    ocupacion=p_ocupacion,
    sexo=p_sexo
		where codigoPaciente=p_codigoPaciente ;
end$$
 call sp_ModificarPacientes(1,'123055980101','Gonzalez','Luisa','1986-08-08',33,'13av 31-05 col Bethania zona7','Contadora','Femenino');
 

 /* Modificar contactoUrgencia */-----------------------------------------------------------------------------
 Delimiter $$
 create procedure sp_ModificarContactoUrgencia(p_codigoContactoUrgencia int,p_nombres varchar(50),p_apellidos varchar(50),p_numeroContacto varchar(10),p_codigoPaciente int)
 begin
 update contactoUrgencia
	set
    nombres=p_nombres,
    apellidos=p_apellidos,
    numeroContacto=p_numeroContacto,
    codigoPaciente=p_codigoPaciente
		where codigoContactoUrgencia=p_codigoContactoUrgencia;
 end$$
 call sp_ModificarContactoUrgencia(1,'Martin','Martinez','5639-9890',3);
 
 /* Modificar turno */----------------------------------------------------------------------------------
 Delimiter $$
 create procedure sp_ModificarTurno(p_codigoTurno int,p_fechaTurno date,p_fechaCita date,p_valorCita  double,p_codigoEspecialidadMedicos int,p_codigoResponsableTurno int,p_codigoPaciente int )
 begin
 update turno
	set
    fechaTurno=p_fechaTurno,
    fechaCita=p_fechaCita,
    valorCita=p_valorCita,
    codigoEspecialidadMedicos=p_codigoEspecialidadMedicos,
    codigoResponsableTurno=p_codigoResponsableTurno,
    codigoPaciente=p_codigoPaciente
		where codigoTurno=p_codigoTurno ;
 end$$
call sp_ModificarTurno(2,'2019-06-02','2019-08-06',300,3,3,2);
/*Modificar ControCitas */-------------------------------------------------------------------------------------------------------------------------
Delimiter $$
create procedure sp_ModificarControlCitas(p_codigoControlCita int, p_fecha date,p_horaInicio varchar(45),p_horaFin varchar(45),p_codigoMedico int,p_codigoPaciente int)
begin
	update ControlCitas
    set
    fecha=p_fecha,
    horaInicio=p_horaInicio,
    horaFin=p_horaFin,
    codigoMedico=p_codigoMedico,
    codigoPaciente=p_codigoPaciente
		where codigoControlCita=p_codigoControlCita;
end$$
call sp_ModificarControlCitas(1,'2019-07-02','06:00 AM ','06:45 AM',1,1);
/*Modificar Recetas*/----------------------------------------------------------------------------------------------------------------
Delimiter $$
create procedure sp_ModificarRecetas(p_codigoReceta int, p_descripcionReceta varchar(45), p_codigoControlCita int)
begin
	update Recetas
    set
    descripcionReceta=p_descripcionReceta,
    codigoControlCita=p_codigoControlCita
		where codigoReceta=p_codigoReceta;
end$$
call sp_ModificarRecetas(2,'Eutirox,Aspirina',3);
------------------------------------------------------------# Procesos Eliminar # ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Eliminar Medicos*/
Delimiter $$ 
create procedure sp_EliminarMedicos (p_codigoMedico int)
begin
delete from Medicos
where  
codigoMedico = p_codigoMedico;
end$$
call sp_EliminarMedicos(3);

/* Eliminar telefonosMedico */----------------------------------------------------------------------------------
Delimiter $$
create procedure sp_EliminarTelefonoMedico(p_codigoTelefonoMedico int)
begin
delete from telefonosMedico
	where
		codigoTelefonoMedico = p_codigoTelefonoMedico;
end$$
call sp_EliminarTelefonoMedico(1);

/* Eliminar especialidades */-------------------------------------------------------
Delimiter $$
create procedure sp_EliminarEspecialidades(p_codigoEspecialidad int)
begin
delete from especialidades
	where
		codigoEspecialidad=p_codigoEspecialidad;
end$$
call sp_EliminarEspecialidades(2);

/* Eliminar horario */----------------------------------------------------------------
Delimiter $$
create procedure sp_EliminarHorario(p_codigoHorario int)
begin
delete from horario
	where 
		codigoHorario=p_codigoHorario;
end$$       
call sp_EliminarHorario(1);

  /* Eliminar especialidadMedicos */-----------------------------------------------------------
  Delimiter $$
  create procedure sp_EliminarEspecialidadMedicos(p_codigoEspecialidadMedicos int)
  begin
  delete from especilidadMedicos
	where 
		codigoEspecialidadMedicos=p_codigoEspecialidadMedicos;
	end$$
  call sp_EliminarEspecialidadMedicos(1);
  
  /* Eliminar areas */-----------------------------------------------------------------------
  Delimiter $$
  create procedure sp_EliminarAreas(p_codigoArea int)
  begin
  delete from areas
	where codigoArea=p_codigoArea;
end$$
call sp_EliminarAreas(2);

/* Eliminar cargos */--------------------------------------------------------------------------
Delimiter $$
create procedure sp_EliminarCargos(p_codigoCargo int)
begin
delete from cargos
	where codigoCargo=p_codigoCargo;
end$$
  call sp_EliminarCargos(2);
  
  /* Eliminar responsableTurno */----------------------------------------------------------------
  Delimiter $$
  create procedure sp_EliminarResponsableTurno(p_codigoResponsableTurno int)
  begin
  delete from responsableTurno
	where 
		codigoResponsableTurno=p_codigoResponsableTurno;
  end$$
  call sp_EliminarResponsableTurno(2);
 
 /* Eliminar pacientes*/-------------------------------------------------------------------
 Delimiter $$
 create procedure sp_EliminarPacientes(p_codigoPaciente int)
 begin
 delete from pacientes
	where
		codigoPaciente=p_codigoPaciente;
 end$$
 call sp_EliminarPacientes(1);
 
 /* Elminar contactoUrgencia */--------------------------------------------------
 Delimiter $$
 create procedure sp_EliminarContactoUrgencia(p_codigoContactoUrgencia int)
 begin
 delete from contactoUrgencia
	where
		codigoContactoUrgencia=p_codigoContactoUrgencia;
 end$$
 call sp_EliminarContactoUrgencia(1);
 
 /* Eliminar turno */------------------------------------------------------------------------------------------------------
 Delimiter $$
 create procedure sp_EliminarTurno(p_codigoTurno int)
 begin
 delete from turno
	where codigoTurno = p_codigoTurno;
end$$
call sp_EliminarTurno(1);
/* Eliminar ControlCitas*/--------------------------------------------------------------------------------------------------------
Delimiter $$
create procedure sp_EliminarContrlCitas(p_codigoControlCita int)
begin
	delete from ControlCitas
		where codigoControlCita=p_codigoControlCita;
end$$
call sp_EliminarContrlCitas(1);
/* Eliminar Recetas*/-----------------------------------------------------------------------------------------------------------------------
Delimiter $$
create procedure sp_EliminarRecetas(p_codigoReceta int)
begin 
	delete from Recetas
		where codigoReceta=p_codigoReceta;
end$$
call sp_EliminarRecetas(1);
----------------------------------------------------------# Procesos Buscar #----------------------------------------------------------------------------------------------------------------------------------------------------------------
 /* Buscar Medicos*/
 Delimiter $$
create procedure sp_BuscarMedicos (p_codigoMedico int)
	begin
    select*from Medicos where codigoMedico=p_codigoMedico;
    end$$
    call sp_BuscarMedicos(1);
    
    /* Buscar teleonosMedico */
    Delimiter $$
    create procedure sp_BuscarTelefonosMedicos(p_codigoTelefonoMedico int)
    begin
    select*from telefonosMedico 
			where codigoTelefonoMedico=p_codigoTelefonoMedico;
    end$$
 call sp_BuscarTelefonosMedicos(1);
 
 /* Buscar especialidades */-------------------------------------------------------
 Delimiter $$
 create procedure sp_BuscarEspecialidades(p_codigoEspecialidad int)
 begin
 select*from especialidades
	where codigoEspecialidad=p_codigoEspecialidad;
 end$$
 call sp_BuscarEspecialidades(1); 
 
 /* Buscar horario */--------------------------------------------------------------------
 
 Delimiter $$
 create procedure sp_BuscarHorario(p_codigoHorario int) 
 begin
	select*from horario
		where codigoHorario=p_codigoHorario;
 end$$
 call sp_BuscarHorario(2);
 
/* Buscar especialidadMedicos */-----------------------------------------------------------------------------
Delimiter $$
create procedure sp_BuscarEspecialidadMedicos(p_codigoEspecialidadMedicos int)
begin
	select*from especialidadMedicos
		where codigoEspecialidadMedicos=p_codigoEspecialidadMedicos;
end$$
call sp_BuscarEspecialidadMedicos(2);

/* Buscar Areas */----------------------------------------------------------------
Delimiter $$
create procedure sp_BuscarAreas(p_codigoArea int)
begin
	select*from areas
		where codigoArea=p_codigoArea;
end$$
call sp_BuscarAreas(1);

/* Buscar cargos */
Delimiter $$
create procedure sp_BuscarCargos(p_codigoCargo int)
begin
	select*from cargos
		where codigoCargo=p_codigoCargo;
end$$
call sp_BuscarCargos(2);
 
/*Buscar responsableTurno */---------------------------------------------------------------------
Delimiter $$
create procedure sp_BuscarResponsableTurno(p_codigoResponsableTurno int)
begin
	select*from responsableTurno
		where codigoResponsableTurno=p_codigoResponsableTurno;
end$$
call sp_BuscarResponsableTurno(2);
 
/* Buscar pacientes*/-----------------------------------------------------------------------------------
Delimiter $$
create procedure sp_BuscarPacientes(p_codigoPaciente int)
begin
	select*from pacientes
		where codigoPaciente=p_codigoPaciente;
end$$
call sp_BuscarPacientes(1);
/* Buscar contactoUrgencia */
Delimiter $$
create procedure sp_BuscarContactoUrgencia(p_codigoContactoUrgencia int)
begin
	select*from contactoUrgencia
		where codigoContactoUrgencia=p_codigoContactoUrgencia;
end$$
  call sp_BuscarContactoUrgencia(2);
  
 
  /* Buscar turno */
  Delimiter $$
  create procedure sp_BuscarTurno (p_codigoTurno int)
  begin
	select*from turno
		where codigoTurno=p_codigoTurno;
  end$$
  call sp_BuscarTurno(1);
  /* Buscar ControlCitas*/------------------------------------------------------------------------------------------------------------------------------------
  Delimiter $$
  create procedure sp_BuscarControlCitas(p_codigoControlCita int)
  begin
	  select * from ControlCitas
		where codigoControlCita=p_codigoControlCita;
	end$$
  call sp_BuscarControlCitas(2);
  /* Buscar Recetas*/---------------------------------------------------------------------------------------------------------------------------------------
  Delimiter $$
  create procedure sp_BuscarRecetas(p_codigoReceta int)
  begin
	select * from Recetas
		where codigoReceta=p_codigoReceta;
  end$$
  call sp_BuscarRecetas(2);
 ---------------------------------------------------# Procesos Listar #---------------------------------------------------------------------------------
 /* Lista Medicos*/

Delimiter $$
create procedure sp_Lista_Medicos ( )
	begin
    select codigoMedico,licenciaMedica,nombre,apellidos,horaEntrada,haraSalida,sexo from Medicos;
    end$$
    call sp_Lista_Medicos();
    
 /* Lista telefonosMedico */-------------------------------
 Delimiter $$
 create procedure sp_ListaTelefonoMedico()
 begin
	select codigoTelefonoMedico,telefonoPersonal,telefonoTrabajo,codigoMedico from telefonosMedico;
 end$$
 call sp_ListaTelefonoMedico(); 
 
 /* Lista especialidades*/-----------------------------------------------------------------------
 Delimiter $$
 create procedure sp_especialidades()
 begin
	select codigoEspecialidad,nombreEspecialidad from especialidades;
 end$$
 call sp_especialidades();
 
 /* Listar horario*/---------------------------------------------------------------------------------------
 Delimiter $$
 create procedure sp_Listarhorario()
 begin
	select codigoHorario, horarioInicio, horarioSalida, lunes, martes, miercoles, jueves, viernes from horario;
 end$$
 call sp_Listarhorario();
 
 /* Lista especialidadMedicos */-----------------------------------------------------------------------------
Delimiter $$
create procedure sp_ListaEspecialidadMedicos()
begin
	select codigoEspecialidadMedicos, codigoMEdico,codgoEspecialidad,codigoHorario from especialidadMedicos;
end$$
call sp_ListaEspecialidadMedicos();
  
/* Lista areas*/------------------------------------------------------------------
Delimiter $$
create procedure sp_ListaAreas()
begin
	select codigoArea, nombreArea from areas;
end$$
call sp_ListaAreas();

/* Lista cargos*/------------------------------------------------------------------
Delimiter $$
create procedure sp_ListaCargos()
begin
	select codigoCargo, nombreCargo from cargos;
end$$
call sp_ListaCargos();

 /* Lista responsableTurno */-----------------------------------------------------
  Delimiter $$
  create procedure sp_ListaResponsableTurno()
  begin
	select codigoResponsableTurno, nombreResponsable,apellidosResponsable,telefonoPersonal,codigoArea,codigoCargo from responsableTurno;
  end$$
  call sp_ListaResponsableTurno();
 
  
  /* Lista pacientes*/-----------------------------------------------------------------
  Delimiter $$
  create procedure sp_ListaPacientes()
  begin
	select codigoPaciente,DPI,apellidos,nombres,fechaNacimiento,edad,direccion,ocupacion,sexo from pacientes;
  end$$
  call sp_ListaPacientes();
  
 /*listar contactoUrgencia */------------------------------------------------------------------------------------------------
 Delimiter $$
 create procedure sp_ListaContactoUrgencia()
 begin
	select codigoContactoUrgencia,nombres,numeroContacto,codigoPaciente from contactoUrgencia;
 end$$
 call sp_ListaContactoUrgencia();
 
 /* Lista turno */-------------------------------------------------------------------------------------------
 Delimiter $$
 create procedure sp_ListaTurno()
 begin
	select codigoTurno,fechaTurno,fechaCita,valorCita,codigoEspecialidadMedicos,codigoResponsableTurno,codigoPaciente from turno;
 end$$
 call sp_ListaTurno();
 /*Listar Control Citas*/---------------------------------------------------------------------------------------------------------------------------
 Delimiter $$
 create procedure sp_ListaControlCitas()
 begin
	 select codigoControlCita,fecha,horaInicio,horaFin,codigoMedico,codigoPaciente from ControlCitas;
 end$$
 call sp_ListaControlCitas();
 /*Listar Recetas*/-------------------------------------------------------------------------------------------------------------------------------
 Delimiter $$
 create procedure sp_ListarRecetas()
 begin
	select codigoReceta,descripcionReceta,codigoControlCita from Recetas;
 end$$
 call sp_ListarRecetas();
 ------------------------------------------------------------------------------------------------------------------------------------------
 ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'admin';
 /*Reporte general */
Delimiter $$
create procedure sp_MedicoHorario(in p_codigoMedico int)
begin

select h.* from especialidadmedicos me inner join horario h on h.codigoHorario= me.codigoHorario where me.codigoMedico = p_codigoMedico;

end $$
call sp_MedicoHorario(1);
Delimiter $$
create procedure sp_Mostrar(p_codigoTurno int)
begin
select turno.codigoTurno, turno.codigoPaciente, pacientes.nombres ,responsableturno.codigoResponsableTurno,
responsableturno.nombreResponsable, horario.codigoHorario, horario.horarioInicio, horario.horarioSalida,
especialidadmedicos.codigoEspecialidadMedicos,especialidadmedicos.codigoEspecialidad,especialidades.nombreEspecialidad   from turno
inner join pacientes on pacientes.codigoPaciente=turno.codigoPaciente
inner join responsableturno on responsableturno.codigoResponsableTurno=turno.codigoResponsableTurno
inner join especialidadmedicos on especialidadmedicos.codigoEspecialidadMedicos=turno.codigoEspecialidadMedicos
inner join horario on horario.codigoHorario=especialidadmedicos.codigoHorario
inner join especialidades on especialidades.codigoEspecialidad=especialidadmedicos.codigoEspecialidad
where codigoTurno=p_codigoTurno;
end$$
call sp_Mostrar(1);


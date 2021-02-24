create database Calendario;
use Calendario ;

create table Categorias(
	categoriaId int not null auto_increment,
    categoriaDesc varchar(25) not null unique,
	PRIMARY KEY (categoriaId)
);

create table Equipos(
	equipoId int not null auto_increment,
    equipoNombre varchar(25) not null unique,
    equipoCategoria int not null,
    PRIMARY KEY (equipoId),
    CONSTRAINT FK_EquipoCategoria FOREIGN KEY (equipoCategoria) REFERENCES Categorias(categoriaId)
);

create table PosicionesMasculino(
	posicionId int not null auto_increment,
    posicionLugar int not null,
    posicionEquipo int not null,
    posicionJJ int not null,
    posicionJG int not null,
    posicionJE int not null,
    posicionPP int not null,
    posicionGF int not null,
    posicionGC int not null,
    posicoinD2F int not null,
    posicionPTS int not null,
    PRIMARY KEY (posicionID),
    CONSTRAINT FK_PosicionEquipoMasculino FOREIGN KEY (posicionEquipo) REFERENCES Equipos(equipoId)
);


create table PosicionesFemenino(
	posicionId int not null auto_increment,
    posicionLugar int not null,
    posicionEquipo int not null,
    posicionJJ int not null,
    posicionJG int not null,
    posicionJE int not null,
    posicionPP int not null,
    posicionGF int not null,
    posicionGC int not null,
    posicoinD2F int not null,
    posicionPTS int not null,
    PRIMARY KEY (posicionID),
    CONSTRAINT FK_PosicionEquipoFemenino FOREIGN KEY (posicionEquipo) REFERENCES Equipos(equipoId)
);

create table EstadoFecha(
	estadoFecha int not null,
    estadoFechaDesc varchar(25),
    PRIMARY KEY (estadoFecha)
);

create table Fechas(
	fechaId int not null auto_increment,
    fechaJornada varchar(25),
    fechaFecha date,
    fechaHora time,
    fechaEquipoLocal int,
    fechaLocalGoles int,
    fechaEquipoVisita int,
    fechaVisitaGoles int,
    fechaEstado int default 1,
    PRIMARY KEY (fechaId),
    CONSTRAINT FK_FechaEquipoLocal FOREIGN KEY (fechaEquipoLocal) REFERENCES Equipos(equipoId),
    CONSTRAINT FK_FechaEquipoVisita FOREIGN KEY (fechaEquipoVisita) REFERENCES Equipos(equipoId),
	CONSTRAINT FK_FechaEstado FOREIGN KEY (fechaEstado) REFERENCES EstadoFecha(estadoFecha)
);


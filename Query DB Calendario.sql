create database CalendarioPartidos;
use CalendarioPartidos;


create table Categorias(
	categorioId int not null,
    categoriaDesc varchar(25) unique not null, 
    PRIMARY KEY (categorioId)
);

create table Equipos(
	equipoId int not null,
    equipoDesc varchar(25) unique not null,
    equipoCategoria int not null,
    PRIMARY KEY (equipoId),
    CONSTRAINT FK_EquipoCategoria FOREIGN KEY (equipoCategoria) REFERENCES Categorias(categorioId)
);

create table TablaPosiciones(
	posicionId int not null, 
    posicionEquipo int not null,
    posicionJJ int not null,
    posicionJG int not null,
    posicionJE int not null,
    posicionPP int not null,
    posicionGF int not null,
    posicionGC int not null,
    posicionesD2F int not null,
    posicionPTS int not null,
    PRIMARY KEY (posicionId),
	CONSTRAINT FK_PosicionesEquipo FOREIGN KEY (posicionEquipo) REFERENCES Equipos(equipoId)
);

create table EstadoPartido(
	estadoPedidoId int not null,
    estadoPartidoDesc varchar(25) not null,
    PRIMARY KEY (estadoPedidoId)
);

create table Resultados(
	resultadosId int not null,
    resultadosNombreVisitante int not null,
    resultadosVisitante int not null,
    resultadoPuntosVisitante int not null,
    resultadoNombreLocal int not null,
    resultadoPuntosLocal int not null,
    resultadoLocal int not null,
    resultadoEstadoPartido int not null,
	PRIMARY KEY (resultadosId),
    CONSTRAINT FK_ResultadoEquipoLocal FOREIGN KEY (resultadoNombreLocal) REFERENCES Equipos(equipoId),
	CONSTRAINT FK_ResultadoEquipoVisitante FOREIGN KEY (resultadosNombreVisitante) REFERENCES Equipos(equipoId),
	CONSTRAINT FK_ResultadoEstado FOREIGN KEY (resultadoEstadoPartido) REFERENCES estadoPartido(estadoPedidoId)
);
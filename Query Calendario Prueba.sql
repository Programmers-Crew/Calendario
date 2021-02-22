create database Prueba;
use Prueba;

create table PruebaFecha(
	fechaId int not null primary key,
    fechaInicio date,
    fechaFinal date,
    fechaResultado int
);

insert into PruebaFecha(fechaId, fechaInicio,fechaFinal)
	values(1, "2021-02-01", "2021-02-20");
    
update PruebaFecha
	set fechaResultado = (fechaInicio - fechaFinal)*-1;
		

SET SQL_SAFE_UPDATES = 0;
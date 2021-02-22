-- insert obligatorios 
insert into Categorias(categoriaId, categoriaDesc)
	values(1, "MASCULINO"), (2, "FEMENINO");

insert into estadoFecha(estadoFecha, estadoFechaDesc)
	values(1, "PENDIENTE"), (2, "JUGADO");
    
-- Entidad Equipos
DELIMITER $$
	create procedure SpListarEquipos()
		begin
			select 
				e.equipoNombre,
                c.categoriaDesc
            from 
				Equipos as e
			inner join 
				Categorias as c
			on e.equipoCategoriaId = c.categoriaId;
        end $$
DELIMITER ;

DELIMITER $$
	create procedure SpBuscarEquipo(idBuscado int)
		begin
			select 
				e.equipoNombre,
                c.categoriaDesc
            from 
				Equipos as e
			inner join 
				Categorias as c
			on e.equipoCategoriaId = c.categoriaId
				where e.equipoId = idBuscado;
        end $$		
DELIMITER ;

DELIMITER $$
	create procedure SpAgregarEquipo(nombre varchar(25), categoria int)
		begin
			insert into Equipos(equipoNomhbre, equipoCategoria)
				values(nombre, categoria);
        end $$ 
DELIMITER ;

DELIMITER $$
	create procedure SpActualizarEquipo(idBuscado int, nombre varchar(25))
		begin 
			update Equipos 
				set equipoNombre = nombre
					where equipoId = idBuscado;
        end $$
DELIMITER ;

DELIMITER $$
	create procedure SpEliminarEquipo(idBuscado int)
		begin
			delete from Equipos
				where equipoId = idBuscado;
        end $$
DELIMITER ; 

-- Posicines masculino
DELIMITER $$
	create procedure SpListarPosiciones()
		begin
			select 
				pm.posicionLugar,
                pm.posicionEquipo,
                pm.posicionJJ,
                pm.posicionJG,
                pm.posicionJE,
                pm.posicionPP,
                pm.posicionGF,
                pm.posicionGC,
                pm.posicionD2F,
                pm.posicionPTS
            from 
				PosicionesMasculino as pm
			Order by pm.posicionPTS asc;
        end $$
DELIMITER ;

-- Entidad Fechas 
DELIMITER $$
	create procedure SpListarFechas()
		begin
			select 
				f.fechaJornada,
                f.fechaFecha,
                f.fechaHora,
                equipoLocal.equipoNombre,
                equipoVisitante.equipoNombre
			from 
				Fechas as f
			inner join Equipos as equipoLocal
				on fechaEquipoLocal = equipoId
			inner join Equipos as equipoVisitante 
				on fechaEquipoVisitante = equipoId
			where fechaEstado = 1
			order by fechaFecha asc;
        end $$
DELIMITER ;

DELIMITER $$
	create procedure SpFiltrarFechas(fechaInicio date, fechaFinal date)
		begin
			select 
				f.fechaJornada,
                f.fechaFecha,
                f.fechaHora,
                equipoLocal.equipoNombre,
                equipoVisitante.equipoNombre,
                ef.fechaEstadoDesc
            from 
				Fechas as f
			inner join Equipos as equipoLocal
				on fechaEquipoLocal = equipoId
			inner join Equipos as equipoVisitante 
				on fechaEquipoVisitante = equipoId
			inner join EstadoFecha as ef
				on f.estadoFecha = ef.estadoFecha
			where fechaFecha between fechaInicio and fechaFinal
				and fechaEstado = 1
			order by fechaFecha asc;
        end $$
DELIMITER ;

DELIMITER $$
	create procedure SpAgregarFecha(jornada varchar(25), fecha date, hora time, equipoLocal int, equipoVisitante int)
		begin
			insert into Fechas(fechaJornada,fechaFecha,fechaHora,fechaEquipoLocal,fechaEquipoVisita)
				value(jornada, fecha, hora, equipoLocal, equipoVisitante);
        end $$
DELIMITER ;

DELIMITER $$
	create procedure SpActualizarJornada(idBuscado int,fecha date, hora time)
		begin
			update Fechas
				set	
					fechaFecha = fecha,
                    fechaHora = hora
				where fechaId = idBuscado and fechaEstado = 1;
        end $$
DELIMITER ;

DELIMITER $$
	create procedure SpEliminarFecha(idBuscado int)
		begin
			delete from Fechas
				where fechaId = idBuscado;
        end $$
DELIMITER ;

-- Entidad Resultados
DELIMITER $$
	create procedure SpListarResultados()
		begin 
			select
				f.fechaJornada,
                f.fechaFecha,
                f.fechaHora,
                f.fechaEquipoLocal,
                f.fechaLocalGoles,
                f.fechaEquipoVisita,
                f.fechaVisitaGoles
			from 
				Fechas as f
			where 
				f.fechaEstado = 2;
        end $$
DELIMITER ;

DELIMITER $$
	create procedure SpConfirmarFechaMasculino(idBuscado int,golesLocal int, golesVisita int)
		begin
			Update Fechas as f
				inner join PosicionesMasculino as pmLocal
					on f.fechaEquipoLocal = pmLocal.posicionEquipo
				inner join PosicionesMasculino as pmVisitante
					on f.fechaEquipoVisita = pmVisitante.posicionEquipo
			set 
				f.fechaEstado = 2,
                f.fechaLocalGoles = golesLocal,
                f.fechaVisitaGoles = golesVisita,
                -- Puntos
                pmLocal.posicionPTS = if (golesLocal > golesVisita, pmLocal.posicionPTS + 3, pmLocal.posicionPTS + 0),
                pmVisitante.posicionPTS = if (golesLocal < golesVisita, pmVisitante.posicionPTS + 3, pmVisitante.posicionPTS + 0),
                -- Juegos Jugados
                pmLocal.posicionJJ = pmLocal.posicionJJ + 1,
                pmVisitante.posicionJJ = pmVisitante.posicionJJ + 1,
                -- Juegos Ganados
                pmLocal.posicionJG = if(golesLocal > golesVisita, pmLocal.posicionJG +1, pmLocal.posicionJG + 0),
                pmVisitante.posicionJG = if(golesLocal < golesVisita, pmVisitante.posicionJG +1, pmVisitante.posicionJG + 0),
                -- Juegos Emptados
                pmLocal.posicionJE = if(golesLocal = golesVisita, pmLocal.posicionJE + 1, pmLocal.posicionJE + 0),
                pmVisitante.posicionJE = if(golesLocal = golesVisita, pmVisitante.posicionJE + 1, pmVisitante.posicionJE + 0),
                -- Juegos Perdidos
                pmLocal.posicionPP = if(golesLocal < golesVisita,  pmLocal.posicionPP + 1,  pmLocal.posicionPP + 0),
				pmVisitante.posicionPP = if(golesLocal > golesVisita,  pmVisitante.posicionPP + 1,  pmVisitante.posicionPP + 0),
                -- Goles a favor
                pmLocal.posicionGF = pmLocal.posicionGF + golesLocal,
                pmVisitante.posicionGF = pmVisitante.posicionGF + golesVisita,
                -- Goles en contra
                pmLocal.posicionGC = pmLocal.posicionGC + golesVisita,
                pmVisitante.posicionGC = pmVisitante.posicionGC + golesLocal,
                -- Diferencia de goles
                pmLocal.posicoinD2F = pmLocal.posicionGF - pmLocal.posicionGC,
                pmVisitante.posicoinD2F = pmVisitante.posicionGF - pmVisitante.posicionGC;
        end $$
DELIMITER ;


DELIMITER $$
	create procedure SpConfirmarFechaFemenino(idBuscado int,golesLocal int, golesVisita int)
		begin
			Update Fechas as f
				inner join PosicionesFemenino as pmLocal
					on f.fechaEquipoLocal = pmLocal.posicionEquipo
				inner join PosicionesFemenino as pmVisitante
					on f.fechaEquipoVisita = pmVisitante.posicionEquipo
			set 
				f.fechaEstado = 2,
                f.fechaLocalGoles = golesLocal,
                f.fechaVisitaGoles = golesVisita,
                -- Puntos
                pmLocal.posicionPTS = if (golesLocal > golesVisita, pmLocal.posicionPTS + 3, pmLocal.posicionPTS + 0),
                pmVisitante.posicionPTS = if (golesLocal < golesVisita, pmVisitante.posicionPTS + 3, pmVisitante.posicionPTS + 0),
                -- Juegos Jugados
                pmLocal.posicionJJ = pmLocal.posicionJJ + 1,
                pmVisitante.posicionJJ = pmVisitante.posicionJJ + 1,
                -- Juegos Ganados
                pmLocal.posicionJG = if(golesLocal > golesVisita, pmLocal.posicionJG +1, pmLocal.posicionJG + 0),
                pmVisitante.posicionJG = if(golesLocal < golesVisita, pmVisitante.posicionJG +1, pmVisitante.posicionJG + 0),
                -- Juegos Emptados
                pmLocal.posicionJE = if(golesLocal = golesVisita, pmLocal.posicionJE + 1, pmLocal.posicionJE + 0),
                pmVisitante.posicionJE = if(golesLocal = golesVisita, pmVisitante.posicionJE + 1, pmVisitante.posicionJE + 0),
                -- Juegos Perdidos
                pmLocal.posicionPP = if(golesLocal < golesVisita,  pmLocal.posicionPP + 1,  pmLocal.posicionPP + 0),
				pmVisitante.posicionPP = if(golesLocal > golesVisita,  pmVisitante.posicionPP + 1,  pmVisitante.posicionPP + 0),
                -- Goles a favor
                pmLocal.posicionGF = pmLocal.posicionGF + golesLocal,
                pmVisitante.posicionGF = pmVisitante.posicionGF + golesVisita,
                -- Goles en contra
                pmLocal.posicionGC = pmLocal.posicionGC + golesVisita,
                pmVisitante.posicionGC = pmVisitante.posicionGC + golesLocal,
                -- Diferencia de goles
                pmLocal.posicoinD2F = pmLocal.posicionGF - pmLocal.posicionGC,
                pmVisitante.posicoinD2F = pmVisitante.posicionGF - pmVisitante.posicionGC;
        end $$
DELIMITER ;




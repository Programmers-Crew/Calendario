DELIMITER $$
	create procedure Sp_ListarEquipos()
		begin 
			select
				e.equipoId,
                e.equipoDesc,
                c.categoriaDesc
            from 
				Equipos as e
			inner join categorias as c
				on e.equipoCategoria = c.categorioId;
        end $$
DELIMITER ;

-- Entidad Equipos
DELIMITER $$
	create procedure Sp_BuscarEquipos(idBuscado int)
		begin
			select
				e.equipoId,
                e.equipoDesc,
                c.categoriaDesc
            from 
				Equipos as e
			inner join categorias as c
				on e.equipoCategoria = c.categorioId
			where
				e.equipoId = idBuscado;
        end $$
DELIMITER ;

DELIMITER $$
	create procedure Sp_AgregarEquipos(descripcion varchar(25), categoria int)
		begin
			insert into Equipos(equipoDesc,equipoCategoria)
				values(descripcion,categoria);
        end $$
DELIMITER ;

DELIMITER $$
	create procedure Sp_ActualizarEquipos(descripcion varchar(25), categoria int)
		begin
			update 
				Equipos
			set 
				equipoDesc = descripcion,
				equipoCategoria = categoria;
        end $$
DELIMITER ;

DELIMITER $$
	create procedure Sp_EliminarEquipos(idBuscado int)
		begin 
			delete from equipos
				where equipoId = idBuscado;
        end $$
DELIMITER ;

-- Entidad 

insert into categorias(categoriaDesc)
	values('Masculino'), ('Femenino');


-- -----------------------------------------------------
-- procedure Insert_Evento_has_Confederaciones
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Insert_Evento_has_Confederaciones`( PEvento_idEvento INT(11), PConfederaciones_idconfederaciones INT(11))
BEGIN
INSERT INTO proyecto2.evento_has_confederaciones
(
  Evento_idEvento
 ,confederaciones_idconfederaciones
)
VALUES
(
  PEvento_idEvento -- Evento_idEvento - INT(11) NOT NULL
 ,PConfederaciones_idconfederaciones -- confederaciones_idconfederaciones - INT(11) NOT NULL
);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Insert_Evento_has_Equipo
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Insert_Evento_has_Equipo`(PEvento_idEvento INT(11), PEquipo_idequipo INT(11))
BEGIN
INSERT INTO proyecto2.evento_has_equipo
(
  Evento_idEvento
 ,equipo_idequipo
 ,ganador
 ,segundo_lugar
)
VALUES
(
  PEvento_idEvento -- Evento_idEvento - INT(11) NOT NULL
 ,PEquipo_idequipo -- equipo_idequipo - INT(11) NOT NULL
 ,0 -- ganador - TINYINT(1)
 ,0 -- segundo lugar - TINYINT(1)
);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Insert_sede
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Insert_sede`(IN PEvento_idEvento INT(11), IN PPais_idPais INT(11))
BEGIN
INSERT INTO proyecto2.sede
(
  Evento_idEvento
 ,Pais_idPais
)
VALUES
(
  PEvento_idEvento -- Evento_idEvento - INT(11) NOT NULL
 ,PPais_idPais -- Pais_idPais - INT(11) NOT NULL
);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure insert_accion
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_accion`(pidJugador int, pidPartido int, ptiempo int, pCatalogoAcciones int)
BEGIN
insert into accion(
	jugador_idjugador,
    partido_idpartido,
    tiempo,
    CatalogodeAcciones_idCatalogodeAcciones
  )
values(
	pidJugador,
    pidPartido,
    ptiempo,
    pCatalogoAcciones
);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_administrador
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_administrador`(pUsername varchar(45), pPassword varchar(45))
BEGIN
	insert into proyecto2.administrador(username, password)
    values(pUsername, AES_ENCRYPT(pPassword, 'basesrulez'));
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_alineacion
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_alineacion`(idEquipo int)
BEGIN
insert into alineacion( equipo_idequipo)
values( idEquipo);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_bitacoraporEquipo
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_bitacoraporEquipo`(idEquipo int, idGrupo int)
BEGIN
INSERT INTO `proyecto2`.`bitacoraporequipo`
(
`pj`,
`pg`,
`pe`,
`pp`,
`GF`,
`gc`,
`grupo_idgrupo`,
`equipo_idequipo`)
VALUES
(
0,
0,
0,
0,
0,
0,
idGrupo,
idEquipo);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_catalogo_de_acciones
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_catalogo_de_acciones`(pNombre varchar(45))
BEGIN
	insert into proyecto2.catalogo_de_acciones(nombre)
    values(pNombre);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_categoria_grupo
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_categoria_grupo`(pNombre varchar(45))
BEGIN
	insert into proyecto2.categoria_grupo(nombre)
    values(pNombre);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_confederacion
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_confederacion`(pNombre varchar(45), pIcono blob)
BEGIN
	insert into proyecto2.confederaciones(nombre, icono)
    values(pNombre, pIcono);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_continente
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_continente`(pNombre varchar(45))
BEGIN
	insert into proyecto2.continente(nombre)
    values(pNombre);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_equipo
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_equipo`(pnombre varchar(45), pbandera blob, ptecnico varchar(95), pconfederaciones int, pPais int)
BEGIN
	insert into equipo(
    nombre,
    bandera,
    tecnico,
    confederaciones_idconfederaciones,
    Pais_idPais
    )
    values(
    pnombre,
    pbandera ,
    ptecnico ,
    pconfederaciones ,
    pPais 
    );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_estadio
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_estadio`(pnombre varchar(45), idPais int, pcapacidad int)
BEGIN
insert into estadio(
	nombre,
	Pais_idPais,
	capacidad
)
values(
	pnombre,
    idPais,
    pcapacidad
);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_evento
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_evento`(pNombre varchar(45), pFechaInicio date, cantidad int, pTipoEvento int)
BEGIN
insert into evento(
	nombre,
	fecha_inicio,
    cantidad_equipos,
	Tipo_Eventos_idTipo_Eventos
)


values(
	pNombre ,
	pFechaInicio ,
    cantidad,
	pTipoEvento
);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_grupo
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_grupo`(pEventID int, pNombre varchar(45), categoria int)
BEGIN
	insert into proyecto2.grupo(Evento_idEvento, nombre, Categoria_Grupo_idCategoria_Grupo)
    values(pEventID, pNombre, categoria);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_jugador
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_jugador`(pnumCamiseta int, pnombre varchar(45), pApellidos varchar(45), pCedula varchar(45), pfoto blob,
idEquipo int, pPais int, pPosicion int )
BEGIN
	insert into jugador(
    numeroCamiseta,
    nombre,
    apellidos,
    cedula,
    foto,
    equipo_idequipo,
    suspendido,
    alineacion_idalineacion,
    Pais_idPais,
    capitan,
    posicion_idposicion
    )
    values (
    pnumCamiseta ,
    pnombre ,
    pApellidos ,
    pCedula ,
    pfoto ,
	idEquipo ,
	0 ,
    null ,
    pPais,
    0,
    pPosicion
    );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_pais
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_pais`(pNombre varchar(45), pBandera blob, pContinenteID int(11))
BEGIN
	insert into proyecto2.pais(nombre, bandera, Continente_idContinente)
    values(pNombre, pBandera, pContinenteID);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_partido
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_partido`(pEventID int, pEquipoLocal int, pEquipoVisita int,
									pEstadio int, pFecha date, Pidgrupo int)
BEGIN
	insert into partido(Evento_idEvento, EquipoLocal, EquipoVisita, Ganador,
    estadio_idestadio, fecha, grupo_idgrupo)
    values(pEventID , pEquipoLocal , pEquipoVisita , 0 ,
									pEstadio , pFecha, Pidgrupo );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_posicion
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_posicion`(pNombre varchar(45))
BEGIN
	insert into posicion(nombre)
    values(pNombre);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_tipo_evento
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_tipo_evento`(pNombre varchar(45))
BEGIN
	insert into tipo_eventos(nombre)
    values(pNombre);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure accionUpdate
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `accionUpdate`(Paccion_id INT,Pjugador_idjugador INT,Ppartido_idpartido INT, Ptiempo INT,Pcatalogo_acciones INT, pEquipo INT)
BEGIN
UPDATE proyecto2.accion 
SET
 jugador_idjugador = Pjugador_idjugador
 ,partido_idpartido = Ppartido_idpartido -- partido_idpartido - INT(11) NOT NULL
 ,tiempo = Ptiempo -- tiempo - INT(11)
 ,idCatalogo_de_Acciones = Pcatalogo_acciones -- Catalogo de Acciones_idCatalogo de Acciones - INT(11) NOT NULL
 ,equipo_idequipo = pEquipo
WHERE
  idAccion = Paccion_id; -- idAccion - INT(11) NOT NULL
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure alineacionUPDATE
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `alineacionUPDATE`(IN Pid_alineacion INT, IN Pid_equipo INT)
BEGIN
UPDATE proyecto2.alineacion 
SET
  equipo_idequipo = Pid_equipo -- equipo_idequipo - INT(11) NOT NULL

WHERE
  idalineacion = Pid_alineacion ;-- idalineacion - INT(11) NOT NULL
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure catalogoAccionesUPDATE
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `catalogoAccionesUPDATE`(Pidcatacciones INT, Pnombre VARCHAR(45))
BEGIN
UPDATE proyecto2.catalogo_de_acciones
SET
  nombre = Pnombre -- nombre - VARCHAR(45)
WHERE
  idCatalogo_de_Acciones = Pidcatacciones; -- idCatalogo de Acciones - INT(11) NOT NULL
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure confederacionesUpdate
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `confederacionesUpdate`(Pidconfederaciones INT, Pnombre VARCHAR(45), Picono BLOB)
BEGIN
UPDATE proyecto2.confederaciones 
SET
  nombre = Pnombre -- nombre - VARCHAR(45)
 ,icono = Picono -- icono - BLOB
WHERE
  idconfederaciones = Pidconfederaciones; -- idconfederaciones - INT(11) NOT NULL
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure continenteUPDATE
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `continenteUPDATE`(Pcontinente VARCHAR(45),Pid INT)
BEGIN
UPDATE proyecto2.continente 
SET
  nombre = Pcontinente -- nombre - VARCHAR(45)
WHERE
  idContinente = Pid; -- idContinente - INT(11) NOT NULL
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure equipoUPDATE
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `equipoUPDATE`(Pidequipo INT, Pnombre VARCHAR(45), Pbandera BLOB, Ptecnico VARCHAR(45),  Pidpais INT)
BEGIN
UPDATE proyecto2.equipo 
SET
  nombre = Pnombre -- nombre - VARCHAR(45)
 ,bandera =Pbandera  -- bandera - BLOB
 ,tecnico = Ptecnico -- tecnico - VARCHAR(95)
 ,Pais_idPais = Pidpais -- Pais_idPais - INT(11) NOT NULL
WHERE
  idequipo = Pidequipo; -- idequipo - INT(11) NOT NULL
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure estadioUPDATE
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `estadioUPDATE`(Pidestadio INT, Pnombre VARCHAR(45), Pidpais INT, Pcapacidad INT)
BEGIN
UPDATE proyecto2.estadio 
SET
  nombre = Pnombre-- nombre - VARCHAR(45)
 ,Pais_idPais = Pidpais -- Pais_idPais - INT(11) NOT NULL
 ,capacidad = Pcapacidad -- capacidad - INT(11)

WHERE
  idestadio = Pidestadio; -- idestadio - INT(11) NOT NULL
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure eventoUPDATE
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eventoUPDATE`(IN Pidevento INT, IN PNombre VARCHAR(45), IN Pfecha_inicio DATE)
BEGIN
UPDATE proyecto2.evento 
SET
  tipo = Ptipo -- tipo - VARCHAR(45)
 ,fecha_inicio = Pfecha_inicio-- fecha_inicio - DATE

WHERE
  idEvento = Pidevento; -- idEvento - INT(11) NOT NULL
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure grupoUPDATE
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `grupoUPDATE`(Pidgrupo INT, Pnombre VARCHAR(45))
BEGIN
UPDATE proyecto2.grupo 
SET
 nombre = Pnombre -- nombre - VARCHAR(45)
WHERE
  idgrupo = Pidgrupo;-- idgrupo - INT(11) NOT NULL
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure jugadorUPDATE
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `jugadorUPDATE`(Pidjugador INT, Pnumcamiseta INT, Pnombre VARCHAR(45),Papellido VARCHAR(45),Pcedula VARCHAR(45),Pfoto BLOB,Pidequipo INT, Pidpais INT)
BEGIN
UPDATE proyecto2.jugador 
SET
  numeroCamiseta = Pnumcamiseta -- numeroCamiseta - INT(11)
 ,nombre = Pnombre -- nombre - VARCHAR(45)
 ,apellidos = Papellido -- apellidos - VARCHAR(45)
 ,cedula = Pcedula -- cedula - VARCHAR(45)
 ,foto =  Pfoto-- foto - BLOB
 ,equipo_idequipo = Pidequipo -- equipo_idequipo - INT(11) NOT NULL
 ,Pais_idPais = Pidpais -- Pais_idPais - INT(11) NOT NULL
WHERE
  idjugador = Pidjugador; -- idjugador - INT(11) NOT NULL
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure paisUPDATE
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `paisUPDATE`(Pidpais INT, Pnombre VARCHAR(45),Pbandera BLOB,Pidcontinente INT)
BEGIN
UPDATE proyecto2.pais 
SET
  nombre = Pnombre -- nombre - VARCHAR(45)
 ,bandera = Pbandera -- bandera - BLOB
 ,Continente_idContinente = Pidcontinente -- Continente_idContinente - INT(11) NOT NULL
WHERE
  idPais = Pidpais; -- idPais - INT(11) NOT NULL
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure posicionUPDATE
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `posicionUPDATE`(Pidposicion INT, Pnombre VARCHAR(45))
BEGIN
UPDATE proyecto2.posicion
SET
  nombre = Pnombre -- nombre - VARCHAR(45)
WHERE
  idposicion = Pidposicion; -- idPais - INT(11) NOT NULL
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure tipoUPDATE
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `tipoUPDATE`(Pidtipo INT, Pnombre VARCHAR(45))
BEGIN
UPDATE proyecto2.tipo_eventos
SET
  nombre = Pnombre -- nombre - VARCHAR(45)
WHERE
  idTipo_Eventos = Pidtipo; -- idPais - INT(11) NOT NULL
END$$

DELIMITER ;

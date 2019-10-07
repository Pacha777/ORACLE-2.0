ET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema proyecto2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema proyecto2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyecto2` DEFAULT CHARACTER SET utf8 ;
USE `proyecto2` ;

-- -----------------------------------------------------
-- Table `proyecto2`.`catalogo_de_acciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`catalogo_de_acciones` (
  `idCatalogo_de_Acciones` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Fecha_Creacion` DATE NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idCatalogo_de_Acciones`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`continente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`continente` (
  `idContinente` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Fecha_Creacion` DATE NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idContinente`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`pais` (
  `idPais` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `bandera` BLOB NULL DEFAULT NULL,
  `Continente_idContinente` INT(11) NOT NULL,
  `Fecha_Creacion` DATE NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idPais`),
  INDEX `fk_Pais_Continente1_idx` (`Continente_idContinente` ASC),
  CONSTRAINT `fk_Pais_Continente1`
    FOREIGN KEY (`Continente_idContinente`)
    REFERENCES `proyecto2`.`continente` (`idContinente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`confederaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`confederaciones` (
  `idconfederaciones` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `icono` BLOB NULL DEFAULT NULL,
  `Fecha_Creacion` DATE NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idconfederaciones`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`equipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`equipo` (
  `idequipo` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `bandera` BLOB NULL DEFAULT NULL,
  `tecnico` VARCHAR(95) NULL DEFAULT NULL,
  `confederaciones_idconfederaciones` INT(11) NOT NULL,
  `Pais_idPais` INT(11) NOT NULL,
  `Fecha_Creacion` DATE NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idequipo`),
  INDEX `fk_equipo_confederaciones1_idx` (`confederaciones_idconfederaciones` ASC),
  INDEX `fk_equipo_Pais1_idx` (`Pais_idPais` ASC),
  CONSTRAINT `fk_equipo_Pais1`
    FOREIGN KEY (`Pais_idPais`)
    REFERENCES `proyecto2`.`pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipo_confederaciones1`
    FOREIGN KEY (`confederaciones_idconfederaciones`)
    REFERENCES `proyecto2`.`confederaciones` (`idconfederaciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`alineacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`alineacion` (
  `idalineacion` INT(11) NOT NULL AUTO_INCREMENT,
  `equipo_idequipo` INT(11) NOT NULL,
  `Fecha_Creacion` DATE NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idalineacion`),
  INDEX `fk_alineacion_equipo1_idx` (`equipo_idequipo` ASC),
  CONSTRAINT `fk_alineacion_equipo1`
    FOREIGN KEY (`equipo_idequipo`)
    REFERENCES `proyecto2`.`equipo` (`idequipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`posicion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`posicion` (
  `idposicion` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Fecha_Creacion` DATE NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idposicion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`jugador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`jugador` (
  `idjugador` INT(11) NOT NULL AUTO_INCREMENT,
  `numeroCamiseta` INT(11) NULL DEFAULT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `cedula` VARCHAR(45) NULL DEFAULT NULL,
  `foto` BLOB NULL DEFAULT NULL,
  `equipo_idequipo` INT(11) NOT NULL,
  `suspendido` TINYINT(1) NULL DEFAULT NULL,
  `alineacion_idalineacion` INT(11) NULL DEFAULT NULL,
  `Pais_idPais` INT(11) NOT NULL,
  `capitan` TINYINT(1) NULL DEFAULT NULL,
  `Fecha_Creacion` DATE NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  `posicion_idposicion` INT(11) NOT NULL,
  PRIMARY KEY (`idjugador`),
  UNIQUE INDEX `numeroCamiseta_UNIQUE` (`numeroCamiseta` ASC),
  INDEX `fk_jugador_equipo1_idx` (`equipo_idequipo` ASC),
  INDEX `fk_jugador_alineacion1_idx` (`alineacion_idalineacion` ASC),
  INDEX `fk_jugador_Pais1_idx` (`Pais_idPais` ASC),
  INDEX `fk_jugador_posicion1_idx` (`posicion_idposicion` ASC),
  CONSTRAINT `fk_jugador_Pais1`
    FOREIGN KEY (`Pais_idPais`)
    REFERENCES `proyecto2`.`pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jugador_alineacion1`
    FOREIGN KEY (`alineacion_idalineacion`)
    REFERENCES `proyecto2`.`alineacion` (`idalineacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jugador_equipo1`
    FOREIGN KEY (`equipo_idequipo`)
    REFERENCES `proyecto2`.`equipo` (`idequipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jugador_posicion1`
    FOREIGN KEY (`posicion_idposicion`)
    REFERENCES `proyecto2`.`posicion` (`idposicion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`tipo_eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`tipo_eventos` (
  `idTipo_Eventos` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Fecha_Creacion` DATE NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idTipo_Eventos`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`administrador` (
  `idadministrador` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARBINARY(200) NULL DEFAULT NULL,
  PRIMARY KEY (`idadministrador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`evento` (
  `idEvento` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `fecha_inicio` DATE NULL DEFAULT NULL,
  `Fecha_Creacion` DATE NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  `administrador_idadministrador` INT(11) NULL DEFAULT NULL,
  `cantidad_equipos` INT(11) NULL DEFAULT NULL,
  `Tipo_Eventos_idTipo_Eventos` INT(11) NOT NULL,
  PRIMARY KEY (`idEvento`),
  INDEX `fk_Evento_administrador1_idx` (`administrador_idadministrador` ASC),
  INDEX `fk_Evento_Tipo_Eventos1_idx` (`Tipo_Eventos_idTipo_Eventos` ASC),
  CONSTRAINT `fk_Evento_Tipo_Eventos1`
    FOREIGN KEY (`Tipo_Eventos_idTipo_Eventos`)
    REFERENCES `proyecto2`.`tipo_eventos` (`idTipo_Eventos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Evento_administrador1`
    FOREIGN KEY (`administrador_idadministrador`)
    REFERENCES `proyecto2`.`administrador` (`idadministrador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`estadio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`estadio` (
  `idestadio` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Pais_idPais` INT(11) NOT NULL,
  `capacidad` INT(11) NULL DEFAULT NULL,
  `Fecha_Creacion` DATE NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idestadio`),
  INDEX `fk_estadio_Pais1_idx` (`Pais_idPais` ASC),
  CONSTRAINT `fk_estadio_Pais1`
    FOREIGN KEY (`Pais_idPais`)
    REFERENCES `proyecto2`.`pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`categoria_grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`categoria_grupo` (
  `idCategoria_Grupo` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Fecha_Creacion` DATE NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idCategoria_Grupo`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`grupo` (
  `idgrupo` INT(11) NOT NULL AUTO_INCREMENT,
  `Evento_idEvento` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Fecha_Creacion` DATE NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  `Categoria_Grupo_idCategoria_Grupo` INT(11) NOT NULL,
  `id_nextgrupo` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idgrupo`),
  INDEX `fk_grupo_Evento1_idx` (`Evento_idEvento` ASC),
  INDEX `fk_grupo_Categoria_Grupo1_idx` (`Categoria_Grupo_idCategoria_Grupo` ASC),
  CONSTRAINT `fk_grupo_Categoria_Grupo1`
    FOREIGN KEY (`Categoria_Grupo_idCategoria_Grupo`)
    REFERENCES `proyecto2`.`categoria_grupo` (`idCategoria_Grupo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupo_Evento1`
    FOREIGN KEY (`Evento_idEvento`)
    REFERENCES `proyecto2`.`evento` (`idEvento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 10591
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`partido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`partido` (
  `idpartido` INT(11) NOT NULL AUTO_INCREMENT,
  `Evento_idEvento` INT(11) NOT NULL,
  `EquipoLocal` INT(11) NOT NULL,
  `EquipoVisita` INT(11) NOT NULL,
  `Ganador` INT(11) NULL DEFAULT NULL,
  `estadio_idestadio` INT(11) NOT NULL,
  `fecha` DATETIME NULL DEFAULT NULL,
  `Fecha_Creacion` DATE NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  `grupo_idgrupo` INT(11) NOT NULL,
  PRIMARY KEY (`idpartido`),
  INDEX `fk_partido_Evento1_idx` (`Evento_idEvento` ASC),
  INDEX `fk_partido_equipo1_idx` (`EquipoLocal` ASC),
  INDEX `fk_partido_equipo2_idx` (`EquipoVisita` ASC),
  INDEX `fk_partido_estadio1_idx` (`estadio_idestadio` ASC),
  INDEX `fk_partido_grupo1_idx` (`grupo_idgrupo` ASC),
  CONSTRAINT `fk_partido_Evento1`
    FOREIGN KEY (`Evento_idEvento`)
    REFERENCES `proyecto2`.`evento` (`idEvento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_partido_equipo1`
    FOREIGN KEY (`EquipoLocal`)
    REFERENCES `proyecto2`.`equipo` (`idequipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_partido_equipo2`
    FOREIGN KEY (`EquipoVisita`)
    REFERENCES `proyecto2`.`equipo` (`idequipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_partido_estadio1`
    FOREIGN KEY (`estadio_idestadio`)
    REFERENCES `proyecto2`.`estadio` (`idestadio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_partido_grupo1`
    FOREIGN KEY (`grupo_idgrupo`)
    REFERENCES `proyecto2`.`grupo` (`idgrupo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`accion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`accion` (
  `idAccion` INT(11) NOT NULL AUTO_INCREMENT,
  `jugador_idjugador` INT(11) NOT NULL,
  `partido_idpartido` INT(11) NOT NULL,
  `tiempo` INT(11) NULL DEFAULT NULL,
  `idCatalogo_de_Acciones` INT(11) NOT NULL,
  `Fecha_Creacion` DATE NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  `equipo_idequipo` INT(11) NOT NULL,
  PRIMARY KEY (`idAccion`),
  INDEX `fk_Accion_jugador1_idx` (`jugador_idjugador` ASC),
  INDEX `fk_Accion_partido1_idx` (`partido_idpartido` ASC),
  INDEX `fk_Accion_Catalogo de Acciones1_idx` (`idCatalogo_de_Acciones` ASC),
  INDEX `fk_Accion_equipo1_idx` (`equipo_idequipo` ASC),
  CONSTRAINT `fk_Accion_Catalogo de Acciones1`
    FOREIGN KEY (`idCatalogo_de_Acciones`)
    REFERENCES `proyecto2`.`catalogo_de_acciones` (`idCatalogo_de_Acciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Accion_equipo1`
    FOREIGN KEY (`equipo_idequipo`)
    REFERENCES `proyecto2`.`equipo` (`idequipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Accion_jugador1`
    FOREIGN KEY (`jugador_idjugador`)
    REFERENCES `proyecto2`.`jugador` (`idjugador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Accion_partido1`
    FOREIGN KEY (`partido_idpartido`)
    REFERENCES `proyecto2`.`partido` (`idpartido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`bitacora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`bitacora` (
  `idbitacora` INT(11) NOT NULL AUTO_INCREMENT,
  `Fecha_Creacion` TIMESTAMP NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  `pj` INT(11) NULL DEFAULT NULL,
  `pg` INT(11) NULL DEFAULT NULL,
  `pe` INT(11) NULL DEFAULT NULL,
  `pp` INT(11) NULL DEFAULT NULL,
  `GF` INT(11) NULL DEFAULT NULL,
  `gc` INT(11) NULL DEFAULT NULL,
  `grupo_idgrupo` INT(11) NOT NULL,
  `equipo_idequipo` INT(11) NOT NULL,
  PRIMARY KEY (`idbitacora`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`bitacoraporequipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`bitacoraporequipo` (
  `idbitacoraPorEquipo` INT(11) NOT NULL AUTO_INCREMENT,
  `pj` INT(11) NULL DEFAULT NULL,
  `pg` INT(11) NULL DEFAULT NULL,
  `pe` INT(11) NULL DEFAULT NULL,
  `pp` INT(11) NULL DEFAULT NULL,
  `GF` INT(11) NULL DEFAULT NULL,
  `gc` INT(11) NULL DEFAULT NULL,
  `grupo_idgrupo` INT(11) NOT NULL,
  `equipo_idequipo` INT(11) NOT NULL,
  `Fecha_Creacion` DATE NULL DEFAULT NULL,
  `Fecha_Edicion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idbitacoraPorEquipo`),
  INDEX `fk_bitacoraPorEquipo_grupo1_idx` (`grupo_idgrupo` ASC),
  INDEX `fk_bitacoraPorEquipo_equipo1_idx` (`equipo_idequipo` ASC),
  CONSTRAINT `fk_bitacoraPorEquipo_equipo1`
    FOREIGN KEY (`equipo_idequipo`)
    REFERENCES `proyecto2`.`equipo` (`idequipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bitacoraPorEquipo_grupo1`
    FOREIGN KEY (`grupo_idgrupo`)
    REFERENCES `proyecto2`.`grupo` (`idgrupo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`evento_has_confederaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`evento_has_confederaciones` (
  `Evento_idEvento` INT(11) NOT NULL,
  `confederaciones_idconfederaciones` INT(11) NOT NULL,
  PRIMARY KEY (`Evento_idEvento`, `confederaciones_idconfederaciones`),
  INDEX `fk_Evento_has_confederaciones_confederaciones1_idx` (`confederaciones_idconfederaciones` ASC),
  INDEX `fk_Evento_has_confederaciones_Evento_idx` (`Evento_idEvento` ASC),
  CONSTRAINT `fk_Evento_has_confederaciones_Evento`
    FOREIGN KEY (`Evento_idEvento`)
    REFERENCES `proyecto2`.`evento` (`idEvento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Evento_has_confederaciones_confederaciones1`
    FOREIGN KEY (`confederaciones_idconfederaciones`)
    REFERENCES `proyecto2`.`confederaciones` (`idconfederaciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`evento_has_equipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`evento_has_equipo` (
  `Evento_idEvento` INT(11) NOT NULL,
  `equipo_idequipo` INT(11) NOT NULL,
  `ganador` TINYINT(1) NULL DEFAULT NULL,
  `segundo_lugar` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`Evento_idEvento`, `equipo_idequipo`),
  INDEX `fk_Evento_has_equipo_equipo1_idx` (`equipo_idequipo` ASC),
  INDEX `fk_Evento_has_equipo_Evento1_idx` (`Evento_idEvento` ASC),
  CONSTRAINT `fk_Evento_has_equipo_Evento1`
    FOREIGN KEY (`Evento_idEvento`)
    REFERENCES `proyecto2`.`evento` (`idEvento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Evento_has_equipo_equipo1`
    FOREIGN KEY (`equipo_idequipo`)
    REFERENCES `proyecto2`.`equipo` (`idequipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto2`.`sede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`sede` (
  `Evento_idEvento` INT(11) NOT NULL,
  `Pais_idPais` INT(11) NOT NULL,
  PRIMARY KEY (`Evento_idEvento`, `Pais_idPais`),
  INDEX `fk_Evento_has_Pais_Pais1_idx` (`Pais_idPais` ASC),
  INDEX `fk_Evento_has_Pais_Evento1_idx` (`Evento_idEvento` ASC),
  CONSTRAINT `fk_Evento_has_Pais_Evento1`
    FOREIGN KEY (`Evento_idEvento`)
    REFERENCES `proyecto2`.`evento` (`idEvento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Evento_has_Pais_Pais1`
    FOREIGN KEY (`Pais_idPais`)
    REFERENCES `proyecto2`.`pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `proyecto2` ;
DELIMITER ;
USE `proyecto2`;

DELIMITER $$
USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`catalogo_edit`
BEFORE UPDATE ON `proyecto2`.`catalogo_de_acciones`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`catalogo_timestamp`
BEFORE INSERT ON `proyecto2`.`catalogo_de_acciones`
FOR EACH ROW
SET NEW.fecha_creacion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`continentes_edit`
BEFORE UPDATE ON `proyecto2`.`continente`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`continentes_timestamp`
BEFORE INSERT ON `proyecto2`.`continente`
FOR EACH ROW
SET NEW.fecha_creacion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`pais_edit`
BEFORE UPDATE ON `proyecto2`.`pais`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`pais_timestamp`
BEFORE INSERT ON `proyecto2`.`pais`
FOR EACH ROW
SET NEW.fecha_creacion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`confederaciones`
BEFORE UPDATE ON `proyecto2`.`confederaciones`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`confederaciones_timestamp`
BEFORE INSERT ON `proyecto2`.`confederaciones`
FOR EACH ROW
SET NEW.fecha_creacion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`equipo_edit`
BEFORE UPDATE ON `proyecto2`.`equipo`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`equipo_timestamp`
BEFORE INSERT ON `proyecto2`.`equipo`
FOR EACH ROW
SET NEW.fecha_creacion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`alineaciones_edit`
BEFORE UPDATE ON `proyecto2`.`alineacion`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`alineaciones_timestamp`
BEFORE INSERT ON `proyecto2`.`alineacion`
FOR EACH ROW
SET NEW.fecha_creacion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`posicion_edit`
BEFORE UPDATE ON `proyecto2`.`posicion`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`posicion_timestamp`
BEFORE INSERT ON `proyecto2`.`posicion`
FOR EACH ROW
SET NEW.fecha_creacion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`jugador_edit`
BEFORE UPDATE ON `proyecto2`.`jugador`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`jugador_timestamp`
BEFORE INSERT ON `proyecto2`.`jugador`
FOR EACH ROW
SET NEW.fecha_creacion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`tipo_edit`
BEFORE UPDATE ON `proyecto2`.`tipo_eventos`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`tipo_timestamp`
BEFORE INSERT ON `proyecto2`.`tipo_eventos`
FOR EACH ROW
SET NEW.fecha_creacion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`event_edit`
BEFORE UPDATE ON `proyecto2`.`evento`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`evento_timestamp`
BEFORE INSERT ON `proyecto2`.`evento`
FOR EACH ROW
SET NEW.fecha_creacion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`estadio_edit`
BEFORE UPDATE ON `proyecto2`.`estadio`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`estadio_timestamp`
BEFORE INSERT ON `proyecto2`.`estadio`
FOR EACH ROW
SET NEW.fecha_creacion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`categoria_edit`
BEFORE UPDATE ON `proyecto2`.`categoria_grupo`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`categoria_timestamp`
BEFORE INSERT ON `proyecto2`.`categoria_grupo`
FOR EACH ROW
SET NEW.fecha_creacion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`grupo_edit`
BEFORE UPDATE ON `proyecto2`.`grupo`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`grupo_timestamp`
BEFORE INSERT ON `proyecto2`.`grupo`
FOR EACH ROW
SET NEW.fecha_creacion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`partido_edit`
BEFORE UPDATE ON `proyecto2`.`partido`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`partido_timestamp`
BEFORE INSERT ON `proyecto2`.`partido`
FOR EACH ROW
SET NEW.fecha_creacion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`accion_edit`
BEFORE UPDATE ON `proyecto2`.`accion`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`accion_timestamp`
BEFORE INSERT ON `proyecto2`.`accion`
FOR EACH ROW
SET NEW.fecha_creacion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`bitacora_edit`
BEFORE UPDATE ON `proyecto2`.`bitacora`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`bitacora_timestamp`
BEFORE INSERT ON `proyecto2`.`bitacora`
FOR EACH ROW
SET NEW.fecha_creacion = CURRENT_TIMESTAMP$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`bitacoraporequipo_edit`
BEFORE UPDATE ON `proyecto2`.`bitacoraporequipo`
FOR EACH ROW
SET NEW.fecha_edicion = NOW()$$

USE `proyecto2`$$
CREATE
DEFINER=`proyecto2`@`localhost`
TRIGGER `proyecto2`.`bitacoraporequipo_timestamp`
BEFORE INSERT ON `proyecto2`.`bitacoraporequipo`
FOR EACH ROW
SET NEW.fecha_creacion = NOW()$$
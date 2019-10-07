
-- -----------------------------------------------------
-- function retornar_diferencia
-- -----------------------------------------------------
-- Recibe el id de una bitacora de equipo
-- y saca la diferencia entre goles anotados y goles recibidos

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` FUNCTION `retornar_diferencia`(pIDBitacora INT) RETURNS int(11)
BEGIN
DECLARE diferencia INT;
SELECT (hechos-recibidos) INTO diferencia
FROM
(SELECT gf AS hechos,
gc AS recibidos
FROM bitacoraPorEquipo
WHERE idbitacoraPorEquipo = pIDBitacora) T1;
RETURN diferencia;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function retornar_puntos
-- -----------------------------------------------------
-- Recibe el id de una bitacora de equipo
-- Multiplica los partidos ganados por 3 y los suma a los partidos empatados
-- para devolver la cantidad de puntos

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` FUNCTION `retornar_puntos`(pIDBitacora INT) RETURNS int(11)
BEGIN
DECLARE puntos INT;
SELECT (empates+ganes) INTO puntos
FROM
(SELECT pg * 3 AS ganes,
pe AS empates
FROM bitacoraPorEquipo
WHERE idbitacoraPorEquipo = pIDBitacora) T1;
RETURN puntos;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function sacar_bitacoraEquipo
-- -----------------------------------------------------
-- recibe un equipo y un evento y busca cual de todas las bitacoras de ese equipo pertenece a ese torneo

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` FUNCTION `sacar_bitacoraEquipo`(pIDEquipo INT, PIdEvento INT) RETURNS int(11)
BEGIN
Declare bitacoraE INT;
SET @bitacoras = (SELECT * FROM bitacoraPorEquipo WHERE equipo_idequipo = pIDEquipo);
SET @grupos = (SELECT idgrupo FROM grupo WHERE Evento_idEvento = PIdEvento);
SELECT idbitacoraPorEquipo INTO bitacoraE FROM bitacoras WHERE grupo_idgrupo IN (grupos);
RETURN bitacoraE;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function seleccionar_alineacion
-- -----------------------------------------------------
-- Recibe el id de un equipo
-- regresa la alineacion relacionada a ese equipo

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` FUNCTION `seleccionar_alineacion`(pIDEquipo INT) RETURNS int(11)
BEGIN
DECLARE retorno INT;

SELECT idalineacion INTO retorno FROM alineacion WHERE equipo_idequipo = pIDEquipo;

RETURN retorno;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function seleccionar_capitan
-- -----------------------------------------------------
-- Recibe el id de un equipo y busca el capitan de este

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` FUNCTION `seleccionar_capitan`(Pid_equipo INT ) RETURNS int(11)
BEGIN
DECLARE retorno INT;

SELECT idjugador INTO retorno FROM jugador WHERE Pais_idPais = Pid_equipo AND  capitan = 1;
RETURN retorno;
END$$

DELIMITER ;


-- -----------------------------------------------------
-- function validar_cantidad_de_partidos
-- -----------------------------------------------------
-- Inicial funcion para insertar un partido, recibe todos los datos del partido y revisa si ya se cumplieron todos los partidos del grupo
-- en cuanto a la cantidad total
-- Si todavia quedan partidos por realizarse llama a validar partido para el siguiente paso

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` FUNCTION `validar_cantidad_de_partidos`(pEventID int, pEquipoLocal int, pEquipoVisita int,
									pEstadio int, pFecha date, Pidgrupo int) RETURNS int(11)
BEGIN
DECLARE estado int;
Declare cantidadP int;
DECLARE category INT;

SET category = (SELECT Categoria_Grupo_idCategoria_Grupo from grupo where idgrupo = Pidgrupo);

set cantidadP = (select count(1) from partido where grupo_idgrupo = Pidgrupo);

CASE when category = 1 and cantidadP = 6 then
set estado = 1; 
when category = 2 and cantidadP = 16 then
set estado = 1; 
when category = 1 and cantidadP = 8 then
set estado = 1; 
when category = 1 and cantidadP = 4 then
set estado = 1; 
when category = 1 and cantidadP = 2 then
set estado = 1; 
when category = 1 and cantidadP = 1 then
set estado = 1; 
ELSE
set estado = 0;
END CASE;

IF estado <> 1 THEN
SET estado = (`proyecto2`.`validar_partido`(pEventID, pEquipoLocal, pEquipoVisita, pEstadio, pFecha, Pidgrupo, category));
end if;


RETURN estado;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function validar_partido
-- -----------------------------------------------------
-- Sirve para validar que el partido que se desea insertar sea unico en esa fase del torneo,
-- Si los dos equipos no han jugado en primera ronda o si es una ronda posterior revisa si cualquiera de los dos equipos no hayan jugado
-- si se cumple la condicion, procede a llamar a insertar partido

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` FUNCTION `validar_partido`(pEventID int, pEquipoLocal int, pEquipoVisita int,
									pEstadio int, pFecha date, Pidgrupo int, category int) RETURNS int(11)
BEGIN

DECLARE estado int;

CASE WHEN category = 1 then
SET estado = (select proyecto2.validar_primera_fase(pEquipoLocal, pEquipoVisita, pEstadio, Pidgrupo));
ELSE
SET estado = (select proyecto2.validar_siguientes_rondas(pEquipoLocal, pEquipoVisita, pEstadio, Pidgrupo));
END CASE;

IF estado < 1 THEN
CALL `proyecto2`.`insert_partido`(pEventID,  pEquipoLocal, pEquipoVisita, pEstadio, pFecha , Pidgrupo);
END IF;



RETURN estado;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function validar_primera_fase
-- -----------------------------------------------------
-- subrutina para validar si los partidos de primera ronda son unicos

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` FUNCTION `validar_primera_fase`(pEquipoLocal int, pEquipoVisita int,
									pEstadio int, Pidgrupo int) RETURNS int(11)
BEGIN
declare estado int;

set estado = (select count(1) from partido where (EquipoLocal = pEquipoLocal and EquipoVisita = pEquipoVisita) or (EquipoLocal = pEquipoVisita and EquipoVisita = pEquipoLocal) );

RETURN estado;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function validar_siguientes_rondas
-- -----------------------------------------------------
-- subrutina para validar si los partidos de segunda ronda son unicos y que ninguno de los 2 equipos ya haya jugado

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` FUNCTION `validar_siguientes_rondas`(pEquipoLocal int, pEquipoVisita int,
									pEstadio int, Pidgrupo int) RETURNS int(11)
BEGIN
declare estado int;

set estado = (select count(1) from partido where EquipoLocal = pEquipoLocal or EquipoVisita = pEquipoVisita or EquipoLocal = pEquipoVisita or EquipoVisita = pEquipoLocal);

RETURN estado;
END$$

-- -----------------------------------------------------
-- function Promedio_amarillasXpartido
-- -----------------------------------------------------


CREATE DEFINER=`proyecto2`@`localhost` FUNCTION `Promedio_amarillasXpartido`(PId_Evento INT) RETURNS float
BEGIN
DECLARE Amarillas_Totales int;
DECLARE cant_Partidos int;
DECLARE Promedio_amarillasXpartido float;

SET cant_Partidos = (
  SELECT
  COUNT(partido.idpartido) AS expr1
FROM partido
  INNER JOIN evento
    ON partido.Evento_idEvento = evento.idEvento
WHERE evento.idEvento = partido.Evento_idEvento);



SET Amarillas_Totales = (
SELECT
 COUNT(accion.idAccion) AS expr1
FROM accion
  INNER JOIN catalogo_de_acciones
    ON accion.idCatalogo_de_Acciones = catalogo_de_acciones.idCatalogo_de_Acciones
  INNER JOIN partido
    ON accion.partido_idpartido = partido.idpartido
  INNER JOIN evento
    ON partido.Evento_idEvento = evento.idEvento
WHERE evento.idEvento = PId_Evento
AND accion.idCatalogo_de_Acciones = 2);

SET Promedio_amarillasXpartido = Amarillas_Totales / cant_Partidos;

RETURN Promedio_amarillasXpartido;
END




DELIMITER ;

-- -----------------------------------------------------
-- function Promedio_cornersXpartido
-- -----------------------------------------------------

CREATE DEFINER=`proyecto2`@`localhost` FUNCTION `Promedio_cornersXpartido`(PId_Evento INT) RETURNS float
BEGIN
DECLARE corners_Totales int;
DECLARE cant_Partidos int;
DECLARE Promedio_cornersXpartido float;

SET cant_Partidos = (
  SELECT
  COUNT(partido.idpartido) AS expr1
FROM partido
  INNER JOIN evento
    ON partido.Evento_idEvento = evento.idEvento
WHERE evento.idEvento = partido.Evento_idEvento);



SET corners_Totales = (
SELECT
 COUNT(accion.idAccion) AS expr1
FROM accion
  INNER JOIN catalogo_de_acciones
    ON accion.idCatalogo_de_Acciones = catalogo_de_acciones.idCatalogo_de_Acciones
  INNER JOIN partido
    ON accion.partido_idpartido = partido.idpartido
  INNER JOIN evento
    ON partido.Evento_idEvento = evento.idEvento
WHERE evento.idEvento = PId_Evento
AND accion.idCatalogo_de_Acciones = 5);

SET Promedio_cornersXpartido = corners_Totales / cant_Partidos;

RETURN Promedio_cornersXpartido;
END

-- -----------------------------------------------------
-- functionPromedio_golesXpartido
-- -----------------------------------------------------

CREATE DEFINER=`proyecto2`@`localhost` FUNCTION `Promedio_golesXpartido`(PId_Evento INT) RETURNS float
BEGIN
  DECLARE cant_Goles int;
  DECLARE cant_Partidos int;
  DECLARE Promedio_golesXpartido float;


SET cant_Partidos = (
  SELECT
  COUNT(partido.idpartido) AS expr1
FROM partido
  INNER JOIN evento
    ON partido.Evento_idEvento = evento.idEvento
WHERE evento.idEvento = partido.Evento_idEvento);

  SET cant_Goles = (
SELECT
  COUNT(accion.idAccion) AS expr1
FROM partido
  INNER JOIN evento
    ON partido.Evento_idEvento = evento.idEvento
  INNER JOIN accion
    ON accion.partido_idpartido = partido.idpartido
  INNER JOIN catalogo_de_acciones
    ON accion.idCatalogo_de_Acciones = catalogo_de_acciones.idCatalogo_de_Acciones
WHERE evento.idEvento = PId_Evento
AND accion.idCatalogo_de_Acciones = 1);


SET Promedio_golesXpartido = cant_Goles / cant_Partidos;
RETURN Promedio_golesXpartido;
END

-- -----------------------------------------------------
-- function Promedio_offsidesXpartido
-- -----------------------------------------------------

CREATE DEFINER=`proyecto2`@`localhost` FUNCTION `Promedio_offsidesXpartido`(PId_Evento INT) RETURNS float
BEGIN
DECLARE offsides_Totales int;
DECLARE cant_Partidos int;
DECLARE Promedio_offsidesXpartido float;

SET cant_Partidos = (
  SELECT
  COUNT(partido.idpartido) AS expr1
FROM partido
  INNER JOIN evento
    ON partido.Evento_idEvento = evento.idEvento
WHERE evento.idEvento = partido.Evento_idEvento);



SET offsides_Totales = (
SELECT
 COUNT(accion.idAccion) AS expr1
FROM accion
  INNER JOIN catalogo_de_acciones
    ON accion.idCatalogo_de_Acciones = catalogo_de_acciones.idCatalogo_de_Acciones
  INNER JOIN partido
    ON accion.partido_idpartido = partido.idpartido
  INNER JOIN evento
    ON partido.Evento_idEvento = evento.idEvento
WHERE evento.idEvento = PId_Evento
AND accion.idCatalogo_de_Acciones = 6);

SET Promedio_offsidesXpartido = offsides_Totales / cant_Partidos;

RETURN Promedio_offsidesXpartido;
END

-- -----------------------------------------------------
-- function Promedio_rojasXpartido
-- -----------------------------------------------------

CREATE DEFINER=`proyecto2`@`localhost` FUNCTION `Promedio_rojasXpartido`(PId_Evento INT) RETURNS float
BEGIN
DECLARE rojas_Totales int;
DECLARE cant_Partidos int;
DECLARE Promedio_rojasXpartido float;

SET cant_Partidos = (
  SELECT
  COUNT(partido.idpartido) AS expr1
FROM partido
  INNER JOIN evento
    ON partido.Evento_idEvento = evento.idEvento
WHERE evento.idEvento = partido.Evento_idEvento);



SET rojas_Totales = (
SELECT
 COUNT(accion.idAccion) AS expr1
FROM accion
  INNER JOIN catalogo_de_acciones
    ON accion.idCatalogo_de_Acciones = catalogo_de_acciones.idCatalogo_de_Acciones
  INNER JOIN partido
    ON accion.partido_idpartido = partido.idpartido
  INNER JOIN evento
    ON partido.Evento_idEvento = evento.idEvento
WHERE evento.idEvento = PId_Evento
AND accion.idCatalogo_de_Acciones = 3);

SET Promedio_rojasXpartido = rojas_Totales / cant_Partidos;

RETURN Promedio_rojasXpartido;
END

-- -----------------------------------------------------
-- function Promedio_savesXpartido
-- -----------------------------------------------------

CREATE DEFINER=`proyecto2`@`localhost` FUNCTION `Promedio_savesXpartido`(PId_Evento INT) RETURNS float
BEGIN
DECLARE saves_Totales int;
DECLARE cant_Partidos int;
DECLARE Promedio_savesXpartido float;

SET cant_Partidos = (
  SELECT
  COUNT(partido.idpartido) AS expr1
FROM partido
  INNER JOIN evento
    ON partido.Evento_idEvento = evento.idEvento
WHERE evento.idEvento = partido.Evento_idEvento);



SET saves_Totales = (
SELECT
 COUNT(accion.idAccion) AS expr1
FROM accion
  INNER JOIN catalogo_de_acciones
    ON accion.idCatalogo_de_Acciones = catalogo_de_acciones.idCatalogo_de_Acciones
  INNER JOIN partido
    ON accion.partido_idpartido = partido.idpartido
  INNER JOIN evento
    ON partido.Evento_idEvento = evento.idEvento
WHERE evento.idEvento = PId_Evento
AND accion.idCatalogo_de_Acciones = 4);

SET Promedio_savesXpartido = saves_Totales / cant_Partidos;

RETURN Promedio_savesXpartido;
END








SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

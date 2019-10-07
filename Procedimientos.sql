-- -----------------------------------------------------
-- procedure agregar_goles_hechos
-- -----------------------------------------------------
-- Funcion que requiere de la funcion para sacar la bitacora por equipo deseada que sirve como parametro
-- Agrega los goles recibidos de un partido recibidos a la bitacora.

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` PROCEDURE `agregar_goles_hechos`(pIDBitacora INT, pIDPartido INT)
BEGIN

DECLARE equipoG INT;

SELECT equipo_idequipo into equipoG from bitacoraPorEquipo where idbitacoraPorEquipo = pIDBitacora;

UPDATE bitacoraPorEquipo
SET gf = gf + (SELECT Count(1) from accion where idCatalogo_de_Acciones = 1 and equipo_idequipo = equipoG and partido_idpartido = pIDPartido)
WHERE idbitacoraPorEquipo = pIDBitacora;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure agregar_goles_recibidos
-- -----------------------------------------------------
-- Funcion que requiere de la funcion para sacar la bitacora por equipo deseada que sirve como parametro
-- Agrega los goles hechos de un partido recibidos a la bitacora.


DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` PROCEDURE `agregar_goles_recibidos`(pIDBitacora INT, pIDPartido INT)
BEGIN

DECLARE equipoG INT;

SELECT equipo_idequipo into equipoG from bitacoraPorEquipo where idbitacoraPorEquipo = pIDBitacora;

UPDATE bitacoraPorEquipo
SET gc = gc + (SELECT Count(1) from accion where idCatalogo_de_Acciones = 1 and partido_idpartido = pIDPartido and equipo_idequipo <> equipoG )
WHERE idbitacoraPorEquipo = pIDBitacora;

END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure asignar_grupos
-- -----------------------------------------------------

-- Este procedimiento recibe el id de un evento abre un cursor para sacar todos los grupos de primera fase de ese evento
-- luego abre otro cursor para sacar todos los equipos del torneo.
-- hace un loop donde de forma aleatoria inserta 4 equipos a cada grupo, creando una bitacora relacionada al equipo y al grupo

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` PROCEDURE `asignar_grupos`(pEvento INT)
BEGIN

DECLARE v_finished INT DEFAULT 0;
DECLARE v_finished2 INT DEFAULT 0;
DECLARE v_idequipo VARCHAR(500) DEFAULT "";
DECLARE v_idgrupo VARCHAR(500) DEFAULT "";
DECLARE contador INT DEFAULT 0;
 
 
 DEClARE grupo_cursor CURSOR FOR 
 SELECT idgrupo FROM grupo where Evento_idEvento = pEvento and Categoria_Grupo_idCategoria_Grupo = 1;
 DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET v_finished = 1; 
 
 
 
OPEN grupo_cursor;
 
FETCH grupo_cursor INTO v_idgrupo;
 
 BLOCK2: BEGIN
 DEClARE equipo_cursor CURSOR FOR 
 SELECT equipo_idequipo FROM evento_has_equipo where Evento_idEvento = pEvento ORDER BY rand();
DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET v_finished2 = 1;
        

 
OPEN equipo_cursor;
        
get_equipo: LOOP
 
 FETCH equipo_cursor INTO v_idequipo;
 
  IF v_finished2 = 1 THEN 
 LEAVE get_equipo;
 END IF;

 IF contador = 4 THEN 
 FETCH grupo_cursor INTO v_idgrupo;
 SET contador = 0;
 END IF;
 
 
 CALL `proyecto2`.`insert_bitacoraporEquipo`(v_idequipo, v_idgrupo);
 SET contador = contador + 1;
 
 
 END LOOP get_equipo;
 
 CLOSE equipo_cursor;
 
 END;
 
 CLOSE grupo_cursor;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure cambiar_alineacion
-- -----------------------------------------------------
-- Hace un update para eliminar a todos los miembros de la alineacion
-- es un procedimiento que es llamado dentro de la funcion para modificar la alineacion

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` PROCEDURE `cambiar_alineacion`(pIDalineacion INT)
BEGIN

UPDATE jugador
SET alineacion_idalineacion = NULL
WHERE alineacion_idalineacion = pIDalineacion ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure cambiar_capitan
-- -----------------------------------------------------
-- Selecciona al antiguo capitan y le cambia el valor de capitan a 0
-- luego selecciona el nuevo apitan cuyo ID es igual al PIDjugador y le da valor 1 a la columna de capitan


DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` PROCEDURE `cambiar_capitan`(pIDjugador INT, PIDEquipo INT)
BEGIN

DECLARE antiguo INT;
set antiguo = `call  seleccionar_capitan(PIDEquipo)`;

UPDATE jugador
SET capitan = 0
WHERE idjugador = antiguo;

UPDATE jugador
SET capitan = 1
WHERE idjugador = pIDjugador;

END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure creacion_grupos_evento
-- -----------------------------------------------------
-- Funcion que se encarga de crear grupos para el evento en dos partes
-- primero divide la cantidad de quipos entre 4 y llama a la funcion para crear los grupos de la fase inicial
-- luego dependiendo de la cantidad de equipos genera las fases posteriores hasta llegar a la final.
-- tambien asigna el valor de next group a la siguiente fase del grupo que se creo

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` PROCEDURE `creacion_grupos_evento`(pEvento INT)
BEGIN

declare cantidad_grupos INT;
declare equiposT INT;
SET equiposT = (SELECT cantidad_equipos from evento where idevento = pEvento);
SET cantidad_grupos = equiposT / 4;
CALL `proyecto2`.`crear_grupos_iniciales`(pEvento, cantidad_grupos);

CASE WHEN equiposT = 4 THEN
CALL `proyecto2`.`insert_grupo`(PEvento, 'Final', 6);
UPDATE grupo
SET id_nextgrupo = LAST_INSERT_ID()
WHERE Evento_idevento = pEvento and Categoria_Grupo_idCategoria_Grupo = 1;
WHEN equiposT = 8 THEN
CALL `proyecto2`.`insert_grupo`(PEvento, 'Semi Finals', 5);
UPDATE grupo
SET id_nextgrupo = LAST_INSERT_ID()
WHERE Evento_idevento  = pEvento and Categoria_Grupo_idCategoria_Grupo = 1;
CALL `proyecto2`.`insert_grupo`(PEvento, 'Final', 6);
UPDATE grupo
SET id_nextgrupo = LAST_INSERT_ID()
WHERE Evento_idevento  = pEvento and Categoria_Grupo_idCategoria_Grupo = 5;
WHEN equiposT = 16 THEN
CALL `proyecto2`.`insert_grupo`(PEvento, 'Quarter Finals', 4);
UPDATE grupo
SET id_nextgrupo = LAST_INSERT_ID()
WHERE Evento_idevento  = pEvento and Categoria_Grupo_idCategoria_Grupo = 1;
CALL `proyecto2`.`insert_grupo`(PEvento, 'Semi Finals', 5);
UPDATE grupo
SET id_nextgrupo = LAST_INSERT_ID()
WHERE Evento_idevento  = pEvento and Categoria_Grupo_idCategoria_Grupo = 4;
CALL `proyecto2`.`insert_grupo`(PEvento, 'Final', 6);
UPDATE grupo
SET id_nextgrupo = LAST_INSERT_ID()
WHERE Evento_idevento  = pEvento and Categoria_Grupo_idCategoria_Grupo = 5;
WHEN equiposT = 32 THEN
CALL `proyecto2`.`insert_grupo`(PEvento, 'Round of 16', 3);
UPDATE grupo
SET id_nextgrupo = LAST_INSERT_ID()
WHERE Evento_idevento  = pEvento and Categoria_Grupo_idCategoria_Grupo = 1;
CALL `proyecto2`.`insert_grupo`(PEvento, 'Quarter Finals', 4);
UPDATE grupo
SET id_nextgrupo = LAST_INSERT_ID()
WHERE Evento_idevento  = pEvento and Categoria_Grupo_idCategoria_Grupo = 3;
CALL `proyecto2`.`insert_grupo`(PEvento, 'Semi Finals', 5);
UPDATE grupo
SET id_nextgrupo = LAST_INSERT_ID()
WHERE Evento_idevento  = pEvento and Categoria_Grupo_idCategoria_Grupo = 4;
CALL `proyecto2`.`insert_grupo`(PEvento, 'Final', 6);
UPDATE grupo
SET id_nextgrupo = LAST_INSERT_ID()
WHERE Evento_idevento = pEvento and Categoria_Grupo_idCategoria_Grupo = 5;
WHEN equiposT = 64 THEN
CALL `proyecto2`.`insert_grupo`(PEvento, 'Second Round', 2);
UPDATE grupo
SET id_nextgrupo = LAST_INSERT_ID()
WHERE Evento_idevento = pEvento and Categoria_Grupo_idCategoria_Grupo = 1;
CALL `proyecto2`.`insert_grupo`(PEvento, 'Round of 16', 3);
UPDATE grupo
SET id_nextgrupo = LAST_INSERT_ID()
WHERE Evento_idevento  = pEvento and Categoria_Grupo_idCategoria_Grupo = 2;
CALL `proyecto2`.`insert_grupo`(PEvento, 'Quarter Finals', 4);
UPDATE grupo
SET id_nextgrupo = LAST_INSERT_ID()
WHERE Evento_idevento  = pEvento and Categoria_Grupo_idCategoria_Grupo = 3;
CALL `proyecto2`.`insert_grupo`(PEvento, 'Semi Finals', 5);
UPDATE grupo
SET id_nextgrupo = LAST_INSERT_ID()
WHERE Evento_idevento  = pEvento and Categoria_Grupo_idCategoria_Grupo = 4;
CALL `proyecto2`.`insert_grupo`(PEvento, 'Final', 6);
UPDATE grupo
SET id_nextgrupo = LAST_INSERT_ID()
WHERE Evento_idevento = pEvento and Categoria_Grupo_idCategoria_Grupo = 5;
END CASE;



END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure crear_alineacion
-- -----------------------------------------------------
-- Procedimiento para crear o cambiar una alineacion, llama a cambiar alineacion para eliminar los valores anteriores
-- y luego asigna a los jugadores que recibe como parametro el id de alineacion

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` PROCEDURE `crear_alineacion`(pIDEquipo INT,
Keeper INT,
Def1 INT,
Def2 INT,
Def3 INT,
Def4 INT,
Mid1 INT,
Mid2 INT,
Mid3 INT,
Mid4 INT,
Fwd1 INT,
Fwd2 INT
)
BEGIN

DECLARE antiguo INT;
set antiguo = `call  seleccionar_alineacion(PIDEquipo)`;
call  cambiar_alineacion(antiguo);

UPDATE jugador
SET alineacion_idalineacion = antiguo
WHERE idjugador = Keeper OR
idjugador = Def1 OR
idjugador = Def2 OR
idjugador = Def3 OR
idjugador = Def4 OR
idjugador = Mid1 OR
idjugador = Mid2 OR
idjugador = Mid3 OR
idjugador = Mid4 OR
idjugador = Fwd1 OR
idjugador = Fwd2;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure crear_grupos_iniciales
-- -----------------------------------------------------
-- subrutina de crear grupos para el torneo
-- Hace un loop hasta cuando cantidad_grupos = 0
-- generando los grupos de la primera ronda

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` PROCEDURE `crear_grupos_iniciales`(pEvento INT, cantidad_grupos INT)
BEGIN

DECLARE nom INT;
DECLARE nom1 VARCHAR(45);

SET nom = 1;

creacion : LOOP
IF cantidad_grupos = 0 THEN 
 LEAVE creacion;
 END IF;
 SET nom1 = CONCAT("Grupo ",nom);
 CALL `proyecto2`.`insert_grupo`(pEvento, nom1, 1);
 SET nom = nom +1;
 SET cantidad_grupos = cantidad_grupos - 1;
 
END LOOP creacion;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure marcador_primera_fase
-- -----------------------------------------------------
-- Procedimiento para decidir el marcador en la primera fase
-- Ve las opciones entre que el equipo 1 tenga mas goles en el partido que el equipo 2 o visceversa
-- dependiendo del ganador aumenta la cuenta de Partidos ganados, perdidos y jugados
-- si tienen igual cantidad de goles asigna el marcador como empate y le aumenta la cantidad de empates a los dos equipos

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`proyecto2`@`localhost` PROCEDURE `marcador_primera_fase`(pIDBitacora1 INT, pIDBitacora2 INT, pIDPartido INT)
BEGIN
DECLARE equipoG INT;
DECLARE equipoF INT;
DECLARE golesG INT;
DECLARE golesF INT;

SELECT equipo_idequipo into equipoG from bitacoraPorEquipo where idbitacoraPorEquipo = pIDBitacora1;
SELECT equipo_idequipo into equipoF from bitacoraPorEquipo where idbitacoraPorEquipo = pIDBitacora2;
SELECT Count(1) into golesG from accion where idCatalogo_de_Acciones = 1 and partido_idpartido = pIDPartido and equipo_idequipo = equipoG; 
SELECT Count(1) into golesF from accion where idCatalogo_de_Acciones = 1 and partido_idpartido = pIDPartido and equipo_idequipo = equipoF; 

CASE
WHEN (golesG > golesF)
THEN
update bitacoraPorEquipo
set pj = pj+1
where idbitacoraPorEquipo = pIDBitacora1;
update bitacoraPorEquipo
set pj = pj+1
where idbitacoraPorEquipo = pIDBitacora2;
update bitacoraPorEquipo
set pg = pg+1
where idbitacoraPorEquipo = pIDBitacora1;
update bitacoraPorEquipo
set pp = pp+1
where idbitacoraPorEquipo = pIDBitacora2;
update partido
set ganador = equipoG
where idpartido = Pidpartido;
WHEN (golesF > golesG)
THEN
update bitacoraPorEquipo
set pj = pj+1
where idbitacoraPorEquipo = pIDBitacora1;
update bitacoraPorEquipo
set pj = pj+1
where idbitacoraPorEquipo = pIDBitacora2;
update bitacoraPorEquipo
set pg = pg+1
where idbitacoraPorEquipo = pIDBitacora2;
update bitacoraPorEquipo
set pp = pp+1
where idbitacoraPorEquipo = pIDBitacora1;
update partido
set ganador = equipoF
where idpartido = Pidpartido;
ELSE
update bitacoraPorEquipo
set pj = pj+1
where idbitacoraPorEquipo = pIDBitacora1;
update bitacoraPorEquipo
set pj = pj+1
where idbitacoraPorEquipo = pIDBitacora2;
update bitacoraPorEquipo
set pe = pe+1
where idbitacoraPorEquipo = pIDBitacora2;
update bitacoraPorEquipo
set pe = pe+1
where idbitacoraPorEquipo = pIDBitacora1;
update partido
set ganador = 0
where idpartido = Pidpartido;
end case;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure marcador_segunda_fase
-- -----------------------------------------------------
-- Similar al procedimiento de primera fase solo que no permite empates ya que se ocupa un ganador en estas instancias

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `marcador_segunda_fase`(pIDBitacora1 INT, pIDBitacora2 INT, pIDPartido INT)
BEGIN
DECLARE equipoG INT;
DECLARE equipoF INT;
DECLARE golesG INT;
DECLARE golesF INT;

SELECT equipo_idequipo into equipoG from bitacoraPorEquipo where idbitacoraPorEquipo = pIDBitacora1;
SELECT equipo_idequipo into equipoF from bitacoraPorEquipo where idbitacoraPorEquipo = pIDBitacora2;
SELECT Count(1) into golesG from accion where idCatalogo_de_Acciones = 1 and partido_idpartido = pIDPartido and equipo_idequipo = equipoG; 
SELECT Count(1) into golesF from accion where idCatalogo_de_Acciones = 1 and partido_idpartido = pIDPartido and equipo_idequipo = equipoF; 

CASE
WHEN (golesG > golesF)
THEN
update bitacoraPorEquipo
set pj = pj+1
where idbitacoraPorEquipo = pIDBitacora1;
update bitacoraPorEquipo
set pj = pj+1
where idbitacoraPorEquipo = pIDBitacora2;
update bitacoraPorEquipo
set pg = pg+1
where idbitacoraPorEquipo = pIDBitacora1;
update bitacoraPorEquipo
set pp = pp+1
where idbitacoraPorEquipo = pIDBitacora2;
update partido
set ganador = equipoG
where idpartido = Pidpartido;
WHEN (golesF > golesG)
THEN
update bitacoraPorEquipo
set pj = pj+1
where idbitacoraPorEquipo = pIDBitacora1;
update bitacoraPorEquipo
set pj = pj+1
where idbitacoraPorEquipo = pIDBitacora2;
update bitacoraPorEquipo
set pg = pg+1
where idbitacoraPorEquipo = pIDBitacora2;
update bitacoraPorEquipo
set pp = pp+1
where idbitacoraPorEquipo = pIDBitacora1;
update partido
set ganador = equipoF
where idpartido = Pidpartido;
ELSE
update partido
set ganador = 0
where idpartido = Pidpartido;
end case;

END$$

DELIMITER ;



-- -----------------------------------------------------
-- procedure tabla_posiciones
-- -----------------------------------------------------
-- Recibe un grupo y saca las bitacoras de ese grupo
-- Crea una tabla temporal para agregar puntos y diferencia
-- luego crea un view organizado por quien tiene mas puntos o mejor gol diferencia descendientemente

DELIMITER $$
USE `proyecto2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `tabla_posiciones`(Pidgrupo INT)
BEGIN

 DECLARE v_finished INT DEFAULT 0;
 DECLARE idB INT;
 DECLARE jugados INT;
 DECLARE ganados INT;
 DECLARE empatados INT;
 DECLARE perdidos INT;
 DECLARE gfavor INT;
 DECLARE gcontra INT;
 DECLARE puntos INT;
 DECLARE diferencia INT;
 DECLARE idG INT;
 DECLARE idE INT;
 DECLARE nomA varchar(45);
DEClARE tabla_cursor CURSOR FOR 
 SELECT idbitacoraporequipo,pj,pg,pe,pp,gf,gc,grupo_idgrupo, equipo_idequipo FROM bitacoraporequipo where grupo_idgrupo = Pidgrupo;
 DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET v_finished = 1; 
 
 DROP TEMPORARY TABLE IF EXISTS `estadisticas`;
 DROP VIEW IF exists `view_estadisticas`;
 
 CREATE TEMPORARY TABLE `estadisticas` (
  `nombre` varchar(45) DEFAULT NULL,
  `pj` int(11) DEFAULT NULL,
  `pg` int(11) DEFAULT NULL,
  `pe` int(11) DEFAULT NULL,
  `pp` int(11) DEFAULT NULL,
  `GF` int(11) DEFAULT NULL,
  `gc` int(11) DEFAULT NULL,
  `pts` int(11) DEFAULT NULL,
  `dif` int(11) DEFAULT NULL,
  `grupo_idgrupo` int(11) NOT NULL,
  `equipo_idequipo` int(11) NOT NULL
  
) ;

 
 
 OPEN tabla_cursor;
        
get_datos: LOOP
 
 FETCH tabla_cursor INTO idB, jugados, ganados, empatados, perdidos, gfavor, gcontra, idG, idE;
 
  IF v_finished = 1 THEN 
 LEAVE get_datos;
 END IF;
 
 SET nomA = (SELECT nombre from equipo where idequipo = idE);
 SET puntos = (SELECT `proyecto2`.`retornar_puntos`(idB));
 SET diferencia = (SELECT `proyecto2`.`retornar_diferencia`(idB));
 
 INSERT INTO estadisticas
(
`nombre`,
`pj`,
`pg`,
`pe`,
`pp`,
`GF`,
`gc`,
`pts`,
`dif`,
`grupo_idgrupo`,
`equipo_idequipo`
)
VALUES
(
nomA,
jugados,
ganados,
empatados,
perdidos,
gfavor,
gcontra,
puntos,
diferencia,
idG,
idE);

end loop;
 
 CREATE OR REPLACE VIEW estadisticas_view AS
 SELECT *
 FROM estadisticas ORDER BY pts, dif DESC;
 
 END$$

DELIMITER ;


CREATE EVENT
	Job_Bitacora
    ON SCHEDULE EVERY 1 DAY  STARTS '2015-11-09 11:00:00' 
    DO 
    INSERT INTO proyecto2.bitacora(pj,pg,pe,pp,GF,gc,grupo_idgrupo,equipo_idequipo)
	SELECT pj,pg,pe,pp,GF,gc,grupo_idgrupo,equipo_idequipo 
	FROM proyecto2.bitacoraporequipo
;

-- Habilita los jobs
set global event_scheduler=ON;
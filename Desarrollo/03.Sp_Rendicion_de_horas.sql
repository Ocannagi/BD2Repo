USE seguimiento_proyectos;

DELIMITER $$
-- DROP PROCEDURE if EXISTS Rendicion_de_horas;
CREATE PROCEDURE Rendicion_de_horas (IN tipo INT, IN id_asig_proy INT, IN fecha_inicio DATE, IN horas INT)
BEGIN
DECLARE contador INT;
SET contador=0;

IF tipo=1 THEN -- diario

	INSERT INTO asignacion_horas (id_asig_proy,fecha_asignacion, dia_trabajado, cant_horas)
		VALUES(id_asig_proy,NOW(),fecha_inicio,horas);	
	
ELSEIF tipo=2 THEN -- semanal
	WHILE contador <7 DO
		INSERT INTO asignacion_horas (id_asig_proy,fecha_asignacion, dia_trabajado, cant_horas)
			VALUES(id_asig_proy, NOW(), DATE_ADD(fecha_inicio, interval contador DAY),horas);
		SET contador=contador+1;
	END WHILE;

ELSEIF tipo=3 THEN -- mensual
	WHILE contador < day(last_day(fecha_inicio)) DO
		INSERT INTO asignacion_horas (id_asig_proy,fecha_asignacion, dia_trabajado, cant_horas)
			VALUES(id_asig_proy, NOW(), DATE_ADD(fecha_inicio, interval contador DAY),horas);
		SET contador=contador+1;
	END WHILE;

ELSE -- Error
	SELECT 'Error';
END IF;

END
$$
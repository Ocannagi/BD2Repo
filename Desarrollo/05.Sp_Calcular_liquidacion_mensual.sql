USE seguimiento_proyectos;

DELIMITER $$
-- DROP PROCEDURE if EXISTS Calcular_liquidacion_mensual;
CREATE PROCEDURE Calcular_liquidacion_mensual (IN opcion BOOLEAN, IN id_sp INT, IN anio INT, IN mes INT) -- opción cliente verdadero/proyecto falso
BEGIN

IF opcion THEN
	INSERT INTO liquidacion_mensual (id_proyecto,anio,mes,id_rol,cant_horas,fecha_liquidacion,usuario_liquidacion)
		SELECT
			ap.id_proyecto
			,YEAR(ah.dia_trabajado)
			,MONTH(ah.dia_trabajado)
			,ap.id_rol
			,SUM(ah.cant_horas)
			,NOW()
			,CURRENT_USER()
		FROM asignacion_horas ah
		INNER JOIN asignacion_proyecto ap
			ON ah.id_asig_proy=ap.id_asig_proy
		INNER JOIN proyectos p
			ON ap.id_proyecto=p.id_proyecto
		WHERE p.id_cliente=id_sp
			AND YEAR(ah.dia_trabajado)=anio
			AND MONTH(ah.dia_trabajado)=mes
		GROUP BY ap.id_proyecto
					,YEAR(ah.dia_trabajado)
					,MONTH(ah.dia_trabajado)
					,ap.id_rol;
ELSE
	INSERT INTO liquidacion_mensual (id_proyecto,anio,mes,id_rol,cant_horas,fecha_liquidacion,usuario_liquidacion)
		SELECT
			ap.id_proyecto
			,YEAR(ah.dia_trabajado)
			,MONTH(ah.dia_trabajado)
			,ap.id_rol
			,SUM(ah.cant_horas)
			,NOW()
			,CURRENT_USER()
		FROM asignacion_horas ah
		INNER JOIN asignacion_proyecto ap
			ON ah.id_asig_proy=ap.id_asig_proy
		WHERE ap.id_proyecto=id_sp
			AND YEAR(ah.dia_trabajado)=anio
			AND MONTH(ah.dia_trabajado)=mes
		GROUP BY ap.id_proyecto
					,YEAR(ah.dia_trabajado)
					,MONTH(ah.dia_trabajado)
					,ap.id_rol;
END IF;
END;
$$
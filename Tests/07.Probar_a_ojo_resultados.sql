-- Usar para verificar si el Sp_Calcular_liquidacion_mensual responde como se espera
USE seguimiento_proyectos;

SELECT p.id_cliente ,cc.desc_cliente
	,ap.id_proyecto ,p.desc_proyecto
	,ap.legajo
	,ap.id_rol,r.desc_rol
	,ap.id_asig_proy
	,ah.dia_trabajado
	,ah.cant_horas
FROM asignacion_horas ah
INNER JOIN asignacion_proyecto ap
	ON ah.id_asig_proy=ap.id_asig_proy
INNER JOIN proyectos p
	ON ap.id_proyecto=p.id_proyecto
INNER JOIN roles r
	ON ap.id_rol=r.id_rol
INNER JOIN clientes cc
	ON p.id_cliente=cc.id_cliente
ORDER BY ap.id_asig_proy;

SELECT * FROM liquidacion_mensual; -- Después de ejecutar Sp de liquidación
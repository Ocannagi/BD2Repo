USE seguimiento_proyectos;

TRUNCATE liquidacion_mensual;

CALL Calcular_liquidacion_mensual (TRUE,3,2021,4);

CALL Calcular_liquidacion_mensual (FALSE,4,2021,2);

SELECT * FROM liquidacion_mensual;
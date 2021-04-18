USE seguimiento_proyectos;

TRUNCATE asignacion_horas;

CALL Rendicion_de_horas (1,117,NOW(),12);
CALL Rendicion_de_horas (2,117,20210404,7);
CALL Rendicion_de_horas (2,104,20210404,10);
CALL Rendicion_de_horas (3,106,20210401,8);
CALL Rendicion_de_horas (3,99,20210401,6);
CALL Rendicion_de_horas (3,39,20210201,6);
CALL Rendicion_de_horas (3,1,20210301,7);
CALL Rendicion_de_horas (2,90,20210411,4);

CALL Rendicion_de_horas (4,2,20210201,8);

SELECT * from asignacion_horas;
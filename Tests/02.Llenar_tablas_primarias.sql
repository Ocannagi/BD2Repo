USE seguimiento_proyectos;

DELIMITER $$
-- DROP PROCEDURE if EXISTS Llenar_tablas_primarias;
CREATE PROCEDURE Llenar_tablas_primarias ()
BEGIN

DECLARE aux INT;
DECLARE contador INT;
SET contador=0;
SET aux=125;

WHILE contador <5 DO
	INSERT INTO colaboradores (legajo)
		VALUES(aux);
	SET aux=aux+25;
	SET contador=contador+1;
END WHILE;

INSERT INTO roles (desc_rol)
	VALUES ('Project Manager'),('Desarrollador'),('Tester'), ('Administrador');

INSERT INTO clientes (desc_cliente)
	VALUES ('Ojota SA'), ('Danger SRL'), ('Alerta SA');

DROP TEMPORARY TABLE if EXISTS auxiliar;
CREATE TEMPORARY TABLE auxiliar (objetos VARCHAR(100) NOT NULL);
INSERT INTO auxiliar VALUES ('Website'),('Sistema'),('Aplicacion');
INSERT INTO proyectos (desc_proyecto,id_cliente)
	SELECT concat(objetos,' ',desc_cliente), id_cliente FROM auxiliar,clientes;

INSERT INTO asignacion_proyecto (legajo,id_proyecto,id_rol)
SELECT legajo,id_proyecto,id_rol FROM colaboradores, proyectos, roles WHERE id_rol<>1 AND legajo<>aux-25;
SET contador=1;
WHILE contador<= (SELECT MAX(id_proyecto) FROM proyectos) DO
	INSERT INTO asignacion_proyecto (id_asig_proy,legajo,id_proyecto,id_rol)
		SELECT MAX(id_asig_proy)+1,aux-25,contador,1 FROM asignacion_proyecto;
	SET contador=contador+1;
END WHILE;

END
$$

CALL llenar_tablas_primarias();

SELECT * FROM colaboradores;
SELECT * FROM roles;
SELECT * FROM clientes;
SELECT * FROM proyectos;
SELECT * FROM asignacion_proyecto;
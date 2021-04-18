CREATE DATABASE seguimiento_proyectos;
USE seguimiento_proyectos;


DROP TABLE if EXISTS asignacion_horas;
DROP TABLE if EXISTS liquidacion_mensual;
DROP TABLE if EXISTS asignacion_proyecto;
DROP TABLE if EXISTS colaboradores;

CREATE TABLE colaboradores (
						legajo INT NOT NULL PRIMARY KEY,
						inactivo BOOLEAN NOT NULL DEFAULT FALSE,
						fecha_baja DATE DEFAULT NULL
						);

DROP TABLE if EXISTS roles;
CREATE TABLE roles (
					id_rol INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
					desc_rol VARCHAR(100) NOT NULL,
					inactivo BOOLEAN NOT NULL DEFAULT FALSE,
					fecha_baja DATE DEFAULT NULL
					);

DROP TABLE if EXISTS proyectos;
DROP TABLE if EXISTS clientes;
CREATE TABLE clientes (
						id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
						desc_cliente VARCHAR(100),
						inactivo BOOLEAN NOT NULL DEFAULT FALSE,
						fecha_baja DATE DEFAULT NULL
						);
						
CREATE TABLE proyectos (
						id_proyecto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
						desc_proyecto VARCHAR(100) NOT NULL,
						id_cliente INT NOT NULL,
						FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
						);
						
CREATE TABLE asignacion_proyecto (
							id_asig_proy INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
							legajo INT NOT NULL,
							id_proyecto INT NOT NULL,
							id_rol INT NOT NULL,
							FOREIGN KEY (legajo) REFERENCES colaboradores (legajo),
							FOREIGN KEY (id_proyecto) REFERENCES proyectos (id_proyecto),
							FOREIGN KEY (id_rol) REFERENCES roles (id_rol)
							);

CREATE TABLE asignacion_horas (
										id_asig_proy INT NOT NULL,
										fecha_asignacion DATE NOT NULL,
										dia_trabajado DATE NOT NULL,
										cant_horas INT NOT NULL,
										PRIMARY KEY (id_asig_proy,fecha_asignacion,dia_trabajado),
										FOREIGN KEY (id_asig_proy) REFERENCES asignacion_proyecto (id_asig_proy)
										);
										
CREATE TABLE liquidacion_mensual (
								id_proyecto INT NOT NULL,
								anio INT NOT NULL,
								mes INT NOT NULL,
								id_rol INT NOT NULL,
								cant_horas INT NOT NULL,
								fecha_liquidacion DATE NOT NULL,
								usuario_liquidacion VARCHAR(100) NOT NULL,
								PRIMARY KEY (id_proyecto,anio,mes,id_rol),
								FOREIGN KEY (id_proyecto) REFERENCES proyectos (id_proyecto),
								FOREIGN KEY (id_rol) REFERENCES roles (id_rol)
								);
CREATE DATABASE suga_prueba3;
USE suga_prueba3;

CREATE TABLE usuario(
id_usuario INT (4) AUTO_INCREMENT,
nombre_usuario VARCHAR (50),
contraseña VARCHAR (40),
PRIMARY KEY (id_usuario));

CREATE TABLE alumno(
matricula VARCHAR (11),
nombre_alumno VARCHAR (50),
grupo VARCHAR (6),
carrera VARCHAR (10),
PRIMARY KEY (matricula));

CREATE TABLE carrera(
clave_carrera VARCHAR (10),
descripcion_carrera VARCHAR (50),
PRIMARY KEY (clave_carrera));

CREATE TABLE cursa(
id_alum VARCHAR (11),
clave_carr VARCHAR (10),
FOREIGN KEY (id_alum) REFERENCES alumno (matricula),
FOREIGN KEY (clave_carr) REFERENCES carrera (clave_carrera));

CREATE TABLE profesor(
id_profesor  INT (4) AUTO_INCREMENT,
nombre_profesor VARCHAR (50),
categoria VARCHAR (10),
PRIMARY KEY (id_profesor));

CREATE TABLE materia(
clave_materia VARCHAR (10),
descripcion_materia VARCHAR (50),
PRIMARY KEY (clave_materia));

CREATE TABLE imparte(
id_prof INT (4),
clave_mat VARCHAR (10),
FOREIGN KEY (id_prof) REFERENCES profesor (id_profesor),
FOREIGN KEY (clave_mat) REFERENCES materia (clave_materia));

CREATE TABLE calificaciones(
id_registro INT (4) AUTO_INCREMENT,
id_alu VARCHAR (11),
id_carr VARCHAR (10),
parcial_1 FLOAT (5),
parcial_2 FLOAT (5),
promedio FLOAT (5),
PRIMARY KEY (id_registro),
FOREIGN KEY (id_alu) REFERENCES alumno (matricula),
FOREIGN KEY (id_carr) REFERENCES carrera (clave_carrera));

CREATE TABLE detalle_calificaciones(
id_reg INT (4),
id_mat VARCHAR (10),
calificacion FLOAT (10),
num_parcial INT (1),
FOREIGN KEY (id_reg) REFERENCES calificaciones (id_registro),
FOREIGN KEY (id_mat) REFERENCES materia (clave_materia));

CREATE TRIGGER calificacion_parciales AFTER INSERT ON detalle_calificaciones
FOR EACH ROW
UPDATE calificaciones SET parcial_1 = (SELECT SUM(calificacion)/7 FROM detalle_calificaciones 
WHERE num_parcial = '1'), parcial_2 = (SELECT SUM(calificacion)/7 FROM detalle_calificaciones 
WHERE num_parcial = '2')
WHERE id_registro=New.id_reg;

CREATE TRIGGER promedio AFTER INSERT ON detalle_calificaciones
FOR EACH ROW
UPDATE calificaciones SET promedio = (parcial_1 + parcial_2)/2
WHERE id_registro=New.id_reg;

delimiter //
CREATE PROCEDURE info_alumnos()
BEGIN
SELECT * FROM alumno INNER JOIN calificaciones ON id_alu = matricula;
END;
//

INSERT INTO usuario(
nombre_usuario,
contraseña)
VALUES(
"Emeryd Escobar",
SHA1('13181105009')),
("Ismael Rivera",
SHA1('13181105027')),
("Jassiel Pacheco",
SHA1('13181105002')),
("Antonio Quiroz",
SHA1('13181105019'));

SELECT * FROM usuario;

INSERT INTO alumno(
matricula,
nombre_alumno,
grupo,
carrera)
VALUES(
"13181105009",
"Escobar Hernandez Emeryd Cristina",
"6MSC1",
"ISC"),
("13181105027",
"Hernandez Rivera Ismael",
"6MSC1",
"ISC"),
("13181105002",
"Pacheco Reyes Set Jassiel",
"6MSC1",
"ISC"),
("13181105019",
"Quiroz Mendez Jose Antonio",
"6MSC1",
"ISC");

SELECT * FROM alumno;

INSERT INTO carrera(
clave_carrera,
descripcion_carrera)
VALUES(
"ISC",
"Ingenieria en Sistemas Computacionales");

SELECT * FROM carrera;

INSERT INTO cursa(
id_alum,
clave_carr)
VALUES(
"13181105009",
"ISC"),
("13181105027",
"ISC"),
("13181105002",
"ISC"),
("13181105019",
"ISC");

SELECT * FROM cursa;

INSERT INTO profesor(
nombre_profesor,
categoria)
VALUES(
"Olmedo Ramos Oscar",
"PA"),
("Fuentes Ruiz Jesus Roman",
"PTC"),
("Fernandez Olivares Jesus Erick",
"PA"),
("Arellano Montiel Jaquelinne",
"PA"),
("Marquez Sanchez Celso",
"PA"),
("De la Vega Espinosa Angelica",
"PTC");

SELECT * FROM profesor;

INSERT INTO materia(
clave_materia,
descripcion_materia)
VALUES(
"IN6",
"Ingles 6"),
("IDR",
"Interconexion de Redes"),
("MI2",
"Matematicas para la Ingenieria 2"),
("POO",
"Programacion Orientada a Objetos"),
("ABD",
"Administracion de Base de Datos"),
("SO",
"Sistemas Operativos"),
("HG",
"Habilidades Gerenciales");

SELECT * FROM materia;

INSERT INTO imparte(
id_prof,
clave_mat)
VALUES(
'1',
"IDR"),
('2',
"POO"),
('2',
"ABD"),
('3',
"MI2"),
('4',
"IN6"),
('5',
"SO"),
('6',
"HG");

SELECT * FROM imparte;

INSERT INTO calificaciones(
id_alu,
id_carr,
parcial_1,
parcial_2,
promedio)
VALUES(
"13181105009",
"ISC",
'0',
'0',
'0'),
("13181105027",
"ISC",
'0',
'0',
'0'),
("13181105002",
"ISC",
'0',
'0',
'0'),
("13181105019",
"ISC",
'0',
'0',
'0');

SELECT * FROM calificaciones;

INSERT INTO detalle_calificaciones(
id_reg,
id_mat,
calificacion,
num_parcial)
VALUES(
'1',
"IN6",
'9.0',
'1'),
('1',
"IDR",
'9.3',
'1'),
('1',
"MI2",
'9.0',
'1'),
('1',
"POO",
'9.2',
'1'),
('1',
"ABD",
'9.0',
'1'),
('1',
"SO",
'8.2',
'1'),
('1',
"HG",
'10',
'1'),
('1',
"IN6",
'8.1',
'2'),
('1',
"IDR",
'7.3',
'2'),
('1',
"MI2",
'8.5',
'2'),
('1',
"POO",
'8.5',
'2'),
('1',
"ABD",
'10.0',
'2'),
('1',
"SO",
'7.2',
'2'),
('1',
"HG",
'9.0',
'2');

SELECT * FROM detalle_calificaciones;

CALL info_alumnos();

DROP DATABASE suga_prueba3;
SHOW TABLES FROM suga_prueba3;
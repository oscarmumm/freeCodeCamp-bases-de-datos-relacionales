
/* ---------- CHEATSHEET ---------- */

/*

Important words:
database
tables
constraint
primary key
foreign key
SERIAL: tipo de dato INT que no será nulo y será auto-incremental

*/

/* ---------- Commands ---------- */

\l
-- listar bases de datos

CREATE DATABASE nombre;
-- para crear una base de datos

\c database_name
-- conectarse a la base de datos

\d
-- muestra las tablas disponibles en la base de datos

CREATE TABLE nombre_tabla();
-- crea una nueva tabla en la base de datos donde estamos

CREATE TABLE nombre_tabla(columna tipo_de_dato constraints);
-- crea una nueva tabla que poseerá una columna con el nombre que le 
-- hayamos pasado y a la vez especificando el tipo de dato que contendrá
-- y el constraint (ej: primary key)

\d nombre_tabla
-- muestra el detalle de la tabla que especifiquemos

ALTER TABLE nombre_tabla ADD COLUMN nombre_columna tipo_de_dato constraint;
-- crear una columna en la tabla especificada

ALTER TABLE nombre_tabla DROP COLUMN nombre_columna;
-- elimina la columna especificada

ALTER TABLE nombre_tabla RENAME COLUMN nombre_viejo TO nombre_nuevo;
-- renombrar columnas

INSERT INTO nombre_tabla (columna_x, columna_y) VALUES (dato_x, dato_y);
-- insertar datos en la tabla

INSERT INTO nombre_tabla (columna_x, columna_y) VALUES (dato_x, dato_y),(dato_x, dato_y),(dato_x, dato_y);
-- es posible ingresar varias filas a la vez de esta forma


SELECT columnas FROM nombre_tabla;
-- permite visualizar las columnas referenciadas y sus datos
-- el * luego del SELECT mostrará todas las columnas

SELECT columnas FROM nombre_tabla ORDER BY columna;
-- muestra todas las filas de la tabla ordenadas por el valor de la columna elegida
-- luego de ORDER BY

DELETE FROM nombre_tabla WHERE condicion;
-- eliminar un campo de la tabla

DROP TABLE nombre_tabla;
-- elimina una tabla de la base de datos

ALTER DATABASE nombre_db RENAME TO nuevo_nombre;
-- para renombrar la base de datos

DROP DATABASE nombre_db;
-- eliminar una base de datos

UPDATE nombre_tabla SET columna = nuevo_valor WHERE condicion;
-- para actualizar el valor de una de las filas e una determinada colummna

ALTER TABLE nombre_tabla ADD PRIMARY KEY (columna);
-- agregar una columna como clave primaria

ALTER TABLE nombre_tabla DROP CONSTRAINT nombre_contraint;
-- eliminar un constraint de la tabla

ALTER TABLE nombre_tabla ADD COLUMN columna tipo_de_dato REFERENCES tabla_referencia(columna_referencia);
-- crea una colmmna y una foreign key que la referencia

ALTER TABLE nombre_tabla ADD UNIQUE (columna);
-- agrega un constraint de tipo UNIQUE a la columna

ALTER TABLE nombre_tabla ALTER COLUMN columna SET NOT NULL;
-- modifica la columna de la tabla para que no admita valores nulos

ALTER TABLE nombre_tabla ADD FOREIGN KEY (columna) REFERENCES tabla_referencia(columna_referencia);
-- para agregar una foreign key a una columna ya creada

ALTER TABLE nombre_tabla ADD PRIMARY KEY(columna1, columna2);
-- crea una clave primaria compuesta, con la información de las dos columnas que
-- le pasamos como parámetro

SELECT columnas FROM tabla1 FULL JOIN tabla2 ON tabla1.primary_key_column = tabla2.foreign_key_column;
/* ver toda la informacion de las dos tablas a la vez
En el ejemplo de freeCodeCamp hacemos:
SELECT * FROM characters FULL JOIN more_info ON characters.character_id = more_info.character_id;
La relacion entre las tablas characters y more_info es 1:1
+--------------+--------+------------------+----------------+--------------+------------+--------------+--------------+--------------+
| character_id |  name  |     homeland     | favorite_color | more_info_id |  birthday  | height_in_cm | weight_in_kg | character_id |
+--------------+--------+------------------+----------------+--------------+------------+--------------+--------------+--------------+
|            1 | Mario  | Mushroom Kingdom | Red            |            1 | 1981-07-09 |          155 |         64.5 |            1 |
|            2 | Luigi  | Mushroom Kingdom | Green          |            2 | 1983-07-14 |          175 |         48.8 |            2 |
|            3 | Peach  | Mushroom Kingdom | Pink           |            3 | 1985-10-18 |          173 |         52.2 |            3 |
|            4 | Toad   | Mushroom Kingdom | Blue           |            4 | 1950-01-10 |           66 |         35.6 |            4 |
|            5 | Bowser | Koopa Kingdom    | Yellow         |            5 | 1990-10-29 |          258 |        300.0 |            5 |
|            6 | Daisy  | Sarasaland       | Orange         |            7 | 1989-07-31 |              |              |            6 |
|            7 | Yoshi  | Dinosaur Land    | Green          |            8 | 1990-04-13 |          162 |         59.1 |            7 |
+--------------+--------+------------------+----------------+--------------+------------+--------------+--------------+--------------+
si visualiazamos, utilizando la misma query las tablas characters y sounds, observaremos que hay datos que 
se repiten, puesto que la relacion es 1:N
+--------------+--------+------------------+----------------+----------+--------------+--------------+
| character_id |  name  |     homeland     | favorite_color | sound_id |   filename   | character_id |
+--------------+--------+------------------+----------------+----------+--------------+--------------+
|            1 | Mario  | Mushroom Kingdom | Red            |        1 | its-a-me.wav |            1 |
|            1 | Mario  | Mushroom Kingdom | Red            |        2 | yippee.wav   |            1 |
|            2 | Luigi  | Mushroom Kingdom | Green          |        3 | ha-ha.wav    |            2 |
|            2 | Luigi  | Mushroom Kingdom | Green          |        4 | oh-yeah.wav  |            2 |
|            3 | Peach  | Mushroom Kingdom | Pink           |        5 | yay.wav      |            3 |
|            3 | Peach  | Mushroom Kingdom | Pink           |        6 | woo-hoo.wav  |            3 |
|            3 | Peach  | Mushroom Kingdom | Pink           |        7 | mm-hmm.wav   |            3 |
|            1 | Mario  | Mushroom Kingdom | Red            |        8 | yahoo.wav    |            1 |
|            5 | Bowser | Koopa Kingdom    | Yellow         |          |              |              |
|            6 | Daisy  | Sarasaland       | Orange         |          |              |              |
|            4 | Toad   | Mushroom Kingdom | Blue           |          |              |              |
|            7 | Yoshi  | Dinosaur Land    | Green          |          |              |              |
+--------------+--------+------------------+----------------+----------+--------------+--------------+

Para visualizar la relacion entre 3 tablas, character_actions, characters y actions hacemos lo siguiente:
SELECT columns FROM junction_table
FULL JOIN table_1 ON junction_table.foreign_key_column = table_1.primary_key_column
FULL JOIN table_2 ON junction_table.foreign_key_column = table_2.primary_key_column;

SELECT * FROM character_actions FULL JOIN characters ON character_actions.character_id = characters.character_id FULL JOIN actions ON character_actions.action_id = actions.action_id;

y obtendremos como resultado:

+--------------+-----------+--------------+--------+------------------+----------------+-----------+--------+
| character_id | action_id | character_id |  name  |     homeland     | favorite_color | action_id | action |
+--------------+-----------+--------------+--------+------------------+----------------+-----------+--------+
|            7 |         1 |            7 | Yoshi  | Dinosaur Land    | Green          |         1 | run    |
|            7 |         2 |            7 | Yoshi  | Dinosaur Land    | Green          |         2 | jump   |
|            7 |         3 |            7 | Yoshi  | Dinosaur Land    | Green          |         3 | duck   |
|            6 |         1 |            6 | Daisy  | Sarasaland       | Orange         |         1 | run    |
|            6 |         2 |            6 | Daisy  | Sarasaland       | Orange         |         2 | jump   |
|            6 |         3 |            6 | Daisy  | Sarasaland       | Orange         |         3 | duck   |
|            5 |         1 |            5 | Bowser | Koopa Kingdom    | Yellow         |         1 | run    |
|            5 |         2 |            5 | Bowser | Koopa Kingdom    | Yellow         |         2 | jump   |
|            5 |         3 |            5 | Bowser | Koopa Kingdom    | Yellow         |         3 | duck   |
|            4 |         1 |            4 | Toad   | Mushroom Kingdom | Blue           |         1 | run    |
|            4 |         2 |            4 | Toad   | Mushroom Kingdom | Blue           |         2 | jump   |
|            4 |         3 |            4 | Toad   | Mushroom Kingdom | Blue           |         3 | duck   |
|            3 |         1 |            3 | Peach  | Mushroom Kingdom | Pink           |         1 | run    |
|            3 |         2 |            3 | Peach  | Mushroom Kingdom | Pink           |         2 | jump   |
|            3 |         3 |            3 | Peach  | Mushroom Kingdom | Pink           |         3 | duck   |
|            2 |         1 |            2 | Luigi  | Mushroom Kingdom | Green          |         1 | run    |
|            2 |         2 |            2 | Luigi  | Mushroom Kingdom | Green          |         2 | jump   |
|            2 |         3 |            2 | Luigi  | Mushroom Kingdom | Green          |         3 | duck   |
|            1 |         1 |            1 | Mario  | Mushroom Kingdom | Red            |         1 | run    |
|            1 |         2 |            1 | Mario  | Mushroom Kingdom | Red            |         2 | jump   |
|            1 |         3 |            1 | Mario  | Mushroom Kingdom | Red            |         3 | duck   |
+--------------+-----------+--------------+--------+------------------+----------------+-----------+--------+

*/
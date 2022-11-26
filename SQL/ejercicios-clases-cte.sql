USE `leccion-10-sql`;

/* ejercicio 1

Las CTE pueden ser útiles para para recorrer datos que siguen cierta jerarquía, 
como podría ser la cadena de supervisión dentro de una empresa. Imaginemos que en esa empresa cada empleada tiene una supervisora. 
Esa supervisora a su vez tiene una supervisora y así sucesivamente hasta llegar a la "cabeza" de la jerarquía, que podría ser la CEO de la empresa. La tabla empleadas 
que contiene esta información en la base de datos tendría el siguiente formato:*/

CREATE TABLE camino_empleadas
WITH RECURSIVE camino_empleadas (id_empleada, nombre, camino) AS
(
SELECT id_empleada, nombre, CAST(id_empleada AS CHAR(200))
FROM empleadas_camino
WHERE id_supervisora IS NULL
UNION ALL
SELECT id_empleada, nombre, CONCAT (camino , ',', id_empleada)
FROM camino_empleada 
INNER JOIN empleadas_camino
ON camino_empleada.id_empleada = empleadas_camino.id_supervisora)
SELECT * 
FROM camino_empleada
ORDER BY camino;


CREATE TABLE camino_empleadas
#para crear la CTE recursiva. Dentro de los pareéntesis ponemos los campos que queremos que nos saque.
WITH RECURSIVE camino_empleadas(id_empleada, nombre, camino) AS
(
SELECT id_empleada, nombre, CAST(id_empleada AS CHAR(200)) #cast es cambiar el tipo de una variable
FROM empleadas_camino
WHERE id_supervisora IS NULL
UNION ALL
SELECT id_empleada, nombre, CONCAT (camino, ',' , id_empleada) #concat nos permite unir 2 columnas en una sola. 
#en este caso será lo que vamos a llamar camino y la otra __ separados por una coma mediante ','
FROM camino_empleada
INNER JOIN empleadas_camino #si solo ponemos join le queda un inner join
ON camino_empleda.id_empleada = empleadas_camino.id_supervisora #vamos a utilizar el campo supervisora porque es la variable que vamos a utilizar para comparar los saltos del id
)
SELECT* FROM camino_empleada
ORDER BY camino;

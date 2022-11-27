
USE northwind;

/* EJERCICIO 1.
Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente 
y el nombre de la compañia de la tabla Customers.
*/

WITH comp_cliente
  AS (
  SELECT customer_id, company_name
  FROM customers
  ORDER BY customer_id
  )
SELECT customer_id, company_name
FROM customers;

/* EJERCICIO 2.
Selecciona solo los de que vengan de "Germany"
Ampliemos un poco la query anterior. 
En este caso, queremos un resultado similar al anterior, pero solo queremos los que pertezcan a "Germany".
*/

WITH comp_cliente2
  AS (
  SELECT customer_id, company_name
  FROM customers
  ORDER BY customer_id
  )
SELECT customer_id, company_name, country
FROM customers
WHERE country = 'Germany';

-- en la consulta final, mostramos la columna 'Country' para confirmar que la consulta solo nos incluye aquellos países
-- que trabajan en Alemania.

/* EJERCICIO 3.
Extraed el id de las facturas y su fecha de cada cliente.
En este caso queremos extraer todas las facturas que se han emitido a un cliente, 
su fecha, y la compañia a la que pertenece.
*/
-- no encontramos ninguna columna que contenga información sobre las facturas del cliente,
-- así que utilizamos orders.

WITH ejerc3
AS (
	SELECT orders.customer_id, customers.company_name, orders.order_id, orders.order_date
    FROM orders
    LEFT JOIN customers
    ON orders.customer_id = customers.customer_id
    ORDER BY customers.customer_id ASC
)
SELECT *
FROM ejerc3
GROUP BY ejerc3.order_id
ORDER BY ejerc3.customer_id ASC;

/* EJERCICIO 4.
Contad el número de facturas por cliente
Mejoremos la query anterior.
En este caso queremos saber el número de facturas emitidas por cada cliente.
*/

WITH ejerc4
AS (
	SELECT orders.customer_id, customers.company_name, orders.order_id
    FROM orders
    LEFT JOIN customers
    ON orders.customer_id = customers.customer_id
)
SELECT ejerc4.customer_id, ejerc4.company_name, COUNT(DISTINCT ejerc4.order_id) AS 'NumeroFacturas'
FROM ejerc4
GROUP BY ejerc4.customer_id
ORDER BY ejerc4.company_name ASC;

/* EJERCICIO 5.
Cuál la cantidad media pedida de todos los productos ProductID.
Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media.
*/

WITH ej5 AS (
	SELECT products.product_id, product_name, AVG(order_details.quantity) AS 'MediasUds'
	FROM products
    LEFT JOIN order_details
    ON order_details.product_id = products.product_id
	group by products.product_id)
select *
FROM ej5;


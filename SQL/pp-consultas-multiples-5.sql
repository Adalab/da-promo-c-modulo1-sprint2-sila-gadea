
/*Establecemos la BBDD que queremos usar:*/
USE northwind;

/* EJERCICIO 1.
Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. 
Para eso nos pide que lo hagamos con una query correlacionada.
*/

SELECT  t1.order_id AS ORDER_ID, t1.customer_id AS CUSTOMER_ID, t1.employee_id AS EMPLOYEE_ID, t1.order_date AS ORDER_DATE, t1.required_date AS REQUIRED_DATE
FROM orders as t1
WHERE t1.order_date >= (
	SELECT max(t2.order_date)
    FROM orders AS t2
    WHERE t2.employee_id = t1.employee_id
)
ORDER BY order_id ASC;

/* EJERCICIO 2.
Extraed el precio unitario máximo (unit_price) de cada producto vendido.
Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario. De nuevo lo tendréis que hacer con queries correlacionadas.
*/

SELECT t1.product_id AS PRODUCT_ID, t1.unit_price
FROM order_details as t1
WHERE t1.unit_price = (
		SELECT MAX(t2.unit_price)
        FROM order_details AS t2
        WHERE t1.product_id = t2.product_id
        )
GROUP BY t1.product_id;

/* EJERCICIO 3
Ciudades que empiezan con "A" o "B".
Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias que están afincadas en ciudades que empiezan por "A" o "B". 
Necesita que le devolvamos la ciudad, el nombre de la compañia y el nombre de contacto.*/

SELECT customers.city AS CIUDAD, customers.company_name AS NOM_COMPAÑIA, customers.contact_name AS NOM_CONTACTO 
FROM customers
WHERE customers.city LIKE 'A%' OR customers.city LIKE 'B%';

/* EJERCICIO 4
Número de pedidos que han hecho en las ciudades que empiezan con L.
En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior 
el número de total de pedidos que han hecho todas las ciudades que empiezan por "L".*/


SELECT customers.city AS CIUDAD, customers.company_name AS NOM_COMPAÑIA, customers.contact_name AS NOM_CONTACTO, COUNT(orders.order_id) AS NUM_PEDIDOS
FROM customers INNER JOIN orders
ON orders.customer_id = customers.customer_id
WHERE customers.city LIKE 'L%'
GROUP BY customers.company_name
ORDER BY customers.company_name;

/* EJERCICIO 5
Todos los clientes cuyo "contact_title" no incluya "Sales".
Nuestro objetivo es extraer los clientes que no tienen el contacto "Sales" en su "contact_title". 
Extraer el nombre de contacto, su posisión (contact_title) y el nombre de la compañia.
*/

SELECT customers.contact_name, customers.contact_title, customers.company_name 
FROM customers
WHERE customers.contact_title NOT LIKE '%Sales%';

/* EJERCICIO 6
Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto.*/

SELECT customers.contact_name
FROM customers
WHERE customers.contact_name NOT LIKE '_a%'

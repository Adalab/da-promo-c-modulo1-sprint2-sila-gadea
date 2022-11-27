use northwind;

#BBDD cuántos pedidos ha realizado cada empresa cliente de UK
#idcliente, nombre, numero de pedidos

/* EJERCICIO 1
Pedidos por empresa en UK:
Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con la que podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK. 
Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos*/

SELECT customers.company_name AS 'NombreCompañia', customers.customer_id, COUNT(orders.order_id)
FROM customers NATURAL JOIN orders
WHERE customers.country = "UK"
GROUP BY customers.company_name;

/* EJERCICIO 2
Productos pedidos por empresa en UK por año:
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han decidido pedirnos una serie de consultas adicionales.
La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año.
Nos piden concretamente conocer el nombre de la empresa,  el año, y la cantidad de objetos que han pedido. 
Para ello hará falta hacer 2 joins.*/

SELECT customers.company_name AS "NombreEmpresa", YEAR(orders.order_date) AS "Año", SUM(order_details.quantity) AS 'NumObjetos'
FROM orders INNER JOIN order_details
ON orders.order_id = order_details.order_id
INNER JOIN customers
ON customers.customer_id = orders.customer_id
WHERE customers.country = "UK" 
GROUP BY Año, NombreEmpresa;


/* EJERCICIO 3
Mejorad la query anterior:
Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad de dinero que han pedido por esa cantidad de objetos, 
teniendo en cuenta los descuentos, etc. Ojo que los descuentos en nuestra tabla nos salen en porcentajes, 15% nos sale como 0.15.*/

SELECT customers.company_name AS "NombreEmpresa", YEAR(orders.order_date) AS "Año", SUM(order_details.quantity) AS 'NumObjetos',
SUM((order_details.unit_price*order_details.quantity)*(1 - order_details.discount)) AS 'DineroTotal'
FROM orders INNER JOIN order_details
ON orders.order_id = order_details.order_id
INNER JOIN customers
ON customers.customer_id = orders.customer_id
WHERE customers.country = "UK" 
GROUP BY Año, NombreEmpresa;



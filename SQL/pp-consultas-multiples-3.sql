
USE northwind;


/*EJERCICIO 1.
Extraer toda la información sobre las compañias que tengamos en la BBDD
Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores que tenemos en la BBDD. 
Mostrad la ciudad a la que pertenecen, el nombre de la empresa y el nombre del contacto, además de la relación (Proveedor o Cliente). Pero importante! No debe haber duplicados en nuestra respuesta. La columna Relationship no existe y debe ser creada como columna temporal.
Para ello añade el valor que le quieras dar al campo y utilizada como alias Relationship.*/


SELECT 'Customers' AS Relationship, company_name AS NombreCompañia, city AS Ciudad, contact_name AS NombreContacto
FROM customers
UNION
SELECT 'Suppliers' AS Relationship, company_name AS NombreCompañia, city AS Ciudad, contact_name AS NombreContacto
FROM suppliers;


/*EJERCICIO 2.
Extraer todos los pedidos gestinados por "Nancy Davolio"
En este caso, nuestro jefe quiere saber cuantos pedidos ha gestionado "Nancy Davolio", 
una de nuestras empleadas. Nos pide todos los detalles tramitados por ella.
Los resultados de la query deben parecerse a la siguiente tabla:*/
#tablas:

SELECT employees.first_name, employees.last_name, orders.order_date
FROM employees, orders
WHERE employees.employee_id = orders.employee_id AND first_name = 'Nancy' AND last_name = 'Davolio';

SELECT * 
FROM orders
WHERE employee_id in (
	select employee_id, first_name, last_name
	FROM employees
	WHERE first_name = 'Nancy' AND last_name = 'Davolio');

/*EJERCICIO 3.
Extraed todas las empresas que no han comprado en el año 1997
En este caso, nuestro jefe quiere saber cuántas empresas no han comprado en el año 1997. */

SELECT company_name, country
FROM customers
WHERE customer_id in (
	SELECT customer_id
	from orders
	where year(order_date) != 1997);

/*Extraed toda la información de los pedidos donde tengamos "Konbu"
Estamos muy interesados en saber como ha sido la evolución de la venta de Konbu a lo largo del tiempo.
Nuestro jefe nos pide que nos muestre todos los pedidos que contengan "Konbu"*/

SELECT * 
FROM products
WHERE products.product_name = 'Konbu';
--
SELECT *
FROM orders 
WHERE order_id IN (
	SELECT *
	FROM products);

/*esto es el stock que tenemos*/
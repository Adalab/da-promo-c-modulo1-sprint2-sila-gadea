
USE northwind;


/*EJERCICIO 1.
Extraer toda la información sobre las compañias que tengamos en la BBDD
Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores que tenemos en la BBDD. 
Mostrad la ciudad a la que pertenecen, el nombre de la empresa y el nombre del contacto, además de la relación (Proveedor o Cliente). Pero importante! No debe haber duplicados en nuestra respuesta. La columna Relationship no existe y debe ser creada como columna temporal.
Para ello añade el valor que le quieras dar al campo y utilizada como alias Relationship.*/


SELECT 'Customers' AS RELATIONSHIP, company_name AS NOMBRE_COMPAÑIA, city AS CIUDAD, contact_name AS NOMBRE_CONTACTO
FROM customers
UNION
SELECT 'Suppliers' AS Relationship, company_name AS NOMBRE_COMPAÑIA, city AS CIUDAD, contact_name AS NOMBRE_CONTACTO
FROM suppliers;

/*EJERCICIO 2.
Extraer todos los pedidos gestinados por "Nancy Davolio"
En este caso, nuestro jefe quiere saber cuantos pedidos ha gestionado "Nancy Davolio", 
una de nuestras empleadas. Nos pide todos los detalles tramitados por ella.
Los resultados de la query deben parecerse a la siguiente tabla:*/
#tablas:

SELECT *
FROM orders
WHERE employee_id IN (
	SELECT employee_id
	FROM employees
	WHERE employees.employee_id = orders.employee_id AND first_name = 'Nancy' AND last_name = 'Davolio');

/*EJERCICIO 3.
Extraed todas las empresas que no han comprado en el año 1997
En este caso, nuestro jefe quiere saber cuántas empresas no han comprado en el año 1997. */

SELECT company_name AS NOM_EMPRESA, country AS PAIS, YEAR(order_date)
FROM customers, orders
WHERE orders.customer_id IN (
	SELECT orders.customer_id
	FROM orders
	WHERE YEAR(order_date) <> 1997)
GROUP BY company_name;
    
/*Extraed toda la información de los pedidos donde tengamos "Konbu"
Estamos muy interesados en saber como ha sido la evolución de la venta de Konbu a lo largo del tiempo.
Nuestro jefe nos pide que nos muestre todos los pedidos que contengan "Konbu"*/

SELECT *
FROM orders INNER JOIN products
WHERE products.product_id = (
		SELECT products.product_id AS NUMERO_PRODUCTO
		FROM products
		WHERE products.product_name = 'Konbu')
ORDER BY order_id ASC;

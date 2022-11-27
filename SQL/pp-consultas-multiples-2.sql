USE northwind;

/* EJERCICIO 1.
Qué empresas tenemos en la BBDD Northwind:
Lo primero que queremos hacer es obtener una consulta SQL
que nos devuelva el nombre de todas las empresas cliente, los ID de sus pedidos y las fechas.*/

SELECT orders.order_id AS NUMERO_PEDIDO, customers.company_name AS EMPRESA_CLIENTE, orders.order_date AS FECHA_PEDIDO
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id;

/* EJERCICIO 2
Pedidos por cliente de UK:
Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos
que ha realizado cada cliente del propio Reino Unido de cara a conocerlos mejor y
poder adaptarse al mercado actual. Especificamente nos piden el nombre de cada compañía cliente
junto con el número de pedidos.*/

SELECT customers.company_name AS EMPRESA_CLIENTE, COUNT(orders.order_id) AS NUMERO_PEDIDOS
FROM customers RIGHT JOIN orders
ON orders.customer_id = customers.customer_id
WHERE customers.country = "UK"
GROUP BY customers.company_name;

/* EJERCICO 3.
Empresas de UK y sus pedidos:
También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido
(tengan pedidos o no) junto con los ID de todos los pedidos que han realizado,
el nombre de contacto de cada empresa y la fecha del pedido.*/

SELECT orders.order_id AS NUMERO_PEDIDO, customers.company_name AS EMPRESA_CLIENTE, orders.order_date AS FECHA_PEDIDO
FROM orders NATURAL JOIN customers
WHERE customers.country = "UK";

/* EJERCICIO 4.
Empleadas que sean de la misma ciudad:
Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta
que muestre por pantalla los datos de todas las empleadas y sus supervisoras.
Concretamente nos piden: la ubicación, nombre, y apellido tanto de las empleadas como de las jefas.
Investiga el resultado, ¿sabes decir quién es el director?*/

SELECT A.city as CIUDAD_EMPLEADOS, A.first_name as NOMBRE_EMPLEADOS, A.last_name as APELLIDO_EMPLEADOS, B.city as CIUDAD_JEFES, B.first_name as NOMBRE_JEFE, B.last_name as APELLIDO_JEFE, A.reports_to AS REPORT_EMP, B.reports_to AS REPORT_JEFE
FROM employees as A, employees as B
WHERE A.employee_id <> B.employee_id
ORDER BY B.reports_to ASC;

-- Lxs jefes son quienes no tienen que reportar a nadie, es decir ReportJefe = NULL

SELECT A.city as CIUDAD_EMPLEADOS, A.first_name as NOMBRE_EMPLEADOS, A.last_name as APELLIDO_EMPLEADOS, B.city as CIUDAD_JEFES, B.first_name as NOMBRE_JEFE, B.last_name as APELLIDO_JEFE, A.reports_to AS REPORT_EMP, B.reports_to AS REPORT_JEFE
FROM employees as A, employees as B
WHERE A.employee_id <> B.employee_id AND B.reports_to IS NULL
ORDER BY B.reports_to ASC;

-- El jefe es Andrew Fuller
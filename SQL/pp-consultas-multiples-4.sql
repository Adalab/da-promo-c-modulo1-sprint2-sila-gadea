USE northwind;

/* EJERCICIO 1.
Extraed información de los productos "Beverages"
En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un tipo de producto.
En concreto, tienen especial interés por los productos con categoría "Beverages".
Devuelve el ID del producto, el nombre del producto y su ID de categoría.*/

SELECT products.product_id AS NUMERO_PRODUCTO, products.product_name NOMBRE_PRODUCTO, products.category_id AS CATEGORIA
FROM products JOIN categories
ON products.category_id = categories.category_id;

/* EJERCICIO 2.
Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país.
Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes,
entonces podría dirigirse a estos países para buscar proveedores adicionales.*/

SELECT customers.country AS COUNTRY
FROM customers
WHERE customers.country NOT IN (
	SELECT suppliers.country
    FROM suppliers)
GROUP BY country;

/* EJERCICIO 3.
Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"
Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto "Grandma's
Boysenberry Spread" (ProductID 6) en un solo pedido.*/

SELECT order_details.order_id AS NUMERO_PEDIDO, orders.customer_id AS NOMBRE_CLIENTE, order_details.quantity AS CANTIDAD_PRODUCTO, order_details.product_id AS ID_PRODUCTO
FROM order_details, orders
WHERE order_details.quantity > 20 AND order_details.product_id = 6;

/* EJERCICIO 4.
Extraed los 10 productos más caros. Nos siguen pidiendo más queries correlacionadas.
En este caso queremos saber cuáles son los 10 productos más caros.*/

SELECT products.product_name AS PRODUCTOS, products.unit_price AS PRECIO_UNIDAD
FROM products
ORDER BY products.unit_price DESC
LIMIT 10;

/* BONUS
Qué producto es más popular.
Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró.*/

SELECT products.product_name AS NOMBRE_PRODUCTO, MAX(quantity) AS CANTIDAD
FROM products INNER JOIN order_details
WHERE products.product_id IN (
	SELECT order_details.product_id
    FROM order_details
	GROUP BY products.product_name
    ORDER BY SUM(order_details.quantity)
    );
    -- El producto más popular según nuestra consulta es el Queso Cabrales.
    -- Hemos probado distintas combinaciones para que el resultado de la query sea el mismo que el presentado en el ejercicio, pero no ha funcionado ninguna. Adjuntamos la que más se ha acercado a la cifra correcta.

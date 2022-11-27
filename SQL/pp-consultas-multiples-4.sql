USE northwind;
/*EJERCICIO 1.
Extraed información de los productos "Beverages"
En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un tipo de producto.
En concreto, tienen especial interés por los productos con categoría "Beverages".
Devuelve el ID del producto, el nombre del producto y su ID de categoría.
*/

SELECT products.product_id, products.product_name, products.category_id
FROM products JOIN categories
ON products.category_id = categories.category_id;

/* EJERCICIO 2.
Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país.
Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes,
entonces podría dirigirse a estos países para buscar proveedores adicionales.
*/

SELECT customers.country AS country
FROM customers
WHERE customers.country NOT IN (
	SELECT suppliers.country
    FROM suppliers)
GROUP BY country;

/* EJERCICIO 3.
Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"
Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto "Grandma's
Boysenberry Spread" (ProductID 6) en un solo pedido.
*/

SELECT orders.customer_id, order_details.order_id
FROM orders, order_details
WHERE orders.order_id = order_details.order_id IN (
	SELECT order_details.quantity > 20
    FROM order_details
    WHERE orders.order_id = order_details.order_id
);

SELECT order_details.order_id, orders.customer_id
FROM order_details, orders
WHERE products.product_id = 6 AND order_details.quantity > 20;

--

SELECT orders_details.customer_id, products.product_id = 6
FROM order_details NATURAL JOIN products
WHERE order_details.quantity > 20
LIMIT 20;

/*EJERCICIO 4.
Extraed los 10 productos más caros. Nos siguen pidiendo más queries correlacionadas.
En este caso queremos saber cuáles son los 10 productos más caros.*/

SELECT products.product_name, products.unit_price
FROM products
order by products.unit_price DESC
LIMIT 10;

/*BONUS
Qué producto es más popular
Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró. */

SELECT products.product_name, MAX(order_details.quantity)
FROM products INNER JOIN order_details
ON product_id
LIMIT 1;

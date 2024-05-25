USE jardineria

SELECT DISTINCT ID_oficina, descripcion, telefono, linea_direccion1, linea_direccion2
FROM oficina
ORDER BY ID_oficina ASC;

SELECT DISTINCT ID_empleado, nombre, apellido1, apellido2, extension, email, ID_oficina, puesto
FROM empleado
ORDER BY ID_empleado ASC;

SELECT ID_producto, CodigoProducto, nombre, Categoria, dimensiones, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor
FROM producto
ORDER BY ID_producto ASC;

SELECT DISTINCT ID_cliente, nombre_cliente, nombre_contacto, apellido_contacto, fax, limite_credito
FROM cliente
ORDER BY ID_cliente ASC;

SELECT ROW_NUMBER() OVER(ORDER BY ciudad) as ID_geografico, ciudad, region, codigo_postal, pais 
FROM(SELECT DISTINCT ciudad, region, codigo_postal, pais FROM cliente) AS subconsulta;

SELECT ROW_NUMBER() OVER(ORDER BY fecha_pedido) AS ID_Fecha, fecha_pedido
FROM(SELECT DISTINCT fecha_pedido FROM pedido) AS subconsulta;

SELECT DISTINCT ID_detalle_pedido, b.ID_pedido, b.ID_producto, a.ID_cliente, d.ID_empleado, d.ID_oficina, ID_geografico, 
cantidad, precio_unidad, numero_linea, fecha.ID_Fecha, P.precio_proveedor
FROM pedido a
INNER JOIN detalle_pedido b ON a.ID_pedido = b.ID_pedido
INNER JOIN cliente c ON c.ID_cliente = a.ID_cliente
INNER JOIN empleado d ON d.ID_empleado = c.ID_empleado_rep_ventas
INNER JOIN (SELECT ROW_NUMBER() OVER(ORDER BY ciudad) as ID_geografico, ciudad, region, codigo_postal, pais 
FROM(SELECT DISTINCT ciudad, region, codigo_postal, pais FROM cliente) AS subconsulta) AS geografico 
ON geografico.ciudad = c.ciudad AND geografico.region = c.region AND geografico.codigo_postal = c.codigo_postal AND 
geografico.pais = c.pais
INNER JOIN (SELECT ROW_NUMBER() OVER(ORDER BY fecha_pedido) AS ID_Fecha, fecha_pedido
FROM(SELECT DISTINCT fecha_pedido FROM pedido) AS subconsulta) Fecha ON fecha.fecha_pedido = a.fecha_pedido 
INNER JOIN producto P ON P.ID_producto = b.ID_producto
ORDER BY ID_detalle_pedido ASC;

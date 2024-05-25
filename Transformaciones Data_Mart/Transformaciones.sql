-- Transformaciones

SELECT fecha_pedido, YEAR (fecha_pedido) Anio, MONTH (fecha_pedido) Mes, DAY (fecha_pedido) Dia, 
DATEPART (DW, fecha_pedido) Dia_de_la_semana, DATEPART (QUARTER, fecha_pedido) Trimestre FROM destino_tiempoST;

SELECT ID_oficina, descripcion, SUBSTRING (dbo.F_REMOVER_CARACTERES(LTRIM(telefono)), 4, 20) Telefono, SUBSTRING (telefono, 1, 4) Indicativo, 
dbo.F_REMOVER_CARACTERES(linea_direccion1) Direccion_1, dbo.F_REMOVER_CARACTERES(linea_direccion2) Direccion_2 FROM destino_oficinaST;

SELECT ID_empleado, ID_empleado ID_jefe, dbo.F_REMOVER_CARACTERES(TRIM(nombre)) Nombre, dbo.F_REMOVER_CARACTERES(TRIM(apellido1)) Primer_Apellido, 
dbo.F_REMOVER_CARACTERES(TRIM(apellido2)) Segundo_Apellido, extension, dbo.f_valida_email (email) Email, ID_oficina, puesto 
FROM destino_empleadoST;

SELECT ID_producto, CodigoProducto, dbo.F_REMOVER_CARACTERES(TRIM(nombre)) Nombre, Categoria, dimensiones,
dbo.F_REMOVER_CARACTERES(TRIM(proveedor)) Proveedor, dbo.F_REMOVER_CARACTERES(TRIM(descripcion)) Descripcion, 
cantidad_en_stock, precio_venta, precio_proveedor FROM destino_productoST;

SELECT ID_cliente, dbo.F_REMOVER_CARACTERES(TRIM(nombre_cliente)) Nombre_del_cliente, 
dbo.F_REMOVER_CARACTERES(TRIM(nombre_contacto)) Nombre_de_contacto, dbo.F_REMOVER_CARACTERES(TRIM(apellido_contacto)) Apellido_contacto,
fax, limite_credito FROM destino_clienteST;

SELECT ID_geografico, dbo.F_REMOVER_CARACTERES(TRIM(ciudad)) Ciudad, dbo.F_REMOVER_CARACTERES(TRIM(region)) Region,
codigo_postal, dbo.F_REMOVER_CARACTERES(TRIM(pais)) Pais FROM destino_geograficoST;

SELECT ID_detalle_pedido, ID_pedido, ID_producto, ID_cliente, ID_empleado, ID_oficina, cantidad, precio_unidad, ID_geografico, 
numero_linea, ID_Fecha, precio_proveedor FROM destino_FacVentasST;




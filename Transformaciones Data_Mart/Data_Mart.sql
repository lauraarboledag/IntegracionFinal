-- DB Data Mart

-- CREATE DATABASE Data_Mart;

USE Data_Mart;

DROP TABLE IF EXISTS dimension_producto;
DROP TABLE IF EXISTS fac_pedido;

CREATE TABLE dimension_tiempo (
  ID_tiempo INT IDENTITY (1,1) PRIMARY KEY,
  fecha DATE,
  año INT,
  mes INT,
  dia INT,
  dia_de_la_semana VARCHAR(10),
  trimestre INT
);

CREATE TABLE dimension_cliente (
  ID_cliente INT PRIMARY KEY,
  nombre_cliente VARCHAR(255),
  nombre_contacto VARCHAR(255),
  apellido_contacto VARCHAR(255),
  fax VARCHAR(20),
  limite_credito DECIMAL(10,2)
);

CREATE TABLE dimension_producto (
  ID_producto INT PRIMARY KEY,
  Categoria int,
  CodigoProducto VARCHAR(255),
  nombre VARCHAR(255),
  dimensiones VARCHAR(255),
  proveedor VARCHAR,
  descripcion TEXT,
  cantidad_en_stock DECIMAL(10,2),
  precio_venta DECIMAL(15,2),
  precio_proveedor DECIMAL(15,2)
);

CREATE TABLE dimension_geografia (
  ID_geografia INT PRIMARY KEY,
  ciudad VARCHAR(255),
  region VARCHAR(255),
  codigo_postal VARCHAR(10),
  país VARCHAR(255)
);

CREATE TABLE dimension_empleado (
  ID_empleado INT PRIMARY KEY,
  ID_jefe INT,
  nombre VARCHAR(50),
  apellido1 VARCHAR(50),
  apellido2 VARCHAR(50),
  extension VARCHAR(10),
  email VARCHAR(100),
  puesto VARCHAR(50)
);

CREATE TABLE dimension_oficina (
  ID_oficina INT PRIMARY KEY,
  descripcion TEXT,
  telefono VARCHAR(20),
  indicativo VARCHAR (5),
  linea_direccion1 VARCHAR(50),
  linea_direccion2 VARCHAR(50)
);

CREATE TABLE fac_pedido (
  ID_pedido INT PRIMARY KEY,
  ID_producto INT,
  ID_Fecha INT,
  ID_cliente INT,
  ID_geografico INT,
  ID_Empleado INT,
  ID_oficina INT,
  precio_proveedor DECIMAL(10,2),
  precio_unidad DECIMAL(10,2),
  numero_linea INT,
  cantidad INT,
    FOREIGN KEY (ID_producto) REFERENCES dimension_producto (ID_producto),
    FOREIGN KEY (ID_Fecha) REFERENCES dimension_tiempo (ID_tiempo),
    FOREIGN KEY (ID_cliente) REFERENCES dimension_cliente (ID_cliente),
    FOREIGN KEY (ID_geografico) REFERENCES dimension_geografia (ID_geografia),
    FOREIGN KEY (ID_Empleado) REFERENCES dimension_empleado (ID_empleado),
    FOREIGN KEY (ID_oficina) REFERENCES dimension_oficina (ID_oficina)
);



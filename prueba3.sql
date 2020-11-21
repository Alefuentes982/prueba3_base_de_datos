----Creando base de datos-----    
    CREATE DATABASE prueba3

-- Creando tablas--------

-----tabla categoria-------
    CREATE TABLE categoria(categoria_id INT,
    nombre_categoria VARCHAR(80),
    descripcion_categoria VARCHAR(255),
    PRIMARY KEY(categoria_id));

-----tabla productos-----
    CREATE TABLE productos(id_producto INT,
    nombre VARCHAR(50),
    descripcion VARCHAR(255),
    prod_valor_u FLOAT,
    cat_id INT, 
    PRIMARY KEY(id_producto),
    FOREIGN KEY (cat_id) REFERENCES categoria(categoria_id));

-----tabla cliente-----
    CREATE TABLE cliente(id_cliente INT,
    rut VARCHAR (10),
    nombre VARCHAR(30),
    direccion VARCHAR(255),
    PRIMARY KEY(id_cliente));

-----tabla facturas-----
    CREATE TABLE facturas(id_factura INT,
    num_factura INT,
    fecha DATE,
    subtotal FLOAT,
    cliente_id INT, 
    PRIMARY KEY(id_factura),
    FOREIGN KEY (cliente_id) REFERENCES cliente(id_cliente));

----tabla intermedia prod_fact--------- 
    CREATE TABLE fact_prod(fact_prod_id INT,
    cantidad INT,
    factura_id INT,
    producto_id INT, 
    PRIMARY KEY (fact_prod_id),
    FOREIGN KEY(factura_id) REFERENCES facturas(id_factura),
    FOREIGN KEY(producto_id) REFERENCES productos(id_producto));

----------------------------------------------------------------

-- Insertando registros-----------------------------------------------------

------clientes---------------------------------------------------

INSERT INTO cliente VALUES (1, '15482965-6', 'Alan Brito Delgado', 
 'Calle el Acero 5241');
INSERT INTO cliente VALUES (2, '8614760-5','Esteban Dido',
 'Av. La Celda 24');
INSERT INTO cliente VALUES (3, '20554632-2','Susana Oria',
 'Huertos Familiares 1024');
INSERT INTO cliente VALUES (4, '17414101-8', 'Elba Zurita',
  'Av Lepanto 81');
INSERT INTO cliente VALUES (5, '10501214-k', 'Helen Chufe',
 'Thomas Alba Edison 6091');


----- Insertando categorias-----------------------------------------------
INSERT INTO categoria VALUES (1001, 'Deportes', 
'Ropa Deportiva, Biciletas, Mundo Fitness');
INSERT INTO categoria VALUES (1002, 'Tecnologia', 
'Computacion, Videojuegos, Televisores');
INSERT INTO categoria VALUES (1003, 'Vestuario', 
'Poleras, Camisas, Jeans');


----Insertando 8 productos---------------------------------------------------
   
INSERT INTO productos VALUES (5001, 'Cannondale 700c', 
'Bicicleta Ruta', 2699990, 1001);
INSERT INTO productos VALUES (5002, 'Athleticx',
'Set Mancuerna Armable 20kg', 59900, 1001);
INSERT INTO productos VALUES (5003, 'Televisor Samsung TU7100', 
'Crystal UHD, 4K Smart TV', 359990, 1002);
INSERT INTO productos VALUES (5004, 'Sony playstation pack 13', 
'Consola Sony + juegos GTA V, God, Death Stranding', 449990, 1002);
INSERT INTO productos VALUES (5005, 'Apple MAcbook pro 16', 
'Intel Core i9 16 GB RAM-1TB SSD Space Gray', 2799990, 1002);
INSERT INTO productos VALUES (5006, 'Sony MHC-V83D//M LA9', 
'Minicomponente', 389990, 1002);
INSERT INTO productos VALUES (5007, 'Mossimo', 
'Jeans slim fit hombre', 19990, 1003);
INSERT INTO productos VALUES (5008, 'Americanino', 
'Camisa Casual Classic Fit', 26990, 1003);


----------Insertando Facturas Clientes -------------------------------------

------------facturas cliente 1-------------------------------------------
INSERT INTO facturas VALUES (1, 90001, '2020-11-01', 2739970, 1);
INSERT INTO fact_prod VALUES (1, 1, 1, 5001);
INSERT INTO fact_prod VALUES (2, 2, 1, 5007);

INSERT INTO facturas VALUES (2, 90002, '2020-11-05', 623950, 1);
INSERT INTO fact_prod VALUES (3, 1, 2, 5004);
INSERT INTO fact_prod VALUES (4, 2, 2, 5008);
INSERT INTO fact_prod VALUES (5, 2, 2, 5002);

------------facturas cliente 2-----------------------------------
INSERT INTO facturas VALUES (3, 90003, '2020-11-05', 1199970, 2);
INSERT INTO fact_prod VALUES (6, 1, 3, 5003);
INSERT INTO fact_prod VALUES (7, 1, 3, 5004);
INSERT INTO fact_prod VALUES (8, 1, 3, 5006);

INSERT INTO facturas VALUES (4, 90004, '2020-11-07', 86980, 2);
INSERT INTO fact_prod VALUES (9, 1, 4, 5002);
INSERT INTO fact_prod VALUES (10, 1, 4, 5008);

INSERT INTO facturas VALUES (5, 90005, '2020-11-10', 1199970, 2);
INSERT INTO fact_prod VALUES (11, 1, 5, 5003);
INSERT INTO fact_prod VALUES (12, 1, 5, 5005);
INSERT INTO fact_prod VALUES (13, 1, 5, 5006);

------------facturas cliente 3--------------------------------------
INSERT INTO facturas VALUES (6, 90006, '2020-11-15', 2699990, 3);
INSERT INTO fact_prod VALUES (14, 1, 6, 5001);

------------facturas cliente 4---------------------------------------
INSERT INTO facturas VALUES (7, 90007, '2020-11-16', 2759980, 4);
INSERT INTO fact_prod VALUES (15, 1, 7, 5001);
INSERT INTO fact_prod VALUES (16, 1, 7, 5002);

INSERT INTO facturas VALUES (8, 90008, '2020-12-17', 3449970, 4);
INSERT INTO fact_prod VALUES (17, 1, 8, 5006);
INSERT INTO fact_prod VALUES (18, 1, 8, 5001);
INSERT INTO fact_prod VALUES (19, 1, 8, 5003);

INSERT INTO facturas VALUES (9, 90009, '2020-12-18', 466960, 4);
INSERT INTO fact_prod VALUES (20, 1, 9, 5008);
INSERT INTO fact_prod VALUES (21, 1, 9, 5007);
INSERT INTO fact_prod VALUES (22, 1, 9, 5002);
INSERT INTO fact_prod VALUES (23, 1, 9, 5003);

INSERT INTO facturas VALUES (10, 90010, '2020-12-20', 2799990, 4);
INSERT INTO fact_prod VALUES (24, 1, 10, 5005);
----------------------------------------------------------------------

-----Realizando Consultas----------------------------------------------------------------------------------------

-- compra mas cara
SELECT expensive.nombre, expensive.rut, expensive.direccion, expensive.num_factura, expensive.subtotal
FROM(SELECT * FROM cliente INNER JOIN facturas ON cliente.id_cliente = facturas.cliente_id) AS expensive
ORDER BY expensive.subtotal DESC LIMIT 1;

-- monto mayor a 3000000
SELECT monto.nombre, monto.rut, monto.direccion, monto.num_factura, monto.subtotal FROM(SELECT * FROM cliente INNER JOIN facturas
ON cliente.id_cliente = facturas.cliente_id) AS monto WHERE monto.subtotal >= 3000000;

--clientes producto 6
SELECT DISTINCT cliente.nombre, cliente.rut, cliente.direccion FROM cliente INNER JOIN facturas
ON cliente.id_cliente = facturas.cliente_id INNER JOIN fact_prod 
ON facturas.id_factura = fact_prod.factura_id WHERE fact_prod.producto_id = 5006; 
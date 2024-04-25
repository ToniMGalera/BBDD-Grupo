CREATE DATABASE masonescompany;
USE masonescompany;

-- Proveedores
CREATE TABLE Proveedores (
    id_proveedor INT AUTO_INCREMENT, 
    nombre NVARCHAR(100) NOT NULL,
    correo NVARCHAR (100) UNIQUE NOT NULL,
    telefono VARCHAR (14),
    direccion NVARCHAR (255),
    PRIMARY KEY (id_proveedor)
);

-- Productos
CREATE TABLE Productos (
  id_producto INT AUTO_INCREMENT,
  nombre NVARCHAR(100) NOT NULL,
  descripcion TEXT,
  foto VARCHAR (255),
  precio DECIMAL(10,2) NOT NULL,
  stock INT NOT NULL,
  proveedor INT,
  PRIMARY KEY (id_producto),
  FOREIGN KEY (proveedor) REFERENCES Proveedores(id_proveedor) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Clientes
CREATE TABLE Clientes (
  id_cliente INT AUTO_INCREMENT,
  nombre NVARCHAR(100) NOT NULL,
  apellido_1 NVARCHAR(100) NOT NULL,
  apellido_2 NVARCHAR(100),
  direccion VARCHAR(255) NOT NULL,
  correo VARCHAR(100) UNIQUE NOT NULL,
  telefono VARCHAR(14) NOT NULL,
  responsable NVARCHAR (100),
  PRIMARY KEY (id_cliente)
);

-- Pedidos
CREATE TABLE Pedidos (
  id_pedido INT AUTO_INCREMENT,
  fecha_pedido DATE,
  total_pedido DECIMAL(10,2),
  estado_pedido ENUM('pendiente', 'aceptado', 'en_preparación', 'enviado', 'entregado', 'cancelado'),
  cliente INT,
  PRIMARY KEY (id_pedido),
  FOREIGN KEY (cliente) REFERENCES Clientes(id_cliente)
);

-- Devoluciones
CREATE TABLE Devoluciones (
  id_devolucion INT AUTO_INCREMENT,
  fecha_devolucion DATE,
  estado_devolucion ENUM('pendiente', 'enviado', 'por_recibir', 'entregado', 'cancelado', 'en_revision', 'aceptado'),
  cliente INT,
  pedido INT,
  PRIMARY KEY (id_devolucion),
  FOREIGN KEY (cliente) REFERENCES Clientes(id_cliente) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (pedido) REFERENCES Pedidos(id_pedido) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Detalles pedidos
CREATE TABLE DetallesPedidos (
  id_detalle_pedido INT AUTO_INCREMENT,
  pedido_id INT,
  producto_id INT,
  cantidad INT,
  precio_unitario DECIMAL(10,2),
  subtotal DECIMAL(10,2),
  PRIMARY KEY (id_detalle_pedido),
  FOREIGN KEY (pedido_id) REFERENCES Pedidos(id_pedido) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (producto_id) REFERENCES Productos(id_producto) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO proveedores (nombre, correo, telefono, direccion)
VALUES
  ( 'Samsung Electronics', 'samsung@example.com', '123456789', 'Calle 1, 123'),
  ( 'LG Electronics', 'lg@example.com', '987654321', 'Calle 2, 456'),
  ('Sony Corporation', 'sony@example.com', '111111111', 'Calle 3, 789'),
  ( 'Apple Inc.', 'apple@example.com', '222222222', 'Calle 4, 901'),
  ( 'HP Inc.', 'hp@example.com', '333333333', 'Calle 5, 234'),
  ('Dell Inc.', 'dell@example.com', '444444444', 'Calle 6, 567'),
  ( 'AsusTek Computer Inc.', 'asus@example.com', '555555555', 'Calle 7, 890'),
  ( 'Acer Inc.', 'acer@example.com', '666666666', 'Calle 8, 345'),
  ( 'Toshiba Corporation', 'toshiba@example.com', '777777777', 'Calle 9, 678'),
  ( 'Lenovo Group', 'lenovo@example.com', '888888888', 'Calle 10, 901');

SELECT * FROM proveedores;
UPDATE Proveedores SET correo = 'newapple@example.com' WHERE nombre = 'Apple Inc.';
UPDATE Proveedores SET direccion = 'Avenida 3, 789' WHERE nombre = 'LG Electronics';

INSERT INTO Clientes (nombre, apellido_1, apellido_2, dirección, correo, telefono, responsable)
VALUES
  ('Juan', 'Pérez', 'González', 'Calle 1, 123', 'juan.perez@example.com', '123456789', 'Toni'),
  ('María', 'García', 'Hernández', 'Calle 2, 456', 'maria.garcia@example.com', '987654321', 'Toni'),
  ('Pedro', 'Martínez', 'Rodríguez', 'Calle 3, 789', 'pedro.martinez@example.com', '111111111', 'Toni'),
  ('Ana', 'Sánchez', 'Gómez', 'Calle 4, 901', 'ana.sanchez@example.com', '222222222', 'Toni'),
  ('Luis', 'García', 'Hernández', 'Calle 5, 234', 'luis.garcia@example.com', '333333333', 'Toni'),
  ('Eva', 'Hernández', 'Gómez', 'Calle 6, 567', 'eva.hernandez@example.com', '444444444', 'Toni'),
  ('Carlos', 'Rodríguez', 'García', 'Calle 7, 890', 'carlos.rodriguez@example.com', '555555555', 'Toni'),
  ('Sofía', 'Gómez', 'Hernández', 'Calle 8, 345', 'sofia.gomez@example.com', '666666666', 'Toni'),
  ('Lucía', 'Fernández', 'García', 'Calle 9, 678', 'lucia.fernandez@example.com', '777777777', 'Toni'),
  ('Jorge', 'López', 'Gómez', 'Calle 10, 901', 'jorge.lopez@example.com', '888888888', 'Toni');

SELECT * FROM clientes;
SELECT * FROM clientes WHERE apellido_1 LIKE '%García%' OR apellido_2 LIKE '%García%';
UPDATE Clientes SET telefono = '555555555' WHERE correo = 'juan.perez@example.com';
DELETE FROM Clientes WHERE apellido_2 = 'González';

INSERT INTO Productos (nombre, descripción, precio, stock, proveedor)
VALUES
  ('Televisor', 'Televisor 4K', 500.00, 10, 1),
  ('Laptop', 'Laptop de 15 pulgadas', 800.50, 5, 2),
  ('Tablet', 'Tablet con pantalla táctil', 300.25, 12, 2),
  ('Smartphone', 'Smartphone con cámara de 12 MP', 600.75, 8, 1),
  ('Consola de videojuegos', 'Consola de videojuegos con juego incluido', 250.99, 15, 3),
  ('Impresora 3D', 'Impresora 3D para imprimir objetos', 1200.50, 3, 4),
  ('Cámara de fotos', 'Cámara de fotos con estabilizador óptico', 400.25, 10, 5),
  ('Reproductor de música', 'Reproductor de música con almacenamiento de 64 GB', 150.50, 12, 6),
  ('Gafas de realidad virtual', 'Gafas de realidad virtual con pantalla de 5 pulgadas', 200.75, 8, 7),
  ('Tableta para niños', 'Tableta para niños con juegos educativos', 180.99, 15, 8);

SELECT * FROM productos;
SELECT SUM(precio) AS total_de_precios FROM productos;
UPDATE Productos SET precio = 550.00 WHERE nombre = 'Televisor';
UPDATE Productos SET stock = 20 WHERE descripción LIKE '%Laptop%';

INSERT INTO Pedidos (fecha_pedido, total_pedido, estado_pedido, cliente)
VALUES
  ('2024-01-01', 1000.00, 'pendiente', 1),
  ('2024-02-01', 800.50, 'aceptado', 2),
  ('2024-03-01', 600.75, 'en_preparación', 3),
  ('2024-04-01', 250.99, 'cancelado', 4),
  ('2024-05-01', 1200.50, 'entregado', 5),
  ('2024-06-01', 400.25, 'enviado', 5),
  ('2024-07-01', 150.50, 'enviado', 2),
  ('2024-08-01', 200.75, 'cancelado', 4),
  ('2024-09-01', 180.99, 'entregado', 8),
  ('2024-10-01', 250.00, 'aceptado', 9);

SELECT * FROM pedidos;
SELECT * FROM pedidos WHERE estado_pedido = 'pendiente' OR estado_pedido = 'aceptado';
UPDATE Pedidos SET total_pedido = 1100.00, estado_pedido = 'aceptado' WHERE id_pedido = 1;

INSERT INTO Devoluciones (fecha_devolucion, estado_devolucion, cliente, pedido)
VALUES
  ('2024-01-01', 'pendiente', 1, 1),
  ('2024-02-01', 'enviado', 2, 2),
  ('2024-03-01', 'por_recibir', 3, 3),
  ('2024-04-01', 'entregado', 4, 4),
  ('2024-05-01', 'cancelado', 5, 5),
  ('2024-06-01', 'en_revision', 6, 6),
  ('2024-07-01', 'en_revision', 7, 7),
  ('2024-08-01', 'aceptado', 8, 8),
  ('2024-09-01', 'aceptado', 9, 9),
  ('2024-10-01', 'pendiente', 10, 10);

  SELECT * FROM devoluciones;
  SELECT * FROM devoluciones WHERE estado_devolucion = 'por_recibir';
  UPDATE Devoluciones SET estado_devolucion = 'entregado' WHERE id_devolucion = 2;

  INSERT INTO DetallesPedidos (pedido_id, producto_id, cantidad, precio_unitario, subtotal)
  VALUES
  (1, 1, 2, 500.00, 1000.00),
  (2, 2, 3, 300.00, 900.00),
  (3, 3, 4, 200.00, 800.00),
  (4, 4, 1, 100.00, 100.00),
  (5, 5, 2, 300.00, 600.00),
  (6, 6, 3, 200.00, 600.00),
  (7, 7, 4, 100.00, 400.00),
  (8, 8, 1, 200.00, 200.00),
  (9, 9, 2, 300.00, 600.00),
  (10, 10, 3, 100.00, 300.00),

  SELECT * FROM detallespedidos;
  SELECT subtotal FROM detallespedidos;
  UPDATE DetallesPedidos SET cantidad = 5 WHERE pedido_id = 2 AND producto_id = 2;
  DELETE FROM DetallesPedidos WHERE id_detalle_pedido = 3;
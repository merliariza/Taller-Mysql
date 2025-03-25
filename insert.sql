INSERT INTO Clientes (nombre) VALUES 
('Juan Pérez'),
('María López'),
('Carlos Ruiz'),
('Ana García'),
('Roberto Díaz'),
('Laura Torres'),
('Miguel Hernández'),
('Sofía Martín'),
('Javier Muñoz'),
('Lucía Vega');

INSERT INTO ContactosClientes (cliente_id, email, tipo) VALUES 
(1, 'juan@gmail.com', 'Personal'),
(1, 'juan@empresa.com', 'Trabajo'),
(2, 'maria@gmail.com', 'Personal'),
(3, 'carlos@gmail.com', 'Personal'),
(4, 'ana@gmail.com', 'Personal'),
(5, 'roberto@gmail.com', 'Personal'),
(6, 'laura@gmail.com', 'Personal'),
(7, 'miguel@gmail.com', 'Personal'),
(8, 'sofia@gmail.com', 'Personal'),
(9, 'javier@gmail.com', 'Personal'),
(10, 'lucia@gmail.com', 'Personal');

INSERT INTO Ubicaciones (entidad, entidad_id, direccion, ciudad, estado, codigo_postal, pais) VALUES 
('Cliente', 1, 'Calle1', 'Bucaramanga', 'Santander', '680001', 'Colombia'),
('Cliente', 2, 'Calle2', 'Bucaramanga', 'Santander', '680002', 'Colombia'),
('Cliente', 3, 'Calle3', 'Bucaramanga', 'Santander', '680003', 'Colombia'),
('Cliente', 4, 'Calle4', 'Bucaramanga', 'Santander', '680004', 'Colombia'),
('Cliente', 5, 'Calle5', 'Bucaramanga', 'Santander', '680005', 'Colombia'),
('Cliente', 6, 'Calle11', 'Floridablanca', 'Santander', '680011', 'Colombia'),
('Cliente', 7, 'Calle12', 'Floridablanca', 'Santander', '680012', 'Colombia'),
('Cliente', 8, 'Calle13', 'Floridablanca', 'Santander', '680013', 'Colombia'),
('Cliente', 9, 'Calle14', 'Floridablanca', 'Santander', '680014', 'Colombia'),
('Cliente', 10, 'Calle15', 'Floridablanca', 'Santander', '680015', 'Colombia'),
('Proveedor', 1, 'Calle6', 'Bucaramanga', 'Santander', '680006', 'Colombia'),
('Proveedor', 2, 'Calle7', 'Bucaramanga', 'Santander', '680007', 'Colombia'),
('Proveedor', 3, 'Calle8', 'Bucaramanga', 'Santander', '680008', 'Colombia'),
('Proveedor', 4, 'Calle9', 'Bucaramanga', 'Santander', '680009', 'Colombia'),
('Proveedor', 5, 'Calle10', 'Bucaramanga', 'Santander', '680010', 'Colombia');

INSERT INTO Telefonos (cliente_id, telefono, tipo) VALUES 
(1, '3101234567', 'Móvil'),
(1, '3159876543', 'Casa'),
(2, '3201234567', 'Móvil'),
(3, '3112345678', 'Móvil'),
(4, '3123456789', 'Móvil'),
(5, '3134567890', 'Móvil'),
(6, '3145678901', 'Móvil'),
(7, '3176543210', 'Móvil'),
(8, '3187654321', 'Móvil'),
(9, '3198765432', 'Móvil'),
(10, '3109876543', 'Móvil');

INSERT INTO Puestos (nombre, salario_base) VALUES 
('Gerente', 6000000),
('Supervisor', 4500000),
('Vendedor', 3000000),
('Administrativo', 2500000),
('Técnico', 3500000),
('Analista', 4000000),
('Desarrollador', 3800000),
('Director', 7000000),
('Asistente', 2200000),
('Consultor', 5000000);

INSERT INTO DatosEmpleados (nombre, puesto_id, fecha_contratacion) VALUES 
('Pablo Martín', 1, '2020-01-15'),
('Elena López', 2, '2021-03-10'),
('David García', 3, '2022-05-20'),
('Isabel Mora', 4, '2023-07-05'),
('Raúl Jiménez', 5, '2021-09-15'),
('Carmen Ortiz', 6, '2022-11-25'),
('Sergio García', 7, '2023-02-10'),
('Marta Vega', 8, '2020-04-30'),
('Alejandro Ruiz', 9, '2022-06-12'),
('Cristina Hernández', 10, '2023-08-22');

INSERT INTO Proveedores (nombre) VALUES 
('Electrónica'),
('Suministros'),
('Componentes'),
('Distribuidora'),
('Materiales'),
('Insumos'),
('Productos'),
('Equipos'),
('Soluciones'),
('Accesorios');

INSERT INTO ContactoProveedores (proveedor_id, nombre, telefono, email) VALUES 
(1, 'Pedro Gómez', '3101234567', 'pedro@gmail.com'),
(2, 'Silvia Hernández', '3159876543', 'silvia@gmail.com'),
(3, 'Jorge García', '3201234567', 'jorge@gmail.com'),
(4, 'Nuria Ruiz', '3112345678', 'nuria@gmail.com'),
(5, 'Alberto Díaz', '3123456789', 'alberto@gmail.com'),
(6, 'Beatriz Mora', '3134567890', 'beatriz@gmail.com'),
(7, 'Daniel Ortiz', '3145678901', 'daniel@gmail.com'),
(8, 'Eva Torres', '3176543210', 'eva@gmail.com'),
(9, 'Fernando Vega', '3187654321', 'fernando@gmail.com'),
(10, 'Gloria López', '3198765432', 'gloria@gmail.com');

INSERT INTO TiposProductos (tipo_nombre, descripcion, parent_id) VALUES 
('Electrónica', 'Productos electrónicos', 1),
('Informática', 'Equipos informáticos', 1),
('Hogar', 'Productos para casa', 3),
('Oficina', 'Material de oficina', 3),
('Móviles', 'Teléfonos móviles', 1),
('Portátiles', 'Ordenadores portátiles', 2),
('Electrodomésticos', 'Aparatos para el hogar', 3),
('Mobiliario', 'Muebles de oficina', 4),
('Tablets', 'Tablets y accesorios', 1),
('Impresoras', 'Impresoras y escáneres', 2);

INSERT INTO Productos (nombre, precio, proveedor_id, tipo_id) VALUES 
('Móvil', 699000, 1, 5),
('Portátil', 1299000, 2, 6),
('Nevera', 899000, 3, 7),
('Mesa', 249000, 4, 8),
('Tablet', 499000, 5, 9),
('Impresora', 179000, 6, 10),
('TV', 799000, 7, 1),
('Monitor', 349000, 8, 2),
('Aspiradora', 299000, 9, 3),
('Silla', 189000, 10, 4),
('Móvil2', 799000, 1, 5),
('Portátil2', 1499000, 2, 6),
('Lavadora', 649000, 3, 7),
('Estantería', 129000, 4, 8),
('Tablet2', 299000, 5, 9),
('Escáner', 149000, 6, 10),
('Altavoz', 89000, 7, 1),
('Teclado', 79000, 8, 2),
('Cafetera', 199000, 9, 3),
('Lámpara', 49000, 10, 4);

INSERT INTO Pedidos (cliente_id, fecha, total) VALUES 
(1, '2023-01-10', 699000),
(2, '2023-02-15', 1299000),
(3, '2023-03-20', 899000),
(4, '2023-04-25', 249000),
(5, '2023-05-30', 499000),
(6, '2023-06-05', 179000),
(7, '2023-07-10', 799000),
(8, '2023-08-15', 349000),
(9, '2023-09-20', 299000),
(10, '2023-10-25', 189000),
(1, '2023-11-01', 1598000),
(2, '2023-12-05', 949000),
(3, '2024-01-10', 979000),
(4, '2024-02-15', 1149000),
(5, '2024-03-20', 649000);

INSERT INTO DetallesPedido (pedido_id, producto_id, cantidad, precio_unitario, subtotal) VALUES 
(1, 1, 1, 699000, 699000),
(2, 2, 1, 1299000, 1299000),
(3, 3, 1, 899000, 899000),
(4, 4, 7, 249000, 174300),
(5, 5, 1, 499000, 499000),
(6, 6, 1, 179000, 179000),
(7, 7, 1, 799000, 799000),
(8, 8, 1, 349000, 349000),
(9, 9, 1, 299000, 299000),
(10, 10, 1, 189000, 189000),
(11, 1, 1, 799000, 799000),
(11, 11, 1, 799000, 799000),
(12, 5, 1, 499000, 499000),
(12, 15, 1, 299000, 299000),
(13, 9, 1, 299000, 299000),
(13, 19, 1, 199000, 199000),
(14, 2, 1, 1299000, 1299000),
(14, 12, 1, 1499000, 1499000),
(15, 6, 1, 179000, 179000),
(15, 16, 1, 149000, 149000);

INSERT INTO HistorialPedidos (pedido_id, fecha_modificacion, estado, comentario) VALUES 
(1, '2023-01-10 10:00:00', 'Pendiente', 'Pedido recibido'),
(1, '2023-01-11 12:00:00', 'Procesando', 'Preparando envío'),
(1, '2023-01-12 15:00:00', 'Enviado', 'Producto en camino'),
(2, '2023-02-15 09:30:00', 'Pendiente', 'Pedido recibido'),
(2, '2023-02-16 11:45:00', 'Procesando', 'Preparando envío'),
(3, '2023-03-20 14:15:00', 'Pendiente', 'Pedido recibido'),
(4, '2023-04-25 16:30:00', 'Pendiente', 'Pedido recibido'),
(5, '2023-05-30 13:45:00', 'Pendiente', 'Pedido recibido'),
(6, '2023-06-05 10:20:00', 'Pendiente', 'Pedido recibido'),
(7, '2023-07-10 12:35:00', 'Pendiente', 'Pedido recibido'),
(8, '2023-08-15 15:50:00', 'Pendiente', 'Pedido recibido'),
(9, '2023-09-20 09:15:00', 'Pendiente', 'Pedido recibido'),
(10, '2023-10-25 11:30:00', 'Pendiente', 'Pedido recibido'),
(11, '2023-11-01 14:45:00', 'Pendiente', 'Pedido recibido'),
(12, '2023-12-05 16:00:00', 'Pendiente', 'Pedido recibido');

INSERT INTO EmpleadoProveedor (empleado_id, proveedor_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO HistorialSalarios (puesto_id, salario_anterior, salario_nuevo, fecha_cambio) VALUES
(1, 450000, 500000, '2024-03-15 10:00:00'),
(2, 320000, 350000, '2024-03-20 15:30:00');

INSERT INTO Inventario (producto_id, cantidad) VALUES 
(1, 15),
(2, 40),
(3, 30),
(4, 25),
(5, 15),
(6, 40),
(7, 30),
(8, 25),
(9, 15),
(10, 40);

INSERT INTO LogActividades (tabla, accion, entidad_id, fecha) VALUES
('Cliente', 'Inserción', 2, '2024-03-10 14:20:00'),
('Proveedor', 'Eliminación', 3, '2024-03-30 10:45:00');

INSERT INTO HistorialContratos (empleado_id, puesto_anterior, puesto_nuevo, fecha_cambio) VALUES
(1, 2, 1, '2024-04-01 09:00:00'), 
(2, 1, 2, '2024-04-05 14:30:00');

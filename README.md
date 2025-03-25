# Solución taller MySQL

## Normalización
 Creación de la base de datos
```sql
CREATE DATABASE vtaszfs;
USE vtaszfs;
```

 Tabla Clientes
```sql
CREATE TABLE Clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100)
);
```

 Tabla ContactosClientes
```sql
CREATE TABLE ContactosClientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    email VARCHAR(100) UNIQUE,
    tipo VARCHAR(20),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);
```

 Tabla Ubicaciones
```sql
CREATE TABLE Ubicaciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    entidad VARCHAR(50),
    entidad_id INT,
    direccion VARCHAR(255),
    ciudad VARCHAR(100),
    estado VARCHAR(50),
    codigo_postal VARCHAR(10),
    pais VARCHAR(50)
);
```

 Tabla Telefonos
```sql
CREATE TABLE Telefonos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    telefono VARCHAR(20),
    tipo VARCHAR(20),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);
```

 Tabla Puestos
```sql
CREATE TABLE Puestos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    salario_base DECIMAL(10,2)
);
```

 Tabla DatosEmpleados
```sql
CREATE TABLE DatosEmpleados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    puesto_id INT,
    fecha_contratacion DATE,
    FOREIGN KEY (puesto_id) REFERENCES Puestos(id)
);
```

 Tabla Proveedores
```sql
CREATE TABLE Proveedores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100)
);
```

 Tabla ContactoProveedores
```sql
CREATE TABLE ContactoProveedores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    proveedor_id INT,
    nombre VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id)
);
```

 Tabla TiposProductos
```sql
CREATE TABLE TiposProductos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_nombre VARCHAR(100),
    descripcion TEXT,
    parent_id INT NULL,
    FOREIGN KEY (parent_id) REFERENCES TiposProductos(id)
);
```

 Tabla Productos
```sql
CREATE TABLE Productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    precio DECIMAL(10, 2),
    proveedor_id INT,
    tipo_id INT,
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id),
    FOREIGN KEY (tipo_id) REFERENCES TiposProductos(id)
);
```

 Tabla Pedidos
```sql
CREATE TABLE Pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    fecha DATE,
    total DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);
```

 Tabla DetallesPedido
```sql
CREATE TABLE DetallesPedido (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT,
    producto_id INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
    FOREIGN KEY (producto_id) REFERENCES Productos(id)
);
```

 Tabla HistorialPedidos
```sql
CREATE TABLE HistorialPedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(50),
    comentario TEXT,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id)
);
```

 Tabla EmpleadoProveedor
```sql
CREATE TABLE EmpleadoProveedor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    empleado_id INT,
    proveedor_id INT,
    FOREIGN KEY (empleado_id) REFERENCES DatosEmpleados(id),
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id)
);
```

 Tabla HistorialSalarios
 ```sql
CREATE TABLE HistorialSalarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    puesto_id INT,
    salario_anterior DECIMAL(10,2),
    salario_nuevo DECIMAL(10,2),
    fecha_cambio DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (puesto_id) REFERENCES Puestos(id) ON DELETE CASCADE
);
```

 Tabla Inventario
```sql
CREATE TABLE Inventario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    producto_id INT,
    cantidad INT NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES Productos(id)
);
```

 Tabla LogActividades
 ```sql
CREATE TABLE LogActividades (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tabla VARCHAR(50) NOT NULL,
    accion VARCHAR(50) NOT NULL,
    entidad_id INT NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

 Tabla HistorialContratos
 ```sql
CREATE TABLE HistorialContratos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    empleado_id INT NOT NULL,
    puesto_anterior INT NOT NULL,
    puesto_nuevo INT NOT NULL,
    fecha_cambio DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (empleado_id) REFERENCES DatosEmpleados(id) ON DELETE CASCADE
);
```

## Joins
1. Obtener la lista de todos los pedidos con los nombres de clientes usando INNER JOIN .
```sql
SELECT p.id AS pedido_id, p.fecha, p.total, c.nombre AS cliente
FROM Pedidos p
INNER JOIN Clientes c ON p.cliente_id = c.id;
```

2. Listar los productos y proveedores que los suministran con INNER JOIN .
```sql
SELECT pr.nombre AS producto, pv.nombre AS proveedor
FROM Productos pr
INNER JOIN Proveedores pv ON pr.proveedor_id = pv.id;
```

3. Mostrar los pedidos y las ubicaciones de los clientes con LEFT JOIN .
```sql
SELECT p.id AS pedido_id, c.nombre AS cliente, u.direccion, u.ciudad, u.estado
FROM Pedidos p
LEFT JOIN Clientes c ON p.cliente_id = c.id
LEFT JOIN Ubicaciones u ON u.entidad = 'Cliente' AND u.entidad_id = c.id;
```

4. Consultar los empleados que han registrado pedidos, incluyendo empleados sin pedidos( LEFT JOIN ).
```sql
SELECT e.nombre AS empleado, COUNT(p.id) AS total_pedidos
FROM DatosEmpleados e
LEFT JOIN Pedidos p ON e.id = p.cliente_id
GROUP BY e.nombre;
```

5. Obtener el tipo de producto y los productos asociados con INNER JOIN .
```sql
SELECT t.tipo_nombre AS tipo, p.nombre AS producto
FROM Productos p
INNER JOIN TiposProductos t ON p.tipo_id = t.id;
```

6. Listar todos los clientes y el número de pedidos realizados con COUNT y GROUP BY .
```sql
SELECT c.nombre AS cliente, COUNT(p.id) AS total_pedidos
FROM Clientes c
LEFT JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.nombre;
```

7. Combinar Pedidos y Empleados para mostrar qué empleados gestionaron pedidos específicos.
```sql
SELECT p.id AS pedido_id, e.nombre AS empleado
FROM Pedidos p
JOIN DatosEmpleados e ON p.cliente_id = e.id;
```

8. Mostrar productos que no han sido pedidos ( RIGHT JOIN ).
```sql
SELECT p.nombre AS producto_no_pedido
FROM DetallesPedido dp
RIGHT JOIN Productos p ON dp.producto_id = p.id
WHERE dp.id IS NULL;
```

9. Mostrar el total de pedidos y ubicación de clientes usando múltiples JOIN .
```sql
SELECT c.nombre AS cliente, u.ciudad, COUNT(p.id) AS total_pedidos
FROM Clientes c
LEFT JOIN Pedidos p ON c.id = p.cliente_id
LEFT JOIN Ubicaciones u ON u.entidad = 'Cliente' AND u.entidad_id = c.id
GROUP BY c.nombre, u.ciudad;
```

10. Unir Proveedores , Productos , y TiposProductos para un listado completo de inventario.
```sql
SELECT pv.nombre AS proveedor, pr.nombre AS producto, tp.tipo_nombre AS tipo
FROM Productos pr
JOIN Proveedores pv ON pr.proveedor_id = pv.id
JOIN TiposProductos tp ON pr.tipo_id = tp.id;
```

## Consultas Simples
1. Seleccionar todos los productos con precio mayor a $50.
```sql
SELECT * FROM Productos WHERE precio > 50;
```

2. Consultar clientes registrados en una ciudad específica.
```sql
SELECT c.nombre 
FROM Clientes c
JOIN Ubicaciones u ON u.entidad = 'Cliente' AND u.entidad_id = c.id
WHERE u.ciudad = 'Bucaramanga';
```

3. Mostrar empleados contratados en los últimos 2 años.
```sql
SELECT nombre FROM DatosEmpleados 
WHERE fecha_contratacion >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);
```

4. Seleccionar proveedores que suministran más de 5 productos.
```sql
SELECT p.nombre, COUNT(pr.id) AS total_productos
FROM Proveedores p
JOIN Productos pr ON p.id = pr.proveedor_id
GROUP BY p.nombre
HAVING COUNT(pr.id) > 5;
```

5. Listar clientes que no tienen dirección registrada en UbicacionCliente .
```sql
SELECT c.nombre
FROM Clientes c
LEFT JOIN Ubicaciones u ON u.entidad = 'Cliente' AND u.entidad_id = c.id
WHERE u.id IS NULL;
```

6. Calcular el total de ventas por cada cliente.
```sql
SELECT c.nombre, SUM(p.total) AS total_ventas
FROM Clientes c
LEFT JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.nombre;
```

7. Mostrar el salario promedio de los empleados.
```sql
SELECT AVG(p.salario_base) AS salario_promedio
FROM Puestos p
JOIN DatosEmpleados e ON p.id = e.puesto_id;
```

8. Consultar el tipo de productos disponibles en TiposProductos .
```sql
SELECT tipo_nombre FROM TiposProductos;
```

9. Seleccionar los 3 productos más caros.
```sql
SELECT nombre, precio FROM Productos
ORDER BY precio DESC LIMIT 3;
```

10. Consultar el cliente con el mayor número de pedidos.
```sql
SELECT c.nombre, COUNT(p.id) AS total_pedidos
FROM Clientes c
JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.nombre
ORDER BY total_pedidos DESC LIMIT 1;
```

## Consultas Multitabla
1. Listar todos los pedidos y el cliente asociado.
```sql
SELECT p.id AS pedido_id, p.fecha, p.total, c.nombre AS cliente
FROM Pedidos p
JOIN Clientes c ON p.cliente_id = c.id;
```

2. Mostrar la ubicación de cada cliente en sus pedidos.
```sql
SELECT p.id AS pedido_id, c.nombre AS cliente, u.direccion, u.ciudad
FROM Pedidos p
JOIN Clientes c ON p.cliente_id = c.id
JOIN Ubicaciones u ON u.entidad = 'Cliente' AND u.entidad_id = c.id;
```

3. Listar productos junto con el proveedor y tipo de producto.
```sql
SELECT pr.nombre AS producto, pv.nombre AS proveedor, tp.tipo_nombre AS tipo
FROM Productos pr
JOIN Proveedores pv ON pr.proveedor_id = pv.id
JOIN TiposProductos tp ON pr.tipo_id = tp.id;
```

4. Consultar todos los empleados que gestionan pedidos de clientes en una ciudad específica.
```sql
SELECT DISTINCT e.nombre AS empleado
FROM DatosEmpleados e
JOIN Pedidos p ON e.id = p.cliente_id
JOIN Clientes c ON p.cliente_id = c.id
JOIN Ubicaciones u ON u.entidad = 'Cliente' AND u.entidad_id = c.id
WHERE u.ciudad = 'Bucaramanga';
```

5. Consultar los 5 productos más vendidos.
```sql
SELECT pr.nombre, SUM(dp.cantidad) AS total_vendido
FROM Productos pr
JOIN DetallesPedido dp ON pr.id = dp.producto_id
GROUP BY pr.nombre
ORDER BY total_vendido DESC LIMIT 5;
```

6. Obtener la cantidad total de pedidos por cliente y ciudad.
```sql
SELECT c.nombre, u.ciudad, COUNT(p.id) AS total_pedidos
FROM Clientes c
JOIN Pedidos p ON c.id = p.cliente_id
JOIN Ubicaciones u ON u.entidad = 'Cliente' AND u.entidad_id = c.id
GROUP BY c.nombre, u.ciudad;
```

7. Listar clientes y proveedores en la misma ciudad.
```sql
SELECT c.id AS cliente_id, c.nombre AS cliente, 
       uc.ciudad AS ciudad_cliente,
       pv.id AS proveedor_id, pv.nombre AS proveedor
FROM Clientes c
INNER JOIN Ubicaciones uc ON uc.entidad = 'Cliente' AND uc.entidad_id = c.id
INNER JOIN Ubicaciones up ON up.entidad = 'Proveedor' AND up.ciudad = uc.ciudad
INNER JOIN Proveedores pv ON up.entidad_id = pv.id;
```

8. Mostrar el total de ventas agrupado por tipo de producto.
```sql
SELECT tp.tipo_nombre, SUM(dp.cantidad * dp.precio_unitario) AS total_ventas
FROM TiposProductos tp
JOIN Productos pr ON tp.id = pr.tipo_id
JOIN DetallesPedido dp ON pr.id = dp.producto_id
GROUP BY tp.tipo_nombre;
```

9. Listar empleados que gestionan pedidos de productos de un proveedor específico.
```sql
SELECT DISTINCT e.nombre AS empleado
FROM DatosEmpleados e
JOIN Pedidos p ON e.id = p.cliente_id
JOIN DetallesPedido dp ON p.id = dp.pedido_id
JOIN Productos pr ON dp.producto_id = pr.id
JOIN Proveedores pv ON pr.proveedor_id = pv.id
WHERE pv.nombre = 'Electrónica';
```

10. Obtener el ingreso total de cada proveedor a partir de los productos vendidos.
```sql
SELECT pv.nombre AS proveedor, SUM(dp.cantidad * dp.precio_unitario) AS ingreso_total
FROM Proveedores pv
JOIN Productos pr ON pv.id = pr.proveedor_id
JOIN DetallesPedido dp ON pr.id = dp.producto_id
GROUP BY pv.nombre;
```

## Subconsultas
1. Consultar el producto más caro en cada categoría.
```sql
SELECT tp.tipo_nombre, p.nombre, p.precio
FROM Productos p
JOIN TiposProductos tp ON p.tipo_id = tp.id
WHERE p.precio = (
    SELECT MAX(precio) 
    FROM Productos 
    WHERE tipo_id = p.tipo_id
);
```

2. Encontrar el cliente con mayor total en pedidos.
```sql
SELECT c.nombre, SUM(p.total) AS total_gastado
FROM Clientes c
JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.nombre
ORDER BY total_gastado DESC LIMIT 1;
```

3. Listar empleados que ganan más que el salario promedio.
```sql
SELECT e.nombre, pu.salario_base
FROM DatosEmpleados e
JOIN Puestos pu ON e.puesto_id = pu.id
WHERE pu.salario_base > (
    SELECT AVG(salario_base) FROM Puestos
);
```

4. Consultar productos que han sido pedidos más de 5 veces.
```sql
SELECT p.nombre, COUNT(dp.id) AS veces_pedido
FROM Productos p
JOIN DetallesPedido dp ON p.id = dp.producto_id
GROUP BY p.nombre
HAVING COUNT(dp.id) > 5;
```

5. Listar pedidos cuyo total es mayor al promedio de todos los pedidos.
```sql
SELECT id, total FROM Pedidos
WHERE total > (SELECT AVG(total) FROM Pedidos);
```

6. Seleccionar los 3 proveedores con más productos.
```sql
SELECT p.nombre, COUNT(pr.id) AS total_productos
FROM Proveedores p
JOIN Productos pr ON p.id = pr.proveedor_id
GROUP BY p.nombre
ORDER BY total_productos DESC LIMIT 3;
```

7. Consultar productos con precio superior al promedio en su tipo.
```sql
SELECT p.nombre, p.precio, tp.tipo_nombre
FROM Productos p
JOIN TiposProductos tp ON p.tipo_id = tp.id
WHERE p.precio > (
    SELECT AVG(precio) 
    FROM Productos 
    WHERE tipo_id = p.tipo_id
);
```

8. Mostrar clientes que han realizado más pedidos que la media.
```sql
SELECT c.nombre, COUNT(p.id) AS total_pedidos
FROM Clientes c
JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.nombre
HAVING COUNT(p.id) > (
    SELECT AVG(count) 
    FROM (
        SELECT COUNT(id) AS count 
        FROM Pedidos 
        GROUP BY cliente_id
    ) AS promedio
);
```

9. Encontrar productos cuyo precio es mayor que el promedio de todos los productos.
```sql
SELECT nombre, precio FROM Productos
WHERE precio > (SELECT AVG(precio) FROM Productos);
```

10. Mostrar empleados cuyo salario es menor al promedio del departamento.
```sql
SELECT e.nombre, p.salario_base, 
    (SELECT AVG(salario_base) FROM Puestos WHERE id = e.puesto_id) AS promedio_puesto
FROM DatosEmpleados e
JOIN Puestos p ON e.puesto_id = p.id
WHERE p.salario_base < (
    SELECT AVG(salario_base) 
    FROM Puestos 
    WHERE id = e.puesto_id
);
```

## Procedimientos Almacenados
1. Crear un procedimiento para actualizar el precio de todos los productos de un proveedor.
```sql
DELIMITER //
CREATE PROCEDURE actualizar_precios_proveedor(IN proveedor_id INT, IN porcentaje DECIMAL(5,2))
BEGIN
    UPDATE Productos
    SET precio = precio * (1 + porcentaje / 100)
    WHERE proveedor_id = proveedor_id;
END //
DELIMITER ;
CALL actualizar_precios_proveedor(1, 10);
SELECT id, nombre, precio, proveedor_id, tipo_id FROM Productos WHERE proveedor_id = 1;
```

2. Un procedimiento que devuelva la dirección de un cliente por ID.
```sql
DELIMITER //
CREATE PROCEDURE obtener_direccion_cliente(IN cliente_id INT)
BEGIN
    SELECT direccion, ciudad, estado, codigo_postal, pais
    FROM Ubicaciones
    WHERE entidad = 'Cliente' AND entidad_id = cliente_id;
END //
DELIMITER ;
CALL obtener_direccion_cliente(3);
```

3. Crear un procedimiento que registre un pedido nuevo y sus detalles.
```sql
DELIMITER //
CREATE PROCEDURE registrar_pedido(
    IN cliente_id INT,
    IN producto_id INT,
    IN cantidad INT
)
BEGIN
    DECLARE pedido_id INT;
    DECLARE precio_unitario DECIMAL(10,2);
    DECLARE subtotal DECIMAL(10,2);
    
    SELECT precio INTO precio_unitario FROM Productos WHERE id = producto_id;
    SET subtotal = precio_unitario * cantidad;
    
    INSERT INTO Pedidos (cliente_id, fecha, total) 
    VALUES (cliente_id, CURDATE(), subtotal);
    
    SET pedido_id = LAST_INSERT_ID();
    
    INSERT INTO DetallesPedido (pedido_id, producto_id, cantidad, precio_unitario, subtotal)
    VALUES (pedido_id, producto_id, cantidad, precio_unitario, subtotal);
    
    INSERT INTO HistorialPedidos (pedido_id, estado)
    VALUES (pedido_id, 'Creado');
END //
DELIMITER ;
CALL registrar_pedido(2, 5, 3);
SELECT id, cliente_id, fecha, total FROM Pedidos ORDER BY id DESC LIMIT 1;
SELECT id, pedido_id, producto_id, cantidad, precio_unitario, subtotal FROM DetallesPedido ORDER BY pedido_id DESC LIMIT 1;
SELECT id, pedido_id, fecha_modificacion, estado, comentario FROM HistorialPedidos ORDER BY pedido_id DESC LIMIT 1;
```

4. Un procedimiento para calcular el total de ventas de un cliente.
```sql
DELIMITER //
CREATE PROCEDURE total_ventas_cliente(IN cliente_id INT, OUT total DECIMAL(10,2))
BEGIN
    SELECT SUM(total) INTO total
    FROM Pedidos
    WHERE cliente_id = cliente_id;
END //
DELIMITER ;
SET @total = 0;
CALL total_ventas_cliente(2, @total);
SELECT @total;
```

5. Crear un procedimiento para obtener los empleados por puesto.
```sql
DELIMITER //
CREATE PROCEDURE empleados_por_puesto(IN puesto_nombre VARCHAR(50))
BEGIN
    SELECT e.nombre, p.nombre AS puesto
    FROM DatosEmpleados e
    JOIN Puestos p ON e.puesto_id = p.id
    WHERE p.nombre = puesto_nombre;
END //
DELIMITER ;
CALL empleados_por_puesto('Gerente');
```

6. Un procedimiento que actualice el salario de empleados por puesto.
```sql
DELIMITER //
CREATE PROCEDURE actualizar_salarios_puesto(
    IN puesto_nombre VARCHAR(50),
    IN porcentaje DECIMAL(5,2)
)
BEGIN
    UPDATE Puestos
    SET salario_base = salario_base * (1 + porcentaje / 100)
    WHERE nombre = puesto_nombre;
END //
DELIMITER ;
CALL actualizar_salarios_puesto('Vendedor', 5);
SELECT id, nombre, salario_base FROM Puestos WHERE nombre = 'Vendedor';
```

7. Crear un procedimiento que liste los pedidos entre dos fechas.
```sql
DELIMITER //
CREATE PROCEDURE pedidos_entre_fechas(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    SELECT p.id, c.nombre AS cliente, p.fecha, p.total
    FROM Pedidos p
    JOIN Clientes c ON p.cliente_id = c.id
    WHERE p.fecha BETWEEN fecha_inicio AND fecha_fin;
END //
DELIMITER ;
CALL pedidos_entre_fechas('2024-01-01', '2024-12-31');
```

8. Un procedimiento para aplicar un descuento a productos de una categoría.
```sql
DELIMITER //
CREATE PROCEDURE aplicar_descuento_categoria(
    IN tipo_id INT,
    IN descuento DECIMAL(5,2))
BEGIN
    UPDATE Productos
    SET precio = precio * (1 - descuento / 100)
    WHERE tipo_id = tipo_id;
END //
DELIMITER ;
CALL aplicar_descuento_categoria(3, 15);
SELECT id, nombre, precio FROM Productos WHERE tipo_id = 3;
```

9. Crear un procedimiento que liste todos los proveedores de un tipo de producto.
```sql
DELIMITER //
CREATE PROCEDURE proveedores_por_tipo(IN tipo_nombre VARCHAR(100))
BEGIN
    SELECT DISTINCT pv.nombre AS proveedor
    FROM Proveedores pv
    JOIN Productos pr ON pv.id = pr.proveedor_id
    JOIN TiposProductos tp ON pr.tipo_id = tp.id
    WHERE tp.tipo_nombre = tipo_nombre;
END //
DELIMITER ;
CALL proveedores_por_tipo('Electrónica');
```

10. Un procedimiento que devuelva el pedido de mayor valor.
```sql
DELIMITER //
CREATE PROCEDURE pedido_mayor_valor()
BEGIN
    SELECT p.id, c.nombre AS cliente, p.total
    FROM Pedidos p
    JOIN Clientes c ON p.cliente_id = c.id
    ORDER BY p.total DESC LIMIT 1;
END //
DELIMITER ;
CALL pedido_mayor_valor();
```

## Funciones Definidas por el Usuario
1. Crear una función que reciba una fecha y devuelva los días transcurridos.
```sql
DELIMITER //
CREATE FUNCTION dias_transcurridos(fecha DATE) RETURNS INT
DETERMINISTIC
BEGIN
    RETURN DATEDIFF(CURDATE(), fecha);
END //
DELIMITER ;
SELECT dias_transcurridos('2024-01-01') AS Dias_Transcurridos;
```

2. Crear una función para calcular el total con impuesto de un monto.
```sql
DELIMITER //
CREATE FUNCTION calcular_total_con_impuesto(monto DECIMAL(10,2), tasa DECIMAL(5,2)) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN monto * (1 + tasa / 100);
END //
DELIMITER ;
SELECT calcular_total_con_impuesto(100, 15) AS Total_Con_Impuesto;
```

3. Una función que devuelva el total de pedidos de un cliente específico.
```sql
DELIMITER //
CREATE FUNCTION total_pedidos_cliente(cliente_id INT) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM Pedidos WHERE cliente_id = cliente_id;
    RETURN total;
END //
DELIMITER ;
SELECT total_pedidos_cliente(1) AS Total_Pedidos;
```

4. Crear una función para aplicar un descuento a un producto.
```sql
DELIMITER //
CREATE FUNCTION aplicar_descuento(precio_original DECIMAL(10,2), descuento DECIMAL(5,2)) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN precio_original * (1 - descuento / 100);
END //
DELIMITER ;
SELECT aplicar_descuento(200, 10) AS Precio_Con_Descuento;
```

5. Una función que indique si un cliente tiene dirección registrada.
```sql
DELIMITER //
CREATE FUNCTION tiene_direccion(cliente_id INT) RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE existe INT;
    SELECT COUNT(*) INTO existe FROM Ubicaciones 
    WHERE entidad = 'Cliente' AND entidad_id = cliente_id;
    RETURN existe > 0;
END //
DELIMITER ;
SELECT tiene_direccion(1) AS Tiene_Direccion;
```

6. Crear una función que devuelva el salario anual de un empleado.
```sql
DELIMITER //
CREATE FUNCTION salario_anual(empleado_id INT) RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE salario DECIMAL(10,2);
    SELECT p.salario_base * 12 INTO salario
    FROM DatosEmpleados e
    JOIN Puestos p ON e.puesto_id = p.id
    WHERE e.id = empleado_id;
    RETURN salario;
END //
DELIMITER ;
SELECT salario_anual(3) AS Salario_Anual;
```

7. Una función para calcular el total de ventas de un tipo de producto.
```sql
DELIMITER //
CREATE FUNCTION ventas_por_tipo(tipo_id INT) RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(dp.cantidad * dp.precio_unitario) INTO total
    FROM DetallesPedido dp
    JOIN Productos p ON dp.producto_id = p.id
    WHERE p.tipo_id = tipo_id;
    RETURN IFNULL(total, 0);
END //
DELIMITER ;
SELECT ventas_por_tipo(2) AS Total_Ventas;
```

8. Crear una función para devolver el nombre de un cliente por ID.
```sql
DELIMITER //
CREATE FUNCTION nombre_cliente(cliente_id INT) RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
    DECLARE nombre_cliente VARCHAR(100);
    SELECT nombre INTO nombre_cliente FROM Clientes WHERE id = cliente_id;
    RETURN nombre_cliente;
END //
DELIMITER ;
SELECT nombre_cliente(5) AS Nombre_Cliente;
```

9. Una función que reciba el ID de un pedido y devuelva su total.
```sql
DELIMITER //
CREATE FUNCTION total_pedido(pedido_id INT) RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT total INTO total FROM Pedidos WHERE id = pedido_id;
    RETURN total;
END //
DELIMITER ;
SELECT total_pedido(10) AS Total_Pedido;
```

10. Crear una función que indique si un producto está en inventario.
```sql
DELIMITER //
CREATE FUNCTION producto_en_inventario(producto_id INT) RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE existe INT;
    SELECT COUNT(*) INTO existe FROM Productos WHERE id = producto_id;
    RETURN existe > 0;
END //
DELIMITER ;
SELECT producto_en_inventario(8) AS Producto_En_Inventario;
```

## Triggers
1. Crear un trigger que registre en HistorialSalarios cada cambio de salario de empleados.
```sql
DELIMITER //
CREATE TRIGGER registrar_cambio_salario
AFTER UPDATE ON Puestos
FOR EACH ROW
BEGIN
    IF NEW.salario_base != OLD.salario_base THEN
        INSERT INTO HistorialSalarios (puesto_id, salario_anterior, salario_nuevo, fecha_cambio)
        VALUES (NEW.id, OLD.salario_base, NEW.salario_base, NOW());
    END IF;
END //
DELIMITER ;
UPDATE Puestos SET salario_base = salario_base + 100 WHERE id = 1;
SELECT id, puesto_id, salario_anterior, salario_nuevo, fecha_cambio FROM HistorialSalarios;
```

2. Crear un trigger que evite borrar productos con pedidos activos.
```sql
DELIMITER //
CREATE TRIGGER evitar_borrado_producto
BEFORE DELETE ON Productos
FOR EACH ROW
BEGIN
    DECLARE pedidos_activos INT;
    SELECT COUNT(*) INTO pedidos_activos FROM DetallesPedido WHERE producto_id = OLD.id;
    IF pedidos_activos > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede borrar un producto con pedidos activos';
    END IF;
END //
DELIMITER ;
DELETE FROM Productos WHERE id = 1;
```

3. Un trigger que registre en HistorialPedidos cada actualización en Pedidos .
```sql
DELIMITER //
CREATE TRIGGER registrar_actualizacion_pedido
AFTER UPDATE ON Pedidos
FOR EACH ROW
BEGIN
    INSERT INTO HistorialPedidos (pedido_id, estado, fecha_modificacion)
    VALUES (NEW.id, 'Actualizado', NOW());
END //
DELIMITER ;
UPDATE Pedidos SET total = total + 10 WHERE id = 1;
SELECT id, pedido_id, fecha_modificacion, estado, comentario FROM HistorialPedidos WHERE pedido_id = 1 ORDER BY fecha_modificacion DESC;
```

4. Crear un trigger que actualice el inventario al registrar un pedido.
```sql
DELIMITER //
CREATE TRIGGER actualizar_inventario
AFTER INSERT ON DetallesPedido
FOR EACH ROW
BEGIN
    UPDATE Inventario 
    SET cantidad = cantidad - NEW.cantidad
    WHERE producto_id = NEW.producto_id;
END //
DELIMITER ;
INSERT INTO DetallesPedido (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1, 1, 2, 50);
SELECT id, producto_id, cantidad FROM Inventario WHERE producto_id = 1;
```

5. Un trigger que evite actualizaciones de precio a menos de $1.
```sql
DELIMITER //
CREATE TRIGGER validar_precio_minimo
BEFORE UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF NEW.precio < 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio no puede ser menor a $1';
    END IF;
END //
DELIMITER ;
UPDATE Productos SET precio = 0.5 WHERE id = 1;
```

6. Crear un trigger que registre la fecha de creación de un pedido en HistorialPedidos .
```sql
DELIMITER //
CREATE TRIGGER registrar_creacion_pedido
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    INSERT INTO HistorialPedidos (pedido_id, estado, fecha_modificacion)
    VALUES (NEW.id, 'Creado', NOW());
END //
DELIMITER ;
INSERT INTO Pedidos (id, cliente_id, total) VALUES (2, 1, 200);
SELECT id, pedido_id, fecha_modificacion, estado, comentario FROM HistorialPedidos WHERE pedido_id = 2;
```

7. Un trigger que mantenga el precio total de cada pedido en Pedidos .
```sql
DELIMITER //
CREATE TRIGGER actualizar_total_pedido
AFTER INSERT ON DetallesPedido
FOR EACH ROW
BEGIN
    DECLARE total_pedido DECIMAL(10,2);
    SELECT SUM(subtotal) INTO total_pedido 
    FROM DetallesPedido 
    WHERE pedido_id = NEW.pedido_id;
    
    UPDATE Pedidos 
    SET total = total_pedido 
    WHERE id = NEW.pedido_id;
END //
DELIMITER ;
INSERT INTO DetallesPedido (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1, 2, 3, 30);
SELECT total FROM Pedidos WHERE id = 1;
```

8. Crear un trigger para validar que UbicacionCliente no esté vacío al crear un cliente.
```sql
DELIMITER //
CREATE TRIGGER validar_ubicacion_cliente
AFTER INSERT ON Clientes
FOR EACH ROW
BEGIN
    DECLARE ubicaciones_count INT;
    SELECT COUNT(*) INTO ubicaciones_count 
    FROM Ubicaciones 
    WHERE entidad = 'Cliente' AND entidad_id = NEW.id;
    
    IF ubicaciones_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El cliente debe tener al menos una ubicación registrada';
    END IF;
END //
DELIMITER ;
INSERT INTO Clientes (id, nombre) VALUES (3, 'Nuevo Cliente');
```

9. Un trigger que registre en LogActividades cada modificación en Proveedores .
```sql
DELIMITER //
CREATE TRIGGER registrar_modificacion_proveedor
AFTER UPDATE ON Proveedores
FOR EACH ROW
BEGIN
    INSERT INTO LogActividades (tabla, accion, entidad_id, fecha)
    VALUES ('Proveedores', 'Actualización', NEW.id, NOW());
END //
DELIMITER ;
UPDATE Proveedores SET nombre = 'Proveedor Modificado' WHERE id = 1;
SELECT id, tabla, accion, entidad_id, fecha FROM LogActividades WHERE tabla = 'Proveedores';
```

10. Crear un trigger que registre en HistorialContratos cada cambio en Empleados .
```sql
DELIMITER //
CREATE TRIGGER registrar_cambio_contrato
AFTER UPDATE ON DatosEmpleados
FOR EACH ROW
BEGIN
    IF NEW.puesto_id != OLD.puesto_id OR NEW.fecha_contratacion != OLD.fecha_contratacion THEN
        INSERT INTO HistorialContratos (empleado_id, puesto_anterior, puesto_nuevo, fecha_cambio)
        VALUES (NEW.id, OLD.puesto_id, NEW.puesto_id, NOW());
    END IF;
END //
DELIMITER ;
UPDATE DatosEmpleados SET puesto_id = 2 WHERE id = 1;
SELECT id, tabla, accion, entidad_id, fecha FROM HistorialContratos WHERE empleado_id = 1;
```
INSERT INTO Socios(Nombre,Email,Telefono,Cuenta,Direccion,Tipo,Contraseña) VALUES('Steam','steam@mail.com','3004461254','123456789','https://www.steam.com','Proveedor','Contrasena');
UPDATE Socios SET Nombre='Steam1' WHERE IDSocio='1';

INSERT INTO Produtos(Nombre,Valoracion,Plataforma,Especificaciones,Desarrolladora) VALUES('Animal Crossing',5,'Nintendo Switch','','Nintendo');
UPDATE Productos SET Nombre='Crossing';

INSERT INTO Links(LURL) VALUES('https://www.1.com');
INSERT INTO Links(LURL) VALUES('https://www.2.com');

INSERT INTO DetallesProdcutos(PrecioBase,PrecioActual,Redireccionamiento,IDProducto,IDProveedor,Formato) VALUES(10000,10000,'1','1','1','Key');
UPDATE DetallesProductos SET PrecioActual=5000 WHERE IDDetalleProducto='1';
UPDATE DetallesProductos SET Formato='Digital' WHERE IDDetalleProducto='1';
DELETE FROM DetallesProductos WHERE IDDetalleProducto='1';

INSERT INTO Proveedores VALUES('1','digital');
INSERT INTO Blogs VALUES('1');

INSERT INTO Reviews(Nombre,Producto,Pertenencia,FPublicacion,Valoracion,Redireccionamiento) VALUES('Review1','1','1',TO_DATE('2012-01-01','yyyy-mm-dd'),4.1,'2'); 
UPDATE Reviews SET Nombre='Nombre1' WHERE IDReview='1';

INSERT INTO Cobros(IDLink,IDProveedor) VALUES('1','1');
UPDATE Cobros SET IDLink='2';
DELETE FROM Cobros;

INSERT INTO Pagos(IDLink,IDBlog) VALUES('1','1');
UPDATE Pagos SET IDLink='2';
DELETE FROM Pagos;

INSERT INTO Usuarios(Username,Contraseña,Email) VALUES('MataCoyas69','J112','jrperezdeleon@gmail.com');
UPDATE Usuarios SET Contraseña='Jr112' WHERE Username='MataCoyas69';
UPDATE Usuarios SET Estado='Melo' WHERE Username='MataCoyas69';

INSERT INTO DireccionesUsuarios(Username,Pais,Ciudad,Departamento,Descripcion) VALUES('MataCoyas69','Colombia','Santa Marta','Magdalena','Mz 1 Casa 4 Urb Villa Kamila');
UPDATE DireccionesUsuarios SET Username='EstallaCoyas'; 
UPDATE DireccionesUsuarios SET Descripcion='Mz 1 Casa 5 Urb Villa Kamila';

UPDATE Links SET Cantidad=1999999;

INSERT INTO Clicks(IDLink,IDUsuario) VALUES('2','MataCoyas69');

/*Unique keys*/
ALTER TABLE Productos ADD CONSTRAINT Producto_UK UNIQUE (Nombre,Plataforma);
ALTER TABLE Socios ADD CONSTRAINT Socio_UK UNIQUE (Nombre,Tipo);
ALTER TABLE Socios ADD CONSTRAINT Socio_mail_UK UNIQUE (Email);
ALTER TABLE Socios ADD CONSTRAINT Socio_Dir_UK UNIQUE (Direccion);
ALTER TABLE Reviews ADD CONSTRAINT Reviews_UK UNIQUE (Redireccionamiento);
ALTER TABLE Usuarios ADD CONSTRAINT Usuario_mail_UK UNIQUE (Email);
ALTER TABLE DetallesProductos ADD CONSTRAINT Productos_UK UNIQUE (Redireccionamiento);
ALTER TABLE Links ADD CONSTRAINT Link_UK UNIQUE (LURL);
ALTER TABLE Cupos ADD CONSTRAINT Cupos_UK UNIQUE (Numero);
INSERT INTO Usuarios(Username,Contraseña, Email) VALUES ('123','123','12htomailcom');

INSERT INTO Socios (IdSocio, Nombre, Email, Cuenta, Telefono) VALUES (2001, 'Jaloo', 'lcoventon0blinklistcom', '3540529907243108', '567-507-7191');

INSERT INTO Proveedores (IdProveedores, Modalidad) VALUES (1001, 'diferente');

INSERT INTO Productos(Nombre, Valoracion,Plataforma,Especificacion) VALUES ('a',11,'Nintendo',
'<?xml version="1.0"?>
<Especificacion>
	<Generos>
	   <Genero
		Genero="Accion"
           ></Genero>
	</Generos>
</Especificacion>'
);

INSERT INTO Reviews(Nombre, Producto,Pertenencia, FPublicacion, Valoracion, Redireccionamiento) VALUES ('S',1,1,TO_DATE('2016-07-25','yyyy-mm-dd'),20,1);

INSERT INTO PaginasDigitales (IdPaginas, Direccion) VALUES (2002, 'https//www1501com');

INSERT INTO EstablecimientosFisicos (IdFisico, Direccion) VALUES (2003, 'htt://www00com');

INSERT INTO Blogs (IdBlog, Direccion) VALUES (2004, 'h://www1.com');

INSERT INTO Links VALUES (2005,,'https:somethingcom');
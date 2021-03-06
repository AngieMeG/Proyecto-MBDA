/* CRUD Productos */

/* El ID de los productos se genera automaticamente */
INSERT INTO Productos(IDProducto, Nombre, Valoracion, Plataforma, Desarrolladora, Especificaciones) VALUES ('J','Animal Crossing',5,'Nintendo Switch','Nintendo','
<Detalle>
	<Generos>
	   <Genero Nombre="Simulacion de vida"></Genero>
	</Generos>
    <Categoria PEGI="3"></Categoria>
</Detalle>'
);

/*No se puede modificar la tabla Productos*/

/*El ID de los detalles de los productos y la FLanzamiento se genera automaticamente*/
INSERT INTO Socios(Nombre, Email, Telefono, Cuenta, Direccion, Tipo, Contraseña) VALUES ('testsocio','testsocio@hotmail.com','1234567890','1234-1234-1234-1234',,'Proveedor','123');
INSERT INTO Proveedores(IdProveedor, Modalidad) VALUES ('1','fisico');
INSERT INTO Links(IDLink,LURL) VALUES ('1','https://www.test1.com');
INSERT INTO DetallesProductos(PrecioBase, PrecioActual, Redireccionamiento, IDProducto, IDProveedor) VALUES (299900,254900,'1','J1','1');

/* Se puede modificar la fecha de lanzamiento(siempre y cuando esta sea no nula o posterior a la fecha actual) de los detalles de los productos */
UPDATE DetallesProductos SET FLanzamiento = TO_DATE('04-10-2021','DD/MM/YYYY') WHERE IDProducto = '10';

/*Si se elimina un Detalle de un producto se elimina el link asociado*/
DELETE FROM DetallesProductos WHERE IDDetalleProducto = '1';

/* CRUD Socios */
/*El ID de las reviews se genera automaticamente*/
INSERT INTO Reviews (Nombre, Producto, Pertenencia, FPublicacion, Valoracion, Redireccionamiento) VALUES ('Flowdesk', '780', '477', TO_DATE('31/07/2019','DD/MM/YYYY'), 5, 1);

/* No se puede modificar las reviews */


/* CRUD Transacciones */
/* La fecha, el valor y el ID del cobro se generan automaticamente. */

/* No se puede modificar los cobros*/

/* No se puede eliminar los cobros*/

/* La fecha, el valor y el ID del pago se generan automaticamente. */

/* No se puede modificar los pagos*/

/* No se puede eliminar los pagos*/

/* CRUD Usuarios */
/* El ID de los usuarios se genera automaticamente */
INSERT INTO Usuarios (Username, Email, Contraseña, Estado) values ('mchurchin0', 'eperazzo0@hhs.gov', 'Taiwanese', 'Suspendido');

/*No se puede modificar el IDUsuario ni el Username*/
UPDATE Usuarios SET Email = 'a@hotmail.com' WHERE IDUsuario = '1';
UPDATE Usuarios SET Contraseña = 'a1' WHERE IDUsuario = '1';
UPDATE Usuarios SET Estado = 'Normal' WHERE IDUsuario = '1';


/* El ID de las direcciones se genera automaticamente */
insert into DireccionesUsuarios (IdUsuario, Descripcion, Pais, Ciudad, Departamento) values ('178', 'asw', 'China', 'Shaoha', 'Yongdong');

/*Solo se puede modificar la descripcion, pais, ciudad y departamento de la direccion*/
UPDATE DireccionesUsuarios SET Descripcion = '111' WHERE IDDireccion = '1';
UPDATE DireccionesUsuarios SET pais = 'Colombia' WHERE IDDireccion = '1';
UPDATE DireccionesUsuarios SET departamento = 'Cundinamarca' WHERE IDDireccion = '1';
UPDATE DireccionesUsuarios SET ciudad = 'Bogota' WHERE IDDireccion = '1';

/*La fecha de los clicks se genera automaticamente, se modifica las visitas en el link correspondiente automaticamente*/
INSERT INTO Clicks (IdUsuario, IdLink) VALUES ('1','1');

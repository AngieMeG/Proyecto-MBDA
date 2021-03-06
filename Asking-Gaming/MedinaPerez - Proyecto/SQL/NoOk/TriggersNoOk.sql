/* CRUD Productos */

/* El ID de los productos se genera automaticamente */

/*No se puede modificar la tabla Productos*/
INSERT INTO Productos(IDProducto, Nombre, Valoracion, Plataforma, Desarrolladora, Especificaciones) VALUES ('J','Animal Crossing',5,'Nintendo Switch','Nintendo','
<Detalle>
	<Generos>
	   <Genero Nombre="Simulacion de vida"></Genero>
	</Generos>
    <Categoria PEGI="3"></Categoria>
</Detalle>'
);
UPDATE Productos SET Nombre = 'Animal Crossing' WHERE IdProducto = 'J1';
UPDATE Productos SET Valoracion = 5 WHERE IdProducto = 'J1';
UPDATE Productos SET Plataforma = 'Nintendo Switch' WHERE IdProducto = 'J1';

/*El ID de los detalles de los productos y la FLanzamiento se genera automaticamente*/

/* Se puede modificar la fecha de lanzamiento(siempre y cuando esta sea no nula o posterior a la fecha actual) de los detalles de los productos */
UPDATE DetallesProductos SET FLanzamiento = TO_DATE('04-10-2019','DD/MM/YYYY') WHERE IDProducto = '10';

/*Si se elimina un Detalle de un producto se elimina el link asociado*/

/* CRUD Socios */
/*El ID de las reviews se genera automaticamente*/

/* No se puede modificar las reviews */
INSERT INTO Reviews (Nombre, Poducto, Pertenencia, FPublicacion, Valoracion, Redireccionamiento) VALUES ('Flowdesk', '780', '477', TO_DATE('31/07/2019','DD/MM/YYYY'), 5, '1');
UPDATE Reviews SET Nombre = 'B1' WHERE IDReviews = '1';
UPDATE Reviews SET Producto = '1' WHERE IDReviews = '1';
UPDATE Reviews SET FPublicacion = TO_DATE('04-10-2019','DD/MM/YYYY') WHERE IDReviews = '1';
UPDATE Reviews SET Valoracion = 5 WHERE IDReviews = '1';
UPDATE Reviews SET Redireccionamiento = '1' WHERE IDReviews = '1';

/* CRUD Transacciones */
/* La fecha, el valor y el ID del cobro se generan automaticamente. */

/* No se puede modificar los cobros*/
UPDATE Cobros SET Valor = 100000 WHERE IDCobro = '1';

/* No se puede eliminar los cobros*/
DELETE FROM Cobros WHERE IDCobro = '1';

/* La fecha, el valor y el ID del pago se generan automaticamente. */

/* No se puede modificar los pagos*/
UPDATE Pagos SET Valor = 100000 WHERE IDPago = '1';

/* No se puede eliminar los pagos*/
DELETE FROM Pagos WHERE IDPago = '1';

/* CRUD Usuarios */
/* El ID de los usuarios se genera automaticamente */

/*No se puede modificar el IDUsuario ni el Username*/
insert into Usuarios (Username, Email, Contraseña, Estado) values ('mchurchin0', 'eperazzo0@hhs.gov', 'Taiwanese', 'Suspendido');
UPDATE Usuarios SET IDUsuario = '100' WHERE IDUsuario = '1';
UPDATE Usuarios SET Username = 'a1' WHERE IDUsuario = '1';

/* El ID de las direcciones se genera automaticamente */

/*Solo se puede modificar la descripcion, pais, ciudad y departamento de la direccion*/
insert into DireccionesUsuarios (Descripcion, Pais, Ciudad, Departamento) values ('59', 'China', 'Shaoha', 'Yongdong');
UPDATE DireccionesUsuarios SET IDUsuario = '1' WHERE IDDireccion = '1';
UPDATE DireccionesUsuarios SET IDDireccion = '1' WHERE IDDireccion = '1';

/*La fecha de los clicks se genera automaticamente, se modifica las visitas en el link correspondiente automaticamente*/


/*USUARIO*/

/*Yo, Jose perez soy un videojugador casual, me interesan siempre conseguir los mejores juegos al mejor precio, 
por eso deseo inscribirme a ASKING-GAMING, 
bajo el nick de J112 y correo jose@mail.com*/

BEGIN PC_Usuarios.AD_USUARIO('J112', 'ContraseñaAletosa1', 'jose@mail.com'); END;

/*Puedo agregar mi direccion para que la plataforma,
si lo deseo busque juegos en formato fisico en los lugares mas cercanos a mi*/

BEGIN PC_DIRECCIONES.AD_DIRECCION_U('J112', 'Colombia', 'Bogota', 'Cundinamarca', 'Calle 44d #45-45');END;

/*Una vez inscrito puedo comenzar a buscar mis juegos favoritos,
no soy muy propenso a comprar keys por lo que especificare que los quiero en formato digital, 
estoy interesado en un juego en especifico, animal crossing, para la plataforma de nintendo switch*/

SELECT PC_Productos.CO_Productos('Animal Crossing', 'Nintendo switch', 'digital') FROM DUAL;

/*Con la lista de juegos organizados por su precio,
puedo escoger el que mas me llame la atencion */

variable rc refcursor; 
exec PC_Productos.MakeAClick('1', 'J112', :rc)
print rc;

UPDATE Links SET Cantidad=1999999;
/*Con esto he completado el proceso,
la transaccion anterior me dala los detalles del juego que he seleccionado y
podre proceder a su comprar en la pagina del proveedor correspondiente*/


/*BLOGGER*/

/*Yo, Luis Amaya soy un blogger y comentarista de videojuegos, el mercado esta creciendo,
cada vez es mas frecuente que me pregunten mi opinion respecto a x o y juego,
es por esto que deseo inscribirme a asking-gaming y sacar una ganancia monetaria de lo que me apasiona, formo parte de la prestigiosa pagina de eurogamer, su enlace es 'https://www.Eurogamer.com' y el correo es 'Euro@mail.com'*/

BEGIN PC_Socios.AD_USUARIO('EuroGamer', 'Euro@mail.com', '3004461254', '123456789', 'https://www.Eurogamer.com', 'Blog', 'Contraseña'); END;

/*Comenzare en este metabuscador agregando una reseña de un juego reciente bastante popular, Animal crossing*/

BEGIN PC_Reviews.AD_Review('Review1', 'Animal Crossing','Nintendo switch', '2', TO_DATE('2005-11-23','yyyy-mm-dd'), 4, 'https://www.link1.com'); END;

/*Parece que he cometido un error, la valoracion debia ser 5 y no 4, realmente adore este juego, no hay problema, esto se puede modificar, especifico mi review y el nuevo valor de la valoracion*/

BEGIN PC_Reviews.MO_Review('1', 5); END;

/*La review ha subido bien, al parecer no hay ningun error, cuando la review comienze a generar visitas poder chequear mis pagos especificando mi blog*/

SELECT PC_PAGOS.CO_SPagos('2') FROM DUAL;


/*Administrador*/


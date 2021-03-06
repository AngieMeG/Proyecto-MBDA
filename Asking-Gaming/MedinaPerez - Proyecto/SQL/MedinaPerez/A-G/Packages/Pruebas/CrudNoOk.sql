/*Socios*/
BEGIN PC_Socios.AD_USUARIO('Nintendo', 'nintendo@mail.com', '3004461254', '123456789', 'https://www.nintendo.com', 'Proveedor', 'NintendoRulesjaja','digital'); END;
BEGIN PC_Socios.AD_USUARIO('EuroGamer', 'nintendo@mail.com', '3004461254', '123456789', 'https://www.Eurogamer.com', 'Blog', 'Contraseña'); END;
BEGIN PC_Socios.AD_USUARIO('TiendaRandom1', 'TiendaRandom1@mail.com', '3004461254', '123456789', 'https://www.TiendaRandom1.com', 'Proveedor', 'NintendoRulesjaja','fisico'); END;
BEGIN PC_Socios.MO_USUARIO('nintendo2@mail.com', '3004461254', '123456789', 'https://www.nintendo2.com', 'NintendoRulesjaja2'); END;
BEGIN PC_Socios.DEL_USUARIO('1',2); END;

/*Usuarios*/
BEGIN PC_Usuarios.AD_USUARIO('MataCoyas69', 'ContraseñaAletosa1', 'jAAAA....Aose@mail.co'); END;
BEGIN PC_Usuarios.MO_USUARIO('MataCoyas69', 'ContraseñaAletosa2',3); END;
BEGIN PC_Usuarios.DEL_USUARIO('MataCoyas69'); END;

/*Productos*/
BEGIN PC_Productos.AD_PRODUCTO('Animal Crossing',10000,12500,TO_DATE('2005-11-23','ymm-dd'),4,'Nintendo switch', '<Detalle><Generos><Genero Nombre="Simulacion de vida"></Genero></Generos><Categoria PEGI="+13"></Categoria></Detalle>', '1', 'Proveedor2', 'digital', 'J', 'https://www.link2.com'); END;
BEGIN PC_Productos.MO_PRODUCTO('J1',15000,NULL,5); END;
BEGIN PC_Productos.DEL_PRODUCTO(F1); END;
SELECT PC_Productos.CO_ProductProx FROM DUAL;
SELECT PC_Productos.CO_Productos('Animal Crossing', 'Nintendo switch') FROM DUAL;
SELECT PC_Productos.CO_Producto('1', MataCoyas69) FROM DUAL;
variable rc refcursor; exec PC_Productos.MakeAClick('1', 'MataCoyas69', :rc)
print rc;

/*Reviews*/

BEGIN PC_Reviews.AD_Review('Review1', 'Animal Crossing', '2', TO_DATE('200511-23','yyyy-mm-dd'), 4, 'https://www.link1.co'); END;
BEGIN PC_Reviews.O_Review('1'); END;
BEGIN PC_Reviews.DEL_Review('1'); END;
SELECT PC_Reviews.CO_Reviews_('Animal Crossing') FROM DUAL;
SELECT PC_Reviews.CO_Reviews_S('2',3) FROM DUAL;
SELECT PC_Reviews.CO_AVGReview('21') FROM DUAL;
SELECT PC_Reviews.CO_BestReview('2',5,6) FROM DUAL;

/*Cobros*/
BEGIN PC_COBROS.AD_COBRO( '1');END;
SELECT PC_COBROS.CO_PCobros() FROM DUAL; 

/*Pagos*/
BEGIN PC_PAGOS.AD_PAGO('2', '-23');END;
SELECT PC_PAGOS.CO_SPagos() FROM DUAL; 

/*Direcciones*/
BEGIN PC_DIRECCIONES.AD_DIRECCION_U( 'Colombia', 'Bogota', 'Cundinamarca', 'Calle 44d #45-45');END;
BEGIN PC_DIRECCIONES.AD_DIRECCION_S('Colombia', 'Bogota', 'Cundinamarca');END;
BEGIN PC_DIRECCIONES.MO_DIRECCION('MataCoyas69', 'Colombia', 'Santa Marta');END;
BEGIN PC_DIRECCIONES.DEL_DIRECCION_U('1');END;
BEGIN PC_DIRECCIONES.DEL_DIRECCION_S('1');END;
SELECT PC_DIRECCIONES.CO_Direccion_U('1') FROM DUAL;
SELECT PC_DIRECCIONES.CO_Direcciones_U('MataCoyas69') FROM DUAL;
SELECT PC_DIRECCIONES.CO_Direccion_S('1') FROM DUAL;
SELECT PC_DIRECCIONES.CO_Direcciones_S('3') FROM DUAL;
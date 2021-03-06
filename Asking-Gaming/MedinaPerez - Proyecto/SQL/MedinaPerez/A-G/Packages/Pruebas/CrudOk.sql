/*Socios*/
BEGIN PC_Socios.AD_USUARIO('Nintendo', 'nintendo@mail.com', '3004461254', '123456789', 'https://www.nintendo.com', 'Proveedor', 'NintendoRulesjaja','digital'); END;
BEGIN PC_Socios.AD_USUARIO('EuroGamer', 'Euro@mail.com', '3004461254', '123456789', 'https://www.Eurogamer.com', 'Blog', 'Contraseña'); END;
BEGIN PC_Socios.AD_USUARIO('TiendaRandom1', 'TiendaRandom1@mail.com', '3004461254', '123456789', 'https://www.TiendaRandom1.com', 'Proveedor', 'NintendoRulesjaja','fisico'); END;
BEGIN PC_Socios.MO_USUARIO('1', 'nintendo2@mail.com', '3004461254', '123456789', 'https://www.nintendo2.com', 'NintendoRulesjaja2'); END;
BEGIN PC_Socios.DEL_USUARIO('1'); END;

/*Usuarios*/
BEGIN PC_Usuarios.AD_USUARIO('MataCoyas69', 'ContraseñaAletosa1', 'jose@mail.com'); END;
BEGIN PC_Usuarios.MO_USUARIO('MataCoyas69', 'ContraseñaAletosa2'); END;
BEGIN PC_Usuarios.DEL_USUARIO('MataCoyas69'); END;

/*Productos*/
BEGIN PC_Productos.AD_PRODUCTO('Animal Crossing',10000,12500,TO_DATE('2005-11-23','yyyy-mm-dd'),4,'Nintendo switch', '<Detalle><Generos><Genero Nombre="Simulacion de vida"></Genero></Generos><Categoria PEGI="+13"></Categoria></Detalle>', '1', 'Proveedor2', 'digital', 'J', 'https://www.link2.com'); END;
BEGIN PC_Productos.MO_PRODUCTO('J1',15000,10500,NULL,5); END;
BEGIN PC_Productos.DEL_PRODUCTO('J1'); END;
SELECT PC_Productos.CO_ProductProx FROM DUAL;
SELECT PC_Productos.CO_Productos('Animal Crossing', 'Nintendo switch', 'digital') FROM DUAL;
SELECT PC_Productos.CO_Producto('1', 'MataCoyas69') FROM DUAL;
variable rc refcursor; exec PC_Productos.MakeAClick('1', 'MataCoyas69', :rc)
print rc;

/*Reviews*/

BEGIN PC_Reviews.AD_Review('Review1', 'Animal Crossing','Nintendo switch', '2', TO_DATE('2005-11-23','yyyy-mm-dd'), 4, 'https://www.link1.com'); END;
BEGIN PC_Reviews.MO_Review('1', 3); END;
BEGIN PC_Reviews.DEL_Review('1'); END;
SELECT PC_Reviews.CO_Reviews_U('Animal Crossing','Nintendo switch') FROM DUAL;
SELECT PC_Reviews.CO_Reviews_S('2') FROM DUAL;
SELECT PC_Reviews.CO_AVGReview('2') FROM DUAL;
SELECT PC_Reviews.CO_BestReview('2') FROM DUAL;

/*Cobros*/
BEGIN PC_COBROS.AD_COBRO('1', '1');END;
SELECT PC_COBROS.CO_PCobros('1') FROM DUAL; 

/*Pagos*/
BEGIN PC_PAGOS.AD_PAGO('2', '2');END;
SELECT PC_PAGOS.CO_SPagos('2') FROM DUAL; 

/*Direcciones*/
BEGIN PC_DIRECCIONES.AD_DIRECCION_U('MataCoyas69', 'Colombia', 'Bogota', 'Cundinamarca', 'Calle 44d #45-45');END;
BEGIN PC_DIRECCIONES.AD_DIRECCION_S('3','Colombia', 'Bogota', 'Cundinamarca', 'Calle 44d #45-45');END;
BEGIN PC_DIRECCIONES.MO_DIRECCION('MataCoyas69', 'Colombia', 'Santa Marta', 'Magdalena', 'Mz. 1 Casa 4 Urb. Villa Kamila');END;
BEGIN PC_DIRECCIONES.DEL_DIRECCION_U('1');END;
BEGIN PC_DIRECCIONES.DEL_DIRECCION_S('1');END;
SELECT PC_DIRECCIONES.CO_Direccion_U('1') FROM DUAL;
SELECT PC_DIRECCIONES.CO_Direcciones_U('MataCoyas69') FROM DUAL;
SELECT PC_DIRECCIONES.CO_Direccion_S('1') FROM DUAL;
SELECT PC_DIRECCIONES.CO_Direcciones_S('3') FROM DUAL;

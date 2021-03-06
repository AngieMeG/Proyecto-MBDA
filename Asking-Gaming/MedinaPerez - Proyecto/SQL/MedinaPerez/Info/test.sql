BEGIN PA_Usuario.AD_USUARIO('Rodrigo Humberto Gualtero Martinez', '@@@RoDriGo@1@9', 'rodrigoGualterom@escuelain.com'); END;

BEGIN PC_Socios.AD_USUARIO('Nintendo', 'nintendo@mail.com', '3004461254', '123456789', 'https://www.nintendo.com', 'Proveedor', 'NintendoRulesjaja','digital'); END;

BEGIN PA_Blogger.AD_USUARIO('EuroGamer', 'Euro@mail.com', '3004461254', '123456789', 'https://www.Eurogamer.com', 'Blog', 'Contraseña'); END;

BEGIN PC_Productos.AD_PRODUCTO('Animal Crossing',10000,12500,TO_DATE('2005-11-23','yyyy-mm-dd'),4,'Nintendo switch', '<Detalle><Generos><Genero Nombre="Simulacion de vida"></Genero></Generos><Categoria PEGI="+13"></Categoria></Detalle>', '1', 'Proveedor2', 'digital', 'J', 'https://www.link1.com'); END;

UPDATE Links SET Cantidad=1999999;

BEGIN PC_Reviews.AD_Review('Review Animal Crossing', 'Animal Crossing', 'Nintendo switch', '2', TO_DATE('2006-11-23','yyyy-mm-dd'), 4, 'https://www.link2.com'); END;

SELECT pc_productos.co_productos('Animal Crossing','Nintendo switch','digital') FROM DUAL;

variable rc refcursor; 
exec PC_Productos.MakeAClick('1', 'MataCoyas69', :rc)
print rc;
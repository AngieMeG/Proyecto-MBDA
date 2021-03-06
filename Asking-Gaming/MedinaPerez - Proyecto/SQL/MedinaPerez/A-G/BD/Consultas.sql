/*Consultar proximos lanzamientos*/
SELECT * FROM Productos x JOIN DetallesProductos y ON x.IDProducto=y.IDProducto WHERE FLanzamiento IS NOT NULL AND FLanzamiento>=CURRENT_DATE;

/*Consultar Productos deseados*/
SELECT x.Nombre, x.Plataforma, x.Valoracion, x.Desarrolladora, y.PrecioActual, y.FLanzamiento, y.formato 
FROM Productos x JOIN DetallesProductos y ON x.IDProducto=y.IDProducto 
WHERE x.Plataforma=xPlataforma AND x.Nombre=xNombre AND y.Formato=xFormato
ORDER BY y.PrecioActual;

/*Consultar Producto especifico*/
SELECT x.Nombre, x.Plataforma, x.Valoracion, x.Desarrolladora, y.PrecioActual, y.FLanzamiento, y.formato 
FROM Productos x JOIN DetallesProductos y ON x.IDProducto=y.IDProducto 
WHERE y.IDDetalleProducto=xIDDetalle
ORDER BY y.PrecioActual;

/*Consultar todos los Cobros de un proveedor especifico*/
SELECT * FROM Cobros WHERE IDProveedor=xIDProveedor;

/*Consultar todos los Pagos de un blog especifico*/
SELECT * FROM Pagos WHERE IDBlog=xIDBlog;

/*Consultar una de mis direcciones en especifico*/
SELECT * FROM DireccionesUsuarios WHERE IDDireccion=xIDDireccion AND Username=xUsername;

/*Consultar todas mis direcciones*/
SELECT * FROM DireccionesUsuarios WHERE Username=xUsername;

/*Consultar una de mis direcciones en especifico(Proveedor)*/
SELECT * FROM DireccionesEstablecimientos WHERE IDDireccion=xIDDireccion AND IDEstablecimiento=xIDEstablecimiento;

/*Consultar todas mis direcciones(Proveedor)*/
SELECT * FROM DireccionesEstablecimientos WHERE IDEstablecimiento=xIDEstablecimiento;

/*Consultar reviews de un producto*/
SELECT * FROM Reviews x JOIN Productos y 
ON x.IDProducto=y.IDProducto
WHERE y.Plataforma=xPlataforma AND y.Nombre=xNombre;
  
/*Consultar mis reviews(Blog)*/                         
SELECT * FROM Reviews WHERE xIDBlog=Pertenencia;

/*Consultar promedio de las reviews(Blog)*/                         
SELECT AVG(Valoracion) FROM Reviews WHERE Pertenencia=xIDBlog;

/*Consultar la review con mejor valoracion(Blog)*/                          
SELECT * FROM Reviews WHERE Valoracion=(SELECT MAX(Valoracion) FROM Reviews WHERE Pertenencia=xIDBlog);

/*Ganancias entre dos fechas*/
DEF cota_Inferior = TO_DATE('&Fecha1','yyyy-mm-dd');
DEF cota_Superior = TO_DATE('&Fecha2','yyyy-mm-dd');
SELECT &cota_Inferior,&cota_Superior FROM DUAL;
SELECT * 
    FROM (SELECT CASE WHEN SCobros IS NULL AND SPagos IS NULL THEN 0 WHEN SCobros IS NULL THEN Spagos*-1 WHEN SPagos IS NULL THEN SCobros ELSE SCobros-Spagos END t FROM
         (SELECT SUM(Valor) AS SCobros FROM Cobros WHERE 
            EXTRACT(DAY FROM Fecha) BETWEEN EXTRACT(DAY FROM &cota_Inferior) AND EXTRACT(DAY FROM &cota_Superior) AND
            EXTRACT(MONTH FROM Fecha) BETWEEN EXTRACT(MONTH FROM &cota_Inferior) AND EXTRACT(MONTH FROM &cota_Superior) AND
            EXTRACT(YEAR FROM Fecha) BETWEEN EXTRACT(YEAR FROM &cota_Inferior) AND EXTRACT(YEAR FROM &cota_Superior)),
         (SELECT SUM(Valor) AS SPagos FROM Pagos WHERE 
            EXTRACT(DAY FROM Fecha) BETWEEN EXTRACT(DAY FROM &cota_Inferior) AND EXTRACT(DAY FROM &cota_Superior) AND
            EXTRACT(MONTH FROM Fecha) BETWEEN EXTRACT(MONTH FROM &cota_Inferior) AND EXTRACT(MONTH FROM &cota_Superior) AND
            EXTRACT(YEAR FROM Fecha) BETWEEN EXTRACT(YEAR FROM &cota_Inferior) AND EXTRACT(YEAR FROM &cota_Superior)));
            
/*Productos auspiciados*/
SELECT * FROM Auspiciados x JOIN DetallesProductos y ON x.IDDetalleProducto=y.IDDetalleProducto WHERE 
    EXISTS(SELECT * FROM (SELECT x1.IDProducto, Details.Genero FROM Productos x1 ,XMLTABLE('/Detalle/Generos/Genero' PASSING x1.Especificaciones COLUMNS Genero VARCHAR(60) PATH '@Nombre[1]') Details) t WHERE t.IDProducto=y.IDProducto AND
        EXISTS(SELECT Genero FROM (SELECT P2_Details.Genero FROM Productos x2 ,XMLTABLE('/Detalle/Generos/Genero' PASSING x2.Especificaciones COLUMNS Genero VARCHAR(60) PATH '@Nombre[1]') P2_Details WHERE x2.Nombre='&Nombre' AND x2.Plataforma='&Plataforma') u WHERE u.Genero=t.Genero)); 



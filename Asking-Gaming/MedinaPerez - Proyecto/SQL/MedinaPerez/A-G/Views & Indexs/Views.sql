/* Vista, Consultar los pagos de cierto blog */
CREATE OR REPLACE VIEW V_Cobros AS 
SELECT x.IDCobro, x.Valor, z.IDProducto, w.Nombre 
FROM Cobros x JOIN Links y ON x.IDLink=y.IDlink
              JOIN DetallesProductos z ON z.Redireccionamiento=y.IDLink
              JOIN Socios w ON w.IDSocio=x.IDProveedor;

/* Vista, Consultar los cobros de cierto proveedor */
CREATE OR REPLACE VIEW V_Pagos AS
SELECT x.IDPago, x.Valor, z.IDReview, w.Nombre
FROM Pagos x JOIN Links y ON x.IDLink=y.IDlink
              JOIN Reviews z ON z.Redireccionamiento=y.IDLink
              JOIN Socios w ON w.IDSocio=x.IDBlog;
              
/*Vista, Consultar producto*/
CREATE OR REPLACE VIEW V_PRODUCTOS AS
SELECT x.Nombre AS Producto, x.Plataforma, x.Valoracion, x.Desarrolladora, y.PrecioActual, x.FLanzamiento, y.formato, z.LURL 
FROM Productos x JOIN DetallesProductos y ON x.IDProducto=y.IDProducto
                 JOIN Links z ON z.IDLink = y.Redireccionamiento
ORDER BY y.PrecioActual;

/*Vista, Consultar Productos*/
CREATE OR REPLACE VIEW V_Reviews AS
SELECT x.IDReview, y.Nombre AS Blog, z.Nombre AS Producto, x.Valoracion, w.LURL AS Link FROM Reviews x 
                        JOIN Socios y ON x.Pertenencia=y.IDSocio
                        JOIN Productos z ON x.IDProducto=z.IDProducto
                        JOIN Links w ON w.IDLink=x.Redireccionamiento;
                        

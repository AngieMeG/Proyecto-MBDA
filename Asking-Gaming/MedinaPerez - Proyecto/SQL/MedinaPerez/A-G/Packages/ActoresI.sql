/*Actores*/
CREATE OR REPLACE PACKAGE BODY PA_USUARIO IS
    PROCEDURE AD_DIRECCION_U(xUsername IN VARCHAR, xPais IN VARCHAR, xCiudad IN VARCHAR, xDepartamento IN VARCHAR, xDescripcion IN VARCHAR) IS
        BEGIN
            PC_DIRECCIONES.AD_DIRECCION_U(xUsername, xPais, xCiudad, xDepartamento, xDescripcion);
        END;
    PROCEDURE MO_DIRECCION(xUsername IN VARCHAR, xPais IN VARCHAR DEFAULT NULL, xCiudad IN VARCHAR DEFAULT NULL, xDepartamento IN VARCHAR DEFAULT NULL, xDescripcion IN VARCHAR DEFAULT NULL) IS
        BEGIN
            PC_DIRECCIONES.MO_DIRECCION(xUsername, xPais, xCiudad, xDepartamento, xDescripcion);
        END;
    PROCEDURE DEL_DIRECCION_U(xIDDireccion IN VARCHAR) IS
        BEGIN
            PC_DIRECCIONES.DEL_DIRECCION_U(xIDDireccion);
        END;
    PROCEDURE AD_USUARIO(xUsername IN VARCHAR, XContraseña IN VARCHAR, xEmail IN VARCHAR) IS
        BEGIN
            PC_USUARIOS.AD_USUARIO(xUsername, XContraseña, xEmail);
        END;
    PROCEDURE MO_USUARIO(xUsername IN VARCHAR, xContraseña IN VARCHAR) IS
        BEGIN
            PC_USUARIOS.MO_USUARIO(xUsername, xContraseña);
        END;
    PROCEDURE DEL_USUARIO(xUsername IN VARCHAR) IS
        BEGIN
            PC_USUARIOS.DEL_USUARIO(xUsername);
        END;
    FUNCTION CO_Direccion(xIDDireccion IN VARCHAR) RETURN SYS_REFCURSOR IS DIR SYS_REFCURSOR;
        BEGIN
            DIR:=PC_DIRECCIONES.CO_Direccion_U(xIDDireccion);
            RETURN DIR;
        END;
    FUNCTION CO_Direcciones_U(xUsername IN VARCHAR) RETURN SYS_REFCURSOR IS DIRS SYS_REFCURSOR;
        BEGIN   
            DIRS:=PC_DIRECCIONES.CO_Direcciones_U(xUsername);
        END;
    FUNCTION CO_Direcciones(xUsername IN VARCHAR) RETURN SYS_REFCURSOR IS DIC SYS_REFCURSOR;
        BEGIN
            DIC:=PC_DIRECCIONES.CO_Direcciones_U(xUsername);
            RETURN DIC;
        END;
    FUNCTION CO_Reviews(xNombre IN VARCHAR ,xPlataforma IN VARCHAR) RETURN SYS_REFCURSOR IS REW SYS_REFCURSOR;
        BEGIN
            REW:=PC_Reviews.CO_Reviews_U(xNombre, xPlataforma);
            RETURN REW;
        END;
    FUNCTION CO_ProductProx RETURN SYS_REFCURSOR IS PPROX SYS_REFCURSOR;
        BEGIN
            PPROX:=PC_PRODUCTOS.CO_ProductProx;
            RETURN PPROX;
        END;
    FUNCTION CO_Productos(xNombre IN VARCHAR , xPlataforma IN VARCHAR, xFormato IN VARCHAR) RETURN SYS_REFCURSOR IS PRO SYS_REFCURSOR; 
        BEGIN
            PRO:=PC_PRODUCTOS.CO_Productos(xNombre, xPlataforma, xFormato);
            RETURN PRO;
        END;
    FUNCTION CO_Producto(xIDDetalle IN VARCHAR, xUsername IN VARCHAR) RETURN SYS_REFCURSOR IS PRO SYS_REFCURSOR; 
        BEGIN
            PRO:=PC_PRODUCTOS.CO_Producto(xIDDetalle, xUsername);
            RETURN PRO;
        END;
    PROCEDURE MakeAClick(xIDDetalle IN VARCHAR, xUsername IN VARCHAR, xOut OUT SYS_REFCURSOR) IS
        BEGIN
            PC_PRODUCTOS.MakeAClick(xIDDetalle, xUsername, xOut);
        END;
    PROCEDURE MakeAClick(xIDReview IN VARCHAR, xUsername IN VARCHAR, xOut OUT SYS_REFCURSOR) IS 
        BEGIN
            PC_REVIEWS.MakeAClick(xIDReview, xUsername, xOut);
        END;
END PA_USUARIO;
/
CREATE OR REPLACE PACKAGE BODY PA_Blogger IS
    PROCEDURE AD_USUARIO(xNombre IN VARCHAR, xEmail IN VARCHAR, xTelefono IN VARCHAR, xCuenta IN VARCHAR, xDireccion IN VARCHAR, xTipo IN VARCHAR, xContraseña IN VARCHAR) IS
        BEGIN
            PC_SOCIOS.AD_USUARIO(xNombre, xEmail, xTelefono, xCuenta, xDireccion, xTipo, xContraseña);
        END;
    PROCEDURE MO_USUARIO(xIDSocio IN VARCHAR, xEmail IN VARCHAR DEFAULT NULL, xTelefono IN VARCHAR DEFAULT NULL, xCuenta IN VARCHAR DEFAULT NULL, xDireccion IN VARCHAR DEFAULT NULL, xContraseña IN VARCHAR DEFAULT NULL) IS
        BEGIN
            PC_SOCIOS.MO_USUARIO(xIDSocio, xEmail, xTelefono, xCuenta, xDireccion, xContraseña);
        END;
    PROCEDURE DEL_USUARIO(xIDSocio IN VARCHAR) IS
        BEGIN
            PC_SOCIOS.DEL_USUARIO(xIDSocio);
        END;
    FUNCTION CO_Reviews(xIDBlog IN VARCHAR) RETURN SYS_REFCURSOR IS REW SYS_REFCURSOR;
        BEGIN
            REW:=PC_Reviews.CO_Reviews_S(xIDBlog);
            RETURN REW;
        END;
    FUNCTION CO_AVGReview(xIDBlog IN VARCHAR) RETURN SYS_REFCURSOR IS AVGR SYS_REFCURSOR;
        BEGIN
            AVGR:=PC_Reviews.CO_AVGReview(xIDBlog);
            RETURN AVGR;
        END;
    FUNCTION CO_BestReview(xIDBlog IN VARCHAR) RETURN SYS_REFCURSOR IS BREW SYS_REFCURSOR;
        BEGIN
            BREW:=PC_Reviews.CO_BestReview(xIDBlog);
            RETURN BREW;
        END;
    FUNCTION CO_SPagos(xIDSocio IN VARCHAR) RETURN SYS_REFCURSOR IS SPAG SYS_REFCURSOR;
        BEGIN
            SPAG:=PC_PAGOS.CO_SPagos(xIDSocio);
            RETURN SPAG;
        END;
END PA_Blogger;
/
CREATE OR REPLACE PACKAGE BODY PA_Proveedor IS
    PROCEDURE AD_USUARIO(xNombre IN VARCHAR, xEmail IN VARCHAR, xTelefono IN VARCHAR, xCuenta IN VARCHAR, xDireccion IN VARCHAR, xTipo IN VARCHAR, xContraseña IN VARCHAR) IS
        BEGIN
            PC_SOCIOS.AD_USUARIO(xNombre, xEmail, xTelefono, xCuenta, xDireccion, xTipo, xContraseña);
        END;
    PROCEDURE MO_USUARIO(xIDSocio IN VARCHAR, xEmail IN VARCHAR DEFAULT NULL, xTelefono IN VARCHAR DEFAULT NULL, xCuenta IN VARCHAR DEFAULT NULL, xDireccion IN VARCHAR DEFAULT NULL, xContraseña IN VARCHAR DEFAULT NULL) IS
        BEGIN
            PC_SOCIOS.MO_USUARIO(xIDSocio, xEmail, xTelefono, xCuenta, xDireccion, xContraseña);
        END;
    PROCEDURE DEL_USUARIO(xIDSocio IN VARCHAR) IS
        BEGIN
            PC_SOCIOS.DEL_USUARIO(xIDSocio);
        END;
    PROCEDURE AD_DIRECCION_S(xIDEstablecimiento IN VARCHAR, xPais IN VARCHAR, xCiudad IN VARCHAR, xDepartamento IN VARCHAR, xDescripcion IN VARCHAR) IS
        BEGIN
            PC_DIRECCIONES.AD_DIRECCION_S(xIDEstablecimiento, xPais, xCiudad, xDepartamento, xDescripcion);
        END;
    PROCEDURE DEL_DIRECCION_S(xIDDireccion IN VARCHAR) IS
        BEGIN
            PC_DIRECCIONES.DEL_DIRECCION_S(xIDDireccion);
        END;
    FUNCTION CO_Direccion(xIDDireccion IN VARCHAR) RETURN SYS_REFCURSOR IS DIR SYS_REFCURSOR;
        BEGIN
            DIR:=PC_DIRECCIONES.CO_Direccion_S(xIDDireccion);
            RETURN DIR;
        END;
    FUNCTION CO_Direcciones(xIDEstablecimiento IN VARCHAR) RETURN SYS_REFCURSOR IS DIC SYS_REFCURSOR;
        BEGIN
            DIC:=PC_DIRECCIONES.CO_Direcciones_S(xIDEstablecimiento);
            RETURN DIC;
        END;
    FUNCTION CO_PCobros(xIDProveedor IN VARCHAR) RETURN SYS_REFCURSOR IS PCOB SYS_REFCURSOR;
        BEGIN
            PCOB:=PC_COBROS.CO_PCobros(xIDProveedor);
            RETURN PCOB;
        END;
END PA_Proveedor;
/
CREATE OR REPLACE PACKAGE BODY PA_Admin IS
    PROCEDURE AD_Auspiciado(xIDDetalle IN VARCHAR) IS 
        BEGIN
            INSERT INTO Auspiciados(IDDetalleProducto) VALUES(xIDDetalle);
            COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20001,'Error al eliminar en auspiciados');
        END;
    PROCEDURE DEL_Auspiciado(xIDAuspiciado IN VARCHAR) IS
        BEGIN
            DELETE FROM Auspiciados WHERE IDAuspiciado=xIDAuspiciado;
            COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20001,'Error al eliminar en auspiciados');
        END;
    PROCEDURE AD_Genero(xNombre IN VARCHAR) IS
        BEGIN
            INSERT INTO Cupos(Nombre) VALUES(xNombre);
            COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20001,'Error al insertar en cupos');
        END;
    PROCEDURE DEL_Genero(xNombre IN VARCHAR) IS
        BEGIN
            DELETE FROM Cupos WHERE Nombre=xNombre;
            COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20001,'Error al eliminar en cupos');
        END;
    FUNCTION CO_Ganancias(Fecha1 IN VARCHAR, Fecha2 IN VARCHAR) RETURN SYS_REFCURSOR IS GAN SYS_REFCURSOR;
        BEGIN
            OPEN GAN FOR
                SELECT * 
                    FROM (SELECT CASE WHEN SCobros IS NULL AND SPagos IS NULL THEN 0 WHEN SCobros IS NULL THEN Spagos*-1 WHEN SPagos IS NULL THEN SCobros ELSE SCobros-Spagos END t FROM
                        (SELECT SUM(Valor) AS SCobros FROM Cobros WHERE 
                            EXTRACT(DAY FROM Fecha) BETWEEN EXTRACT(DAY FROM TO_DATE(Fecha1,'yyyy-mm-dd')) AND EXTRACT(DAY FROM TO_DATE(Fecha2,'yyyy-mm-dd')) AND
                            EXTRACT(MONTH FROM Fecha) BETWEEN EXTRACT(MONTH FROM TO_DATE(Fecha1,'yyyy-mm-dd')) AND EXTRACT(MONTH FROM TO_DATE(Fecha2,'yyyy-mm-dd')) AND
                            EXTRACT(YEAR FROM Fecha) BETWEEN EXTRACT(YEAR FROM TO_DATE(Fecha1,'yyyy-mm-dd')) AND EXTRACT(YEAR FROM TO_DATE(Fecha2,'yyyy-mm-dd'))),
                        (SELECT SUM(Valor) AS SPagos FROM Pagos WHERE 
                            EXTRACT(DAY FROM Fecha) BETWEEN EXTRACT(DAY FROM TO_DATE(Fecha1,'yyyy-mm-dd')) AND EXTRACT(DAY FROM TO_DATE(Fecha2,'yyyy-mm-dd')) AND
                            EXTRACT(MONTH FROM Fecha) BETWEEN EXTRACT(MONTH FROM TO_DATE(Fecha1,'yyyy-mm-dd')) AND EXTRACT(MONTH FROM TO_DATE(Fecha2,'yyyy-mm-dd')) AND
                            EXTRACT(YEAR FROM Fecha) BETWEEN EXTRACT(YEAR FROM TO_DATE(Fecha1,'yyyy-mm-dd')) AND EXTRACT(YEAR FROM TO_DATE(Fecha2,'yyyy-mm-dd'))));
            RETURN GAN;
        END;
    FUNCTION CO_Auspiciados RETURN SYS_REFCURSOR IS AUS SYS_REFCURSOR;
        BEGIN
            OPEN AUS FOR
                SELECT * FROM Auspiciados;
            RETURN AUS;
        END;
    FUNCTION CO_ProductProx RETURN SYS_REFCURSOR IS PROP SYS_REFCURSOR;
        BEGIN
            PROP:=PC_PRODUCTOS.CO_ProductProx;
            RETURN PROP;
        END;
    
    FUNCTION CO_PCobros(xIDProveedor IN VARCHAR) RETURN SYS_REFCURSOR IS COB SYS_REFCURSOR;
        BEGIN
            COB:=PC_COBROS.CO_PCobros(xIDProveedor);
            RETURN COB;
        END;
    FUNCTION CO_SPagos(xIDBlog IN VARCHAR) RETURN SYS_REFCURSOR IS PAG SYS_REFCURSOR;
        BEGIN
            PAG:=PC_PAGOS.CO_SPagos(xIDBlog);
            RETURN PAG;
        END;
END PA_Admin;
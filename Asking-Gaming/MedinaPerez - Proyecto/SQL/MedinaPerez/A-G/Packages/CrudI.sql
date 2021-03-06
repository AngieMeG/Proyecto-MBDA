/*CRUDS*/
CREATE OR REPLACE PACKAGE BODY PC_PRODUCTOS IS
    PROCEDURE AD_PRODUCTO(xNombre IN VARCHAR, xPrecioBase IN NUMBER, xPrecioActual IN NUMBER, xFLanzamiento IN DATE, xValoracion IN NUMBER, xPlataforma IN VARCHAR, xEspecificacion IN VARCHAR, xIDProveedor IN VARCHAR, xDesarrolladora IN VARCHAR, xFormato IN VARCHAR, xTipo IN VARCHAR, xLink IN VARCHAR) IS
            IF_tmp INTEGER;
            ID_tmp VARCHAR(10);
            Link_tmp VARCHAR(10);
        BEGIN
            SELECT COUNT(*) INTO IF_tmp FROM Productos WHERE Nombre=xNombre AND Plataforma=xPlataforma;
            IF IF_tmp=0 THEN
                INSERT INTO Productos(IDProducto,Nombre, Valoracion, Plataforma, FLanzamiento, Especificaciones, Desarrolladora) VALUES (xTipo, xNombre, xValoracion, xPlataforma, xFLanzamiento, XMLTYPE(xEspecificacion), xDesarrolladora);
            END IF;
            SELECT COUNT(IDLink) INTO IF_tmp FROM Links WHERE LURL=xLink;
            IF IF_tmp>0 THEN
                raise_application_error(-20001,'El link especificado se encuentra en uso');
            END IF;
            SELECT IDProducto INTO ID_tmp FROM Productos WHERE Nombre=xNombre AND Plataforma=xPlataforma;
            INSERT INTO Links(LURL) VALUES(xLink);
            SELECT IDLink INTO Link_tmp FROM Links WHERE LURL=xLink;
            INSERT INTO DetallesProductos(PrecioBase, PrecioActual, Redireccionamiento, IDProducto, IDProveedor, Formato) VALUES (xPrecioBase, xPrecioActual, Link_tmp, ID_tmp, xIDProveedor, xFormato);
            COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20101,'Error al insertar en Productos');
        END;
    PROCEDURE MO_PRODUCTO(xIDProducto IN VARCHAR, xPrecioBase IN INTEGER DEFAULT NULL, xPrecioActual IN INTEGER DEFAULT NULL, xFLanzamiento IN DATE DEFAULT NULL, xValoracion IN NUMBER DEFAULT NULL) IS
        BEGIN
            IF xPrecioActual IS NOT NULL THEN
                UPDATE DetallesProductos SET PrecioActual=xPrecioActual WHERE IDProducto=xIDProducto;
            END IF;
            IF xPrecioBase IS NOT NULL THEN
                UPDATE DetallesProductos SET PrecioBase=xPrecioBase WHERE IDProducto=xIDProducto;
            END IF;
            IF xFLanzamiento IS NOT NULL THEN
                UPDATE Productos SET FLanzamiento=xFLanzamiento WHERE IDProducto=xIDProducto;
            END IF;
            IF xValoracion IS NOT NULL THEN
                UPDATE Productos SET Valoracion=xValoracion WHERE IDProducto=xIDProducto; 
            END IF;
            COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20001,'Error al modificar en Productos');
        END;
    PROCEDURE DEL_PRODUCTO(xIDProducto IN VARCHAR) IS
        BEGIN
            DELETE FROM Productos WHERE IDProducto=xIDProducto;
        END;
    FUNCTION CO_ProductProx RETURN SYS_REFCURSOR IS PROP SYS_REFCURSOR;
        BEGIN
            OPEN PROP FOR
                SELECT * FROM Productos x JOIN DetallesProductos y ON x.IDProducto=y.IDProducto WHERE FLanzamiento IS NOT NULL OR FLanzamiento>=CURRENT_DATE;
            RETURN PROP;
        END;
    FUNCTION CO_Productos(xNombre IN VARCHAR , xPlataforma IN VARCHAR, xFormato IN VARCHAR) RETURN SYS_REFCURSOR IS PROs SYS_REFCURSOR;
        BEGIN
            OPEN PROs FOR
                SELECT 'Tu consulta' AS Consulta, Producto, Plataforma, Valoracion, Desarrolladora, PrecioActual, FLanzamiento, formato  FROM V_PRODUCTOS Pro WHERE Plataforma=xPlataforma AND Producto=xNombre AND Formato=xFormato
                    UNION
                SELECT 'Te puede interesar' AS Consulta, z.Nombre AS Producto, z.Plataforma, z.Valoracion, z.Desarrolladora, y.PrecioActual, z.FLanzamiento, y.formato  FROM Auspiciados x JOIN DetallesProductos y ON x.IDDetalleProducto=y.IDDetalleProducto JOIN Productos z ON z.IDProducto=y.IDProducto WHERE 
                    EXISTS(SELECT * FROM (SELECT x1.IDProducto, Details.Genero FROM Productos x1 ,XMLTABLE('/Detalle/Generos/Genero' PASSING x1.Especificaciones COLUMNS Genero VARCHAR(60) PATH '@Nombre[1]') Details) t WHERE t.IDProducto=y.IDProducto AND
                        EXISTS(SELECT Genero FROM (SELECT P2_Details.Genero FROM Productos x2 ,XMLTABLE('/Detalle/Generos/Genero' PASSING x2.Especificaciones COLUMNS Genero VARCHAR(60) PATH '@Nombre[1]') P2_Details WHERE x2.Nombre=xNombre AND x2.Plataforma=xPlataforma) u WHERE u.Genero=t.Genero)); 
            RETURN PROs;
        END;
    FUNCTION CO_Producto(xIDDetalle IN VARCHAR, xUsername IN VARCHAR) RETURN SYS_REFCURSOR IS PRO SYS_REFCURSOR;
        BEGIN
            OPEN PRO FOR
                SELECT x.Nombre, x.Plataforma, x.Valoracion, x.Desarrolladora, y.PrecioActual, x.FLanzamiento, y.formato 
                    FROM Productos x JOIN DetallesProductos y ON x.IDProducto=y.IDProducto 
                        WHERE y.IDDetalleProducto=xIDDetalle
                        ORDER BY y.PrecioActual;
            RETURN PRO;
        END;
    PROCEDURE MakeAClick(xIDDetalle IN VARCHAR, xUsername IN VARCHAR, xOut OUT SYS_REFCURSOR) IS --xIDDetalle IN VARCHAR, xUsername IN VARCHAR,
        ID_tmp VARCHAR(10);
        BEGIN
            OPEN xOut FOR
                SELECT PC_Productos.CO_Producto(xIDDetalle, xUsername) FROM DUAL;
            SELECT Redireccionamiento INTO ID_tmp FROM DetallesProductos WHERE IDDetalleProducto=xIDDetalle;
            INSERT INTO Clicks(IDLink,IDUsuario) VALUES(ID_tmp, xUsername);
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                raise_application_error(-20001,'El ID especificado no corresponde a un Producto');
        END;
END PC_PRODUCTOS;
/
CREATE OR REPLACE PACKAGE BODY PC_COBROS IS
    PROCEDURE AD_COBRO(xIDProveedor IN VARCHAR, xIDLink IN VARCHAR) IS
    BEGIN
        INSERT INTO Cobros(IDProveedor, IDLink) VALUES(xIDProveedor, xIDLink);
        COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            raise_application_error(-20001,'Error al insertar en Pagos');
    END;
    FUNCTION CO_PCobros(xIDProveedor IN VARCHAR) RETURN SYS_REFCURSOR IS COB SYS_REFCURSOR;
        BEGIN
            OPEN COB FOR
                SELECT * FROM Cobros WHERE IDProveedor=xIDProveedor;
            RETURN COB;
        END;
END PC_COBROS;
/
CREATE OR REPLACE PACKAGE BODY PC_PAGOS IS
    PROCEDURE AD_PAGO(xIDBlog IN VARCHAR, xIDLink IN VARCHAR) IS
    BEGIN
        INSERT INTO Pagos(IDBlog, IDLink) VALUES(xIDBlog, xIDLink);
        COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            raise_application_error(-20001,'Error al insertar en Pagos');
    END;
    FUNCTION CO_SPagos(xIDBlog IN VARCHAR) RETURN SYS_REFCURSOR IS PAG SYS_REFCURSOR;
        BEGIN
            OPEN PAG FOR
                SELECT * FROM Pagos WHERE IDBlog=xIDBlog;
            RETURN PAG;
        END;
END PC_PAGOS;
/
CREATE OR REPLACE PACKAGE BODY PC_USUARIOS IS
    PROCEDURE AD_USUARIO(xUsername IN VARCHAR, xContraseña IN VARCHAR, xEmail IN VARCHAR) IS
        BEGIN
            INSERT INTO Usuarios(Username,Contraseña,Email) VALUES(xUsername,xContraseña,xEmail);
            COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20104,'Error al insertar en Usuarios');
        END;  
    PROCEDURE MO_USUARIO(xUsername IN VARCHAR, xContraseña IN VARCHAR) IS
        BEGIN
            UPDATE Usuarios SET Contraseña=xContraseña WHERE Username=xUsername;
            COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20105,'Error al actualizar en Usuarios');
        END; 
    PROCEDURE DEL_USUARIO(xUsername IN VARCHAR) IS
        BEGIN
            DELETE FROM Usuarios WHERE Username=xUsername;
            COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20106,'Error al eliminar en Usuarios');
        END;  
END PC_USUARIOS;
/
CREATE OR REPLACE PACKAGE BODY PC_DIRECCIONES IS
    PROCEDURE AD_DIRECCION_U(xUsername IN VARCHAR, xPais IN VARCHAR, xCiudad IN VARCHAR, xDepartamento IN VARCHAR, xDescripcion IN VARCHAR) IS
        tmp_ID VARCHAR(10);
        BEGIN 
            SELECT IDUsuario INTO tmp_ID FROM Usuarios WHERE Username=xUsername;
            INSERT INTO DireccionesUsuarios(IDUsuario, Pais, Ciudad, Departamento, Descripcion) VALUES(tmp_ID, xPais, xCiudad, xDepartamento, xDescripcion);
            COMMIT;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                raise_application_error(-20101,'El usuario especificado no existe');
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20101,'Error al insertar en DireccionesUsuarios');
        END;
    PROCEDURE AD_DIRECCION_S(xIDEstablecimiento IN VARCHAR, xPais IN VARCHAR, xCiudad IN VARCHAR, xDepartamento IN VARCHAR, xDescripcion IN VARCHAR) IS
        BEGIN 
            INSERT INTO DireccionesEstablecimientos(IDEstablecimiento, Pais, Ciudad, Departamento, Descripcion) VALUES(xIDEstablecimiento, xPais, xCiudad, xDepartamento, xDescripcion);
            COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20101,'Error al insertar en DireccionesUsuarios');
        END;
    PROCEDURE MO_DIRECCION(xUsername IN VARCHAR, xPais IN VARCHAR DEFAULT NULL, xCiudad IN VARCHAR DEFAULT NULL, xDepartamento IN VARCHAR DEFAULT NULL, xDescripcion IN VARCHAR DEFAULT NULL) IS
        tmp_ID VARCHAR(10);
        BEGIN
            SELECT IDUsuario INTO tmp_ID FROM Usuarios WHERE Username=xUsername;
            IF xPais IS NOT NULL THEN
                UPDATE DireccionesUsuarios SET Pais=xPais WHERE IDUsuario=IDUsuario;
            END IF;
            IF xPais IS NOT NULL THEN
                UPDATE DireccionesUsuarios SET Ciudad=xCiudad WHERE IDUsuario=IDUsuario;
            END IF;
            IF xPais IS NOT NULL THEN
                UPDATE DireccionesUsuarios SET Departamento=xDepartamento WHERE IDUsuario=IDUsuario;
            END IF;
            IF xPais IS NOT NULL THEN
                UPDATE DireccionesUsuarios SET Descripcion=xDescripcion WHERE IDUsuario=IDUsuario;
            END IF;
            COMMIT;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                raise_application_error(-20101,'El usuario especificado no existe');
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20102,'Error al actualizar en DireccionesUsuarios');
        END;    
    PROCEDURE DEL_DIRECCION_U(xIDDireccion IN VARCHAR) IS
        BEGIN
            DELETE FROM DireccionesUsuarios WHERE IDDireccion=xIDDireccion;
            COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20103,'Error al eliminar en DireccionesUsuarios');
        END;
    PROCEDURE DEL_DIRECCION_S(xIDDireccion IN VARCHAR) IS
        BEGIN
            DELETE FROM DireccionesEstablecimientos WHERE IDDireccion=xIDDireccion;
            COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20103,'Error al eliminar en DireccionesEstablecimientos');
        END;
    FUNCTION CO_Direccion_U(xIDDireccion IN VARCHAR) RETURN SYS_REFCURSOR IS DIC SYS_REFCURSOR;
        BEGIN
            OPEN DIC FOR
                SELECT * FROM DireccionesUsuarios WHERE IDDireccion=xIDDireccion;
            RETURN DIC;
        END;
    FUNCTION CO_Direcciones_U(xUsername IN VARCHAR) RETURN SYS_REFCURSOR IS DIC SYS_REFCURSOR;
        tmp_ID VARCHAR(10);
        BEGIN
            SELECT IDUsuario INTO tmp_ID FROM Usuarios WHERE Username=xUsername;
            OPEN DIC FOR
                SELECT * FROM DireccionesUsuarios WHERE IDUsuario=tmp_ID;
            RETURN DIC;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                raise_application_error(-20101,'El usuario especificado no existe');
        END;
    FUNCTION CO_Direccion_S(xIDDireccion IN VARCHAR) RETURN SYS_REFCURSOR IS DIC SYS_REFCURSOR;
        BEGIN
            OPEN DIC FOR
                SELECT * FROM DireccionesEstablecimientos WHERE IDDireccion=xIDDireccion;
            RETURN DIC;
        END;
    FUNCTION CO_Direcciones_S(xIDEstablecimiento IN VARCHAR) RETURN SYS_REFCURSOR IS DIC SYS_REFCURSOR;
        BEGIN
            OPEN DIC FOR
                SELECT * FROM DireccionesEstablecimientos WHERE IDEstablecimiento=xIDEstablecimiento;
            RETURN DIC;
        END;
END PC_DIRECCIONES;
/
CREATE OR REPLACE PACKAGE BODY PC_REVIEWS IS
    PROCEDURE AD_Review(xNombre IN VARCHAR, xProducto IN VARCHAR, xPlataforma IN VARCHAR, xPertenencia IN VARCHAR, xFPublicacion IN DATE, xValoracion IN NUMBER, xRedireccionamiento IN VARCHAR) IS
        ID_tmp VARCHAR(10);
        ID_Ptmp VARCHAR(10);
        IF_tmp INTEGER;
        BEGIN
            SELECT COUNT(IDLink) INTO IF_tmp FROM Links WHERE LURL=xRedireccionamiento;
            IF IF_tmp>0 THEN
                raise_application_error(-20001,'El link especificado se encuentra en uso');
            END IF;
            INSERT INTO Links(LURL) VALUES(xRedireccionamiento);
            SELECT IDProducto INTO ID_Ptmp FROM Productos WHERE Nombre=xProducto AND Plataforma=xPlataforma;
            SELECT IDLink INTO ID_tmp FROM Links WHERE LURL=xRedireccionamiento;
            INSERT INTO Reviews(Nombre, IDProducto, Pertenencia, FPublicacion, Valoracion, Redireccionamiento) VALUES(xNombre, ID_Ptmp, xPertenencia, xFPublicacion, xValoracion, ID_tmp);
            COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20001,'Error al insertar en Reviews');
        END;    
    PROCEDURE MO_Review(xIDReview IN VARCHAR, xValoracion IN NUMBER) IS
        BEGIN
            UPDATE Reviews SET Valoracion=xValoracion WHERE IDReview=xIDReview;
            COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20000,'Error al actualizar en Reviews');
        END;
    PROCEDURE DEL_Review(xIDReview IN VARCHAR) IS
        BEGIN
            DELETE FROM Reviews WHERE IDReview=xIDReview;
            COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20000,'Error al eliminar en Reviews');
        END;
    FUNCTION CO_Reviews_U(xNombre IN VARCHAR, xPlataforma IN VARCHAR) RETURN SYS_REFCURSOR IS REW SYS_REFCURSOR;
        BEGIN
            OPEN REW FOR
                SELECT * FROM Reviews x JOIN Productos y 
                         ON x.IDProducto=y.IDProducto
                         WHERE y.Plataforma=xPlataforma AND y.Nombre=xNombre;
            RETURN REW;
        END;
    FUNCTION CO_Reviews_S(xIDBlog IN VARCHAR) RETURN SYS_REFCURSOR IS REW SYS_REFCURSOR;
        BEGIN
            OPEN REW FOR
                SELECT * FROM Reviews WHERE xIDBlog=Pertenencia;
            RETURN REW;
        END;
    FUNCTION CO_AVGReview(xIDBlog IN VARCHAR) RETURN SYS_REFCURSOR IS AVGR SYS_REFCURSOR;
        BEGIN
            OPEN AVGR FOR
                SELECT AVG(Valoracion) FROM Reviews WHERE Pertenencia=xIDBlog;
            RETURN AVGR;
        END;
    FUNCTION CO_BestReview(xIDBlog IN VARCHAR) RETURN SYS_REFCURSOR IS BREW SYS_REFCURSOR;
        BEGIN
            OPEN BREW FOR
                SELECT * FROM Reviews WHERE Valoracion=(SELECT MAX(Valoracion) FROM Reviews WHERE Pertenencia=xIDBlog);
            RETURN BREW;
        END;
    PROCEDURE MakeAClick(xIDReview IN VARCHAR, xUsername IN VARCHAR, xOut OUT SYS_REFCURSOR) IS --xIDDetalle IN VARCHAR, xUsername IN VARCHAR,
        ID_tmp VARCHAR(10);
        BEGIN
            OPEN xOut FOR
                SELECT * FROM V_Reviews WHERE IDReview=xIDReview;
            SELECT Redireccionamiento INTO ID_tmp FROM Reviews WHERE IDReview=xIDReview;
            INSERT INTO Clicks(IDLink,IDUsuario) VALUES(ID_tmp, xUsername);
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                raise_application_error(-20001,'El ID especificado no corresponde a una Review');
        END; 
END PC_REVIEWS;
/
CREATE OR REPLACE PACKAGE BODY PC_SOCIOS IS
    PROCEDURE AD_USUARIO(xNombre IN VARCHAR, xEmail IN VARCHAR, xTelefono IN VARCHAR, xCuenta IN VARCHAR, xDireccion IN VARCHAR, xTipo IN VARCHAR, xContraseña IN VARCHAR, xModalidad IN VARCHAR DEFAULT NULL) IS
    tmp VARCHAR(10);
    BEGIN
        INSERT INTO SOCIOS(Nombre,Email,Telefono,Cuenta,Direccion,Tipo,Contraseña) VALUES(xNombre,xEmail,xTelefono,xCuenta,xDireccion,xTipo,xContraseña);
        SELECT IDSocio INTO tmp FROM Socios WHERE Email=xEmail;
        IF LOWER(xTipo)='proveedor' THEN
            INSERT INTO Proveedores(IDProveedor,Modalidad) VALUES(tmp,xModalidad);
            IF LOWER(xModalidad)='digital' THEN
                INSERT INTO PaginasDigitales VALUES(tmp);
            ELSE
                INSERT INTO EstablecimientosFisicos VALUES(tmp);
            END IF;
        ELSE
            INSERT INTO Blogs VALUES(tmp);
        COMMIT;
        END IF;
        EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            raise_application_error(-20001,'Error al Insertar en Socios');
    END;
    PROCEDURE MO_USUARIO(xIDSocio IN VARCHAR, xEmail IN VARCHAR DEFAULT NULL, xTelefono IN VARCHAR DEFAULT NULL, xCuenta IN VARCHAR DEFAULT NULL, xDireccion IN VARCHAR DEFAULT NULL, xContraseña IN VARCHAR DEFAULT NULL) IS
    BEGIN
        IF xEmail IS NOT NULL THEN
            UPDATE SOCIOS SET Email=xEmail WHERE IDSocio=xIDSocio;
            COMMIT;
        END IF;
            IF xTelefono IS NOT NULL THEN
            UPDATE SOCIOS SET Telefono=xTelefono WHERE IDSocio=xIDSocio;
            COMMIT;
        END IF;
            IF xCuenta IS NOT NULL THEN
            UPDATE SOCIOS SET Cuenta=xCuenta WHERE IDSocio=xIDSocio;
            COMMIT;
        END IF;
            IF xDireccion IS NOT NULL THEN
            UPDATE SOCIOS SET Direccion=xDireccion WHERE IDSocio=xIDSocio;
            COMMIT;
        END IF;
            IF xContraseña IS NOT NULL THEN
            UPDATE SOCIOS SET Contraseña=xContraseña WHERE IDSocio=xIDSocio;
            COMMIT;
        END IF;
        EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            raise_application_error(-20001,'Error al Modificar en Socios');
    END;
    PROCEDURE DEL_USUARIO(xIDSocio IN VARCHAR) IS
        BEGIN
        DELETE FROM SOCIOS WHERE IDSocio=xIDSocio; 
        COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            raise_application_error(-20001,'Error al Modificar en Socios');
        END;
END PC_SOCIOS;
/
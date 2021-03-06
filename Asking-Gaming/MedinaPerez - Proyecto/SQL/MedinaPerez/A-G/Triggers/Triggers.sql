/* CRUD Productos */
/*Productos*/
CREATE OR REPLACE TRIGGER AD_Product
BEFORE INSERT ON Productos
FOR EACH ROW
DECLARE
tmp INTEGER;
text VARCHAR(3000);
DATE_tmp DATE;
BEGIN
    SELECT CAST(:new.Especificaciones AS VARCHAR(3000)) INTO text FROM DUAL;
    IF UPPER(:new.IDProducto)<>'J' THEN
            :new.Especificaciones:=XMLTYPE(CONCAT('<?xml version = "1.0"?>
<!DOCTYPE Detalle[
	<!ELEMENT Detalle (Generos,Categoria,Relacion)>
	<!ELEMENT Generos (Genero+)>
	<!ELEMENT Genero EMPTY>
	<!ATTLIST Genero Nombre CDATA #REQUIRED>
  <!ELEMENT Categoria EMPTY>
  <!ATTLIST Categoria PEGI CDATA #REQUIRED>
  <!ELEMENT Relacion EMPTY>
  <!ATTLIST Relacion Pertenencia CDATA #REQUIRED>
]>'
,text));    
    ELSE
        :new.Especificaciones:=XMLTYPE(CONCAT('<?xml version = "1.0"?>
<!DOCTYPE Detalle[
	<!ELEMENT Detalle (Generos,Categoria)>
	<!ELEMENT Generos (Genero+)>
	<!ELEMENT Genero EMPTY>
	<!ATTLIST Genero Nombre CDATA #REQUIRED>
  <!ELEMENT Categoria EMPTY>
  <!ATTLIST Categoria PEGI CDATA #REQUIRED>
]>'
,text)); 
    END IF;
    SELECT COUNT(*)+1 INTO tmp FROM Productos;
    :new.IDProducto:=CONCAT(UPPER(:new.IDProducto),tmp);
    SELECT CURRENT_DATE INTO DATE_tmp FROM DUAL;
    :new.FLanzamiento := DATE_tmp;
END;
/
CREATE OR REPLACE TRIGGER Mo_Product
BEFORE UPDATE ON Productos
FOR EACH ROW
DECLARE
newTmp VARCHAR(3000);
oldTmp VARCHAR(3000);
tmp INTEGER;
BEGIN
    SELECT CAST(:new.Especificaciones AS VARCHAR(3000)), CAST(:old.Especificaciones AS VARCHAR(3000)) INTO newTmp,oldTmp FROM DUAL;
    IF :new.IDProducto<>:old.IDProducto OR :new.Nombre<>:old.Nombre OR :new.Plataforma<>:old.Plataforma OR newTmp<>oldTmp OR :new.Desarrolladora<>:old.Desarrolladora THEN
        raise_application_error(-20000,'No se puede modifica en la tabla PRODUCTOS');
    END IF;
    IF :new.FLanzamiento IS NOT NULL THEN
        SELECT CURRENT_DATE-:new.FLanzamiento INTO tmp FROM DUAL;
        IF tmp>0 THEN
            raise_application_error(-20008,'Ya se definio una fecha de lanzamiento');
        END IF;
    END IF;
END;
/

/*DetallesProductos*/
CREATE OR REPLACE TRIGGER AD_ProductDetail
BEFORE INSERT ON DetallesProductos
FOR EACH ROW
DECLARE
ID_tmp INTEGER;
DATE_tmp DATE;
BEGIN
    SELECT COUNT(*)+1 INTO ID_tmp FROM DetallesProductos;
    SELECT CURRENT_DATE INTO DATE_tmp FROM DUAL;
    :new.IDDetalleProducto := ID_tmp;
END;
/
CREATE OR REPLACE TRIGGER MO_ProductDetail 
BEFORE UPDATE ON DetallesProductos
FOR EACH ROW
DECLARE
tmp INTEGER;
BEGIN
	IF :new.IDDetalleProducto<>:old.IDDetalleProducto OR :new.IDProducto<>:old.IDProducto OR :new.IDProveedor<>:old.IDProveedor OR :new.Redireccionamiento<>:old.Redireccionamiento  THEN
        raise_application_error(-20007,'Solo puede modificar la fecha de lanzamiento, el precio base, valoracion y el precio actual');	
	END IF;
END;
/
CREATE OR REPLACE TRIGGER DEL_ProductDetail
AFTER DELETE ON DetallesProductos
FOR EACH ROW
BEGIN
	DELETE FROM Links WHERE IDLink=:old.Redireccionamiento;
END;
/


/* CRUD Socios */
/*Reviews*/
CREATE OR REPLACE TRIGGER AD_Reviews
BEFORE INSERT ON Reviews
FOR EACH ROW
DECLARE
tmp INTEGER;
tmp_Date DATE;
BEGIN
	SELECT COUNT(*)+1 INTO tmp FROM Reviews;
	:new.IDReview:=CONCAT(tmp,'');
    SELECT FLanzamiento INTO tmp_Date FROM Productos WHERE IDProducto=:new.IDProducto;
    IF tmp_Date>:new.FPublicacion THEN
        raise_application_error(-20001,'Las fecha de la review especificada viola las leyes del espacio-tiempo');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER MO_Reviews
BEFORE UPDATE ON Reviews
FOR EACH ROW
DECLARE
tmp INTEGER;
BEGIN
    IF :new.IDReview<>:old.IDReview OR :new.Nombre<>:old.Nombre OR :new.IDProducto<>:old.IDProducto OR :new.Pertenencia<>:old.Pertenencia OR :new.FPublicacion<>:old.FPublicacion OR :new.Redireccionamiento<>:old.Redireccionamiento THEN
        raise_application_error(-20009,'No se puede modificar los datos de esta tabla');	
    END IF;
END;
/
CREATE OR REPLACE TRIGGER DEL_Reviews
AFTER DELETE ON Reviews
FOR EACH ROW
BEGIN
	DELETE FROM Links WHERE IDLink=:old.Redireccionamiento;
END;
/

/*Socios*/
CREATE OR REPLACE TRIGGER AD_Socios
BEFORE INSERT ON Socios
FOR EACH ROW
DECLARE
tmp INTEGER;
BEGIN
    SELECT COUNT(*)+1 INTO tmp FROM Socios;
    :new.IDSocio:=CONCAT(tmp,'');
END;
/
CREATE OR REPLACE TRIGGER MO_Socios
BEFORE UPDATE ON Socios
FOR EACH ROW
BEGIN
    IF :new.Tipo<>:old.Tipo OR :new.IDSocio<>:old.IDSocio THEN
        raise_application_error(-20001,'No se pueden modificar los valores especificados');
    END IF;
END;
/

/*DireccionesEstablecimientos*/
CREATE OR REPLACE TRIGGER AD_Direccion_S
BEFORE INSERT ON DireccionesEstablecimientos
FOR EACH ROW
DECLARE
tmp INTEGER;
BEGIN
	SELECT COUNT(*)+1 INTO tmp FROM DireccionesEstablecimientos;
	:new.IDDireccion:=CONCAT(tmp,'');
END;
/
CREATE OR REPLACE TRIGGER Mo_Direccion_S
BEFORE UPDATE ON DireccionesEstablecimientos
FOR EACH ROW
BEGIN
	IF :new.IDDireccion<>:old.IDDireccion OR :new.IDEstablecimiento<>:old.IDEstablecimiento THEN
	raise_application_error(-20010,'Solo puede modificar la descripcion, el pais, la ciudad, el estado, la contraseña y el pais');	
	END IF;
END;
/

/*Blogs*/
CREATE OR REPLACE TRIGGER CK_AD_Blog
BEFORE INSERT ON Blogs
FOR EACH ROW
DECLARE 
tmp VARCHAR(10);
BEGIN
    SELECT Tipo INTO tmp FROM Socios WHERE IDSocio=:new.IDBlog;
    IF LOWER(tmp)<>'blog' THEN
        raise_application_error(-20001,'La ID especificada no corresponde al tipo de socio');
    END IF;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'No existe un socio con la ID especificada');
END;
/

/*Proveedores*/
CREATE OR REPLACE TRIGGER CK_AD_Prov
BEFORE INSERT ON Proveedores
FOR EACH ROW
DECLARE 
tmp VARCHAR(10);
BEGIN
    SELECT Tipo INTO tmp FROM Socios WHERE IDSocio=:new.IDProveedor;
    IF LOWER(tmp)<>'proveedor' THEN
        raise_application_error(-20001,'La ID especificada no corresponde al tipo de socio');
    END IF;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'No existe un socio con la ID especificada');
END;
/


/* CRUD Transacciones */
/*Cobros*/
CREATE OR REPLACE TRIGGER AD_Cobros
BEFORE INSERT ON Cobros
FOR EACH ROW
DECLARE
tmp INTEGER;
tmpC NUMBER(10,2);
tmpD DATE;
BEGIN
	SELECT COUNT(*) INTO tmp FROM Productos;
	SELECT Cantidad*0.1 INTO tmpC FROM Links 
	WHERE IdLink=:new.Idlink;
	SELECT CURRENT_DATE INTO tmpD FROM DUAL; 
	:new.IDCobro:=CONCAT(tmp,'');
	:new.Fecha:=tmpD;
	:new.Valor:=tmpC;
END;
/
CREATE OR REPLACE TRIGGER MO_Cobros
BEFORE UPDATE ON Cobros
FOR EACH ROW
DECLARE
tmp INTEGER;
BEGIN
	raise_application_error(-20009,'No se puede modificar los datos de esta tabla');	
END;
/
CREATE OR REPLACE TRIGGER DEL_Cobros
BEFORE DELETE ON Cobros
FOR EACH ROW
DECLARE
tmp INTEGER;
BEGIN
	raise_application_error(-20009,'No se puede eliminar los datos de esta tabla');	
END;
/

/*Pagos*/
CREATE OR REPLACE TRIGGER AD_Pago
BEFORE INSERT ON Pagos
FOR EACH ROW
DECLARE
tmp INTEGER;
tmpC NUMBER(10,2);
tmpD DATE;
BEGIN
	SELECT COUNT(*) INTO tmp FROM Pagos;
	SELECT Cantidad*0.1 INTO tmpC FROM Links 
	WHERE IdLink=:new.Idlink;
	SELECT CURRENT_DATE INTO tmpD FROM DUAL; 
	:new.IDPago:=CONCAT(tmp,'');
	:new.Fecha:=tmpD;
	:new.Valor:=tmpC;
END;
/
CREATE OR REPLACE TRIGGER MO_Pago
BEFORE UPDATE ON Pagos
FOR EACH ROW
DECLARE
tmp INTEGER;
BEGIN
	raise_application_error(-20009,'No se puede modificar los datos de esta tabla');	
END;
/
CREATE OR REPLACE TRIGGER DEL_Pago
BEFORE DELETE ON Pagos
FOR EACH ROW
DECLARE
tmp INTEGER;
BEGIN
	raise_application_error(-20009,'No se puede eliminar los datos de esta tabla');	
END;
/

/*Clicks*/
CREATE OR REPLACE TRIGGER AD_Click
BEFORE INSERT ON Clicks
FOR EACH ROW
DECLARE
tmp DATE;
ID_tmp INTEGER;
Cant_tmp INTEGER;
Cobros INTEGER;
Pagos INTEGER;
Prov VARCHAR(10);
Blog VARCHAR(10);
BEGIN
    SELECT COUNT(*)+1 INTO ID_tmp FROM Clicks;
    :new.IDClick:=ID_tmp;
    SELECT CURRENT_DATE INTO tmp FROM DUAL;
    :new.Fecha:=tmp;
    SELECT Cantidad INTO Cant_tmp FROM Links WHERE :new.IDLink=IDLink;
    IF Cant_tmp = 1999999 THEN
        UPDATE Links SET Cantidad=2000000 WHERE :new.IDLink=IDLink;
        SELECT COUNT(*) INTO Cobros FROM DetallesProductos WHERE Redireccionamiento=:new.IDLink;
        IF Cobros>0 THEN
            SELECT IDProveedor INTO Prov FROM DetallesProductos WHERE Redireccionamiento=:new.IDLink;
            INSERT INTO Cobros(IDProveedor,IDLInk) VALUES(Prov,:new.IDLink); 
        ELSE
            SELECT Pertenencia INTO Blog FROM Reviews WHERE Redireccionamiento=:new.IDLink;
            INSERT INTO Pagos(IDBlog,IDLInk) VALUES(Blog,:new.IDLink); 
        END IF;
        UPDATE Links SET Cantidad=0 WHERE :new.IDLink=IDLink;
    ELSE
        UPDATE Links SET Cantidad=Cantidad+1 WHERE :new.IDLink=IDLink;
    END IF;
END;
/

/*Links*/
CREATE OR REPLACE TRIGGER AD_Link
BEFORE INSERT ON Links
FOR EACH ROW
DECLARE
tmp INTEGER;
BEGIN
    SELECT COUNT(*)+1 INTO tmp FROM Links;
    :new.Cantidad:=0;
    :new.IDLink:=tmp;
END;
/


/* CRUD Usuarios */
/*Usuarios*/
CREATE OR REPLACE TRIGGER AD_Usuario
BEFORE INSERT ON Usuarios
FOR EACH ROW
DECLARE
tmp INTEGER;
BEGIN
    SELECT COUNT(*)+1 INTO tmp FROM Usuarios;
    :new.IDUsuario:=CONCAT(tmp,'');
END;
/
CREATE OR REPLACE TRIGGER MO_Usuario
BEFORE UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    IF :new.Email<>:old.Email OR :new.Username<>:old.Username OR :new.Estado<>:Old.Estado THEN
    raise_application_error(-20011,'No se puede modificar los atributos especificados en esta tabla');
    END IF;
END;
/

/*DireccionesUsuarios*/
CREATE OR REPLACE TRIGGER AD_Direccion
BEFORE INSERT ON DireccionesUsuarios
FOR EACH ROW
DECLARE
tmp INTEGER;
BEGIN
	SELECT COUNT(*)+1 INTO tmp FROM DireccionesUsuarios;
	:new.IDDireccion:=CONCAT(tmp,'');
END;
/
CREATE OR REPLACE TRIGGER Mo_Direccion
BEFORE UPDATE ON DireccionesUsuarios
FOR EACH ROW
BEGIN
	IF :new.IDDireccion<>:old.IDDireccion OR :new.IDUsuario<>:old.IDUsuario THEN
	raise_application_error(-20010,'Solo puede modificar la descripcion, el pais, la ciudad y el pais');	
	END IF;
END;
/

/*Ciclo 2*/
CREATE OR REPLACE TRIGGER AD_Auspiciado
BEFORE INSERT ON Auspiciados
FOR EACH ROW
DECLARE
tmp INTEGER;
tmpS VARCHAR(100);
tmpConcat VARCHAR(100);
tmpI INTEGER;
tmpC INTEGER;
tmpDate DATE;
tmpID VARCHAR(10);
BEGIN
    SELECT IDProducto INTO tmpID FROM DetallesProductos WHERE IDDetalleProducto=:new.IDDetalleProducto;
    SELECT COUNT(*) INTO tmpI FROM(SELECT ROW_NUMBER() OVER(ORDER BY Genero) AS ID, Details.Genero FROM Productos x ,XMLTABLE('/Detalle/Generos/Genero' PASSING x.Especificaciones COLUMNS Genero VARCHAR(60) PATH '@Nombre[1]') Details WHERE x.IDProducto=tmpID);
    tmpConcat:='';
    WHILE tmpI>0
        LOOP
            SELECT Lower(Genero) INTO tmpS FROM(SELECT ROW_NUMBER() OVER(ORDER BY Genero) AS ID, Details.Genero FROM Productos x ,XMLTABLE('/Detalle/Generos/Genero' PASSING x.Especificaciones COLUMNS Genero VARCHAR(60) PATH '@Nombre[1]') Details WHERE x.IDProducto=tmpID) WHERE ID=tmpI;
            tmpConcat:=CONCAT(CONCAT(tmpConcat,' '),tmpS);
            tmpI:=tmpI-1;
        END LOOP;
    SELECT COUNT(*) INTO tmpI FROM Cupos;
        WHILE tmpI>0
        LOOP
            SELECT LOWER(Nombre),Cantidad INTO tmpS,tmpC FROM Cupos WHERE Numero=tmpI;
            IF tmpC=0 AND tmpConcat LIKE CONCAT(CONCAT('%',tmpS),'%') THEN
                    raise_application_error(-20001,'No hay cupos disponibles');                
            END IF;
            tmpI:=tmpI-1;
        END LOOP;
    SELECT COUNT(*) INTO tmpI FROM Cupos;
    WHILE tmpI>0
        LOOP
            SELECT LOWER(Nombre),Cantidad INTO tmpS,tmpC FROM Cupos WHERE Numero=tmpI;
            IF tmpConcat LIKE CONCAT(CONCAT('%',tmpS),'%') THEN
                    UPDATE Cupos SET Cantidad=Cantidad-1 WHERE Lower(Nombre)=tmpS;
            END IF;
            tmpI:=tmpI-1;
        END LOOP;
    SELECT CURRENT_DATE INTO tmpDate FROM DUAL;
    :new.Fecha:=tmpDate;
    SELECT COUNT(*)+1 INTO tmp FROM Auspiciados;
    :new.IDAuspiciado:=tmp;
END;

/
CREATE OR REPLACE TRIGGER AD_Cupo
BEFORE INSERT ON Cupos
FOR EACH ROW
DECLARE
tmp INTEGER;
BEGIN
    SELECT COUNT(*)+1 INTO tmp FROM Cupos;
    :new.Numero:=tmp;
END;


CREATE TABLE Auspiciados(
    IDAusp INTEGER NOT NULL
);
DROP TABLE Auspiciados;

CREATE TABLE xml_Test(
    IDXml INTEGER,
    Detalles XMLTYPE
);
DROP TABLE  xml_Test;

CREATE TABLE CONCAT_T(
    Cadena VARCHAR(1000)
)
DROP TABLE CONCAT_T;
CREATE TABLE Cupos(
    Numero INTEGER NOT NULL UNIQUE,
    Nombre VARCHAR(20) NOT NULL PRIMARY KEY,
    CANTIDAD INTEGER DEFAULT 10
);
DROP TABLE Cupos;

INSERT INTO xml_Test VALUES(1,XMLTYPE('<Detalle>
	<Generos>
  	<Genero Nombre="Accion"/>
    <Genero Nombre="Disparos"/>
    <Genero Nombre="Aventura"/>
    <Genero Nombre="Exploracion"/>
    <Genero Nombre="Rol"/>
    <Genero Nombre="Fantasia"/>
    <Genero Nombre="Indie"/>
  </Generos>
  <Categoria PEGI="+16"/>
</Detalle>'));

insert into auspiciados values(1);

update cupos set cantidad=0 where numero=1;

CREATE OR REPLACE TRIGGER AD_Ausp
BEFORE INSERT ON Auspiciados
FOR EACH ROW
DECLARE
tmpS VARCHAR(100);
tmpConcat VARCHAR(100);
tmpI INTEGER;
tmpC INTEGER;
BEGIN
    SELECT COUNT(*) INTO tmpI FROM(SELECT ROW_NUMBER() OVER(ORDER BY Genero) AS ID, Details.Genero FROM xml_Test x ,XMLTABLE('/Detalle/Generos/Genero' PASSING x.Detalles COLUMNS Genero VARCHAR(60) PATH '@Nombre[1]') Details WHERE x.IDXml=:new.IDAusp);
    tmpConcat:='';
    WHILE tmpI>0
        LOOP
            SELECT Lower(Genero) INTO tmpS FROM(SELECT ROW_NUMBER() OVER(ORDER BY Genero) AS ID, Details.Genero FROM xml_Test x ,XMLTABLE('/Detalle/Generos/Genero' PASSING x.Detalles COLUMNS Genero VARCHAR(60) PATH '@Nombre[1]') Details WHERE x.IDXml=:new.IDAusp) WHERE ID=tmpI;
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
    INSERT INTO CONCAT_TEST VALUES(tmpConcat);
END;






CREATE TABLE Productos(
    IDProducto VARCHAR(10) NOT NULL,
    Nombre VARCHAR(60) NOT NULL,
    Valoracion INTEGER NOT NULL,
    Plataforma VARCHAR(20) NOT NULL,
    Especificaciones XMLTYPE NOT NULL,
    FLanzamiento DATE, 
    Desarrolladora VARCHAR(60) NOT NULL  
);
CREATE TABLE DetallesProductos(
    IDDetalleProducto VARCHAR(10) NOT NULL,
    PrecioBase INTEGER NOT NULL,
    PrecioActual INTEGER NOT NULL,
    Redireccionamiento VARCHAR(10) NOT NULL,
    IDProducto VARCHAR(10) NOT NULL,
    IDProveedor VARCHAR(10) NOT NULL,
    Formato VARCHAR(7) NOT NULL
);
CREATE TABLE Socios(
    IDSocio VARCHAR(10) NOT NULL,
    Nombre VARCHAR(60) NOT NULL,
    Email VARCHAR(60) NOT NULL,
    Telefono VARCHAR(15) NOT NULL,
    Cuenta VARCHAR(20) NOT NULL,
    Direccion VARCHAR(1000),
    Tipo VARCHAR(10) NOT NULL,
    Contraseña VARCHAR(60) NOT NULL
);
CREATE TABLE Proveedores(
    IDProveedor VARCHAR(10) NOT NULL,
    Modalidad VARCHAR(8) NOT NULL
);
CREATE TABLE EstablecimientosFisicos(
    IDFisico VARCHAR(15) NOT NULL
);
CREATE TABLE DireccionesEstablecimientos(
    IDDireccion VARCHAR(10) NOT NULL,
    IDEstablecimiento VARCHAR(10) NOT NULL,
    Pais VARCHAR(60) DEFAULT 'Colombia',
    Ciudad VARCHAR(60) DEFAULT 'Bogota',
    Departamento VARCHAR(60) DEFAULT 'Cundinamarca',
    Descripcion VARCHAR(1000) NOT NULL
);
CREATE TABLE Blogs(
    IDBlog VARCHAR(10) NOT NULL
);
CREATE TABLE Reviews(
    IDReview VARCHAR(10) NOT NULL,
    Nombre VARCHAR(60) NOT NULL,
    IDProducto VARCHAR(10) NOT NULL,
    Pertenencia VARCHAR(10) NOT NULL,
    FPublicacion DATE NOT NULL,
    Valoracion INTEGER NOT NULL,
    Redireccionamiento VARCHAR(10) NOT NULL
);
CREATE TABLE PaginasDigitales(
    IDPaginas VARCHAR(10) NOT NULL
);
CREATE TABLE Links(
    IDLink VARCHAR(10) NOT NULL,
    Cantidad INTEGER DEFAULT 0,
    LURL VARCHAR(1000) NOT NULL
);
CREATE TABLE Cobros(
    IDCobro VARCHAR(10) NOT NULL,
    Valor INTEGER NOT NULL,
    IDProveedor VARCHAR(10) NOT NULL,
    IDLink VARCHAR(10) NOT NULL,
    Fecha DATE NOT NULL
);
CREATE TABLE Pagos(
    IDPago VARCHAR(10) NOT NULL,
    IDBlog VARCHAR(10) NOT NULL,
    Valor INTEGER NOT NULL,
    IDLink VARCHAR(10) NOT NULL,
    Fecha DATE NOT NULL
);
CREATE TABLE Usuarios(
    Username VARCHAR(60) NOT NULL,
    Contraseña VARCHAR(30) NOT NULL,
    Email VARCHAR(60) NOT NULL,
    Estado VARCHAR(60) DEFAULT 'Normal'
);
CREATE TABLE DireccionesUsuarios(
    IDDireccion VARCHAR(10) NOT NULL,
    Username VARCHAR(60) NOT NULL,
    Pais VARCHAR(60) NOT NULL,
    Ciudad VARCHAR(60) NOT NULL,
    Departamento VARCHAR(60) NOT NULL,
    Descripcion VARCHAR(1000) NOT NULL
);
CREATE TABLE Clicks(
    IDClick VARCHAR(10) NOT NULL,
    IDUsuario VARCHAR(60) NOT NULL,
    IDLink VARCHAR(10) NOT NULL,
    Fecha DATE NOT NULL
);

/*Primary keys*/
ALTER TABLE Productos ADD CONSTRAINT Producto_PK PRIMARY KEY (IDProducto);
ALTER TABLE DetallesProductos ADD CONSTRAINT DestalleProducto_PK PRIMARY KEY (IDDetalleProducto);

ALTER TABLE Socios ADD CONSTRAINT Socios_PK PRIMARY KEY (IDSocio);
ALTER TABLE Proveedores ADD CONSTRAINT Proveedores_PK PRIMARY KEY (IDProveedor);
ALTER TABLE EstablecimientosFisicos ADD CONSTRAINT Fisico_PK PRIMARY KEY (IDFisico);
ALTER TABLE DireccionesEstablecimientos ADD CONSTRAINT DireccionesEstablecimientos_PK PRIMARY KEY (IDDireccion);
ALTER TABLE Blogs ADD CONSTRAINT Blog_PK PRIMARY KEY (IDBlog);
ALTER TABLE Reviews ADD CONSTRAINT Review_PK PRIMARY KEY (IDReview);
ALTER TABLE PaginasDigitales ADD CONSTRAINT Paginas_PK PRIMARY KEY (IDPaginas);

ALTER TABLE Links ADD CONSTRAINT Link_PK PRIMARY KEY (IDLink);
ALTER TABLE Cobros ADD CONSTRAINT Cobros_PK PRIMARY KEY (IDCobro);
ALTER TABLE Pagos ADD CONSTRAINT Pagos_PK PRIMARY KEY (IDPago);

ALTER TABLE Usuarios ADD CONSTRAINT Usuarios_PK PRIMARY KEY (Username);
ALTER TABLE DireccionesUsuarios ADD CONSTRAINT DireccionesUsuarios_PK PRIMARY KEY (IDDireccion);
ALTER TABLE Clicks ADD CONSTRAINT Clicks_PK PRIMARY KEY (IDClick);

/*Foreign keys*/
ALTER TABLE DetallesProductos ADD CONSTRAINT DPRedireccion_FK FOREIGN KEY (Redireccionamiento) REFERENCES Links(IDLink);
ALTER TABLE DetallesProductos ADD CONSTRAINT DPProveedor_FK FOREIGN KEY (IDProveedor) REFERENCES Proveedores(IDProveedor) ON DELETE CASCADE;
ALTER TABLE DetallesProductos ADD CONSTRAINT DPProducto_FK FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto) ON DELETE CASCADE;

ALTER TABLE Proveedores ADD CONSTRAINT Proveedores_FK FOREIGN KEY (IDProveedor) REFERENCES Socios(IDSocio) ON DELETE CASCADE;
ALTER TABLE EstablecimientosFisicos ADD CONSTRAINT Establecimiento_FK FOREIGN KEY (IDFisico) REFERENCES Proveedores(IDProveedor) ON DELETE CASCADE;
ALTER TABLE DireccionesEstablecimientos ADD CONSTRAINT Direccion_FK FOREIGN KEY (IDEstablecimiento) REFERENCES EstablecimientosFisicos(IDFisico) ON DELETE CASCADE;
ALTER TABLE Blogs ADD CONSTRAINT Blogs_FK FOREIGN KEY (IDblog) REFERENCES Socios(IDSocio) ON DELETE CASCADE;
ALTER TABLE Reviews ADD CONSTRAINT Review_Producto_FK FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto) ON DELETE CASCADE;
ALTER TABLE Reviews ADD CONSTRAINT Review_Pertenencia_FK FOREIGN KEY (Pertenencia) REFERENCES Blogs(IDBlog) ON DELETE CASCADE;
ALTER TABLE PaginasDigitales ADD CONSTRAINT Paginas_Proveedor_FK FOREIGN KEY (IDPaginas) REFERENCES Proveedores(IDProveedor) ON DELETE CASCADE;

ALTER TABLE Cobros ADD CONSTRAINT CobroProveedor_FK FOREIGN KEY (IDProveedor) REFERENCES Proveedores(IDProveedor) ON DELETE SET NULL;
ALTER TABLE Cobros ADD CONSTRAINT CobroRedireccion_FK FOREIGN KEY (IDLink) REFERENCES Links(IDLink) ON DELETE SET NULL;
ALTER TABLE Pagos ADD CONSTRAINT PagosBlogs_FK FOREIGN KEY (IDBlog) REFERENCES Blogs(IDBlog) ON DELETE SET NULL;
ALTER TABLE Pagos ADD CONSTRAINT PagosLink_FK FOREIGN KEY (IDLink) REFERENCES Links(IDLink) ON DELETE SET NULL;

ALTER TABLE DireccionesUsuarios ADD CONSTRAINT DireccionesUsuarios_FK FOREIGN KEY (Username) REFERENCES Usuarios(Username) ON DELETE CASCADE;
ALTER TABLE Clicks ADD CONSTRAINT ClickUser_FK FOREIGN KEY (IDUsuario) REFERENCES Usuarios(Username) ON DELETE SET NULL;
ALTER TABLE Clicks ADD CONSTRAINT ClickLink_FK FOREIGN KEY (IDLink) REFERENCES Links(IDLink) ON DELETE SET NULL;

/*Unique keys*/
ALTER TABLE Productos ADD CONSTRAINT Producto_UK UNIQUE (Nombre,Plataforma);
ALTER TABLE Socios ADD CONSTRAINT Socio_mail_UK UNIQUE (Email);
ALTER TABLE Socios ADD CONSTRAINT Socio_Dir_UK UNIQUE (Direccion);
ALTER TABLE Reviews ADD CONSTRAINT Reviews_UK UNIQUE (Redireccionamiento);
ALTER TABLE Usuarios ADD CONSTRAINT Usuario_mail_UK UNIQUE (Email);
ALTER TABLE Pagos ADD CONSTRAINT Pagos_UK UNIQUE (IDLink,Fecha);
ALTER TABLE Cobros ADD CONSTRAINT Cobros_UK UNIQUE (IDLink,Fecha);
ALTER TABLE DetallesProductos ADD CONSTRAINT Productos_UK UNIQUE (Redireccionamiento);
ALTER TABLE Links ADD CONSTRAINT Link_UK UNIQUE (LURL);
/*Constraint keys*/
ALTER TABLE Usuarios ADD CONSTRAINT Usuarios_CK CHECK (NOT(regexp_instr ('%[ &'',":;!+=\/()<>]*%', email) > 0
						   or regexp_instr ('[@.-_]%', email) > 0 
						   or regexp_instr ('%[@.-_]', email) > 0 
						   or email not like '%@%.%'
						   or email like '%..%'  
						   or email like '%@%@%' 
						   or email like '%.@%' or email like '%@.%'
						   or email like '%.cm' or email like '%.co'
						   or email like '%.or' or email like '%.ne'));
ALTER TABLE Socios ADD CONSTRAINT Socios_CK CHECK (NOT(regexp_instr ('%[ &'',":;!+=\/()<>]*%', email) > 0
						   or regexp_instr ('[@.-_]%', email) > 0 
						   or regexp_instr ('%[@.-_]', email) > 0 
						   or email not like '%@%.%'
						   or email like '%..%'  
						   or email like '%@%@%' 
						   or email like '%.@%' or email like '%@.%'
						   or email like '%.cm' or email like '%.co'
						   or email like '%.or' or email like '%.ne'));
ALTER TABLE Proveedores ADD CONSTRAINT Proveedores_CK CHECK (modalidad IN ('fisico','digital'));
ALTER TABLE Productos ADD CONSTRAINT Producto_CK CHECK (Valoracion BETWEEN 0 AND 10);
ALTER TABLE Reviews ADD CONSTRAINT Reviews_CK CHECK (Valoracion BETWEEN 0 AND 10);
ALTER TABLE Socios ADD CONSTRAINT Socios_Dir_CK CHECK (Direccion LIKE '%.%.%' AND Direccion LIKE 'https://%');
ALTER TABLE Links ADD CONSTRAINT Links_CK CHECK (LURL LIKE '%.%.%' AND LURL LIKE 'https://%');
ALTER TABLE DetallesProductos ADD CONSTRAINT DetailFormat_CK CHECK (LOWER(Formato) IN ('key','fisico','digital'));
ALTER TABLE DetallesProductos ADD CONSTRAINT DetailPrice_CK CHECK (precioActual BETWEEN 100 AND 2000000 AND precioBase BETWEEN 100 AND 2000000);
ALTER TABLE Socios ADD CONSTRAINT SocioType_CHECK CHECK (LOWER(Tipo) IN ('blog','proveedor'));

/*XPoblar*/
DELETE FROM Productos;
DELETE FROM DetallesProductos;
DELETE FROM Socios;
DELETE FROM Proveedores;
DELETE FROM EstablecimientosFisicos;
DELETE FROM DireccionesEstablecimientos;
DELETE FROM Blogs;
DELETE FROM Reviews;
DELETE FROM PaginasDigitales;
DELETE FROM Links;
DELETE FROM Cobros;
DELETE FROM Usuarios;
DELETE FROM DireccionesUsuarios;
DELETE FROM Clicks;
DELETE FROM Pagos;

/*XTablas*/
DROP TABLE Productos CASCADE CONSTRAINTS;
DROP TABLE DetallesProductos CASCADE CONSTRAINTS;
DROP TABLE Socios CASCADE CONSTRAINTS;
DROP TABLE Proveedores CASCADE CONSTRAINTS;
DROP TABLE EstablecimientosFisicos CASCADE CONSTRAINTS;
DROP TABLE DireccionesEstablecimientos CASCADE CONSTRAINTS;
DROP TABLE Blogs CASCADE CONSTRAINTS;
DROP TABLE Reviews CASCADE CONSTRAINTS;
DROP TABLE PaginasDigitales CASCADE CONSTRAINTS;
DROP TABLE Links CASCADE CONSTRAINTS;
DROP TABLE Cobros CASCADE CONSTRAINTS;
DROP TABLE Usuarios CASCADE CONSTRAINTS;
DROP TABLE DireccionesUsuarios CASCADE CONSTRAINTS;
DROP TABLE Clicks CASCADE CONSTRAINTS;
DROP TABLE Pagos CASCADE CONSTRAINTS;

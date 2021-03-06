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
    IDUsuario VARCHAR(10) NOT NULL,
    Username VARCHAR(60) NOT NULL,
    Contraseña VARCHAR(30) NOT NULL,
    Email VARCHAR(60) NOT NULL,
    Estado VARCHAR(60) DEFAULT 'Normal'
);
CREATE TABLE DireccionesUsuarios(
    IDDireccion VARCHAR(10) NOT NULL,
    IDUsuario VARCHAR(10) NOT NULL,
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
CREATE TABLE Auspiciados(
    IDAuspiciado VARCHAR(10) NOT NULL,
    IDDetalleProducto VARCHAR(10) NOT NULL,
    Fecha DATE NOT NULL
);
CREATE TABLE Cupos(
    Numero INTEGER NOT NULL,
    Nombre VARCHAR(20) NOT NULL,
    Cantidad INTEGER DEFAULT 10
);
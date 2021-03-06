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
ALTER TABLE Reviews ADD CONSTRAINT Review_Link_FK FOREIGN KEY (Redireccionamiento) REFERENCES Links(IDLink);
ALTER TABLE PaginasDigitales ADD CONSTRAINT Paginas_Proveedor_FK FOREIGN KEY (IDPaginas) REFERENCES Proveedores(IDProveedor) ON DELETE CASCADE;

ALTER TABLE Cobros ADD CONSTRAINT CobroProveedor_FK FOREIGN KEY (IDProveedor) REFERENCES Proveedores(IDProveedor) ON DELETE SET NULL;
ALTER TABLE Cobros ADD CONSTRAINT CobroRedireccion_FK FOREIGN KEY (IDLink) REFERENCES Links(IDLink) ON DELETE SET NULL;
ALTER TABLE Pagos ADD CONSTRAINT PagosBlogs_FK FOREIGN KEY (IDBlog) REFERENCES Blogs(IDBlog) ON DELETE SET NULL;
ALTER TABLE Pagos ADD CONSTRAINT PagosLink_FK FOREIGN KEY (IDLink) REFERENCES Links(IDLink) ON DELETE SET NULL;

ALTER TABLE DireccionesUsuarios ADD CONSTRAINT DireccionesUsuarios_FK FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario) ON DELETE CASCADE;
ALTER TABLE Clicks ADD CONSTRAINT ClickUser_FK FOREIGN KEY (IDUsuario) REFERENCES Usuarios(Username) ON DELETE SET NULL;
ALTER TABLE Clicks ADD CONSTRAINT ClickLink_FK FOREIGN KEY (IDLink) REFERENCES Links(IDLink) ON DELETE SET NULL;

ALTER TABLE Auspiciados ADD CONSTRAINT Auspiciado_FK FOREIGN KEY (IDDetalleProducto) REFERENCES DetallesProductos(IDDetalleProducto) ON DELETE CASCADE;
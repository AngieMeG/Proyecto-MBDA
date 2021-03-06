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

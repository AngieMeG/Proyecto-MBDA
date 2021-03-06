CREATE ROLE Usuario_A;
CREATE ROLE Blogger;
CREATE ROLE Proveedor;
CREATE ROLE Administrador;

GRANT EXECUTE ON PA_USUARIO TO Usuario_A;
GRANT EXECUTE ON PA_Blogger TO Blogger;
GRANT EXECUTE ON PA_Proveedor TO Proveedor;
GRANT EXECUTE ON PA_Usuario TO Administrador;
GRANT EXECUTE ON PA_Blogger TO Administrador;
GRANT EXECUTE ON PA_Proveedor TO Administrador;
GRANT EXECUTE ON PA_Admin TO Administrador;


GRANT Blogger, Proveedor TO bd2161696;
GRANT Usuario TO bd2160192;

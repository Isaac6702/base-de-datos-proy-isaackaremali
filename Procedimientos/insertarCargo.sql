create or replace PROCEDURE insertarCargo(nombre IN VARCHAR2, tipoAscenso IN VARCHAR2, departamento IN NUMBER, jefe IN NUMBER) IS
BEGIN
    INSERT INTO CARGO
        (idCargo, nombre, tipoAscenso, fkDepartamento, fkJefe)
    VALUES
        (seqCargo.NEXTVAL, lower(nombre), lower(tipoAscenso), departamento, jefe);
COMMIT;
    
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;  

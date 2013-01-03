create or replace PROCEDURE insertarDepartamento(nombre IN VARCHAR2, ascenso IN NUMBER) IS
BEGIN
    INSERT INTO DEPARTAMENTO
        (idDepartamento, nombre, tiempoAscenso)
    VALUES
        (seqDepartamento.NEXTVAL, lower(nombre), ascenso);
COMMIT;
    
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
  

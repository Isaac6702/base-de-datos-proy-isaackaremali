create or replace PROCEDURE insertarOrquesta(nombre IN VARCHAR2, invitado IN NUMBER) IS
BEGIN
    INSERT INTO ORQUESTA
        (idOrquesta, nombre, invitado)
    VALUES
        (seqOrquesta.NEXTVAL, lower(nombre), invitado);
COMMIT;
    
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;      
   
    
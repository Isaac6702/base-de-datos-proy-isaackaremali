create or replace PROCEDURE agregarVozCantante (voz IN NUMBER, cantante IN NUMBER) IS
BEGIN
    INSERT INTO CANTANTE_VOZ
        (pkVoz, pkCantante)
    VALUES
        (voz, cantante);
        
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
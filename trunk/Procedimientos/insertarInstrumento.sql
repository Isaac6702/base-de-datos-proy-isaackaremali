create or replace PROCEDURE insertarInstrumento (instrumento IN VARCHAR2) IS
BEGIN
    INSERT INTO INSTRUMENTO
    (idInstrumento, nombre)
    VALUES
    (seqInstrumento.NEXTVAL, lower(instrumento));
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
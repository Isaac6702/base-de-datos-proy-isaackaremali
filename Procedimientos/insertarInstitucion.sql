create or replace PROCEDURE insertarInstitucion(nombreInstitucion IN VARCHAR2) IS

BEGIN
          
    INSERT INTO INSTITUCION
       (idInstitucion, nombre)
    VALUES 
       (seqInstitucion.NEXTVAL, lower(nombreInstitucion));
       
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
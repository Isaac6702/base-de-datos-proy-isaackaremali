create or replace PROCEDURE insertarInstitucion(nombreInstitucion IN VARCHAR2) IS

CURSOR BUSQUEDA_INSTITUCION IS select seqInstitucion.NEXTVAL from dual;
ID BUSQUEDA_INSTITUCION % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA_INSTITUCION LOOP
          
      INSERT INTO INSTITUCION
       (idInstitucion, nombre)
      VALUES 
       (ID.NEXTVAL, nombreInstitucion);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
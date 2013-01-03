CREATE OR REPLACE 
DIRECTORY FOTOSDIRECTODE AS 'C:\BasesDeDatosII\fotos\fotoDE\';
/
GRANT READ ON DIRECTORY FOTOSDIRECTODE to PUBLIC;
/
create or replace PROCEDURE insertDirectorEscenografia(pasaporte IN NUMBER, invitado IN NUMBER,nombreCompleto IN DATOS_PERSONALES, telefonos IN TELEFONOS, sexo IN VARCHAR2, fechaNacimiento IN DATE, fallecimiento IN DATE, archivoFoto IN VARCHAR2, fkLugar IN NUMBER, detalleDireccion IN VARCHAR2, nacionalidad IN NUMBER, fechaInicioCargo IN DATE, sueldo IN NUMBER ) IS
l_bfile  BFILE;
l_blob   BLOB; 
CURSOR BUSQUEDA IS select seqDirectorEscenografia.NEXTVAL  from dual;
ID BUSQUEDA % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA LOOP

    validarTDA(nombreCompleto, telefonos);  
    validarNacionalidad(sexo, nacionalidad);     
      INSERT INTO DIRECTOR_ESCENOGRAFIA
       (IDDE, PASAPORTE, INVITADO, NOMBRECOMPLETO, TELEFONO, SEXO, FECHANACIMIENTO, FALLECIMIENTO, FOTO, FKLUGAR, DETALLEDIRECCION)
      VALUES 
       (ID.NEXTVAL, pasaporte, invitado, nombreCompleto , telefonos, sexo, fechaNacimiento, fallecimiento, EMPTY_BLOB(), fkLugar, detalleDireccion )
      RETURN foto INTO l_blob;
      
    if archivoFoto IS NOT NULL THEN
    
      l_bfile := BFILENAME('FOTOSDIRECTODE', archivoFoto);
      DBMS_LOB.fileopen(l_bfile, Dbms_Lob.File_Readonly);
      DBMS_LOB.loadfromfile(l_blob,l_bfile,DBMS_LOB.getlength(l_bfile));
      DBMS_LOB.fileclose(l_bfile);
      
    end if;
    
    INSERT INTO TRABAJADOR_CARGO
        (IDTC, FECHAINICIO, SUELDO, FKDIRECTORESCENOGRAFIA, FKCARGO)
      VALUES 
       (seqTrabajadorCargo.NEXTVAL, fechaInicioCargo, sueldo, ID.NEXTVAL, 25);
      
    INSERT INTO NACIONALIDAD_DE
       (PKNACIONALIDAD, PKDE)
      VALUES
       (nacionalidad, ID.NEXTVAL);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;

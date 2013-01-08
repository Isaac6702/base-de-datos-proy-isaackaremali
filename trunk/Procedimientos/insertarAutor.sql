CREATE OR REPLACE 
DIRECTORY FOTOSAUTORES AS 'C:\BasesDeDatosII\fotos\fotosAutores';
/
GRANT READ ON DIRECTORY FOTOSAUTORES to PUBLIC;
/
create or replace PROCEDURE insertarAutor(nombreCompleto IN DATOS_PERSONALES, nroPasaporte IN NUMBER, telefonos IN TELEFONOS, sexo IN VARCHAR2, fechaNacimiento IN DATE, fallecimiento IN DATE, archivoFoto IN VARCHAR2, fkLugar IN NUMBER, detalleDireccion IN VARCHAR2, nacionalidad IN NUMBER, fechaInicioCargo IN DATE, sueldo IN NUMBER, idInst IN NUMBER, estudio IN NUMBER, fechaInicioEst IN DATE, fechaFinEst IN DATE, invitado IN NUMBER) IS
l_bfile  BFILE;
l_blob   BLOB; 
CURSOR BUSQUEDA IS select seqAutor.NEXTVAL  from dual;
ID BUSQUEDA % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA LOOP

    validarTDA(nombreCompleto, telefonos);
          
      INSERT INTO AUTOR
       (idAutor, pasaporte, nombreCompleto, telefono, sexo, fechaNacimiento, fallecimiento, foto, fkLugar, detalleDireccion, invitado)
      VALUES 
       (ID.NEXTVAL, nroPasaporte, nombreCompleto, telefonos, sexo, fechaNacimiento, fallecimiento, EMPTY_BLOB(), fkLugar, detalleDireccion, invitado)
      RETURN foto INTO l_blob;
      
    if archivoFoto IS NOT NULL THEN
    
      l_bfile := BFILENAME('FOTOSAUTORES', archivoFoto);
      DBMS_LOB.fileopen(l_bfile, Dbms_Lob.File_Readonly);
      DBMS_LOB.loadfromfile(l_blob,l_bfile,DBMS_LOB.getlength(l_bfile));
      DBMS_LOB.fileclose(l_bfile);
      
    end if;
    
    INSERT INTO TRABAJADOR_CARGO
        (idTC, fechaInicio, sueldo, fkAutor, fkCargo)
      VALUES 
       (seqTrabajadorCargo.NEXTVAL, fechaInicioCargo, sueldo, ID.NEXTVAL, 54);
      
    INSERT INTO NACIONALIDAD_AUTOR
       (pkNacionalidad, pkAutor)
      VALUES
       (nacionalidad, ID.NEXTVAL);
   
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
CREATE OR REPLACE 
DIRECTORY FOTOSDM AS 'C:\BasesDeDatosII\fotos\fotosDM';
/
GRANT READ ON DIRECTORY FOTOSDM to PUBLIC;
/
create or replace PROCEDURE insertDM(nroPasaporte IN NUMBER, invitadoDM IN NUMBER, nombreCompleto IN DATOS_PERSONALES, telefonos IN TELEFONOS, sexo IN VARCHAR2, fechaNacimiento IN DATE, fallecimiento IN DATE, archivoFoto IN VARCHAR2, fkLugar IN NUMBER, detalleDireccion IN VARCHAR2, nacionalidad IN NUMBER, fechaInicioCargo IN DATE, sueldo IN NUMBER) IS
l_bfile  BFILE;
l_blob   BLOB; 
CURSOR BUSQUEDA IS select seqDirectorMusical.NEXTVAL  from dual;
ID BUSQUEDA % ROWTYPE;

CURSOR BUSQUEDA_ESTUDIO IS select seqEstudio.NEXTVAL  from dual;
ID_ESTUDIO BUSQUEDA_ESTUDIO % ROWTYPE;
BEGIN
FOR ID IN BUSQUEDA LOOP

    validarTDA(nombreCompleto, telefonos);
    validarNacionalidad(sexo, nacionalidad); 
          
      INSERT INTO DIRECTOR_MUSICAL
       (idDM, pasaporte, nombreCompleto, telefono, sexo, fechaNacimiento, fallecimiento, foto, fkLugar, detalleDireccion, invitado)
      VALUES 
       (ID.NEXTVAL, nroPasaporte, nombreCompleto, telefonos, sexo, fechaNacimiento, fallecimiento, EMPTY_BLOB(), fkLugar, detalleDireccion, invitadoDM)
      RETURN foto INTO l_blob;
      
    if archivoFoto IS NOT NULL THEN
    
      l_bfile := BFILENAME('FOTOSDM', archivoFoto);
      DBMS_LOB.fileopen(l_bfile, Dbms_Lob.File_Readonly);
      DBMS_LOB.loadfromfile(l_blob,l_bfile,DBMS_LOB.getlength(l_bfile));
      DBMS_LOB.fileclose(l_bfile);
      
    end if;
    
    INSERT INTO TRABAJADOR_CARGO
        (idTC, fechaInicio, sueldo, fkDM, fkCargo)
      VALUES 
       (seqTrabajadorCargo.NEXTVAL, fechaInicioCargo, sueldo, ID.NEXTVAL, 54);
      
    INSERT INTO NACIONALIDAD_DM
       (pkNacionalidad, pkDM)
      VALUES
       (nacionalidad, ID.NEXTVAL);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;

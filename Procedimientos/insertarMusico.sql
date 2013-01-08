CREATE OR REPLACE 
DIRECTORY FOTOSMUSICOS AS 'C:\BasesDeDatosII\fotos\fotosMusicos';
/
GRANT READ ON DIRECTORY FOTOSMUSICOS to PUBLIC;
/
create or replace PROCEDURE insertarMusico(nombreCompleto IN DATOS_PERSONALES, nroPasaporte IN NUMBER, telefonos IN TELEFONOS, sexo IN VARCHAR2, fechaNacimiento IN DATE, fallecimiento IN DATE, archivoFoto IN VARCHAR2, fkLugar IN NUMBER, detalleDireccion IN VARCHAR2, nacionalidad IN NUMBER, fechaInicioCargo IN DATE, sueldo IN NUMBER, idInstr IN NUMBER, instPpal IN NUMBER, fechaEjecucionInst IN NUMBER, invitado IN NUMBER) IS
l_bfile  BFILE;
l_blob   BLOB; 
CURSOR BUSQUEDA IS select seqMusico.NEXTVAL  from dual;
ID BUSQUEDA % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA LOOP

    validarTDA(nombreCompleto, telefonos);
          
      INSERT INTO MUSICO
       (idMusico, pasaporte, nombreCompleto, telefono, sexo, fechaNacimiento, fallecimiento, foto, fkLugar, detalleDireccion, invitado)
      VALUES 
       (ID.NEXTVAL, nroPasaporte, nombreCompleto, telefonos, sexo, fechaNacimiento, fallecimiento, EMPTY_BLOB(), fkLugar, detalleDireccion, invitado)
      RETURN foto INTO l_blob;
      
    if archivoFoto IS NOT NULL THEN
    
      l_bfile := BFILENAME('FOTOSMUSICOS', archivoFoto);
      DBMS_LOB.fileopen(l_bfile, Dbms_Lob.File_Readonly);
      DBMS_LOB.loadfromfile(l_blob,l_bfile,DBMS_LOB.getlength(l_bfile));
      DBMS_LOB.fileclose(l_bfile);
      
    end if;
    
    INSERT INTO TRABAJADOR_CARGO
        (idTC, fechaInicio, sueldo, fkMusico, fkCargo)
      VALUES 
       (seqTrabajadorCargo.NEXTVAL, fechaInicioCargo, sueldo, ID.NEXTVAL, 38);
      
    INSERT INTO NACIONALIDAD_MUSICO
       (pkNacionalidad, pkMusico)
      VALUES
       (nacionalidad, ID.NEXTVAL);
    
    INSERT INTO MUSICO_INSTRUMENTO
        (pkMusico, pkInstrumento, instrumentoPrincipal, fechaEjecucion)
    VALUES
        (ID.NEXTVAL, idInstr, instPpal, to_date(fechaEjecucionInst, 'dd/mm/yyyy'));
        
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;

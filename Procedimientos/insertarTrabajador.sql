create or replace PROCEDURE insertTrabajador(id IN NUMBER, nombreCompleto IN DATOS_PERSONALES, telefonos IN TELEFONOS, sexo IN VARCHAR2, fechaNacimiento IN DATE, fallecimiento IN DATE, archivoFoto IN VARCHAR2, fkLugar IN NUMBER, detalleDireccion IN VARCHAR2, nacionalidad IN NUMBER, cargo IN NUMBER, fechaInicioCargo IN DATE, sueldo IN NUMBER ) IS
l_bfile  BFILE;
l_blob   BLOB;
BEGIN

   validarTDA(nombreCompleto, telefonos);
   
  INSERT INTO TRABAJADOR
   (IDTRABAJADOR, NOMBRECOMPLETO, TELEFONO, SEXO, FECHANACIMIENTO, FALLECIMIENTO, FOTO, FKLUGAR, DETALLEDIRECCION)
  VALUES 
   (id, nombreCompleto , telefonos, sexo, fechaNacimiento, fallecimiento, EMPTY_BLOB(), fkLugar, detalleDireccion )
  RETURN foto INTO l_blob;

  l_bfile := BFILENAME('IMAGES', archivoFoto);
  DBMS_LOB.fileopen(l_bfile, Dbms_Lob.File_Readonly);
  DBMS_LOB.loadfromfile(l_blob,l_bfile,DBMS_LOB.getlength(l_bfile));
  DBMS_LOB.fileclose(l_bfile);


INSERT INTO TRABAJADOR_CARGO
    (IDTC, FECHAINICIO, SUELDO, FKTRABAJADOR, FKCARGO)
  VALUES 
   (seqTrabajadorCargo.NEXTVAL, fechaInicioCargo, sueldo, id, cargo);
  
INSERT INTO NACIONALIDAD_TRABAJADOR
   (PKNACIONALIDAD, PKTRABAJADOR)
  VALUES
   (nacionalidad, id);

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
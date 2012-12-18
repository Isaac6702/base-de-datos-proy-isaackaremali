CREATE OR REPLACE 
DIRECTORY IMAGES AS 'C:/BaseDeDatosII/imagenes/';

GRANT READ ON DIRECTORY IMAGES to PUBLIC;



create or replace PROCEDURE loadBlob(archivo IN VARCHAR2, id_tabla IN NUMBER) IS
  aux_bfile  BFILE;
  aux_blob   BLOB;
BEGIN
  UPDATE prueba
  SET
   foto = EMPTY_BLOB()
  WHERE
   id = id_tabla
  RETURN foto INTO aux_blob;

  aux_bfile := BFILENAME('IMAGES', archivo);
  DBMS_LOB.fileopen(aux_bfile, Dbms_Lob.File_Readonly);
  DBMS_LOB.loadfromfile(aux_blob,aux_bfile,DBMS_LOB.getlength(aux_bfile));
  DBMS_LOB.fileclose(aux_bfile);
  COMMIT;

END;

INSERT INTO prueba (id, foto) VALUES (2, empty_blob());

BEGIN
loadBlob('nat.jpg',1);
END;
/
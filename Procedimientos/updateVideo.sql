CREATE OR REPLACE 
DIRECTORY VIDEOS AS 'C:\BasesDeDatosII\videos';
/
GRANT READ ON DIRECTORY VIDEOS to PUBLIC;
/
create or replace PROCEDURE updateVideo (archivo IN VARCHAR2, id_tabla IN NUMBER) IS
  aux_bfile  BFILE;
  aux_blob   BLOB;
BEGIN
  UPDATE VIDEO
  SET
   CONTENIDO = EMPTY_BLOB()
  WHERE
   IDVIDEO = id_tabla
  RETURN CONTENIDO INTO aux_blob;

  aux_bfile := BFILENAME('VIDEOS', archivo);
  DBMS_LOB.fileopen(aux_bfile, Dbms_Lob.File_Readonly);
  DBMS_LOB.loadfromfile(aux_blob,aux_bfile,DBMS_LOB.getlength(aux_bfile));
  DBMS_LOB.fileclose(aux_bfile);
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
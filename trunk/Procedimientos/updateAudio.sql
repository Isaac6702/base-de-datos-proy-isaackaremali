CREATE OR REPLACE 
DIRECTORY AUDIO AS 'C:\BasesDeDatosII\audios';
/
GRANT READ ON DIRECTORY AUDIO to PUBLIC;
/
create or replace PROCEDURE updateAudio (archivo IN VARCHAR2, id_tabla IN NUMBER) IS
  aux_bfile  BFILE;
  aux_blob   BLOB;
BEGIN
  UPDATE AUDIO
  SET
   CONTENIDO = EMPTY_BLOB()
  WHERE
   IDAUDIO = id_tabla
  RETURN CONTENIDO INTO aux_blob;

  aux_bfile := BFILENAME('AUDIO', archivo);
  DBMS_LOB.fileopen(aux_bfile, Dbms_Lob.File_Readonly);
  DBMS_LOB.loadfromfile(aux_blob,aux_bfile,DBMS_LOB.getlength(aux_bfile));
  DBMS_LOB.fileclose(aux_bfile);
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
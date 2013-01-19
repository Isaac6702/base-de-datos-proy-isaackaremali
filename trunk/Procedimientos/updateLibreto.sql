CREATE OR REPLACE 
DIRECTORY LIBRETOS AS 'C:\BasesDeDatosII\Libretos';
/
GRANT READ ON DIRECTORY LIBRETOS to PUBLIC;
/
create or replace PROCEDURE updateLibretos (archivo IN VARCHAR2, id_tabla IN NUMBER) IS
  aux_bfile  BFILE;
  aux_blob   BLOB;
BEGIN
  UPDATE LIBRETO
  SET
   PDF = EMPTY_BLOB()
  WHERE
   IDLIBRETO = id_tabla
  RETURN PDF INTO aux_blob;

  aux_bfile := BFILENAME('LIBRETOS', archivo);
  DBMS_LOB.fileopen(aux_bfile, Dbms_Lob.File_Readonly);
  DBMS_LOB.loadfromfile(aux_blob,aux_bfile,DBMS_LOB.getlength(aux_bfile));
  DBMS_LOB.fileclose(aux_bfile);
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
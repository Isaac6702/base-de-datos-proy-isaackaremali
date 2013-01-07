create or replace PROCEDURE updateFotoBailarin (archivo IN VARCHAR2, id_tabla IN NUMBER) IS
  aux_bfile  BFILE;
  aux_blob   BLOB;
BEGIN
  UPDATE BAILARIN
  SET
   foto = EMPTY_BLOB()
  WHERE
   IDBAILARIN = id_tabla
  RETURN foto INTO aux_blob;

  aux_bfile := BFILENAME('FOTOSBAILARINES', archivo);
  DBMS_LOB.fileopen(aux_bfile, Dbms_Lob.File_Readonly);
  DBMS_LOB.loadfromfile(aux_blob,aux_bfile,DBMS_LOB.getlength(aux_bfile));
  DBMS_LOB.fileclose(aux_bfile);
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateFotoMusico (archivo IN VARCHAR2, id_tabla IN NUMBER) IS
  aux_bfile  BFILE;
  aux_blob   BLOB;
BEGIN
  UPDATE MUSICO
  SET
   foto = EMPTY_BLOB()
  WHERE
   IDMUSICO = id_tabla
  RETURN foto INTO aux_blob;

  aux_bfile := BFILENAME('FOTOSMUSICOS', archivo);
  DBMS_LOB.fileopen(aux_bfile, Dbms_Lob.File_Readonly);
  DBMS_LOB.loadfromfile(aux_blob,aux_bfile,DBMS_LOB.getlength(aux_bfile));
  DBMS_LOB.fileclose(aux_bfile);
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateFotoCantante (archivo IN VARCHAR2, id_tabla IN NUMBER) IS
  aux_bfile  BFILE;
  aux_blob   BLOB;
BEGIN
  UPDATE CANTANTE
  SET
   foto = EMPTY_BLOB()
  WHERE
   IDCANTANTE = id_tabla
  RETURN foto INTO aux_blob;

  aux_bfile := BFILENAME('FOTOSCANTANTE', archivo);
  DBMS_LOB.fileopen(aux_bfile, Dbms_Lob.File_Readonly);
  DBMS_LOB.loadfromfile(aux_blob,aux_bfile,DBMS_LOB.getlength(aux_bfile));
  DBMS_LOB.fileclose(aux_bfile);
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateFotoEscenografo (archivo IN VARCHAR2, id_tabla IN NUMBER) IS
  aux_bfile  BFILE;
  aux_blob   BLOB;
BEGIN
  UPDATE ESCENOGRAFO
  SET
   foto = EMPTY_BLOB()
  WHERE
   IDESCENOGRAFO = id_tabla
  RETURN foto INTO aux_blob;

  aux_bfile := BFILENAME('FOTOSESCENOGRAFO', archivo);
  DBMS_LOB.fileopen(aux_bfile, Dbms_Lob.File_Readonly);
  DBMS_LOB.loadfromfile(aux_blob,aux_bfile,DBMS_LOB.getlength(aux_bfile));
  DBMS_LOB.fileclose(aux_bfile);
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateFotoDM (archivo IN VARCHAR2, id_tabla IN NUMBER) IS
  aux_bfile  BFILE;
  aux_blob   BLOB;
BEGIN
  UPDATE DIRECTOR_MUSICAL
  SET
   foto = EMPTY_BLOB()
  WHERE
   IDDM = id_tabla
  RETURN foto INTO aux_blob;

  aux_bfile := BFILENAME('FOTOSDM', archivo);
  DBMS_LOB.fileopen(aux_bfile, Dbms_Lob.File_Readonly);
  DBMS_LOB.loadfromfile(aux_blob,aux_bfile,DBMS_LOB.getlength(aux_bfile));
  DBMS_LOB.fileclose(aux_bfile);
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateFotoCoreografo (archivo IN VARCHAR2, id_tabla IN NUMBER) IS
  aux_bfile  BFILE;
  aux_blob   BLOB;
BEGIN
  UPDATE COREOGRAFO
  SET
   FOTO = EMPTY_BLOB()
  WHERE
   IDCOREOGRAGO = id_tabla
  RETURN foto INTO aux_blob;

  aux_bfile := BFILENAME('FOTOSCOREOGRAFO', archivo);
  DBMS_LOB.fileopen(aux_bfile, Dbms_Lob.File_Readonly);
  DBMS_LOB.loadfromfile(aux_blob,aux_bfile,DBMS_LOB.getlength(aux_bfile));
  DBMS_LOB.fileclose(aux_bfile);
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateFotoDirector (archivo IN VARCHAR2, id_tabla IN NUMBER) IS
  aux_bfile  BFILE;
  aux_blob   BLOB;
BEGIN
  UPDATE DIRECTOR
  SET
   FOTO = EMPTY_BLOB()
  WHERE
   IDDIRECTOR = id_tabla
  RETURN foto INTO aux_blob;

  aux_bfile := BFILENAME('FOTOSDIRECTO', archivo);
  DBMS_LOB.fileopen(aux_bfile, Dbms_Lob.File_Readonly);
  DBMS_LOB.loadfromfile(aux_blob,aux_bfile,DBMS_LOB.getlength(aux_bfile));
  DBMS_LOB.fileclose(aux_bfile);
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateFotoDE(archivo IN VARCHAR2, id_tabla IN NUMBER) IS
  aux_bfile  BFILE;
  aux_blob   BLOB;
BEGIN
  UPDATE DIRECTOR_ESCENOGRAFIA
  SET
   FOTO = EMPTY_BLOB()
  WHERE
   IDDE = id_tabla
  RETURN foto INTO aux_blob;

  aux_bfile := BFILENAME('FOTOSDIRECTODE', archivo);
  DBMS_LOB.fileopen(aux_bfile, Dbms_Lob.File_Readonly);
  DBMS_LOB.loadfromfile(aux_blob,aux_bfile,DBMS_LOB.getlength(aux_bfile));
  DBMS_LOB.fileclose(aux_bfile);
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateFotoTrabajador(archivo IN VARCHAR2, id_tabla IN NUMBER) IS
  aux_bfile  BFILE;
  aux_blob   BLOB;
BEGIN
  UPDATE TRABAJADOR
  SET
   FOTO = EMPTY_BLOB()
  WHERE
   IDTRABAJADOR = id_tabla
  RETURN foto INTO aux_blob;

  aux_bfile := BFILENAME('FOTOSTRABAJADOR', archivo);
  DBMS_LOB.fileopen(aux_bfile, Dbms_Lob.File_Readonly);
  DBMS_LOB.loadfromfile(aux_blob,aux_bfile,DBMS_LOB.getlength(aux_bfile));
  DBMS_LOB.fileclose(aux_bfile);
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;


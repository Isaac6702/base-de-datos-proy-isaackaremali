create or replace PROCEDURE updateTelefBailarin (id_tabla IN NUMBER, telef IN TELEFONOS) IS

BEGIN
  UPDATE BAILARIN
  SET
   TELEFONO = telef
  WHERE
   IDBAILARIN = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateTelfMusico (id_tabla IN NUMBER, telef IN TELEFONOS) IS

BEGIN
  UPDATE MUSICO
  SET
   TELEFONO = telef
  WHERE
   IDMUSICO = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateTelefCantante (id_tabla IN NUMBER, telef IN TELEFONOS) IS

BEGIN
  UPDATE CANTANTE
  SET
   TELEFONO = telef
  WHERE
   IDCANTANTE = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateTelefEscenografo (id_tabla IN NUMBER, telef IN TELEFONOS) IS

BEGIN
  UPDATE ESCENOGRAFO
  SET
   TELEFONO = telef
  WHERE
   IDESCENOGRAFO = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateTelefDM (id_tabla IN NUMBER, telef IN TELEFONOS) IS

BEGIN
  UPDATE DIRECTOR_MUSICAL
  SET
   TELEFONO = telef
  WHERE
   IDDM = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;


create or replace PROCEDURE updateTelfCoreografo (id_tabla IN NUMBER, telef IN TELEFONOS) IS

BEGIN
  UPDATE COREOGRAFO
  SET
   TELEFONO = telef
  WHERE
   IDCOREOGRAFO = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateTelefDirector (id_tabla IN NUMBER, telef IN TELEFONOS) IS

BEGIN
  UPDATE DIRECTOR
  SET
   TELEFONO = telef
  WHERE
   IDDIRECTOR = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;


create or replace PROCEDURE updateTelefDE(id_tabla IN NUMBER, telef IN TELEFONOS) IS

BEGIN
  UPDATE DIRECTOR_ESCENOGRAFO
  SET
   TELEFONO = telef
  WHERE
   IDDE = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateTelefTrabajador(id_tabla IN NUMBER, telef IN TELEFONOS) IS

BEGIN
  UPDATE TRABAJADOR
  SET
   TELEFONO = telef
  WHERE
   IDTRABAJADOR = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
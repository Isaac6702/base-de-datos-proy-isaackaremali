create or replace PROCEDURE updateDireccionBailarin (id_tabla IN NUMBER, idlugar IN NUMBER, detalle IN varchar2) IS

BEGIN
  UPDATE BAILARIN
  SET
   fklugar = idlugar, DETALLEDIRECCION = detalle
  WHERE
   IDBAILARIN = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateDireccionMusico (id_tabla IN NUMBER, idlugar IN NUMBER, detalle IN varchar2) IS

BEGIN
  UPDATE MUSICO
  SET
   fklugar = idlugar, DETALLEDIRECCION = detalle
  WHERE
   IDMUSICO = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateDireccionCantante (id_tabla IN NUMBER, idlugar IN NUMBER, detalle IN varchar2) IS

BEGIN
  UPDATE CANTANTE
  SET
   fklugar = idlugar, DETALLEDIRECCION = detalle
  WHERE
   IDCANTANTE = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateDireccionEscenografo (id_tabla IN NUMBER, idlugar IN NUMBER, detalle IN varchar2) IS

BEGIN
  UPDATE ESCENOGRAFO
  SET
   fklugar = idlugar, DETALLEDIRECCION = detalle
  WHERE
   IDESCENOGRAFO = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateDireccionDM (id_tabla IN NUMBER, idlugar IN NUMBER, detalle IN varchar2) IS

BEGIN
  UPDATE DIRECTO_MUSICAL
  SET
   fklugar = idlugar, DETALLEDIRECCION = detalle
  WHERE
   IDDM = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;


create or replace PROCEDURE updateDireccionCoreografo (id_tabla IN NUMBER, idlugar IN NUMBER, detalle IN varchar2) IS

BEGIN
  UPDATE COREOGRAFO
  SET
   fklugar = idlugar, DETALLEDIRECCION = detalle
  WHERE
   IDCOREOGRAFO = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateDireccionDirector (id_tabla IN NUMBER, idlugar IN NUMBER, detalle IN varchar2) IS

BEGIN
  UPDATE DIRECTOR
  SET
   fklugar = idlugar, DETALLEDIRECCION = detalle
  WHERE
   IDDIRECTOR = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateDireccionDE(id_tabla IN NUMBER, idlugar IN NUMBER, detalle IN varchar2) IS

BEGIN
  UPDATE DIRECTOR_ESCENOGRAFia
  SET
   fklugar = idlugar, DETALLEDIRECCION = detalle
  WHERE
   IDDE = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE updateDireccionTrabajador(id_tabla IN NUMBER, idlugar IN NUMBER, detalle IN varchar2) IS

BEGIN
  UPDATE TRABAJADOR
  SET
   fklugar = idlugar, DETALLEDIRECCION = detalle
  WHERE
   IDTRABAJADOR = id_tabla;
   
  COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
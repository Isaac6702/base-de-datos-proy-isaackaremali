create or replace PROCEDURE insertarEstudioAutor(autor IN NUMBER, institucion IN NUMBER, estudio IN VARCHAR2, fechaInicio IN DATE, fechaFin IN DATE) IS

CURSOR BUSQUEDA_ESTUDIO IS select seqInstitucion.NEXTVAL  from dual;
ID BUSQUEDA_ESTUDIO % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA_ESTUDIO LOOP
          
    INSERT INTO ESTUDIO
        (idEstudio, descripcion, fechaInicio, fechaFin, fkInstitucion, fkAutor)
    VALUES
        (seqEstudio.NEXTVAL, estudio, to_date(fechaInicio, 'dd/mm/yyyy'), to_date(fechaFin, 'dd/mm/yyyy'), institucion, autor);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE insertarEstudioTrabajador(trabajador IN NUMBER, institucion IN NUMBER, estudio IN VARCHAR2, fechaInicio IN DATE, fechaFin IN DATE) IS

CURSOR BUSQUEDA_ESTUDIO IS select seqInstitucion.NEXTVAL  from dual;
ID BUSQUEDA_ESTUDIO % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA_ESTUDIO LOOP
          
    INSERT INTO ESTUDIO
        (idEstudio, descripcion, fechaInicio, fechaFin, fkTrabajador, fkInstitucion)
    VALUES
        (seqEstudio.NEXTVAL, estudio, to_date(fechaInicio, 'dd/mm/yyyy'), to_date(fechaFin, 'dd/mm/yyyy'), trabajador, institucion);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE insertarEstudioMusico(musico IN NUMBER, institucion IN NUMBER, estudio IN VARCHAR2, fechaInicio IN DATE, fechaFin IN DATE) IS

CURSOR BUSQUEDA_ESTUDIO IS select seqInstitucion.NEXTVAL  from dual;
ID BUSQUEDA_ESTUDIO % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA_ESTUDIO LOOP
          
    INSERT INTO ESTUDIO
        (idEstudio, descripcion, fechaInicio, fechaFin, fkMusico, fkInstitucion)
    VALUES
        (seqEstudio.NEXTVAL, estudio, to_date(fechaInicio, 'dd/mm/yyyy'), to_date(fechaFin, 'dd/mm/yyyy'), musico, institucion);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE insertarEstudioBailarin(bailarin IN NUMBER, institucion IN NUMBER, estudio IN VARCHAR2, fechaInicio IN DATE, fechaFin IN DATE) IS

CURSOR BUSQUEDA_ESTUDIO IS select seqInstitucion.NEXTVAL  from dual;
ID BUSQUEDA_ESTUDIO % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA_ESTUDIO LOOP
          
    INSERT INTO ESTUDIO
        (idEstudio, descripcion, fechaInicio, fechaFin, fkBailarin, fkInstitucion)
    VALUES
        (seqEstudio.NEXTVAL, estudio, to_date(fechaInicio, 'dd/mm/yyyy'), to_date(fechaFin, 'dd/mm/yyyy'), bailarin, institucion);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE insertarEstudioCantante(cantante IN NUMBER, institucion IN NUMBER, estudio IN VARCHAR2, fechaInicio IN DATE, fechaFin IN DATE) IS

CURSOR BUSQUEDA_ESTUDIO IS select seqInstitucion.NEXTVAL  from dual;
ID BUSQUEDA_ESTUDIO % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA_ESTUDIO LOOP
          
    INSERT INTO ESTUDIO
        (idEstudio, descripcion, fechaInicio, fechaFin, fkCantante, fkInstitucion)
    VALUES
        (seqEstudio.NEXTVAL, estudio, to_date(fechaInicio, 'dd/mm/yyyy'), to_date(fechaFin, 'dd/mm/yyyy'), cantante, institucion);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE insertarEstudioEscenografo(escenografo IN NUMBER, institucion IN NUMBER, estudio IN VARCHAR2, fechaInicio IN DATE, fechaFin IN DATE) IS

CURSOR BUSQUEDA_ESTUDIO IS select seqInstitucion.NEXTVAL  from dual;
ID BUSQUEDA_ESTUDIO % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA_ESTUDIO LOOP
          
    INSERT INTO ESTUDIO
        (idEstudio, descripcion, fechaInicio, fechaFin, fkEscenografo, fkInstitucion)
    VALUES
        (seqEstudio.NEXTVAL, estudio, to_date(fechaInicio, 'dd/mm/yyyy'), to_date(fechaFin, 'dd/mm/yyyy'), escenografo, institucion);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE insertarEstudioDE(de IN NUMBER, institucion IN NUMBER, estudio IN VARCHAR2, fechaInicio IN DATE, fechaFin IN DATE) IS

CURSOR BUSQUEDA_ESTUDIO IS select seqInstitucion.NEXTVAL  from dual;
ID BUSQUEDA_ESTUDIO % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA_ESTUDIO LOOP
          
    INSERT INTO ESTUDIO
        (idEstudio, descripcion, fechaInicio, fechaFin, fkDirectorEscenografia, fkInstitucion)
    VALUES
        (seqEstudio.NEXTVAL, estudio, to_date(fechaInicio, 'dd/mm/yyyy'), to_date(fechaFin, 'dd/mm/yyyy'), de, institucion);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE insertarEstudioCoreografo(coreografo IN NUMBER, institucion IN NUMBER, estudio IN VARCHAR2, fechaInicio IN DATE, fechaFin IN DATE) IS

CURSOR BUSQUEDA_ESTUDIO IS select seqInstitucion.NEXTVAL  from dual;
ID BUSQUEDA_ESTUDIO % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA_ESTUDIO LOOP
          
    INSERT INTO ESTUDIO
        (idEstudio, descripcion, fechaInicio, fechaFin, fkCoreografo, fkInstitucion)
    VALUES
        (seqEstudio.NEXTVAL, estudio, to_date(fechaInicio, 'dd/mm/yyyy'), to_date(fechaFin, 'dd/mm/yyyy'), coreografo, institucion);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE insertarEstudioDirector(director IN NUMBER, institucion IN NUMBER, estudio IN VARCHAR2, fechaInicio IN DATE, fechaFin IN DATE) IS

CURSOR BUSQUEDA_ESTUDIO IS select seqInstitucion.NEXTVAL  from dual;
ID BUSQUEDA_ESTUDIO % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA_ESTUDIO LOOP
          
    INSERT INTO ESTUDIO
        (idEstudio, descripcion, fechaInicio, fechaFin, fkDirector, fkInstitucion)
    VALUES
        (seqEstudio.NEXTVAL, estudio, to_date(fechaInicio, 'dd/mm/yyyy'), to_date(fechaFin, 'dd/mm/yyyy'), director, institucion);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE insertarEstudioDM(dm IN NUMBER, institucion IN NUMBER, estudio IN VARCHAR2, fechaInicio IN DATE, fechaFin IN DATE) IS

CURSOR BUSQUEDA_ESTUDIO IS select seqInstitucion.NEXTVAL  from dual;
ID BUSQUEDA_ESTUDIO % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA_ESTUDIO LOOP
          
    INSERT INTO ESTUDIO
        (idEstudio, descripcion, fechaInicio, fechaFin, fkDM, fkInstitucion)
    VALUES
        (seqEstudio.NEXTVAL, estudio, to_date(fechaInicio, 'dd/mm/yyyy'), to_date(fechaFin, 'dd/mm/yyyy'), dm, institucion);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE insertarEstudioInvitado(invitado IN NUMBER, institucion IN NUMBER, estudio IN VARCHAR2, fechaInicio IN DATE, fechaFin IN DATE) IS

CURSOR BUSQUEDA_ESTUDIO IS select seqInstitucion.NEXTVAL  from dual;
ID BUSQUEDA_ESTUDIO % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA_ESTUDIO LOOP
          
    INSERT INTO ESTUDIO
        (idEstudio, descripcion, fechaInicio, fechaFin, fkInvitado, fkInstitucion)
    VALUES
        (seqEstudio.NEXTVAL, estudio, to_date(fechaInicio, 'dd/mm/yyyy'), to_date(fechaFin, 'dd/mm/yyyy'), invitado, institucion);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
  
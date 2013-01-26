CREATE OR REPLACE function consultar_telefonos (tl telefonos)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(500);
BEGIN

    IF tl  IS NOT NULL THEN
        FOR i IN 1..tl.COUNT LOOP
                IF i=1 then
                RESULTADO:= tl (i).codigo|| tl (i).numero;
                end if;
                IF i>1 then
                RESULTADO:= RESULTADO || ', ' ||tl (i).codigo || tl (i).numero;
                end if;
END LOOP;
    END IF;
    IF tl  IS NULL THEN
    RESULTADO:='';
    END IF;

RETURN (RESULTADO);
END;
/
create or replace PROCEDURE validarTDA(nombreCompleto IN DATOS_PERSONALES, telefonos IN TELEFONOS ) IS
BEGIN

if nombreCompleto.primerNombre is  null then
    
      RAISE_APPLICATION_ERROR(-20000,'Debe introducir al menos el Primer nombre');
    end if;
    
    if telefonos is null then
    
      RAISE_APPLICATION_ERROR(-20000,'Debe introducir al menos un numero de telefono');
    end if;
    
    if nombreCompleto.primerNombre is  null  then
    
      RAISE_APPLICATION_ERROR(-20000,'Debe introducir al menos el Primer nombre');
    end if;
    
END;
/
create or replace PROCEDURE validarNacionalidad(sexoPersona IN VARCHAR2, nacionalidad IN NUMBER) IS
CURSOR VALIDAR_SEXO IS select sexo from NACIONALIDAD where idNacionalidad = nacionalidad;
sexoNac VALIDAR_SEXO % ROWTYPE;
BEGIN
if sexoPersona='f' or sexoPersona='m' or sexoPersona='a' then
    for SEXONAC IN VALIDAR_SEXO LOOP
        if sexoPersona <> sexoNac.SEXO then
            RAISE_APPLICATION_ERROR(-20000,'Debe introducir un sexo valido a su nacionalidad');
        end if;
    END LOOP;
else
    RAISE_APPLICATION_ERROR(-20000,'Debe introducir un sexo valido');
end if;    
END;
/
create or replace PROCEDURE validarFechaFin(fechaInicio IN DATE, fechaFin IN DATE) IS

BEGIN
if fechaFin < fechaInicio then
    RAISE_APPLICATION_ERROR(-20000,'La fecha de fin debe ser mayor a la fecha de inicio');
end if;    
END;
/
create or replace PROCEDURE agregarInstrumentoMusico (musico IN NUMBER, instrumento IN NUMBER, ppal IN NUMBER, fecha IN DATE) IS
BEGIN
    INSERT INTO MUSICO_INSTRUMENTO
    (pkMusico, pkInstrumento, instrumentoPrincipal, fechaEjecucion)
    VALUES
    (musico, instrumento, ppal, to_date(fecha, 'dd/mm/yyyy'));
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
/
create or replace PROCEDURE agregarOrquestaDM (dm IN NUMBER, orquesta IN NUMBER, fechaInicio IN DATE, fechaFin IN DATE) IS
BEGIN
    INSERT INTO DM_ORQUESTA
        (pkDM, pkOrquesta, fechaInicio, fechaFin)
    VALUES
        (dm, orquesta, to_date(fechaInicio, 'dd/mm/yyyy'), to_date(fechaFin, 'dd/mm/yyyy'));
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
/
create or replace PROCEDURE agregarOrquestaMusico (musico IN NUMBER, orquesta IN NUMBER, fechaInicio IN DATE, fechaFin IN DATE, posicion VARCHAR2) IS
BEGIN
    INSERT INTO MUSICO_ORQUESTA
        (pkMusico, pkOrquesta, fechaInicio, fechaFin, posicion)
    VALUES
        (musico, orquesta, to_date(fechaInicio, 'dd/mm/yyyy'), to_date(fechaFin, 'dd/mm/yyyy'), posicion);
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;    
/
create or replace PROCEDURE agregarVozCantante (voz IN NUMBER, cantante IN NUMBER) IS
BEGIN
    INSERT INTO CANTANTE_VOZ
        (pkVoz, pkCantante)
    VALUES
        (voz, cantante);
        
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
CREATE OR REPLACE FUNCTION antiguedad(fec_inicio IN date) RETURN VARCHAR2
AS
anos number;
meses number;
dias number;
antiguedad varchar2(40);
BEGIN
SELECT floor(months_between(sysdate, fec_inicio )/12) INTO anos FROM dual;
SELECT floor(mod(months_between(sysdate, fec_inicio ),12)) INTO meses FROM dual;
SELECT floor(
         (mod(months_between(sysdate, fec_inicio) ,12)
          - floor(mod(months_between(sysdate, fec_inicio ),12)))*30
            ) INTO dias FROM dual;
            
    if anos > 0 THEN
        antiguedad:= antiguedad ||' '||anos||' anos ';
    end if;
    if meses > 0 THEN
        antiguedad:= antiguedad ||' '||meses||' meses ';
    end if;
    if dias  > 0 THEN
        antiguedad:= antiguedad ||' '||dias||' d’as ';
    end if;
    
    if antiguedad is null then
        antiguedad := 0 ||' d’as ';
    end if;
RETURN antiguedad;
END;
/
create or replace function Bailarini_obras (idbailarin IN NUMBER) RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select o.nombre nombre from bailarin_ballet bb, ballet b, obra o where bb.pkballet = b.idballet
                    AND bb.pkbailarin = idbailarin AND b.idballet = o.fkballet; AUX BUSQUEDA % ROWTYPE;
BEGIN
FOR AUX IN BUSQUEDA LOOP
    if AUX.nombre is not null then
        RESULTADO := AUX.nombre||'. '||RESULTADO;
    else RESULTADO:=null;
    END IF;
END LOOP;
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE function ballet_anteriores (idBailarin IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select bl.nombre balletAnteriores 
from Bailarin_ballet bb, ballet bl
where bb.PKBAILARIN =idBailarin and bb.PKBALLET = bl.IDBALLET and bb.fechafin is not null;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := AUX.BALLETANTERIORES|| ' , ' ||RESULTADO;
END LOOP;
    
RETURN (RESULTADO);
END;
/
create or replace PROCEDURE cancelarReservas IS

CURSOR BUSQUEDA IS select r.idreserva, r.fecha fechareserva, fp.fecha fechapresentacion, e.identrada 
from reserva r, detalle_reserva dr, entrada e, fecha_presentacion fp
where dr.PKRESERVA = r.idreserva AND dr.PKENTRADA = e.identrada AND e.FKPRESENTACION = fp.idfp AND dr.status=1;

AUX BUSQUEDA % ROWTYPE;
diasPasados number;
BEGIN

FOR AUX IN BUSQUEDA LOOP
    
    diasPasados := to_Date(AUX.FECHAPRESENTACION,'dd/mm/yy') - to_Date(AUX.FECHARESERVA,'dd/mm/yy');
    IF diasPasados < 20 THEN
        dbms_output.put_line('fue cancelada la reserva n¼ ' || AUX.IDRESERVA);
        update DETALLE_RESERVA
            set status = 'c'
            where PKRESERVA = AUX.IDRESERVA AND PKENTRADA = AUX.IDENTRADA ;
        
        
    END IF;

END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/

CREATE OR REPLACE function consultar_obras_m(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select o.nombre obra
                    from musico m, fecha_presentacion fp, musico_obra mo, obra o
                    where  fp.idfp = mo.pkpresentacion AND mo.pkmusico = m.idmusico AND m.idmusico = id AND fp.fkobra = o.idobra  ;
AUX  BUSQUEDA % ROWTYPE;
BEGIN
FOR AUX IN BUSQUEDA LOOP
    if AUX.obra is not null then
        RESULTADO := 'Posicion: '||AUX.obra||' . ';
    else
        RESULTADO:=null;
    END IF;
END LOOP;
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE function consultar_direccion (fkDireccion IN NUMBER, detalleDireccion IN VARCHAR2)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select p.nombre pais, e.nombre estado, c.nombre ciudad from lugar p, lugar c, lugar e where p.idlugar = e.fklugar and e.idlugar = c.fklugar and e.idlugar = fkDireccion;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP

     RESULTADO := 'Pais: '||AUX.PAIS ||' , Estado: '|| AUX.ESTADO ||' , Ciudad: '|| AUX.CIUDAD ||' , Detalle: '||detalleDireccion;

END LOOP;
    
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE function consultar_obras_DM(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select o.nombre obra
                    from director_musical dm, obra o
                    where  o.FKDM = dm.iddm AND dm.iddm = id ;
AUX  BUSQUEDA % ROWTYPE;

BEGIN

FOR AUX IN BUSQUEDA LOOP
    if AUX.obra is not null then
        RESULTADO :=AUX.OBRA||' , '|| RESULTADO;
    else
        RESULTADO:=null;
    END IF;
END LOOP;
    
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE function nombres (tda DATOS_PERSONALES)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BEGIN

    IF tda.primerNombre IS NOT NULL THEN
        
        RESULTADO := tda.primerNombre;
        
    END IF;
     IF tda.segundoNombre IS NOT NULL THEN
        
        RESULTADO := RESULTADO || ' '|| tda.segundoNombre; 
        
    END IF;
    
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE function apellidos (tda DATOS_PERSONALES)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BEGIN

    IF tda.primerApellido IS NOT NULL THEN
        
        RESULTADO := tda.primerApellido;
        
    END IF;
    
    IF tda.segundoApellido IS NOT NULL THEN
        
        RESULTADO := RESULTADO || ' '|| tda.segundoApellido;
        
    END IF;
    
    
RETURN (RESULTADO);
END;
/
create or replace PROCEDURE despedirTrabajador (trabajador IN NUMBER, cargo IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkTrabajador = trabajador AND fkCargo = cargo;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
create or replace PROCEDURE despedirMusico (musico IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkMusico = musico;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
create or replace PROCEDURE despedirBailarin (bailarin IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkBailarin = bailarin;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
create or replace PROCEDURE despedirCantante (cantante IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkCantante = cantante;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
create or replace PROCEDURE despedirEscenografo (escenografo IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkEscenografo = escenografo;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
create or replace PROCEDURE despedirAutor (autor IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkAutor = autor;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
create or replace PROCEDURE despedirDE (de IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkDirectorEscenografia = de;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
create or replace PROCEDURE despedirCoreografo (coreografo IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkCoreografo = coreografo;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
create or replace PROCEDURE despedirDirector (director IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkDirector = director;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
create or replace PROCEDURE despedirDM (dm IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkDM = dm;
COMMIT;
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
create or replace PROCEDURE despedirInvitado(invitado IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkInvitado = invitado;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
 /
 CREATE OR REPLACE function entradas_restantes (totalEntradas in NUMBER, idZona in NUMBER, idOpera in NUMBER )
RETURN NUMBER IS

RESULTADO NUMBER;

CURSOR BUSQUEDA IS 
select COUNT(e.idEntrada) cantidadAsientos, z.nombre zona, z.idubicacion idzona, o.nombre opera 
from entrada e, ubicacion a, ubicacion z, fecha_presentacion fp, obra o 
where e.fkubicacion = a.idubicacion AND e.pagada = 1 AND a.fkubicacion = z.idubicacion AND fp.fkobra = o.idobra AND e.fkpresentacion = fp.idfp AND z.idubicacion = idZona and o.idobra = idOpera
GROUP BY z.nombre, z.idubicacion, o.nombre;  

AUX  BUSQUEDA % ROWTYPE;

BEGIN

RESULTADO := totalEntradas ;

FOR AUX IN BUSQUEDA LOOP

    if AUX.CANTIDADASIENTOS is not null then
        RESULTADO := totalEntradas - AUX.CANTIDADASIENTOS;
    END if;

END LOOP;
 
RETURN (RESULTADO );
END;
/
CREATE OR REPLACE function estudios_bailarin (idBailarin IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select i.nombre institucion, e.DESCRIPCION  
                    from estudio e, institucion i
                    where e.FKINSTITUCION = i.IDINSTITUCION AND e.FKBAILARIN = idBailarin;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := 'Institucion: '||AUX.institucion|| ' , Estudio: ' ||AUX.DESCRIPCION||'. ';
END LOOP;
    
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE function estudios_cantante (idcantante IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select i.nombre institucion, e.DESCRIPCION  
                    from estudio e, institucion i
                    where e.FKINSTITUCION = i.IDINSTITUCION AND e.FKCANTANTE = idcantante;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := 'Institucion: '||AUX.institucion|| ' , Estudio: ' ||AUX.DESCRIPCION||'. ';
END LOOP;
    
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE function estudios_director (iddirector IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select i.nombre institucion, e.DESCRIPCION  
                    from estudio e, institucion i
                    where e.FKINSTITUCION = i.IDINSTITUCION AND e.FKDIRECTOR = iddirector;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := 'Institucion: '||AUX.institucion|| ' , Estudio: ' ||AUX.DESCRIPCION||'. ';
END LOOP;
    
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE function estudios_musico (idmusico IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select i.nombre institucion, e.DESCRIPCION  
                    from estudio e, institucion i
                    where e.FKINSTITUCION = i.IDINSTITUCION AND e.FKmusico = idmusico;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := 'Institucion: '||AUX.institucion|| ' , Estudio: ' ||AUX.DESCRIPCION||'. ';
END LOOP;
    
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE 
DIRECTORY FOTOSAUTORES AS 'C:\BasesDeDatosII\fotos\fotosAutores';
/
GRANT READ ON DIRECTORY FOTOSAUTORES to PUBLIC;
/
create or replace PROCEDURE insertarAutor(nombreCompleto IN DATOS_PERSONALES, nroPasaporte IN NUMBER, telefonos IN TELEFONOS, sexo IN VARCHAR2, fechaNacimiento IN DATE, fallecimiento IN DATE, archivoFoto IN VARCHAR2, fkLugar IN NUMBER, detalleDireccion IN VARCHAR2, nacionalidad IN NUMBER, fechaInicioCargo IN DATE, sueldo IN NUMBER, idInst IN NUMBER, estudio IN NUMBER, fechaInicioEst IN DATE, fechaFinEst IN DATE, invitado IN NUMBER) IS
l_bfile  BFILE;
l_blob   BLOB; 
CURSOR BUSQUEDA IS select seqAutor.NEXTVAL  from dual;
ID BUSQUEDA % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA LOOP

    validarTDA(nombreCompleto, telefonos);
          
      INSERT INTO AUTOR
       (idAutor, pasaporte, nombreCompleto, telefono, sexo, fechaNacimiento, fallecimiento, foto, fkLugar, detalleDireccion, invitado)
      VALUES 
       (ID.NEXTVAL, nroPasaporte, nombreCompleto, telefonos, sexo, fechaNacimiento, fallecimiento, EMPTY_BLOB(), fkLugar, detalleDireccion, invitado)
      RETURN foto INTO l_blob;
      
    if archivoFoto IS NOT NULL THEN
    
      l_bfile := BFILENAME('FOTOSAUTORES', archivoFoto);
      DBMS_LOB.fileopen(l_bfile, Dbms_Lob.File_Readonly);
      DBMS_LOB.loadfromfile(l_blob,l_bfile,DBMS_LOB.getlength(l_bfile));
      DBMS_LOB.fileclose(l_bfile);
      
    end if;
    
    INSERT INTO TRABAJADOR_CARGO
        (idTC, fechaInicio, sueldo, fkAutor, fkCargo)
      VALUES 
       (seqTrabajadorCargo.NEXTVAL, fechaInicioCargo, sueldo, ID.NEXTVAL, 54);
      
    INSERT INTO NACIONALIDAD_AUTOR
       (pkNacionalidad, pkAutor)
      VALUES
       (nacionalidad, ID.NEXTVAL);
   
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
/
CREATE OR REPLACE 
DIRECTORY FOTOSBAILARINES AS 'C:\BasesDeDatosII\fotos\fotosBailarines';
/
GRANT READ ON DIRECTORY FOTOSBAILARINES to PUBLIC;
/
create or replace PROCEDURE insertBailarin(pasaporte IN NUMBER, invitado IN NUMBER,nombreCompleto IN DATOS_PERSONALES, telefonos IN TELEFONOS, sexo IN VARCHAR2, fechaNacimiento IN DATE, fallecimiento IN DATE, archivoFoto IN VARCHAR2, fkLugar IN NUMBER, detalleDireccion IN VARCHAR2, nacionalidad IN NUMBER, fechaInicioCargo IN DATE, sueldo IN NUMBER ) IS
l_bfile  BFILE;
l_blob   BLOB; 
CURSOR BUSQUEDA IS select seqbailarin.NEXTVAL  from dual;
ID BUSQUEDA % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA LOOP

    validarTDA(nombreCompleto, telefonos);
    validarNacionalidad(sexo, nacionalidad);      
      INSERT INTO BAILARIN
       (IDBAILARIN, PASAPORTE, INVITADO,NOMBRECOMPLETO, TELEFONO, SEXO, FECHANACIMIENTO, FALLECIMIENTO, FOTO, FKLUGAR, DETALLEDIRECCION)
      VALUES 
       (ID.NEXTVAL, pasaporte, invitado,nombreCompleto , telefonos, sexo, fechaNacimiento, fallecimiento, EMPTY_BLOB(), fkLugar, detalleDireccion )
      RETURN foto INTO l_blob;
      
    if archivoFoto IS NOT NULL THEN
    
      l_bfile := BFILENAME('FOTOSBAILARINES', archivoFoto);
      DBMS_LOB.fileopen(l_bfile, Dbms_Lob.File_Readonly);
      DBMS_LOB.loadfromfile(l_blob,l_bfile,DBMS_LOB.getlength(l_bfile));
      DBMS_LOB.fileclose(l_bfile);
      
    end if;
    
    INSERT INTO TRABAJADOR_CARGO
        (IDTC, FECHAINICIO, SUELDO, FKBAILARIN, FKCARGO)
      VALUES 
       (seqTrabajadorCargo.NEXTVAL, fechaInicioCargo, sueldo, ID.NEXTVAL, 43);
      
    INSERT INTO NACIONALIDAD_BAILARIN
       (PKNACIONALIDAD, PKBAILARIN)
      VALUES
       (nacionalidad, ID.NEXTVAL);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
/
create or replace PROCEDURE insertarCargo(nombre IN VARCHAR2, tipoAscenso IN VARCHAR2, departamento IN NUMBER, jefe IN NUMBER) IS
BEGIN
    INSERT INTO CARGO
        (idCargo, nombre, tipoAscenso, fkDepartamento, fkJefe)
    VALUES
        (seqCargo.NEXTVAL, lower(nombre), lower(tipoAscenso), departamento, jefe);
COMMIT;
    
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;  
/
create or replace PROCEDURE insertarCargo(nombre IN VARCHAR2, tipoAscenso IN VARCHAR2, departamento IN NUMBER, jefe IN NUMBER) IS
BEGIN
    INSERT INTO CARGO
        (idCargo, nombre, tipoAscenso, fkDepartamento, fkJefe)
    VALUES
        (seqCargo.NEXTVAL, lower(nombre), lower(tipoAscenso), departamento, jefe);
COMMIT;
    
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;  
/
CREATE OR REPLACE 
DIRECTORY FOTOSDM AS 'C:\BasesDeDatosII\fotos\fotosDM';
/
GRANT READ ON DIRECTORY FOTOSDM to PUBLIC;
/
create or replace PROCEDURE insertDM(nroPasaporte IN NUMBER, invitadoDM IN NUMBER, nombreCompleto IN DATOS_PERSONALES, telefonos IN TELEFONOS, sexo IN VARCHAR2, fechaNacimiento IN DATE, fallecimiento IN DATE, archivoFoto IN VARCHAR2, fkLugar IN NUMBER, detalleDireccion IN VARCHAR2, nacionalidad IN NUMBER, fechaInicioCargo IN DATE, sueldo IN NUMBER) IS
l_bfile  BFILE;
l_blob   BLOB; 
CURSOR BUSQUEDA IS select seqDirectorMusical.NEXTVAL  from dual;
ID BUSQUEDA % ROWTYPE;

CURSOR BUSQUEDA_ESTUDIO IS select seqEstudio.NEXTVAL  from dual;
ID_ESTUDIO BUSQUEDA_ESTUDIO % ROWTYPE;
BEGIN
FOR ID IN BUSQUEDA LOOP

    validarTDA(nombreCompleto, telefonos);
    validarNacionalidad(sexo, nacionalidad); 
          
      INSERT INTO DIRECTOR_MUSICAL
       (idDM, pasaporte, nombreCompleto, telefono, sexo, fechaNacimiento, fallecimiento, foto, fkLugar, detalleDireccion, invitado)
      VALUES 
       (ID.NEXTVAL, nroPasaporte, nombreCompleto, telefonos, sexo, fechaNacimiento, fallecimiento, EMPTY_BLOB(), fkLugar, detalleDireccion, invitadoDM)
      RETURN foto INTO l_blob;
      
    if archivoFoto IS NOT NULL THEN
    
      l_bfile := BFILENAME('FOTOSDM', archivoFoto);
      DBMS_LOB.fileopen(l_bfile, Dbms_Lob.File_Readonly);
      DBMS_LOB.loadfromfile(l_blob,l_bfile,DBMS_LOB.getlength(l_bfile));
      DBMS_LOB.fileclose(l_bfile);
      
    end if;
    
    INSERT INTO TRABAJADOR_CARGO
        (idTC, fechaInicio, sueldo, fkDM, fkCargo)
      VALUES 
       (seqTrabajadorCargo.NEXTVAL, fechaInicioCargo, sueldo, ID.NEXTVAL, 54);
      
    INSERT INTO NACIONALIDAD_DM
       (pkNacionalidad, pkDM)
      VALUES
       (nacionalidad, ID.NEXTVAL);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
/
CREATE OR REPLACE 
DIRECTORY FOTOSESCENOGRAFO AS 'C:\BasesDeDatosII\fotos\fotosEscenografo';
/
GRANT READ ON DIRECTORY FOTOSESCENOGRAFO to PUBLIC;
/
create or replace PROCEDURE insertEscenografo(pasaporte IN NUMBER, invitado IN NUMBER, nombreCompleto IN DATOS_PERSONALES, telefonos IN TELEFONOS, sexo IN VARCHAR2, fechaNacimiento IN DATE, fallecimiento IN DATE, archivoFoto IN VARCHAR2, fkLugar IN NUMBER, detalleDireccion IN VARCHAR2, nacionalidad IN NUMBER, fechaInicioCargo IN DATE, sueldo IN NUMBER ) IS
l_bfile  BFILE;
l_blob   BLOB; 
CURSOR BUSQUEDA IS select seqEscenografo.NEXTVAL  from dual;
ID BUSQUEDA % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA LOOP

    validarTDA(nombreCompleto, telefonos);
    validarNacionalidad(sexo, nacionalidad);
          
      INSERT INTO ESCENOGRAFO
       (IDESCENOGRAFO, PASAPORTE, INVITADO, NOMBRECOMPLETO, TELEFONO, SEXO, FECHANACIMIENTO, FALLECIMIENTO, FOTO, FKLUGAR, DETALLEDIRECCION)
      VALUES 
       (ID.NEXTVAL, pasaporte, invitado, nombreCompleto , telefonos, sexo, fechaNacimiento, fallecimiento, EMPTY_BLOB(), fkLugar, detalleDireccion )
      RETURN foto INTO l_blob;
    
    if archivoFoto IS NOT NULL THEN
      l_bfile := BFILENAME('FOTOSESCENOGRAFO', archivoFoto);
      DBMS_LOB.fileopen(l_bfile, Dbms_Lob.File_Readonly);
      DBMS_LOB.loadfromfile(l_blob,l_bfile,DBMS_LOB.getlength(l_bfile));
      DBMS_LOB.fileclose(l_bfile);
    end if;
    
    INSERT INTO TRABAJADOR_CARGO
        (IDTC, FECHAINICIO, SUELDO, FKESCENOGRAFO, FKCARGO)
      VALUES 
       (seqTrabajadorCargo.NEXTVAL, fechaInicioCargo, sueldo, ID.NEXTVAL, 55);
      
    INSERT INTO NACIONALIDAD_ESCENOGRAFO
       (PKNACIONALIDAD, PKESCENOGRAFO)
      VALUES
       (nacionalidad, ID.NEXTVAL);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
create or replace PROCEDURE insertarInstitucion(nombreInstitucion IN VARCHAR2) IS

BEGIN
          
    INSERT INTO INSTITUCION
       (idInstitucion, nombre)
    VALUES 
       (seqInstitucion.NEXTVAL, lower(nombreInstitucion));
       
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
/create or replace PROCEDURE insertarInstrumento (instrumento IN VARCHAR2) IS
BEGIN
    INSERT INTO INSTRUMENTO
    (idInstrumento, nombre)
    VALUES
    (seqInstrumento.NEXTVAL, lower(instrumento));
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
/
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
/
create or replace PROCEDURE insertarOrquesta(nombre IN VARCHAR2, invitado IN NUMBER) IS
BEGIN
    INSERT INTO ORQUESTA
        (idOrquesta, nombre, invitado)
    VALUES
        (seqOrquesta.NEXTVAL, lower(nombre), invitado);
COMMIT;
    
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;      
/

CREATE OR REPLACE 
DIRECTORY FOTOSTRABAJADOR AS 'C:\BasesDeDatosII\fotos\fotosTrabajador';
/
GRANT READ ON DIRECTORY FOTOSTRABAJADOR to PUBLIC;
/
create or replace PROCEDURE insertTrabajador(pasaporte IN NUMBER, invitado IN NUMBER,nombreCompleto IN DATOS_PERSONALES, telefonos IN TELEFONOS, sexo IN VARCHAR2, fechaNacimiento IN DATE, fallecimiento IN DATE, archivoFoto IN VARCHAR2, fkLugar IN NUMBER, detalleDireccion IN VARCHAR2, nacionalidad IN NUMBER, cargo IN NUMBER, fechaInicioCargo IN DATE, sueldo IN NUMBER ) IS
l_bfile  BFILE;
l_blob   BLOB;
CURSOR BUSQUEDA IS select seqTrabajador.NEXTVAL  from dual;
ID BUSQUEDA % ROWTYPE;
BEGIN

FOR ID IN BUSQUEDA LOOP
   validarTDA(nombreCompleto, telefonos);
   validarNacionalidad(sexo, nacionalidad);
   
  INSERT INTO TRABAJADOR
   (IDTRABAJADOR, PASAPORTE, INVITADO,NOMBRECOMPLETO, TELEFONO, SEXO, FECHANACIMIENTO, FALLECIMIENTO, FOTO, FKLUGAR, DETALLEDIRECCION)
  VALUES 
   (ID.NEXTVAL, pasaporte, invitado,nombreCompleto , telefonos, sexo, fechaNacimiento, fallecimiento, EMPTY_BLOB(), fkLugar, detalleDireccion )
  RETURN foto INTO l_blob;
    
    if archivoFoto IS NOT NULL THEN
        l_bfile := BFILENAME('IMAGES', archivoFoto);
        DBMS_LOB.fileopen(l_bfile, Dbms_Lob.File_Readonly);
        DBMS_LOB.loadfromfile(l_blob,l_bfile,DBMS_LOB.getlength(l_bfile));
        DBMS_LOB.fileclose(l_bfile);
        
    end if;

INSERT INTO TRABAJADOR_CARGO
    (IDTC, FECHAINICIO, SUELDO, FKTRABAJADOR, FKCARGO)
  VALUES 
   (seqTrabajadorCargo.NEXTVAL, fechaInicioCargo, sueldo, ID.NEXTVAL, cargo);
  
INSERT INTO NACIONALIDAD_TRABAJADOR
   (PKNACIONALIDAD, PKTRABAJADOR)
  VALUES
   (nacionalidad, ID.NEXTVAL);
END LOOP;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
create or replace PROCEDURE insertarTrabajadorCargo(sueldo IN NUMBER, cargo IN NUMBER, trabajador IN NUMBER, musico IN NUMBER, invitado IN NUMBER, bailarin IN NUMBER, cantante IN NUMBER, escenografo IN NUMBER, autor IN NUMBER, de IN NUMBER, director IN NUMBER, dm IN NUMBER, coreografo IN NUMBER) IS
BEGIN
    INSERT INTO TRABAJADOR_CARGO
        (idTC, fechaInicio, sueldo, fkCargo, fkTrabajador, fkMusico, fkInvitado, fkBailarin, fkCantante, fkEscenografo, fkAutor, fkDirectorEscenografia, fkCoreografo, fkDirector, fkDM)
    VALUES
        (seqTrabajadorCargo.NEXTVAL, SYSDATE, sueldo, cargo, trabajador, musico, invitado, bailarin, cantante, escenografo, autor, de, coreografo, director, dm);
COMMIT;
    
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;  
/
CREATE OR REPLACE 
DIRECTORY FOTOSCOREOGRAFO AS 'C:\BasesDeDatosII\fotos\fotosCoreografo';
/
GRANT READ ON DIRECTORY FOTOSCOREOGRAFO to PUBLIC;
/
create or replace PROCEDURE insertCoreografo(pasaporte IN NUMBER, invitado IN NUMBER, nombreCompleto IN DATOS_PERSONALES, telefonos IN TELEFONOS, sexo IN VARCHAR2, fechaNacimiento IN DATE, fallecimiento IN DATE, archivoFoto IN VARCHAR2, fkLugar IN NUMBER, detalleDireccion IN VARCHAR2, nacionalidad IN NUMBER, fechaInicioCargo IN DATE, sueldo IN NUMBER ) IS
l_bfile  BFILE;
l_blob   BLOB; 
CURSOR BUSQUEDA IS select seqCoreografo.NEXTVAL  from dual;
ID BUSQUEDA % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA LOOP

    validarTDA(nombreCompleto, telefonos);   
    validarNacionalidad(sexo, nacionalidad);
          
      INSERT INTO COREOGRAFO
       (IDCOREOGRAFO, PASAPORTE, INVITADO, NOMBRECOMPLETO, TELEFONO, SEXO, FECHANACIMIENTO, FALLECIMIENTO, FOTO, FKLUGAR, DETALLEDIRECCION)
      VALUES 
       (ID.NEXTVAL, pasaporte, invitado, nombreCompleto, telefonos, sexo, fechaNacimiento, fallecimiento, EMPTY_BLOB(), fkLugar, detalleDireccion )
      RETURN foto INTO l_blob;
      
    if archivoFoto IS NOT NULL THEN
    
      l_bfile := BFILENAME('FOTOSCOREOGRAFO', archivoFoto);
      DBMS_LOB.fileopen(l_bfile, Dbms_Lob.File_Readonly);
      DBMS_LOB.loadfromfile(l_blob,l_bfile,DBMS_LOB.getlength(l_bfile));
      DBMS_LOB.fileclose(l_bfile);
      
    end if;
    
    INSERT INTO TRABAJADOR_CARGO
        (IDTC, FECHAINICIO, SUELDO, FKCOREOGRAFO, FKCARGO)
      VALUES 
       (seqTrabajadorCargo.NEXTVAL, fechaInicioCargo, sueldo, ID.NEXTVAL, 42);
      
    INSERT INTO NACIONALIDAD_COREOGRAFO
       (PKNACIONALIDAD, PKCOREOGRAFO)
      VALUES
       (nacionalidad, ID.NEXTVAL);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
/
CREATE OR REPLACE 
DIRECTORY FOTOSDIRECTODE AS 'C:\BasesDeDatosII\fotos\fotoDE\';
/
GRANT READ ON DIRECTORY FOTOSDIRECTODE to PUBLIC;
/
create or replace PROCEDURE insertDirectorEscenografia(pasaporte IN NUMBER, invitado IN NUMBER,nombreCompleto IN DATOS_PERSONALES, telefonos IN TELEFONOS, sexo IN VARCHAR2, fechaNacimiento IN DATE, fallecimiento IN DATE, archivoFoto IN VARCHAR2, fkLugar IN NUMBER, detalleDireccion IN VARCHAR2, nacionalidad IN NUMBER, fechaInicioCargo IN DATE, sueldo IN NUMBER ) IS
l_bfile  BFILE;
l_blob   BLOB; 
CURSOR BUSQUEDA IS select seqDirectorEscenografia.NEXTVAL  from dual;
ID BUSQUEDA % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA LOOP

    validarTDA(nombreCompleto, telefonos);  
    validarNacionalidad(sexo, nacionalidad);     
      INSERT INTO DIRECTOR_ESCENOGRAFIA
       (IDDE, PASAPORTE, INVITADO, NOMBRECOMPLETO, TELEFONO, SEXO, FECHANACIMIENTO, FALLECIMIENTO, FOTO, FKLUGAR, DETALLEDIRECCION)
      VALUES 
       (ID.NEXTVAL, pasaporte, invitado, nombreCompleto , telefonos, sexo, fechaNacimiento, fallecimiento, EMPTY_BLOB(), fkLugar, detalleDireccion )
      RETURN foto INTO l_blob;
      
    if archivoFoto IS NOT NULL THEN
    
      l_bfile := BFILENAME('FOTOSDIRECTODE', archivoFoto);
      DBMS_LOB.fileopen(l_bfile, Dbms_Lob.File_Readonly);
      DBMS_LOB.loadfromfile(l_blob,l_bfile,DBMS_LOB.getlength(l_bfile));
      DBMS_LOB.fileclose(l_bfile);
      
    end if;
    
    INSERT INTO TRABAJADOR_CARGO
        (IDTC, FECHAINICIO, SUELDO, FKDIRECTORESCENOGRAFIA, FKCARGO)
      VALUES 
       (seqTrabajadorCargo.NEXTVAL, fechaInicioCargo, sueldo, ID.NEXTVAL, 25);
      
    INSERT INTO NACIONALIDAD_DE
       (PKNACIONALIDAD, PKDE)
      VALUES
       (nacionalidad, ID.NEXTVAL);
END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
/
CREATE TYPE id_cantidad_material AS OBJECT(idMaterial NUMBER, Cantidad NUMBER);
/
CREATE TYPE listaEscenografiaMaterial AS TABLE OF id_cantidad_material;
/

CREATE OR REPLACE procedure insertEscenografia (descripcionEscenografia VARCHAR2, fkObra NUMBER, fkEscenografo NUMBER, fkDirectorEscenografo NUMBER, tablaAux listaEscenografiaMaterial) IS

CURSOR BUSQUEDA IS select SEQESCENOGRAFIA.NEXTVAL  from dual;
IdE BUSQUEDA % ROWTYPE;

BEGIN
    FOR IdE IN BUSQUEDA LOOP
        insert into ESCENOGRAFIA
            (IDESCENOGRAFIA, DESCRIPCION, FKOBRA, FKESCENOGRAFO, FKDIRECTORESCENOGRAFIA)
        values 
            (IdE.NEXTVAL, descripcionEscenografia, fkObra, fkEscenografo, fkDirectorEscenografo);
        
        IF tablaAux IS NOT NULL THEN
        
            FOR i IN 1..tablaAux.COUNT LOOP
                insert into ESCENOGRAFIA_MATERIAL
                    (IDEM, COSTO, FKMATERIAL, FKESCENOGRAFIA)
                values
                    (SEQESCENOGRAFIAMATERIAL.NEXTVAL, tablaAux(i).Cantidad , tablaAux(i).idMaterial , idE.NEXTVAL);
                                
             END LOOP;
        
        ELSE
            RAISE_APPLICATION_ERROR(-20000,'Debe introducir los datos completos de los materiales de la escenografia');
        END IF;
            
    END LOOP;
END;
/

create or replace PROCEDURE insertFechaPresentacion(idObra IN NUMBER, fecha IN DATE, costoZona IN NUMBER) IS

CURSOR BUSQUEDA IS select a.idubicacion idasiento, z.porcentaje 
                        from ubicacion a, ubicacion z 
                        where z.tipo='zona' AND a.FKUBICACION = z.IDUBICACION;
asiento BUSQUEDA % ROWTYPE;

CURSOR BUSQUEDAID IS select SEQFP.NEXTVAL  from dual;
ID BUSQUEDAID % ROWTYPE;

BEGIN

FOR ID IN BUSQUEDAID LOOP
    INSERT INTO FECHA_PRESENTACION
            (IDFP, FECHA, ZONAMASCARA, FKOBRA)
        VALUES
            (ID.NEXTVAL, fecha, costoZona, idObra);


    FOR asiento IN BUSQUEDA LOOP
        
        INSERT INTO ENTRADA
            (IDENTRADA, COSTO, PAGADA, FKUBICACION, FKPRESENTACION)
        VALUES
            (seqEntrada.NEXTVAL, costoZona * asiento.PORCENTAJE, 0, asiento.IDASIENTO, ID.NEXTVAL);
        
        
    END LOOP;
    
END LOOP;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
/
    create or replace PROCEDURE insertReservacion(idEntradas listaIdAux, idUsuario NUMBER ) IS
    
    CURSOR BUSQUEDA IS select SEQRESERVA.NEXTVAL  from dual;
    IDR BUSQUEDA % ROWTYPE;
    
    BEGIN
    FOR IDR IN BUSQUEDA LOOP
    
        insert into RESERVA
                (IDRESERVA, FECHA, FKUSUARIO)
            values
                (IDR.NEXTVAL, TO_DATE(SYSDATE,'dd/mm/yyyy'), idUsuario);
         
        IF idEntradas IS NOT NULL THEN    
            FOR i IN 1..idEntradas.COUNT LOOP
            
                insert into detalle_Reserva
                        (PKRESERVA, PKENTRADA, STATUS)
                    values
                        (IDR.NEXTVAL, idEntradas(i).id, 'a');
                
            END LOOP;
        ELSE
            RAISE_APPLICATION_ERROR(-20000,'debe introduccir al menos una entrada');
        END IF;
    
    END LOOP;
    
    COMMIT;
     
    EXCEPTION WHEN OTHERS THEN
       ROLLBACK;
       RAISE;
    
    END;
/
create or replace PROCEDURE insertUsuario(pasaporte IN NUMBER, nombreCompleto IN DATOS_PERSONALES, telefonos IN TELEFONOS, sexo IN VARCHAR2, fechaNacimiento IN DATE, fkLugar IN NUMBER, detalleDireccion IN VARCHAR2, nacionalidad IN NUMBER, fkIdioma IN NUMBER) IS

CURSOR BUSQUEDA IS select seqUsuario.NEXTVAL  from dual;
ID BUSQUEDA % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA LOOP

    validarTDA(nombreCompleto, telefonos);
    validarNacionalidad(sexo, nacionalidad);      

    insert into USUARIO
        (IDUSUARIO, PASAPORTE, NOMBRE, DETALLEDIRECCION, TELEFONO, SEXO, FECHANACIMIENTO, FKLUGAR, FKIDIOMA, FKNACIONALIDAD)
    values
        (ID.NEXTVAL, pasaporte, nombreCompleto, detalleDireccion, telefonos, sexo, fechaNacimiento, fkLugar, fkIdioma, nacionalidad);

END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
/
CREATE TYPE Idaux AS OBJECT( id NUMBER);
/
CREATE TYPE listaIdAux AS TABLE OF Idaux;
/
create or replace PROCEDURE insertVentaEntrada(idEntradas listaIdAux, idUsuario NUMBER ) IS

CURSOR BUSQUEDA IS select SEQFACTURA.NEXTVAL  from dual;
IDF BUSQUEDA % ROWTYPE;
auxCostoEntrada NUMBER(12,2); 
BEGIN
FOR IDF IN BUSQUEDA LOOP

    insert into FACTURA
            (IDFACTURA, FECHA, FKUSUARIO)
        values
            (IDF.NEXTVAL, TO_DATE(SYSDATE,'dd/mm/yyyy'), idUsuario);
     
    IF idEntradas IS NOT NULL THEN    
        FOR i IN 1..idEntradas.COUNT LOOP
            select e.costo
            INTO  auxCostoEntrada
            from entrada e
            where e.identrada = idEntradas(i).id;      
            
            insert into detalle_Factura
                    (IDDF, MONTO, FKFACTURA, FKENTRADA)
                values
                    (seqdf.NEXTVAL, auxCostoEntrada, IDF.NEXTVAL, idEntradas(i).id);
            
        END LOOP;
    ELSE
        RAISE_APPLICATION_ERROR(-20000,'debe introduccir al menos una entrada');
    END IF;

END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
/
CREATE OR REPLACE function musico_instrument(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select i.nombre instrumento 
from MUSICO_INSTRUMENTO mi, MUSICO m, INSTRUMENTO i
where m.idmusico = mi.pkmusico AND mi.pkinstrumento = i.idinstrumento AND id = m.idmusico ;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := 'Instrumento:  '||AUX.instrumento|| '. ';
END LOOP;
    
RETURN (RESULTADO);
END;
/

CREATE OR REPLACE function musico_instrument(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select i.nombre instrumento, antiguedad(mi.FECHAEJECUCION) antiguedad 
from MUSICO_INSTRUMENTO mi, MUSICO m, INSTRUMENTO i
where m.idmusico = mi.pkmusico AND mi.pkinstrumento = i.idinstrumento AND id = m.idmusico ;
AUX ÊBUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
 Ê Ê RESULTADO := 'Instrumento: Ê'||AUX.instrumento|| ', Antiguedad: Ê'||AUX.antiguedad|| '. '||RESULTADO;
END LOOP;
 Ê Ê
RETURN (RESULTADO);
END;
/

CREATE OR REPLACE function musico_instrumentP(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select i.nombre instrumento, antiguedad(mi.FECHAEJECUCION) antiguedad 
from MUSICO_INSTRUMENTO mi, MUSICO m, INSTRUMENTO i
where m.idmusico = mi.pkmusico AND mi.pkinstrumento = i.idinstrumento AND id = m.idmusico AND mi.instrumentoprincipal = 1  ;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := 'Instrumento:  '||AUX.instrumento|| ', Antiguedad:  '||AUX.antiguedad|| '. '||RESULTADO;
END LOOP;
    
RETURN (RESULTADO);
END;
/
create or replace function musico_orquest(id IN NUMBER) RETURN VARCHAR2 IS RESULTADO VARCHAR2(1000); CURSOR BUSQUEDA IS select o.nombre orquesta, mo.posicion posicion, mo.fechainicio fechainicio, mo.fechafin fechafin from MUSICO_ORQUESTA mo, MUSICO m, ORQUESTA O where m.idmusico = mo.pkmusico AND mo.pkorquesta = o.idorquesta AND id = m.idmusico ; AUX BUSQUEDA % ROWTYPE; BEGIN FOR AUX IN BUSQUEDA LOOP RESULTADO := 'Orquesta: '||AUX.orquesta|| ' , Posicion: ' ||AUX.posicion|| ' , fecha Inicio: ' ||AUX.fechainicio|| ' , fecha fin: ' ||AUX.fechafin|| '. '; END LOOP; RETURN (RESULTADO); END;
/
CREATE OR REPLACE function consultar_obras_d(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select o.nombre obra
                    from director d, obra o
                    where  o.FKDM = d.IDDIRECTOR AND d.Iddirector = id ;
AUX  BUSQUEDA % ROWTYPE;

BEGIN

FOR AUX IN BUSQUEDA LOOP
    if AUX.obra is not null then
        RESULTADO :=AUX.OBRA||' , '|| RESULTADO;
    else
        RESULTADO:=null;
    END IF;
END LOOP;
    
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE function musico_orquest(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select o.nombre orquesta, mo.posicion posicion, mo.fechainicio fechainicio, mo.fechafin fechafin
from MUSICO_ORQUESTA mo, MUSICO m, ORQUESTA O
where m.idmusico = mo.pkmusico AND mo.pkorquesta = o.idorquesta AND id = m.idmusico ;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := AUX.orquesta||  ' ,  Posicion: ' ||AUX.posicion|| ' , fecha Inicio:  ' ||AUX.fechainicio|| ' , fecha fin:  ' ||AUX.fechafin||   '. ';
END LOOP;
    
RETURN (RESULTADO);
END;
/
create or replace PROCEDURE pagoReserva(idR NUMBER, pagos listaAuxPago ) IS

CURSOR BUSQUEDA IS select e.identrada, u.idUsuario, r.idreserva 
                    from detalle_reserva dr, entrada e, usuario u, reserva r 
                    where dr.PKENTRADA = e.IDENTRADA AND dr.PKRESERVA = 1 AND  r.FKUSUARIO = u.idusuario;

AUX BUSQUEDA % ROWTYPE;
idU NUMBER;
idF NUMBER;
BEGIN
    FOR AUX IN BUSQUEDA LOOP
       insertVentaEntrada(listaIdAux(Idaux(AUX.IDENTRADA)), AUX.IDUSUARIO );
       idU := AUX.IDUSUARIO;
    END LOOP;

    select f.idfactura
        INTO idF
        from factura f, usuario u
        where f.FKUSUARIO = 1 AND TO_DATE(f.FECHA,'dd/mm/yyyy') = TO_DATE(sysdate,'dd/mm/yyyy') AND rownum <=1
        ORDER BY F.FECHA;

        
    pagoFactura(idF , pagos);
    idU := AUX.IDUSUARIO;
    
    FOR AUX IN BUSQUEDA LOOP
        UPDATE DETALLE_RESERVA
            SET STATUS = 'p'
            where PKRESERVA = AUX.IDRESERVA AND PKENTRADA = AUX.IDENTRADA;
    END LOOP;
    
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
/
CREATE TYPE auxPago AS OBJECT( idMoneda NUMBER, montoPagado NUMBER, formaPago VARCHAR2(10));
/

CREATE TYPE listaAuxPago AS TABLE OF auxPago;
/

create or replace PROCEDURE pagoFactura(idF NUMBER, pagos listaAuxPago ) IS

total NUMBER;
totalPago NUMBER;
valorMoneda NUMBER;
BEGIN
    select SUM(p.monto)
        INTO totalPago
        from pago p
        where p.fkFactura = idF;
        
        IF totalPago is null THEN
            totalPago:= 0;
        END IF;
    
    select SUM(df.monto)
        INTO total
        from factura f, detalle_factura df
        where df.fkfactura = f.idfactura AND f.idfactura = idF
        GROUP BY f.idfactura;
        
    IF totalPago < total THEN
        IF pagos IS NOT NULL THEN    
            FOR i IN 1..pagos.COUNT LOOP
                select valor
                    into valorMoneda 
                    from moneda
                    where idmoneda = pagos(i).idMoneda;
                    
                totalPago := totalPago + pagos(i).montoPagado*valorMoneda;
                
            END LOOP;
            
            IF total = totalPago THEN
                FOR i IN 1..pagos.COUNT LOOP
               
                    INSERT INTO PAGO
                        (IDPAGO, MONTO, FECHA, FORMAPAGO, FKMONEDA, FKFACTURA)
                    VALUES
                        (SEQPAGO.NEXTVAL, pagos(i).montoPagado, TO_DATE(SYSDATE,'dd/mm/yyyy'), pagos(i).formaPago, pagos(i).idMoneda, idF);
               
                END LOOP;
                update entrada 
                    set pagada = 1
                    where identrada in (select e.identrada
                                          from entrada e, detalle_factura dt  
                                         where dt.fkFactura = idF AND dt.fkentrada = e.identrada );
                        
                dbms_output.put_line('Pago completo');
            
            END IF;
            
            IF total > totalPago  THEN
                    RAISE_APPLICATION_ERROR(-20000,'FALTA PAGAR un monto de ' || to_char(total-totalPago));    
            END IF;
            
            IF total < totalPago  THEN
                    RAISE_APPLICATION_ERROR(-20000,'EL PAGO ESCEDIO un monto de ' || to_char(totalPago-total));    
            END IF;   
                
        ELSE
            RAISE_APPLICATION_ERROR(-20000,'Debe introducir al menos un pago');
        END IF;
        
    ELSE
        
        RAISE_APPLICATION_ERROR(-20000,'LA factura ya fue pagada');
    END IF;
    
    
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
/
create or replace PROCEDURE pagoReserva(idR NUMBER, pagos listaAuxPago ) IS

CURSOR BUSQUEDA IS select e.identrada, u.idUsuario, r.idreserva 
                    from detalle_reserva dr, entrada e, usuario u, reserva r 
                    where dr.PKENTRADA = e.IDENTRADA AND dr.PKRESERVA = 1 AND  r.FKUSUARIO = u.idusuario;

AUX BUSQUEDA % ROWTYPE;
idU NUMBER;
idF NUMBER;
BEGIN
    FOR AUX IN BUSQUEDA LOOP
       insertVentaEntrada(listaIdAux(Idaux(AUX.IDENTRADA)), AUX.IDUSUARIO );
       idU := AUX.IDUSUARIO;
    END LOOP;

    select f.idfactura
        INTO idF
        from factura f, usuario u
        where f.FKUSUARIO = 1 AND TO_DATE(f.FECHA,'dd/mm/yyyy') = TO_DATE(sysdate,'dd/mm/yyyy') AND rownum <=1
        ORDER BY F.FECHA;

        
    pagoFactura(idF , pagos);
    idU := AUX.IDUSUARIO;
    
    FOR AUX IN BUSQUEDA LOOP
        UPDATE DETALLE_RESERVA
            SET STATUS = 'p'
            where PKRESERVA = AUX.IDRESERVA AND PKENTRADA = AUX.IDENTRADA;
    END LOOP;
    
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
/
create or replace PROCEDURE promocion IS

CURSOR BUSQUEDA IS select tc.FECHAINICIO , d.TIEMPOASCENSO, j.idcargo idjefe, t.idtrabajador 
from cargo c, cargo j, departamento d, trabajador t ,trabajador_cargo tc
where c.FKJEFE = j.idcargo AND c.fkDepartamento = d.iddepartamento AND c.TIPOASCENSO = 'tiempo' AND  tc.fktrabajador = t.idtrabajador and tc.fkcargo = c.idcargo AND tc.fechafin is null;

AUX BUSQUEDA % ROWTYPE;
antiguedad number;
BEGIN

FOR AUX IN BUSQUEDA LOOP
    
    antiguedad:= months_between(to_date(sysdate,'dd/mm/yy'), TO_DATE(AUX.FECHAINICIO,'dd/mm/yy'));
    IF antiguedad = AUX.TIEMPOASCENSO THEN
        dbms_output.put_line('el trabajador fue ascendido ' || AUX.IDTRABAJADOR);
        update TRABAJADOR_CARGO
            set FKCARGO = AUX.IDJEFE
            where FKTRABAJADOR = AUX.IDTRABAJADOR;
    
    END IF;

END LOOP;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
create or replace PROCEDURE remateEntrada IS

CURSOR BUSQUEDA IS select ( ((2258-count(e.identrada))*100)/2258) ventas, fp.FECHA, fp.idfp 
                    from entrada e, FECHA_PRESENTACION fp
                    where e.FKPRESENTACION = fp.IDFP AND e.PAGADA = 0
                    GROUP BY fp.FECHA, fp.idfp ;


AUX BUSQUEDA % ROWTYPE;

diasRestante NUMBER;

BEGIN

FOR AUX IN BUSQUEDA LOOP
    diasRestante := to_Date(AUX.FECHA,'dd/mm/yy') - to_Date(SYSDATE,'dd/mm/yy');
  
    IF diasRestante < 19 AND diasRestante >= 0 THEN
        
        IF AUX.VENTAS < 30 THEN
        
            UPDATE ENTRADA
            SET COSTO = COSTO - COSTO*0.03
            WHERE FKPRESENTACION = AUX.IDFP;           
                  
        END IF;
        
        IF AUX.VENTAS  >= 30 THEN
        
            UPDATE ENTRADA
            SET COSTO = COSTO + COSTO*0.03
            WHERE FKPRESENTACION = AUX.IDFP;
                    
                  
        END IF; 
        
    END IF;

END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
/
create or replace function split(input_list varchar2, ret_this_one number, delimiter varchar2)
return varchar2
is
	v_list varchar2(32767) := delimiter || input_list;
	start_position number;
	end_position number;
begin
	start_position := instr(v_list, delimiter, 1, ret_this_one);
	if start_position > 0 then
		end_position := instr( v_list, delimiter, 1, ret_this_one + 1);
		if end_position = 0 then
			end_position := length(v_list) + 1; 
		end if;
		return(substr(v_list, start_position + 1, end_position - start_position - 1));
	else
		return NULL;
	end if;
end split;
/
create or replace trigger personaNotNull
before insert or update of fkTrabajador or
insert or update fkDirector or
insert or update fkDirectorEscenografia or
insert or update fkDM or
insert or update fkAutor or
insert or update fkCoreografo or
insert or update fkEscenografo or
insert or update fkBailarin or
insert or update fkMusico or
insert or update fkInvitado 
ON TRABAJADOR_CARGO
BEGIN
    if fkTrabajador IS NULL and fkDirector IS NULL and fkDirectorEscenografia IS NULL and fkDM IS NULL and fkAutor IS NULL and fkCoreografo IS NULL and fkEscenografo IS NULL and fkBailarin IS NULL and fkMusico IS NULL and fkInvitado IS NULL then
        RAISE_APPLICATION_ERROR(-20000,'Debe asignarse el cargo a algun empleado');
END;

create or replace trigger personaNotNull
    BEFORE INSERT ON TRABAJADOR_CARGO
    FOR EACH ROW
BEGIN
    if fkTrabajador IS NULL and fkDirector IS NULL and fkDirectorEscenografia IS NULL and fkDM IS NULL and fkAutor IS NULL and fkCoreografo IS NULL and fkEscenografo IS NULL and fkBailarin IS NULL and fkMusico IS NULL and fkInvitado IS NULL then
        RAISE_APPLICATION_ERROR(-20000,'Debe asignarse el cargo a algun empleado');
    END IF;
END;
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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
/
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

/
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
/
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
/
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
/
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
/
CREATE OR REPLACE function voz_cantante (idcantante IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select v.nombre nombre, v.descripcion descripcion from cantante c, voz v, cantante_voz cv where c.idcantante = cv.pkcantante AND cv.pkvoz = v.idvoz AND idcantante = c.idcantante;
AUX ÊBUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
 Ê Ê RESULTADO := AUX.nombre|| ', Descripcion: ' ||AUX.descripcion||'. ';
END LOOP;
 Ê Ê
RETURN (RESULTADO);
END;
/
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
create or replace procedure audicionMusico (idp number, idm number, ruta varchar2) is

archivo utl_file.file_type;
linea varchar2(1024);
x number;
y number;
contador number;
CURSOR BUSQUEDA IS select ri.x, ri.y, ri.IDRI
                        from partitura p, registro_instrumento ri
                        where p.idpartitura = ri.PKPARTITURA AND idpartitura = idp
                        order by ri.IDRI;

 AUX BUSQUEDA % ROWTYPE;

CURSOR BUSQUEDA2 IS select SEQAUDICIONMUSICO.nextval from dual;
ID BUSQUEDA2 % ROWTYPE;
v_idva number := 1;
begin
 
archivo := utl_file.fopen ('DIR_TMP', ruta, 'r');
contador := 0;
FOR AUX IN BUSQUEDA LOOP

    utl_file.get_line (archivo, linea);
    x := split(linea ,1,',');
    y := split(linea ,2,',');
    IF x-AUX.X >=-1 AND x-AUX.X<=1 AND y-AUX.Y >=-1 AND y-AUX.Y<=1  THEN
        contador := contador +1;
    END IF;
END LOOP;

FOR ID IN BUSQUEDA2 LOOP
    IF contador >=90 THEN
        dbms_output.put_line('Pasaste la prueba');
    
        INSERT INTO AUDICION_MUSICO (IDAM, FECHA, APROBO, FKPARTITURA, FKMUSICO)
            VALUES (ID.NEXTVAL, SYSDATE, 1, idp, idm);
        
    ELSE
       dbms_output.put_line('NO pasastes la prueba'); 
       INSERT INTO AUDICION_MUSICO (IDAM, FECHA, APROBO, FKPARTITURA, FKMUSICO)
            VALUES (ID.NEXTVAL, SYSDATE, 0, idp, idm);

    END IF;

    FOR AUX IN BUSQUEDA LOOP
    
        INSERT INTO INSTRUMENTO_AUDICION (IDIA, PKAM, X, Y)
            VALUES(v_idva, ID.NEXTVAL, AUX.X, AUX.Y);
            
         v_idva:= v_idva +1;
   END LOOP;
END LOOP;

utl_file.fclose(archivo); 
exception
 when no_data_found then
   dbms_output.put_line ('Fin del archivo');
end;
/
create or replace procedure audicionCantante (idp number, idc number, ruta varchar2) is

archivo utl_file.file_type;
linea varchar2(1024);
x number;
y number;
contador number;
CURSOR BUSQUEDA IS select rp.x, rp.y, idrvp
                    from personaje p, REGISTRO_VOZ_PERSONAJE rp
                    where rp.PKPERSONAJE = p.idpersonaje and p.idpersonaje = idp
                    order by idrvp;
 AUX BUSQUEDA % ROWTYPE;

CURSOR BUSQUEDA2 IS select SEQAUDICIONCANTANTE.nextval from dual;
ID BUSQUEDA2 % ROWTYPE;
v_idva number := 1;
begin
 
archivo := utl_file.fopen ('DIR_TMP', ruta, 'r');
contador := 0;
FOR AUX IN BUSQUEDA LOOP

    utl_file.get_line (archivo, linea);
    x := split(linea ,1,',');
    y := split(linea ,2,',');
    IF x-AUX.X >=-1 AND x-AUX.X<=1 AND y-AUX.Y >=-1 AND y-AUX.Y<=1  THEN
        contador := contador +1;
    END IF;
END LOOP;

FOR ID IN BUSQUEDA2 LOOP
    IF contador >=90 THEN
        dbms_output.put_line('Pasaste la prueba');
    
        INSERT INTO AUDICION_CANTANTE (IDAC, FECHA, APROBO, FKCANTANTE, FKPERSONAJE)
            VALUES (ID.NEXTVAL, SYSDATE, 1, idc, idp);
        
    ELSE
       dbms_output.put_line('NO pasastes la prueba'); 
       INSERT INTO AUDICION_CANTANTE (IDAC, FECHA, APROBO, FKCANTANTE, FKPERSONAJE)
            VALUES (ID.NEXTVAL, SYSDATE, 0, idc, idp);

    END IF;

    FOR AUX IN BUSQUEDA LOOP
    
        INSERT INTO VOZ_AUDICION (IDVA, PKAC, X, Y)
            VALUES(v_idva, ID.NEXTVAL, AUX.X, AUX.Y);
            
         v_idva:= v_idva +1;
   END LOOP;
END LOOP;

utl_file.fclose(archivo); 
exception
 when no_data_found then
   dbms_output.put_line ('Fin del archivo');
end;
/
create or replace procedure cargaMasiva( ruta varchar2)  is

archivo utl_file.file_type;
linea varchar2(2000);
parametro varchar2(2000);
rif varchar2(2000);
nombre varchar2(2000); 
idlugar varchar2(2000);
detalle varchar2(2000); 
codigoTele varchar2(2000);
telefeno varchar2(2000); 
idzona varchar2(2000); 
numeroPuestos varchar2(2000);
NAsientos number;


CURSOR BUSQUEDA IS select SEQFACTURA.nextval from dual;
IDF BUSQUEDA % ROWTYPE;

CURSOR BUSQUEDA2 IS select seqempresa.nextval from dual;
IDE BUSQUEDA2 % ROWTYPE;

type v_type is ref cursor;

CURSOR BUSQUEDA3 IS select e.IDENTRADA, e.costo
                                        from ubicacion a, ubicacion z, entrada e
                                        where a.tipo = 'asiento' AND a.fkubicacion = z.idubicacion AND e.FKUBICACION = a.idubicacion
                                        AND e.pagada = 0;
AUX BUSQUEDA3 % ROWTYPE;
type c_type is ref cursor;
v_cursor c_type;

begin
 
archivo := utl_file.fopen ('DIR_TMP', ruta, 'r');
loop
    
    utl_file.get_line (archivo, linea);
    parametro := split(linea ,1,':');
    
    IF parametro = 'RIF' THEN
        rif := split(linea ,2,':');
    END IF;
    
    IF parametro = 'NOMBRE' THEN
        nombre := split(linea ,2,':');
    END IF;
    
    IF parametro = 'RIF' THEN
        rif := split(linea ,2,':');
    END IF;
    
    IF parametro = 'IDLUGAR' THEN
        idlugar := split(linea ,2,':');
    END IF;
    
    IF parametro = 'DETALLE DIRECCION' THEN
        detalle := split(linea ,2,':');
    END IF;
    
    IF parametro = 'TELEFONO' THEN
        codigoTele := split(linea ,2,':');
        telefeno := split(linea ,3,':');
    END IF;
    
    IF parametro = 'IDZONA' THEN
        idzona := split(linea ,2,':');
    END IF;
    
     IF parametro = 'NUMERO PUESTOS' THEN
        numeroPuestos := split(linea ,2,':');
    END IF;
       
end loop;
utl_file.fclose(archivo);

exception
 when no_data_found then
 
    SELECT p.pagado + r.reservado disponibles
    INTO NAsientos
    from (select count(z.idubicacion) pagado
            from ubicacion a, ubicacion z, entrada e
            where a.tipo = 'asiento' AND a.fkubicacion = z.idubicacion AND e.FKUBICACION = a.idubicacion
            AND e.pagada = 0 and z.idubicacion = idzona) p,
            (select count(z.idubicacion) reservado
            from ubicacion a, ubicacion z, entrada e, detalle_reserva dr
            where a.tipo = 'asiento' AND a.fkubicacion = z.idubicacion AND e.FKUBICACION = a.idubicacion
            AND dr.PKRESERVA = e.identrada or dr.status ='c' AND z.idubicacion = idzona) r;

    IF NAsientos <  numeroPuestos THEN    
        RAISE_APPLICATION_ERROR(-20000,'NO HAY SUFICIENTES PUESTOS '||NAsientos ||' < '||  numeroPuestos );
        
    ELSE
        FOR IDE IN BUSQUEDA2 LOOP
            INSERT INTO EMPRESA (IDEMPRESA, RIF, NOMBRE, FKLUGAR, DETALLELUGAR, TELEFONO)
             VALUES (IDE.NEXTVAL, rif, nombre, idlugar, detalle, TELEFONOS(TELEFONO(codigoTele,telefeno)));
            
            
            FOR IDF IN BUSQUEDA LOOP
            
                INSERT INTO FACTURA (IDFACTURA, FECHA, FKEMPRESA)
                    VALUES (IDF.NEXTVAL, SYSDATE, IDE.NEXTVAL);
                    
                    OPEN v_cursor FOR 'select e.IDENTRADA, e.costo
                                        from ubicacion a, ubicacion z, entrada e
                                        where a.tipo = ''asiento'' AND a.fkubicacion = z.idubicacion AND e.FKUBICACION = a.idubicacion
                                        AND e.pagada = 0 and rownum <= '||numeroPuestos||' and z.idubicacion = '||idzona;
                                        
                        loop
                            fetch v_cursor into AUX;
                            exit when v_cursor%notfound;
                            
                                INSERT INTO DETALLE_FACTURA (IDDF, MONTO, FKFACTURA, FKENTRADA)
                                    VALUES (SEQDF.nextval, AUX.COSTO, IDF.NEXTVAL, AUX.IDENTRADA);
                        end loop;

                    CLOSE v_cursor;
            
            END LOOP;
            
            
        END LOOP;
    END IF; 

 
   dbms_output.put_line ('Fin del archivo');
end;
/
create or replace PROCEDURE comprarAudio  (idu number, ida number, v_cantidad number) is

CURSOR BUSQUEDA IS select SEQDF.NEXTVAL  from dual;
ID BUSQUEDA % ROWTYPE;

v_precio varchar2(2000);
dias number;

BEGIN

select floor( sysdate  - fp.fecha)
into dias 
from audio a, fecha_presentacion fp
where a.idaudio = ida AND fp.idfp = a.fkpresentacion;


IF dias < 20 THEN
RAISE_APPLICATION_ERROR(-20000,'ERROR  no se puede vender el audio antes de los 20 d’as despuŽs  de la presentaci—n ');

END IF;

select a.precio
into v_precio
from audio a
where a.idaudio = ida;

FOR ID IN BUSQUEDA LOOP

INSERT INTO FACTURA_DIGITALIZACION ( IDFD, FECHA, FKUSUARIO) 
VALUES (ID.NEXTVAL, SYSDATE, idu );

INSERT INTO  DETALLE_FACTURA_DIGITALIZADA (IDDFD, CANTIDAD,  MONTO, FKFD,  FKAUDIO)
VALUES (SEQDFD.NEXTVAL, v_cantidad,  v_precio,  ID.NEXTVAL, ida);

   dbms_output.put_line ('numero de factura '|| ID.nextval);

END LOOP;
END;
/
create or replace PROCEDURE comprarVideo  (idu number, idv number, v_cantidad number) is

CURSOR BUSQUEDA IS select SEQDF.NEXTVAL  from dual;
ID BUSQUEDA % ROWTYPE;

v_precio varchar2(2000);
dias number;

BEGIN

select floor( sysdate  - fp.fecha)
into dias 
from video v, fecha_presentacion fp
where v.idvideo = idv AND fp.idfp = v.fkpresentacion;


IF dias < 20 THEN
RAISE_APPLICATION_ERROR(-20000,'ERROR  no se puede vender el video antes de los 20 d’as despuŽs  de la presentaci—n ');
end if;

select v.precio
into v_precio
from video v
where v.idvideo = idv;

FOR ID IN BUSQUEDA LOOP

INSERT INTO FACTURA_DIGITALIZACION ( IDFD, FECHA, FKUSUARIO) 
VALUES (ID.NEXTVAL, SYSDATE, idu );

INSERT INTO  DETALLE_FACTURA_DIGITALIZADA (IDDFD, CANTIDAD,  MONTO, FKFD,  FKVIDEO)
VALUES (SEQDFD.NEXTVAL, v_cantidad,  v_precio,  ID.NEXTVAL, idv);

   dbms_output.put_line ('numero de factura '|| ID.nextval);

END LOOP;
END;
/
create or replace PROCEDURE pagoFacturaD(idF NUMBER, pagos listaAuxPago ) IS

total NUMBER;
totalPago NUMBER;
valorMoneda NUMBER;
BEGIN
    select SUM(p.monto)
        INTO totalPago
        from pago_digitalizacion p
        where p.fkFd = idF;
        
        IF totalPago is null THEN
            totalPago:= 0;
        END IF;
    
    select SUM(df.monto)
        INTO total
        from factura_digitalizacion f, detalle_factura_digitalizada df
        where df.fkfd = f.idfd AND f.idfd = idF
        GROUP BY f.idfd;
        
    IF totalPago < total THEN
        IF pagos IS NOT NULL THEN    
            FOR i IN 1..pagos.COUNT LOOP
                select valor
                    into valorMoneda 
                    from moneda
                    where idmoneda = pagos(i).idMoneda;
                    
                totalPago := totalPago + pagos(i).montoPagado*valorMoneda;
                
            END LOOP;
            
            IF total = totalPago THEN
                FOR i IN 1..pagos.COUNT LOOP
               
                    INSERT INTO PAGO_DIGITALIZACION
                        (IDPD, MONTO, FECHA, FORMAPAGO, FKMONEDA, FKFD)
                    VALUES
                        (SEQPAGOD.NEXTVAL, pagos(i).montoPagado, TO_DATE(SYSDATE,'dd/mm/yyyy'), pagos(i).formaPago, pagos(i).idMoneda, idF);
               
                END LOOP;
                        
                dbms_output.put_line('Pago completo');
            
            END IF;
            
            IF total > totalPago  THEN
                    RAISE_APPLICATION_ERROR(-20000,'FALTA PAGAR un monto de ' || to_char(total-totalPago));    
            END IF;
            
            IF total < totalPago  THEN
                    RAISE_APPLICATION_ERROR(-20000,'EL PAGO ESCEDIO un monto de ' || to_char(totalPago-total));    
            END IF;   
                
        ELSE
            RAISE_APPLICATION_ERROR(-20000,'Debe introducir al menos un pago');
        END IF;
        
    ELSE
        
        RAISE_APPLICATION_ERROR(-20000,'LA factura ya fue pagada');
    END IF;
    
    
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
/
create or replace PROCEDURE pagoPersonalObra(fechaPresentacion date) is

CURSOR BUSQUEDA IS select nombres(m.nombreCompleto) musico, tc.sueldo, m.idmusico id, fp.IDFP fecha
                    from fecha_presentacion fp, obra o, musico_obra mo, musico m, trabajador_cargo tc
                    where fp.fkobra = o.idobra AND  mo.pkpresentacion = fp.idfp AND mo.pkmusico = m.idmusico
                    and tc.fkmusico = m.idmusico and to_date(fp.fecha,'dd/mm/yy') = to_date(fechaPresentacion,'dd/mm/yy');

musicos BUSQUEDA % ROWTYPE;

CURSOR BUSQUEDA2 IS select nombres(b.nombrecompleto) " BAILARINES INVITADOS", tc.sueldo, b.idbailarin id, fp.IDFP fecha 
                        from bailarin b,  BALLET bl, BAILARIN_BALLET bb, obra o, fecha_presentacion fp , trabajador_cargo tc
                        where o.fkballet = bl.idballet and bb.pkballet = bl.idballet
                        and bb.pkbailarin = b.idbailarin and fp.fkobra = o.idobra 
                        and tc.fkbailarin = b.idbailarin and to_date(fp.fecha,'dd/mm/yy') = to_date(fechaPresentacion,'dd/mm/yy');
bailarinesInvitados BUSQUEDA2 % ROWTYPE;

CURSOR BUSQUEDA3 IS select nombres(c.nombrecompleto) cantantes, tc.sueldo, c.idcantante id, fp.IDFP fecha
                        from obra o, fecha_presentacion fp, elenco e, cantante c , trabajador_cargo tc
                        where fp.fkobra = o.idobra and fp.idfp = e.pkfechaPresentacion and e.pkcantante = c.idcantante
                        and tc.fkcantante = c.idcantante and to_date(fp.fecha,'dd/mm/yy') = to_date(fechaPresentacion,'dd/mm/yy');
cantantes BUSQUEDA3 % ROWTYPE;

CURSOR BUSQUEDA4 IS select nombres(m.nombrecompleto) "MUSICO INVITADOS", tc.sueldo, m.idmusico id, fp.IDFP fecha
                from obra o, fecha_presentacion fp, orquesta oq, musico_orquesta mo, musico m , trabajador_cargo tc
                where fp.fkobra = o.idobra and o.fkorquesta = oq.idorquesta and mo.pkorquesta = oq.idorquesta
                and mo.pkmusico = m.idmusico
                and tc.fkmusico = m.idmusico and to_date(fp.fecha,'dd/mm/yy') = to_date(fechaPresentacion,'dd/mm/yy');
musicoInvitados BUSQUEDA4 % ROWTYPE;

CURSOR BUSQUEDA5 IS select nombres(b.nombreCompleto) bailarin, tc.sueldo, b.idbailarin id, fp.IDFP fecha
                        from obra o, fecha_presentacion fp, bailarin_obra bo, bailarin b, trabajador_cargo tc 
                        where fp.fkobra = o.idobra and fp.idfp = bo.pkpresentacion and  bo.pkbailarin = b.idbailarin
                        and tc.fkbailarin = b.idbailarin and to_date(fp.fecha,'dd/mm/yy') = to_date(fechaPresentacion,'dd/mm/yy');
bailarin BUSQUEDA5 % ROWTYPE;

CURSOR BUSQUEDA6 IS select nombres(eg.nombreCompleto) escenografo, tc.sueldo, eg.idescenografo id, fp.IDFP fecha
                        from obra o, fecha_presentacion fp, escenografia e, escenografo eg, trabajador_cargo tc
                        where  fp.fkobra = o.idobra and o.idobra = e.fkescenografo and  e.fkescenografo = eg.idescenografo
                        and tc.fkescenografo = eg.idescenografo and to_date(fp.fecha,'dd/mm/yy') = to_date(fechaPresentacion,'dd/mm/yy');
escenografo BUSQUEDA6 % ROWTYPE;

CURSOR BUSQUEDA7 IS select nombres(de.nombreCompleto) "directo escenografia", tc.sueldo, de.idde id, fp.IDFP fecha
                        from obra o, fecha_presentacion fp, escenografia e, director_escenografia de, trabajador_cargo tc
                        where  fp.fkobra = o.idobra and o.idobra = e.fkescenografo and  e.fkescenografo = de.idde
                        and tc. FKDIRECTORESCENOGRAFIA = de.idde and to_date(fp.fecha,'dd/mm/yy') = to_date(fechaPresentacion,'dd/mm/yy');

D_escenografo BUSQUEDA7 % ROWTYPE;



BEGIN

FOR musicos IN BUSQUEDA LOOP

    INSERT INTO HISTORIAL_PAGO (IDHP, FECHA, MONTO, FKMUSICO, FKFP)
    VALUES (SEQHP.nextval, sysdate, musicos.sueldo, musicos.id, musicos.fecha);

END LOOP;

FOR bailarinesInvitados IN BUSQUEDA2 LOOP

    INSERT INTO HISTORIAL_PAGO (IDHP, FECHA, MONTO, FKBAILARIN, FKFP)
    VALUES (SEQHP.nextval, sysdate, bailarinesInvitados.sueldo, bailarinesInvitados.id, bailarinesInvitados.fecha);

END LOOP;

FOR cantantes IN BUSQUEDA3 LOOP

    INSERT INTO HISTORIAL_PAGO (IDHP, FECHA, MONTO, FKCANTANTE, FKFP)
    VALUES (SEQHP.nextval, sysdate, cantantes.sueldo, cantantes.id, cantantes.fecha);

END LOOP;

FOR musicoInvitados IN BUSQUEDA4 LOOP

    INSERT INTO HISTORIAL_PAGO (IDHP, FECHA, MONTO, FKMUSICO, FKFP)
    VALUES (SEQHP.nextval, sysdate, musicoInvitados.sueldo, musicoInvitados.id, musicoInvitados.fecha);

END LOOP;

FOR bailarin IN BUSQUEDA5 LOOP

    INSERT INTO HISTORIAL_PAGO (IDHP, FECHA, MONTO, FKBAILARIN, FKFP)
    VALUES (SEQHP.nextval, sysdate, bailarin.sueldo, bailarin.id, bailarin.fecha);

END LOOP;

FOR escenografo IN BUSQUEDA6 LOOP

    INSERT INTO HISTORIAL_PAGO (IDHP, FECHA, MONTO, FKESCENOGRAFO, FKFP)
    VALUES (SEQHP.nextval, sysdate, escenografo.sueldo, escenografo.id, escenografo.fecha);

END LOOP;

FOR D_escenografo IN BUSQUEDA7 LOOP

    INSERT INTO HISTORIAL_PAGO (IDHP, FECHA, MONTO, FKDIRECTORESCENOGRAFIA, FKFP)
    VALUES (SEQHP.nextval, sysdate, D_escenografo.sueldo, D_escenografo.id, D_escenografo.fecha);

END LOOP;

commit;

END;
/
create or replace PROCEDURE pagoTrabajadores is

CURSOR BUSQUEDA IS select t.idtrabajador id, tc.sueldo
                        from trabajador t, trabajador_cargo tc
                        where tc.fktrabajador = t.idtrabajador;

trabajador BUSQUEDA % ROWTYPE;

BEGIN

FOR trabajador IN BUSQUEDA LOOP

    INSERT INTO HISTORIAL_PAGO (IDHP, FECHA, MONTO, FKTRABAJADOR)
    VALUES (SEQHP.nextval, sysdate, trabajador.sueldo, trabajador.id);

END LOOP;

END;
/

 


  

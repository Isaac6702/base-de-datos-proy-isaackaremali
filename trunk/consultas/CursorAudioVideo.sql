CREATE OR REPLACE function datosObraAutor(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select lower(o.nombre) obra, lower(nombres(nombreCompleto)) nombre, lower(apellidos(nombreCompleto)) apellido
from autor a, obra o
where o.fkAutor = a.idAutor
and o.idObra = id;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := AUX.obra|| ' - ' ||AUX.NOMBRE || ' '|| AUX.APELLIDO;
END LOOP;
    
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE function datosDirectores(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select lower(nombres(dm.nombreCompleto)) dmnombre, lower(apellidos(dm.nombreCompleto)) dmapellido, lower(nombres(d.nombreCompleto)) dnombre, lower(apellidos(d.nombreCompleto)) dapellido
from director_musical dm, director d, obra o
where dm.idDM = o.fkDM
and o.fkDirector = d.idDirector 
and o.idObra = id;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := 'Director Musical: '||AUX.dmnombre|| ' ' ||AUX.dmapellido || ' Director: '|| AUX.dnombre || ' ' || AUX.dapellido;
END LOOP;
    
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE function datosOrquesta(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select lower(o.nombre) orquesta
from orquesta o, obra ob
where o.idOrquesta = ob.fkOrquesta
and ob.idObra= id;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := 'Royal Opera House - Orquesta invitada: '||AUX.orquesta;
END LOOP;
    
RETURN (RESULTADO);
END;

create or replace procedure CT_Audio(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
    select datosObraAutor(o.idObra) obra, datosDirectores(o.idObra) directores, to_char(fp.fecha,'dd/mm/yyyy hh:mi:ssam') fecha, datosOrquesta(o.idObra) orquesta, a.formato formato
    from obra o, fecha_presentacion fp, audio a
    where fp.fkObra = o.idObra
    and a.fkpresentacion = fp.idFP
    order by o.idObra, fp.fecha;

END;

create or replace procedure CT_VIDEO(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
    select datosObraAutor(o.idObra) obra, datosDirectores(o.idObra) directores, to_char(fp.fecha,'dd/mm/yyyy hh:mi:ssam') fecha, datosOrquesta(o.idObra) orquesta, v.formato formato
    from obra o, fecha_presentacion fp, video v
    where fp.fkObra = o.idObra
    and v.fkpresentacion = fp.idFP
    order by o.idObra, fp.fecha;

END;
/
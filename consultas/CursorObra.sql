select lower(o.nombre) "NOMBRE", lower(o.descripcion) "DESCRIPCION", datosBiograficosAutor(a.idAutor) "AUTOR", datosDirectores(o.idObra) "DIRECTORES", partes(o.idOBra) "PARTES", fechas_obra(o.idObra) "PRESENTACIONES", datosOrquesta(o.idObra) "ORQUESTA", personajeCantante(o.idObra) "PERSONAJE", musicosObra(o.idObra) "MUSICOS"
from obra o, autor a
where o.fkAutor = a.idAutor


CREATE OR REPLACE function datosBiograficosAutor(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select lower(nombres(a.nombreCompleto)) nombres, lower(apellidos(a.nombreCompleto)) apellidos, to_char(a.fechaNacimiento, 'dd/mm/yyyy') nacimiento, to_char(a.fallecimiento, 'dd/mm/yyyy') fallecimiento, n.nombre nacionalidad
                   from autor a, nacionalidad n, nacionalidad_autor na
                   where a.idAutor = id and na.pkNacionalidad = n.idNacionalidad and na.pkAutor = a.idAutor;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := AUX.nombres || ' '|| AUX.apellidos || ' nacimiento: ' || AUX.nacimiento || ' fallecimiento: ' || AUX.fallecimiento || ' nacionalidad: ' || AUX.nacionalidad;
END LOOP;
    
RETURN (RESULTADO);
END;

CREATE OR REPLACE function partes(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(4000);
CURSOR BUSQUEDA IS select lower(p.tipo) tipo, lower(p.nombre) nombre
                   from parte p, obra o
                   where o.idObra = id
                   and o.idObra = p.fkObra
                   order by p.idParte;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := RESULTADO || '- ' || AUX.tipo || ': '|| AUX.nombre || '  ';
END LOOP;
    
RETURN (RESULTADO);
END;

CREATE OR REPLACE function fechas_obra(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(4000);
NRO NUMBER(2);
CURSOR BUSQUEDA IS select to_char(fp.fecha, 'dd/mm/yyyy, hh:mi:ssam') fecha
                   from fecha_presentacion fp, obra o
                   where o.idObra = id
                   and fp.fkOBra = o.idObra;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
NRO := 1;
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := RESULTADO || '  ' || NRO || '- ' || AUX.fecha;
     NRO := NRO + 1;
END LOOP;
    
RETURN (RESULTADO);
END;

CREATE OR REPLACE function personajeCantante(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(4000);

CURSOR BUSQUEDA IS  select to_char(fp.fecha, 'dd/mm/yyyy hh:mi:ssam') presentacion, lower(p.nombre) personaje, lower(nombres(c.nombreCompleto)) nombres, lower(apellidos(c.nombreCompleto)) apellidos, v.nombre voz
                   from obra o, personaje p, cantante c, fecha_presentacion fp, voz v, elenco e, cantante_voz cv
                   where o.idObra = id 
                   and fp.fkObra = o.idObra
                   and o.idObra = p.fkObra
                   and e.pkPersonaje = p.idPersonaje
                   and e.pkCantante = c.idCantante
                   and e.pkFechaPresentacion = fp.idFP
                   and c.idCantante = cv.pkCantante
                   and v.idVoz = cv.pkVoz
                   order by fp.fecha, p.idPersonaje;
AUX  BUSQUEDA % ROWTYPE;

BEGIN

FOR AUX IN BUSQUEDA LOOP

      RESULTADO := RESULTADO ||AUX.presentacion ||' '|| AUX.personaje || ' : ' || AUX.nombres || ' ' || AUX.apellidos;
    
END LOOP;
    
RETURN (RESULTADO);
END;

CREATE OR REPLACE function musicosObra(id IN NUMBER)
RETURN varchar2 IS
RESULTADO varchar2(4000);

CURSOR BUSQUEDA IS  select to_char(fp.fecha, 'dd/mm/yyyy hh:mi:ssam') presentacion, lower(i.nombre) instrumento, lower(nombres(m.nombreCompleto)) nombres, lower(apellidos(m.nombreCompleto)) apellidos
                   from obra o, fecha_presentacion fp, musico m, musico_obra mo, musico_instrumento mi, instrumento i
                   where o.idObra = id 
                   and fp.fkObra = o.idObra
                   and fp.idFP = mo.pkPresentacion
                   and m.idMusico = mi.pkMusico
                   and i.idInstrumento = mi.pkInstrumento;
AUX  BUSQUEDA % ROWTYPE;

BEGIN

FOR AUX IN BUSQUEDA LOOP
  
        RESULTADO := RESULTADO ||'- '||AUX.presentacion ||' '|| AUX.instrumento || ' : ' || AUX.nombres || ' ' || AUX.apellidos || ' ';
    
END LOOP;
    
RETURN (RESULTADO);
END;


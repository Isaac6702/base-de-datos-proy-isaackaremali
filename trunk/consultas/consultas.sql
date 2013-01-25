create or replace procedure CT_Asientos_vendidos(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
select o.nombre obra, z.nombre Zona, a.nombre asiento 
from entrada e, fecha_presentacion fp,ubicacion z, ubicacion a, obra o  
where a.fkubicacion = z.idubicacion AND a.tipo = 'asiento' AND e.fkubicacion = a.idubicacion AND  e.FKPRESENTACION = fp.idfp AND fp.FKOBRA = o.idobra AND e.PAGADA = 1;

END;
/
create or replace procedure CT_Asientos_restantes(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR

select o.nombre obra, z.nombre Zona, a.nombre asiento 
from entrada e, fecha_presentacion fp,ubicacion z, ubicacion a, OBRA o
where a.fkubicacion = z.idubicacion AND a.tipo = 'asiento' AND e.fkubicacion = a.idubicacion AND  e.FKPRESENTACION = fp.idfp 
AND fp.FKOBRA = o.idobra AND e.FKPRESENTACION = fp.IDFP AND e.PAGADA = 0 and rownum<=5; 
END;
/
create or replace procedure CT_entradas_vendidas(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
select o.nombre opera, z.nombre Ubicacion,  (COUNT(a.idubicacion) - entradas_restantes(COUNT(a.idubicacion), Z.IDUBICACION, o.idobra)) total 
, entradas_restantes(COUNT(a.idubicacion), Z.IDUBICACION, o.idobra) restantes, e.COSTO
from ubicacion z, ubicacion a, ubicacion p, obra o, entrada e
where z.fkubicacion = p.idubicacion AND a.fkubicacion = z.idubicacion AND e.FKUBICACION = a.idubicacion
GROUP BY z.idubicacion, z.nombre, o.nombre, o.idobra, e.COSTO;
END;
/
create or replace procedure CT_entradas_vendidas_momento(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
select o.nombre obra, COUNT(e.identrada) "TOTAL ENTRADAS", to_char(fp.fecha,'dd/mm/yy') "FECHA PRESENTACION" ,to_char(o.FECHAVENTA,'dd/mm/yy') " FECHA DE VENTA" 
from entrada e, fecha_presentacion fp,ubicacion z, ubicacion a, obra o  
where a.fkubicacion = z.idubicacion AND a.tipo = 'asiento' AND e.fkubicacion = a.idubicacion AND  e.FKPRESENTACION = fp.idfp AND fp.FKOBRA = o.idobra AND e.PAGADA = 1
GROUP BY o.nombre, fp.fecha, o.FECHAVENTA; 
END;
/
create or replace procedure CT_Bailarines(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
select  l.nombre pais, l.idlugar, b.pasaporte pasaporte, nombres(b.NOMBRECOMPLETO) nombres, apellidos(b.NOMBRECOMPLETO) apellidos,
        n.nombre nacionalidad, consultar_direccion(b.FKLUGAR, b.DETALLEDIRECCION)direccion, consultar_telefonos(b.telefono) telefonos,
        antiguedad(tc.FECHAINICIO) antiguedad , ballet_anteriores(b.idbailarin) balletAnteriores, estudios_bailarin(idBailarin) estudios,
        b.foto
        from BAILARIN b, NACIONALIDAD_BAILARIN nb, NACIONALIDAD n, trabajador_cargo tc, lugar l
        WHERE nb.PKBAILARIN = b.IDBAILARIN AND nb.PKNACIONALIDAD = n.IDNACIONALIDAD AND tc.FKBAILARIN = b.IDBAILARIN
        AND n.fkpais = l.idlugar AND b.invitado = 0;    
END;
/
create or replace procedure CT_Bailarines_invitados(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
select l.nombre pais, l.idlugar, b.pasaporte pasaporte, nombres(b.NOMBRECOMPLETO) nombres, apellidos(b.NOMBRECOMPLETO) apellidos, n.nombre nacionalidad,
        consultar_direccion(b.FKLUGAR, b.DETALLEDIRECCION)direccion, consultar_telefonos(b.telefono) telefonos, antiguedad(tc.FECHAINICIO) antiguedad ,
        ballet_anteriores(b.idbailarin) balletAnteriores, estudios_bailarin(idbailarin) estudios, Bailarini_obras(idbailarin) Obras, b.foto foto  
        from BAILARIN b, NACIONALIDAD_BAILARIN nb, NACIONALIDAD n, trabajador_cargo tc, lugar l 
        WHERE nb.PKBAILARIN = b.IDBAILARIN AND nb.PKNACIONALIDAD = n.IDNACIONALIDAD AND tc.FKBAILARIN = b.IDBAILARIN
        AND n.fkpais = l.idlugar AND b.invitado = 1;

END;
/
create or replace procedure CT_Cantante(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
    select voz_cantante (c.idcantante) voz,c.pasaporte pasaporte, l.nombre pais, l.idlugar, nombres(c.NOMBRECOMPLETO) nombres,
        apellidos(c.NOMBRECOMPLETO) apellidos, n.nombre nacionalidad, consultar_direccion(c.FKLUGAR, c.DETALLEDIRECCION)direccion,
        consultar_telefonos(c.telefono) telefonos, antiguedad(tc.FECHAINICIO) antiguedad,  estudios_cantante(idcantante) estudios, c.foto 
    from CANTANTE c, NACIONALIDAD_CANTANTE nc, NACIONALIDAD n, trabajador_cargo tc, lugar l
    WHERE nc.PKCANTANTE = c.IDCANTANTE AND nc.PKNACIONALIDAD = n.IDNACIONALIDAD AND tc.FKCANTANTE = c.IDCANTANTE
            AND n.fkpais = l.idlugar AND c.invitado = 0;

END;
/
create or replace procedure CT_Cargo(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
    select c.NOMBRE cargo, d.NOMBRE departamento, d.TIEMPOASCENSO tiempo, c.TIPOASCENSO "TIPO DE ASCENSO"
    from cargo c, departamento d 
    where c.FKDEPARTAMENTO = d.IDDEPARTAMENTO;

END;
/
create or replace procedure CT_Coreografo (REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
    select consultar_direccion(co.fklugar, co.detalleDireccion) direccion, idcoreografo id, co.pasaporte pasaporte ,
    Nombres(NOMBRECOMPLETO) nombres, apellidos(NOMBRECOMPLETO) apellidos, consultar_telefonos(TELEFONO) telefonos,
    c.nombre cargo, Antiguedad(tc.FECHAINICIO)antiguedad, n.nombre nacionalidad, co.foto
    from coreografo co, cargo c, NACIONALIDAD_COREOGRAFO nc, nacionalidad n, trabajador_cargo tc
    where tc.FKCARGO = c.IDCARGO AND co.idcoreografo = tc.FKCOREOGRAFO AND  invitado = 0 AND nc.PKCOREOGRAFO = co.idcoreografo
        AND nc.PKNACIONALIDAD = n.idnacionalidad AND tc.FECHAFIN is NULL;

END;
/
create or replace procedure CT_DM (REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
    select consultar_direccion(dm.fklugar, dm.detalleDireccion) direccion, IDDM id, dm.pasaporte pasaporte ,
    Nombres(NOMBRECOMPLETO) Nombres, Apellidos(NOMBRECOMPLETO) Apellidos, consultar_telefonos(TELEFONO) telefonos,
    c.nombre cargo, Antiguedad(tc.FECHAINICIO) antiguedad, consultar_obras_DM(dm.iddm) obras, dm.FALLECIMIENTO,
    n.nombre nacionalidad, dm.foto foto
    from director_musical dm, cargo c, trabajador_cargo tc, nacionalidad n, NACIONALIDAD_DM nd
    where tc.FKCARGO = c.IDCARGO AND dm.IDDM = tc.FKDM  AND invitado = 0  AND nd.PKDM = dm.iddm
    AND nd.PKNACIONALIDAD = n.idnacionalidad;

END;
/
create or replace procedure CT_DO (REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
    select d.pasaporte ,l.nombre pais, l.idlugar, nombres(d.NOMBRECOMPLETO) nombres, apellidos(d.NOMBRECOMPLETO) apellidos,
    n.nombre nacionalidad, consultar_direccion(d.FKLUGAR, d.DETALLEDIRECCION)direccion, consultar_telefonos(d.telefono) telefonos,
    antiguedad(tc.FECHAINICIO) antiguedad, consultar_obras_d(idDirector) obra, estudios_director(iddirector) estudios, d.foto foto
    from DIRECTOR d, NACIONALIDAD_DIRECTOR nd, NACIONALIDAD n, trabajador_cargo tc, lugar l
    WHERE nd.PKDIRECTOR = d.IDDIRECTOR AND nd.PKNACIONALIDAD = n.IDNACIONALIDAD AND tc.FKDIRECTOR = d.IDDIRECTOR
    AND n.fkpais = l.idlugar AND d.invitado = 0;

END;
/
create or replace procedure CT_Escenografo (REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
    select consultar_direccion(e.fklugar, e.detalleDireccion) direccion, IDESCENOGRAFO id, e.pasaporte pasaporte ,
        nombres(NOMBRECOMPLETO) nombres,  apellidos(NOMBRECOMPLETO) apellidos, consultar_telefonos(TELEFONO) telefonos,
        c.nombre cargo, Antiguedad(tc.FECHAINICIO) antiguedad , n.nombre nacionalidad, e.foto foto
        from ESCENOGRAFO e, cargo c, trabajador_cargo tc, nacionalidad n, NACIONALIDAD_ESCENOGRAFO ne
        where tc.FKCARGO = c.IDCARGO AND e.IDESCENOGRAFO = tc.FKESCENOGRAFO AND tc.FECHAFIN is NULL
        AND invitado = 0 AND ne.PKNACIONALIDAD = n.idnacionalidad AND ne.PKESCENOGRAFO = e.idescenografo;

END;
/
create or replace procedure CT_Musico (REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
    select m.pasaporte, l.nombre pais, l.idlugar, nombres(m.NOMBRECOMPLETO) nombres, apellidos(m.NOMBRECOMPLETO) apellidos,
    n.nombre nacionalidad, consultar_direccion(m.FKLUGAR, m.DETALLEDIRECCION)direccion, consultar_telefonos(m.telefono) telefonos,
    antiguedad(tc.FECHAINICIO) antiguedad, consultar_obras_m(idMusico) "POSICION OBRA", estudios_musico(idMusico) estudios,
    musico_instrument(idMusico) instrumento, musico_orquest(idMusico) orquesta, consultar_obras_m(idMusico) obra,
    musico_instrumentP(idMusico) " INSTRUMENTO POSICION", m.foto foto
    from MUSICO m, NACIONALIDAD_MUSICO nm, NACIONALIDAD n, trabajador_cargo tc, lugar l
    WHERE nm.PKMUSICO = m.IDMUSICO AND nm.PKNACIONALIDAD = n.IDNACIONALIDAD AND tc.FKMUSICO = m.IDMUSICO
    AND n.fkpais = l.idlugar AND m.invitado = 0;

END;
/
create or replace procedure CT_Musico_invitado (REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
    select m.pasaporte, l.nombre pais, l.idlugar, nombres(m.NOMBRECOMPLETO) nombres, apellidos(m.NOMBRECOMPLETO) apellidos,
    n.nombre nacionalidad, consultar_direccion(m.FKLUGAR, m.DETALLEDIRECCION)direccion, consultar_telefonos(m.telefono) telefonos,
    antiguedad(tc.FECHAINICIO) antiguedad, consultar_obras_m(idMusico) Posiconobra, estudios_musico(idMusico) estudios,
    musico_instrument(idMusico) instrumento, musico_orquest(idMusico) orquesta, consultar_obras_m(idMusico) obra,
    musico_instrumentP(idMusico) "INSTRUMENTO POSICION", m.foto foto
    from MUSICO m, NACIONALIDAD_MUSICO nm, NACIONALIDAD n, trabajador_cargo tc, lugar l
    WHERE nm.PKMUSICO = m.IDMUSICO AND nm.PKNACIONALIDAD = n.IDNACIONALIDAD AND tc.FKMUSICO = m.IDMUSICO
    AND n.fkpais = l.idlugar AND m.invitado = 1;

END;
/
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
/
create or replace procedure CT_Audio(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
    select datosObraAutor(o.idObra) obra, datosDirectores(o.idObra) directores, to_char(fp.fecha,'dd/mm/yyyy hh:mi:ssam') fecha, datosOrquesta(o.idObra) orquesta, a.formato formato
    from obra o, fecha_presentacion fp, audio a
    where fp.fkObra = o.idObra
    and a.fkpresentacion = fp.idFP
    order by o.idObra, fp.fecha;

END;
/
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
create or replace procedure CT_COMPRADOR(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
select u.idUsuario "ID", nombres(u.nombre) "NOMBRES", apellidos(u.nombre) "APELLIDOS", n.nombre "NACIONALIDAD", consultar_direccion(u.fkLugar, u.detalleDireccion) "DIRECCION", metodoPagoFactura(u.idUsuario, f.idFactura) "METODO DE PAGO", datosObraComprador(u.idUsuario, f.idFactura) "OBRAS", ticketsComprados(f.idFactura) "NRO TICKETS", nombreUbicacion(f.idFactura) "UBICACION", nombreAsientos(f.idFactura) "ASIENTOS", aux.monto "TOTAL NACIONAL", montoExtranjero(f.idFactura) "TOTAL EXTRANJERO"
from usuario u, factura f, nacionalidad n, (select f.idFactura factura, sum(df.monto) monto
                                            from factura f, detalle_factura df
                                            where f.idFactura = df.fkfactura
                                            group by idFactura) aux,
(select lower(o.nombre)obra, to_char(fp.fecha, 'dd/mm/yyyy hh24:mi:ss') presentacion, f.idFactura factura
 from fecha_presentacion fp, obra o, entrada e, detalle_factura df, factura f
 where fp.fkobra = o.idobra
 and df.fkEntrada = e.identrada
 and e.fkpresentacion = fp.idfp
 and f.idfactura = df.fkfactura) a
where u.idUsuario = f.fkUsuario
and n.idnacionalidad = u.fknacionalidad
and aux.factura = f.idFactura
and a.factura = f.idFactura
order by u.idusuario, f.idfactura;

END;
/
CREATE OR REPLACE function montoExtranjero (id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select lower(m.nombre) nombre, p.costoExtranjero extranjero
                    from factura f, pago p, moneda m
                    where f.idFactura = id
                    and p.fkFactura = f.idFactura
                    and m.idMoneda = p.fkMoneda;
                   
AUX  BUSQUEDA % ROWTYPE;

BEGIN

FOR AUX IN BUSQUEDA LOOP
    if AUX.nombre = 'libra' then
        
        RESULTADO := 'no aplica';
    else
        RESULTADO := AUX.extranjero || ' ' || AUX.nombre || 's';
    end if;
    
END LOOP;
    
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE function nombreAsientos (id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BOOLEAN NUMBER(1);
CURSOR BUSQUEDA IS select lower(x.nombre) ubicacion
                    from factura f, detalle_factura df, ubicacion x, entrada e
                    where f.idFactura = ID
                    and f.idFactura = df.fkFactura
                    and e.idEntrada = df.fkEntrada
                    and e.fkUbicacion = x.idUbicacion;
                   
AUX  BUSQUEDA % ROWTYPE;

BEGIN
BOOLEAN := 0;
FOR AUX IN BUSQUEDA LOOP
    if BOOLEAN = 0 then
        BOOLEAN := 1;
        RESULTADO := AUX.ubicacion;
    else
        RESULTADO := RESULTADO || ', ' || AUX.ubicacion;
    end if;
    
END LOOP;
    
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE function nombreUbicacion (id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BOOLEAN NUMBER(1);
CURSOR BUSQUEDA IS select lower(u.nombre) ubicacion
                    from factura f, detalle_factura df, ubicacion u, ubicacion x, entrada e
                    where f.idFactura = ID
                    and f.idFactura = df.fkFactura
                    and e.idEntrada = df.fkEntrada
                    and e.fkUbicacion = x.idUbicacion
                    and x.fkUbicacion = u.idUbicacion;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
BOOLEAN := 0;
FOR AUX IN BUSQUEDA LOOP
    if BOOLEAN = 0 then
        BOOLEAN := 1;
        RESULTADO := AUX.ubicacion;
    else
        RESULTADO := RESULTADO || ', ' || AUX.ubicacion;
    end if;
    
END LOOP;
    
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE function ticketsComprados (id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BOOLEAN NUMBER(1);
CURSOR BUSQUEDA IS select count(*) ticket
                   from detalle_factura df, factura f
                   where f.idFactura = id
                   and f.idFactura = df.fkFactura;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
    RESULTADO := AUX.ticket;
END LOOP;
    
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE function datosObraComprador(id IN NUMBER, fact IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BOOLEAN NUMBER(1);
CURSOR BUSQUEDA IS select lower(o.nombre) obra, to_char(fp.fecha, 'dd/mm/yyyy hh24:mi:ssam') fecha
                    from obra o, fecha_presentacion fp, entrada e, detalle_factura df, factura f, usuario u
                    where u.idUsuario = id
                    and f.idFactura = fact
                    and o.idObra = fp.fkObra
                    and fp.idFP = e.fkPresentacion
                    and e.idEntrada = df.fkEntrada
                    and f.idFactura = df.fkFactura
                    and u.idUsuario = f.fkUsuario;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
BOOLEAN := 0;
FOR AUX IN BUSQUEDA LOOP
    if BOOLEAN = 0 then
        BOOLEAN := 1;
        RESULTADO :=  '- '|| AUX.obra || ' ' || AUX.fecha;
    elsif BOOLEAN = 1 then 
        RESULTADO := RESULTADO ||'- '|| AUX.obra || ' ' || AUX.fecha;
    end if;
END LOOP;
    
RETURN (RESULTADO);
END;
/
CREATE OR REPLACE function metodoPagoFactura(id IN NUMBER, fact IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BOOLEAN NUMBER(1);
CURSOR BUSQUEDA IS select p.formaPago pago
                   from usuario u, pago p, factura f
                   where u.idUsuario = id
                   and u.idUsuario = f.fkUsuario
                   and p.fkFactura = fact 
                   and f.idFactura = p.fkFactura;
                
AUX  BUSQUEDA % ROWTYPE;

BEGIN
BOOLEAN:= 0;
FOR AUX IN BUSQUEDA LOOP
    if AUX.pago = 'tdc' and BOOLEAN = 0 then
        BOOLEAN := 1;
        RESULTADO := 'tarjeta de credito';
    elsif AUX.pago = 'tdd' and BOOLEAN = 0 then
        BOOLEAN := 1;
        RESULTADO := 'tarjeta de debito';
    elsif AUX.pago = 'efectivo' and BOOLEAN = 0 then
        BOOLEAN := 1;
        RESULTADO := 'efectivo';
    elsif AUX.pago = 'tdc' and BOOLEAN = 1 then
        BOOLEAN := 1;
        RESULTADO := RESULTADO  || ', tarjeta de credito';
    elsif AUX.pago = 'tdd' and BOOLEAN = 1 then
        BOOLEAN := 1;
        RESULTADO := RESULTADO  || ', tarjeta de debito';
    elsif AUX.pago = 'efectivo' and BOOLEAN = 1 then
        BOOLEAN := 1;
        RESULTADO := RESULTADO || ', efectivo';
    end if;
END LOOP;
    
RETURN (RESULTADO);
END;
/
create or replace procedure CT_obraMasVendida(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   SELECT lower(t.obra) "OBRA", total "CANTIDAD"
   FROM (select o.nombre obra, SUM(DF.CANTIDAD) TOTAL
        from obra o, FECHA_PRESENTACION fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where fp.fkobra = o.idobra AND a.FKPRESENTACION = fp.idfp
        AND v.FKPRESENTACION = fp.idfp AND (v.idvideo =df.fkvideo 
        or a.idaudio=df.fkaudio )
        GROUP BY o.nombre
        ORDER BY SUM(DF.CANTIDAD) desc) t
   where rownum<=1;
END;
/
create or replace procedure CT_balletMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(b.nombre) "BALLET", sum(d.cantidad) "CANTIDAD"
         from obra o, detalle_factura_digitalizada d, audio au, fecha_presentacion f, video v, ballet b
         where b.idBallet = o.fkBallet 
         and (d.fkAudio = au.idAudio or d.fkVideo = v.idVideo)
         and (au.fkPresentacion = f.idFP and v.fkPresentacion = f.idFP)
         and f.fkObra = o.idObra
         group by idBallet, b.nombre
         order by sum(d.cantidad) desc) aut
   where rownum <=1;
END;
/
create or replace procedure CT_orquestaMasVendida(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(orq.nombre) "ORQUESTA", sum(d.cantidad) "CANTIDAD"
         from obra o, detalle_factura_digitalizada d, audio au, fecha_presentacion f, video v, orquesta orq
         where orq.idOrquesta = o.fkOrquesta 
         and (d.fkAudio = au.idAudio or d.fkVideo = v.idVideo)
         and (au.fkPresentacion = f.idFP and v.fkPresentacion = f.idFP)
         and f.fkObra = o.idObra
   group by idOrquesta, orq.nombre
   order by sum(d.cantidad) desc) aut
   where rownum <=1;
END;
/
create or replace procedure CT_autorMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(nombreCompleto)) "NOMBRE", lower(apellidos(nombreCompleto)) "APELLIDO", sum(d.cantidad) "CANTIDAD"
         from autor a, obra o, detalle_factura_digitalizada d, audio au, fecha_presentacion f, video v
         where a.idAutor = o.fkAutor 
         and (d.fkAudio = au.idAudio or d.fkVideo = v.idVideo)
         and (au.fkPresentacion = f.idFP and v.fkPresentacion = f.idFP)
         and f.fkObra = o.idObra
         group by idAutor, a.pasaporte, nombres(nombreCompleto), apellidos(nombreCompleto)
         order by sum(d.cantidad) desc) aut
   where rownum <=1;
END;
/
create or replace procedure CT_directorMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   SELECT *
   FROM (select lower(nombres(d.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(d.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD" 
           from obra o, director d, FECHA_PRESENTACION fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
           where o.fkdirector = d.IDDIRECTOR AND fp.fkobra = o.idobra AND a.FKPRESENTACION = fp.IDFP AND v.FKPRESENTACION = fp.IDFP AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio)
           GROUP BY nombres(d.NOMBRECOMPLETO), apellidos(d.NOMBRECOMPLETO)
           ORDER BY sum(df.monto) DESC) t
   WHERE rownum <=1;
END;
/
create or replace procedure CT_mezzoMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 2 
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad) desc)aux
where rownum <=1;
END;
/
create or replace procedure CT_tenorMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 4 
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad) desc)aux
where rownum <=1;
END;
/
create or replace procedure CT_baritonoMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 5 
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad) desc)aux
where rownum <=1;
END;
/
create or replace procedure CT_bajoMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 2
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad) desc)aux
where rownum <=1;
END;
/
create or replace procedure CT_contraltoMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 3
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad) desc)aux
where rownum <=1;
END;
/
create or replace procedure CT_sopranoMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 1
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad) desc)aux
where rownum <=1;
END;
/
create or replace procedure CT_obraMenosVendida(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   SELECT lower(t.obra) "OBRA", total "CANTIDAD"
   FROM (select o.nombre obra, SUM(DF.CANTIDAD) TOTAL
        from obra o, FECHA_PRESENTACION fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where fp.fkobra = o.idobra AND a.FKPRESENTACION = fp.idfp
        AND v.FKPRESENTACION = fp.idfp AND (v.idvideo =df.fkvideo 
        or a.idaudio=df.fkaudio )
        GROUP BY o.nombre
        ORDER BY SUM(DF.CANTIDAD)  ) t
   where rownum<=1;
END;
/
create or replace procedure CT_balletMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(b.nombre) "BALLET", sum(d.cantidad) "CANTIDAD"
         from obra o, detalle_factura_digitalizada d, audio au, fecha_presentacion f, video v, ballet b
         where b.idBallet = o.fkBallet 
         and (d.fkAudio = au.idAudio or d.fkVideo = v.idVideo)
         and (au.fkPresentacion = f.idFP and v.fkPresentacion = f.idFP)
         and f.fkObra = o.idObra
         group by idBallet, b.nombre
         order by sum(d.cantidad)  ) aut
   where rownum <=1;
END;
/
create or replace procedure CT_orquestaMenosVendida(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(orq.nombre) "ORQUESTA", sum(d.cantidad) "CANTIDAD"
         from obra o, detalle_factura_digitalizada d, audio au, fecha_presentacion f, video v, orquesta orq
         where orq.idOrquesta = o.fkOrquesta 
         and (d.fkAudio = au.idAudio or d.fkVideo = v.idVideo)
         and (au.fkPresentacion = f.idFP and v.fkPresentacion = f.idFP)
         and f.fkObra = o.idObra
   group by idOrquesta, orq.nombre
   order by sum(d.cantidad)  ) aut
   where rownum <=1;
END;
/
create or replace procedure CT_autorMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(nombreCompleto)) "NOMBRE", lower(apellidos(nombreCompleto)) "APELLIDO", sum(d.cantidad) "CANTIDAD"
         from autor a, obra o, detalle_factura_digitalizada d, audio au, fecha_presentacion f, video v
         where a.idAutor = o.fkAutor 
         and (d.fkAudio = au.idAudio or d.fkVideo = v.idVideo)
         and (au.fkPresentacion = f.idFP and v.fkPresentacion = f.idFP)
         and f.fkObra = o.idObra
         group by idAutor, a.pasaporte, nombres(nombreCompleto), apellidos(nombreCompleto)
         order by sum(d.cantidad)  ) aut
   where rownum <=1;
END;
/
create or replace procedure CT_directorMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   SELECT *
   FROM (select lower(nombres(d.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(d.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD" 
           from obra o, director d, FECHA_PRESENTACION fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
           where o.fkdirector = d.IDDIRECTOR AND fp.fkobra = o.idobra AND a.FKPRESENTACION = fp.IDFP AND v.FKPRESENTACION = fp.IDFP AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio)
           GROUP BY nombres(d.NOMBRECOMPLETO), apellidos(d.NOMBRECOMPLETO)
           ORDER BY sum(df.monto)  ) t
   WHERE rownum <=1;
END;
/
create or replace procedure CT_mezzoMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 2 
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad)  )aux
where rownum <=1;
END;
/
create or replace procedure CT_tenorMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 4 
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad)  )aux
where rownum <=1;
END;
/
create or replace procedure CT_baritonoMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 5 
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad)  )aux
where rownum <=1;
END;
/
create or replace procedure CT_bajoMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 2
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad))aux
where rownum <=1;
END;
/
create or replace procedure CT_contraltoMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 3
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad))aux
where rownum <=1;
END;
/
create or replace procedure CT_sopranoMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 1
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad))aux
where rownum <=1;
END;
/
create or replace procedure precio_entradas(REC_CUR OUT SYS_REFCURSOR) is
BEGIN
OPEN REC_CUR FOR
    select lower(o.nombre) nombre, to_char(fp.fecha, 'dd/mm/yyyy hh:mi:ssam') presentacion, u.nombre ubicacion, (u.porcentaje*fp.zonamascara) precio
    from obra o, fecha_presentacion fp, ubicacion u
    where fp.fkObra = o.idObra and u.tipo = 'zona'
    order by o.nombre, fp.fecha;

END;
  /
create or replace procedure numero_programas(REC_CUR OUT SYS_REFCURSOR) is
BEGIN
OPEN REC_CUR FOR
    select lower(o.nombre) obra, ((2258 * a.nroPresentaciones) - count(fp.idfp)) programas
    from entrada e, obra o, fecha_presentacion fp, ( select o.idobra id, count(idFP) nroPresentaciones
                                                     from fecha_presentacion fp, obra o
                                                     where fp.fkObra = o.idObra group by o.idobra) a
    where fp.fkObra = o.idObra and e.pagada = 0 and fp.idfp = e.fkpresentacion and a.id = o.idObra group by o.nombre, a.nroPresentaciones;

END;
/ 
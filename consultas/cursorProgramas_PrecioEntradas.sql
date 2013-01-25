create or replace procedure precio_entradas(REC_CUR OUT SYS_REFCURSOR) is
BEGIN
OPEN REC_CUR FOR
    select lower(o.nombre) nombre, to_char(fp.fecha, 'dd/mm/yyyy hh:mi:ssam') presentacion, u.nombre ubicacion, (u.porcentaje*fp.zonamascara) precio
    from obra o, fecha_presentacion fp, ubicacion u
    where fp.fkObra = o.idObra and u.tipo = 'zona'
    order by o.nombre, fp.fecha;

END;
  

create or replace procedure numero_programas(REC_CUR OUT SYS_REFCURSOR) is
BEGIN
OPEN REC_CUR FOR
    select lower(o.nombre) obra, ((2258 * a.nroPresentaciones) - count(fp.idfp)) programas
    from entrada e, obra o, fecha_presentacion fp, ( select o.idobra id, count(idFP) nroPresentaciones
                                                     from fecha_presentacion fp, obra o
                                                     where fp.fkObra = o.idObra group by o.idobra) a
    where fp.fkObra = o.idObra and e.pagada = 0 and fp.idfp = e.fkpresentacion and a.id = o.idObra group by o.nombre, a.nroPresentaciones;

END;
   
  


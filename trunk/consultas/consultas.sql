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
create or replace procedure CT_Asientos_vendidos(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
select o.nombre obra, z.nombre Zona, a.nombre asiento 
from entrada e, fecha_presentacion fp,ubicacion z, ubicacion a, obra o  
where a.fkubicacion = z.idubicacion AND a.tipo = 'asiento' AND e.fkubicacion = a.idubicacion AND  e.FKPRESENTACION = fp.idfp AND fp.FKOBRA = o.idobra AND e.PAGADA = 1;

END;
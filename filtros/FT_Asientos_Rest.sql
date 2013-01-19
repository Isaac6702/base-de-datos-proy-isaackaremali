
create or replace PROCEDURE FT_Asientos_Rest(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  CURSOR BUSQUEDA IS select o.nombre obra, z.nombre Zona, a.nombre asiento 
                        from entrada e, fecha_presentacion fp,ubicacion z, ubicacion a, OBRA o
                        where a.fkubicacion = z.idubicacion AND a.tipo = 'asiento' AND e.fkubicacion = a.idubicacion AND  e.FKPRESENTACION = fp.idfp 
                        AND fp.FKOBRA = o.idobra AND e.FKPRESENTACION = fp.IDFP AND e.PAGADA = 0 and rownum<=5; 
  fila BUSQUEDA%ROWTYPE;
  v_query     VARCHAR2(2550);
  obra varchar2(2000);
  ubicacion varchar2(2000);
  
BEGIN
    obra:= split(buscador ,1,',');
    ubicacion:= split(buscador ,2,',');
  v_query := 'select o.nombre obra, z.nombre Zona, a.nombre asiento 
                        from entrada e, fecha_presentacion fp,ubicacion z, ubicacion a, OBRA o
                        where a.fkubicacion = z.idubicacion AND a.tipo = ''asiento'' AND e.fkubicacion = a.idubicacion AND  e.FKPRESENTACION = fp.idfp 
                        AND fp.FKOBRA = o.idobra AND e.FKPRESENTACION = fp.IDFP AND e.PAGADA = 0 and rownum<=5';
                        
    IF obra != 'null' THEN
     v_query := v_query || 'AND  o.nombre like ''%'||obra||'%''';
    END IF;
    IF ubicacion != 'null' THEN
     v_query := v_query || 'AND  z.nombre like''%'||ubicacion||'%''';
    END IF;
    
 
  OPEN REC_CUR FOR v_query;

END; 
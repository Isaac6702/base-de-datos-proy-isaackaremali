
create or replace procedure obras(REC_CUR OUT SYS_REFCURSOR) is
BEGIN
OPEN REC_CUR FOR
    select lower(o.nombre) nombre from obra o order by o.nombre;
END;
  

create or replace procedure monedas(REC_CUR OUT SYS_REFCURSOR) is
BEGIN
OPEN REC_CUR FOR
    select lower(m.nombre) nombre from moneda m order by nombre;
END;
        
  

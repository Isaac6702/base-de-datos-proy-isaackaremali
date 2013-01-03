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
    

    

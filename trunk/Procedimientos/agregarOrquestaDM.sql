create or replace PROCEDURE agregarOrquestaDM (dm IN NUMBER, orquesta IN NUMBER, fechaInicio IN DATE, fechaFin IN DATE) IS
BEGIN
    INSERT INTO DM_ORQUESTA
        (pkDM, pkOrquesta, fechaInicio, fechaFin)
    VALUES
        (dm, orquesta, to_date(fechaInicio, 'dd/mm/yyyy'), to_date(fechaFin, 'dd/mm/yyyy'));
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;    
create or replace PROCEDURE agregarInstrumentoMusico (musico IN NUMBER, instrumento IN NUMBER, ppal IN NUMBER, fecha IN DATE) IS
BEGIN
    INSERT INTO MUSICO_INSTRUMENTO
    (pkMusico, pkInstrumento, instrumentoPrincipal, fechaEjecucion)
    VALUES
    (musico, instrumento, ppal, to_date(fecha, 'dd/mm/yyyy'));
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;



  
create or replace PROCEDURE validarFechaFin(fechaInicio IN DATE, fechaFin IN DATE) IS

BEGIN
if fechaFin < fechaInicio then
    RAISE_APPLICATION_ERROR(-20000,'La fecha de fin debe ser mayor a la fecha de inicio');
end if;    
END;
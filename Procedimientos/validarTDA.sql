create or replace PROCEDURE validarTDA(nombreCompleto IN DATOS_PERSONALES, telefonos IN TELEFONOS ) IS
BEGIN

if nombreCompleto.primerNombre is  null then
    
      RAISE_APPLICATION_ERROR(-20000,'Debe introducir al menos el Primer nombre');
    end if;
    
    if telefonos is null then
    
      RAISE_APPLICATION_ERROR(-20000,'Debe introducir al menos un numero de telefono');
    end if;
    
    if nombreCompleto.primerNombre is  null  then
    
      RAISE_APPLICATION_ERROR(-20000,'Debe introducir al menos el Primer nombre');
    end if;
    
END;
create or replace PROCEDURE insertUsuario(pasaporte IN NUMBER, nombreCompleto IN DATOS_PERSONALES, telefonos IN TELEFONOS, sexo IN VARCHAR2, fechaNacimiento IN DATE, fkLugar IN NUMBER, detalleDireccion IN VARCHAR2, nacionalidad IN NUMBER, fkIdioma IN NUMBER) IS

CURSOR BUSQUEDA IS select seqUsuario.NEXTVAL  from dual;
ID BUSQUEDA % ROWTYPE;

BEGIN
FOR ID IN BUSQUEDA LOOP

    validarTDA(nombreCompleto, telefonos);
    validarNacionalidad(sexo, nacionalidad);      

    insert into USUARIO
        (IDUSUARIO, PASAPORTE, NOMBRE, DETALLEDIRECCION, TELEFONO, SEXO, FECHANACIMIENTO, FKLUGAR, FKIDIOMA, FKNACIONALIDAD)
    values
        (ID.NEXTVAL, pasaporte, nombreCompleto, detalleDireccion, telefonos, sexo, fechaNacimiento, fkLugar, fkIdioma, nacionalidad);

END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;

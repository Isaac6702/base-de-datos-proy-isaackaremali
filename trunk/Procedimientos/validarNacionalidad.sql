create or replace PROCEDURE validarNacionalidad(sexoPersona IN VARCHAR2, nacionalidad IN NUMBER) IS
CURSOR VALIDAR_SEXO IS select sexo from NACIONALIDAD where idNacionalidad = nacionalidad;
sexoNac VALIDAR_SEXO % ROWTYPE;
BEGIN
if sexoPersona='f' || sexoPersona='m' || sexoPersona='a' then
    for SEXO_NAC IN VALIDAR_SEXO LOOP
        if sexoPersona <> sexoNac then
            RAISE_APPLICATION_ERROR(-20000,'Debe introducir un sexo valido a su nacionalidad');
        end if;
    END LOOP;
else
    RAISE_APPLICATION_ERROR(-20000,'Debe introducir un sexo valido');
end if;    
END;
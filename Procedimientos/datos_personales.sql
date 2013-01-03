CREATE OR REPLACE function primer_nombre (tda DATOS_PERSONALES)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BEGIN

    IF tda.primerNombre IS NOT NULL THEN
        
        RESULTADO := tda.primerNombre;
        
    END IF;
RETURN (RESULTADO);
END;

CREATE OR REPLACE function segundo_nombre (tda DATOS_PERSONALES)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BEGIN

    IF tda.segundoNombre IS NOT NULL THEN
        
        RESULTADO := tda.segundoNombre;
        
    END IF;
RETURN (RESULTADO);
END;


CREATE OR REPLACE function primer_apellido (tda DATOS_PERSONALES)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BEGIN

    IF tda.primerApellido IS NOT NULL THEN
        
        RESULTADO := tda.primerApellido;
        
    END IF;
RETURN (RESULTADO);
END;

CREATE OR REPLACE function segundo_apellido(tda DATOS_PERSONALES)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);

BEGIN

    IF tda.segundoApellido IS NOT NULL THEN
        
        RESULTADO := tda.segundoApellido;
        
    END IF;
RETURN (RESULTADO);
END;

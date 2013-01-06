CREATE OR REPLACE function nombres (tda DATOS_PERSONALES)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BEGIN

    IF tda.primerNombre IS NOT NULL THEN
        
        RESULTADO := tda.primerNombre;
        
    END IF;
     IF tda.segundoNombre IS NOT NULL THEN
        
        RESULTADO := RESULTADO || ' '|| tda.segundoNombre; 
        
    END IF;
    
RETURN (RESULTADO);
END;


CREATE OR REPLACE function apellidos (tda DATOS_PERSONALES)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BEGIN

    IF tda.primerApellido IS NOT NULL THEN
        
        RESULTADO := tda.primerApellido;
        
    END IF;
    
    IF tda.segundoApellido IS NOT NULL THEN
        
        RESULTADO := RESULTADO || ' '|| tda.segundoApellido;
        
    END IF;
    
    
RETURN (RESULTADO);
END;
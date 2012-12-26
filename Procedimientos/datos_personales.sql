CREATE OR REPLACE function consulta_primer_nombre (paramID IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select * from trabajador  WHERE trabajador.IDTRABAJADOR = paramID;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
    IF AUX.NombreCompleto.primerNombre IS NOT NULL THEN
RESULTADO := AUX.NombreCompleto.primerNombre;

END IF;
END LOOP;
    
RETURN (RESULTADO);
END;

CREATE OR REPLACE function consulta_segundo_nombre (paramID IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select * from trabajador  WHERE trabajador.IDTRABAJADOR = paramID;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
    IF AUX.NombreCompleto.segundoNombre IS NOT NULL THEN
RESULTADO := AUX.NombreCompleto.segundoNombre;

END IF;
END LOOP;
    
RETURN (RESULTADO);
END;

CREATE OR REPLACE function consulta_primer_apellido (paramID IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select * from trabajador  WHERE trabajador.IDTRABAJADOR = paramID;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
    IF AUX.NombreCompleto.PrimerApellido IS NOT NULL THEN
RESULTADO := AUX.NombreCompleto.PrimerApellido ;

END IF;
END LOOP;
    
RETURN (RESULTADO);
END;

CREATE OR REPLACE function consulta_segundo_apellido (paramID IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select * from trabajador  WHERE trabajador.IDTRABAJADOR = paramID;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
    IF AUX.NombreCompleto.segundoApellido IS NOT NULL THEN
RESULTADO := AUX.NombreCompleto.segundoApellido ;

END IF;
END LOOP;
    
RETURN (RESULTADO);
END;
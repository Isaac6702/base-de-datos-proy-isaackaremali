CREATE OR REPLACE function consulta_telefonos (paramID IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(500);
CURSOR BUSQUEDA IS select * from trabajador WHERE trabajador.IDTRABAJADOR = paramID;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
    IF AUX.telefono IS NOT NULL THEN
        FOR i IN 1..AUX.telefono.COUNT LOOP
                IF i=1 then
                RESULTADO:= AUX.telefono(i).codigo|| AUX.telefono(i).numero;
                end if;
                IF i>1 then
                RESULTADO:= RESULTADO || ', ' ||AUX.telefono(i).codigo || AUX.telefono(i).numero;
                end if;
                
               
                
        END LOOP;
    END IF;
    IF AUX.telefono IS NULL THEN
    RESULTADO:='';
    END IF;
END LOOP;
RETURN (RESULTADO);
END;

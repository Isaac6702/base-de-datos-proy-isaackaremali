CREATE OR REPLACE function consultar_telefonos (tl telefonos)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(500);
BEGIN

    IF tl  IS NOT NULL THEN
        FOR i IN 1..tl.COUNT LOOP
                IF i=1 then
                RESULTADO:= tl (i).codigo|| tl (i).numero;
                end if;
                IF i>1 then
                RESULTADO:= RESULTADO || ', ' ||tl (i).codigo || tl (i).numero;
                end if;
END LOOP;
    END IF;
    IF tl  IS NULL THEN
    RESULTADO:='';
    END IF;

RETURN (RESULTADO);
END;
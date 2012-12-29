CREATE OR REPLACE FUNCTION antiguedad(fec_inicio IN date) RETURN VARCHAR2
AS
anos number;
meses number;
dias number;
antiguedad varchar2(40);
BEGIN
SELECT floor(months_between(sysdate, fec_inicio )/12) INTO anos FROM dual;
SELECT floor(mod(months_between(sysdate, fec_inicio ),12)) INTO meses FROM dual;
SELECT floor(
         (mod(months_between(sysdate, fec_inicio) ,12)
          - floor(mod(months_between(sysdate, fec_inicio ),12)))*30
            ) INTO dias FROM dual;
            
    if anos > 0 THEN
        antiguedad:= antiguedad ||' '||anos||' anos ';
    end if;
    if meses > 0 THEN
        antiguedad:= antiguedad ||' '||meses||' meses ';
    end if;
    if dias  > 0 THEN
        antiguedad:= antiguedad ||' '||dias||' d’as ';
    end if;
    
    if antiguedad is null then
        antiguedad := 0 ||' d’as ';
    end if;
RETURN antiguedad;
END;

CREATE OR REPLACE function musico_instrumentP(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select i.nombre instrumento, antiguedad(mi.FECHAEJECUCION) antiguedad 
from MUSICO_INSTRUMENTO mi, MUSICO m, INSTRUMENTO i
where m.idmusico = mi.pkmusico AND mi.pkinstrumento = i.idinstrumento AND id = m.idmusico AND mi.instrumentoprincipal = 1  ;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := 'Instrumento:  '||AUX.instrumento|| ', Antiguedad:  '||AUX.antiguedad|| '. '||RESULTADO;
END LOOP;
    
RETURN (RESULTADO);
END;
CREATE OR REPLACE function musico_instrument(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select i.nombre instrumento 
from MUSICO_INSTRUMENTO mi, MUSICO m, INSTRUMENTO i
where m.idmusico = mi.pkmusico AND mi.pkinstrumento = i.idinstrumento AND id = m.idmusico ;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := 'Instrumento:  '||AUX.instrumento|| '. ';
END LOOP;
    
RETURN (RESULTADO);
END;



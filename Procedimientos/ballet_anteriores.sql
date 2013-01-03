CREATE OR REPLACE function ballet_anteriores (idBailarin IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select bl.nombre balletAnteriores 
from Bailarin_ballet bb, ballet bl
where bb.PKBAILARIN =idBailarin and bb.PKBALLET = bl.IDBALLET and bb.fechafin is not null;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := AUX.BALLETANTERIORES|| ' , ' ||RESULTADO;
END LOOP;
    
RETURN (RESULTADO);
END;
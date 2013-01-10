CREATE OR REPLACE function entradas_restantes (totalEntradas in NUMBER, idZona in NUMBER )
RETURN NUMBER IS

RESULTADO NUMBER;

CURSOR BUSQUEDA IS select COUNT(e.idEntrada) cantidadAsientos, z.nombre zona, z.idubicacion idzona 
from entrada e, ubicacion a, ubicacion z
where e.fkubicacion = a.idubicacion AND e.pagada = 1 AND a.fkubicacion = z.idubicacion AND z.idubicacion = idZona
GROUP BY z.nombre, z.idubicacion 

AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP

    if AUX.CANTIDADASIENTOS is not null then
     RESULTADO := totalEntradas - AUX.CANTIDADASIENTOS;
    else
        RESULTADO:= 0;
    END IF;
END LOOP;
    
RETURN (RESULTADO);
END;
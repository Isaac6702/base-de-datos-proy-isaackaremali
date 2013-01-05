CREATE OR REPLACE function entradas_restantes (totalEntradas in NUMBER, idZona in NUMBER, idOpera in NUMBER )
RETURN NUMBER IS

RESULTADO NUMBER;

CURSOR BUSQUEDA IS 
select COUNT(e.idEntrada) cantidadAsientos, z.nombre zona, z.idubicacion idzona, o.nombre opera 
from entrada e, ubicacion a, ubicacion z, fecha_presentacion fp, obra o 
where e.fkubicacion = a.idubicacion AND e.pagada = 1 AND a.fkubicacion = z.idubicacion AND fp.fkobra = o.idobra AND e.fkpresentacion = fp.idfp AND z.idubicacion = idZona and o.idobra = idOpera
GROUP BY z.nombre, z.idubicacion, o.nombre;  

AUX  BUSQUEDA % ROWTYPE;

BEGIN

RESULTADO := totalEntradas ;

FOR AUX IN BUSQUEDA LOOP

    if AUX.CANTIDADASIENTOS is not null then
        RESULTADO := totalEntradas - AUX.CANTIDADASIENTOS;
    END if;

END LOOP;
 
RETURN (RESULTADO );
END;
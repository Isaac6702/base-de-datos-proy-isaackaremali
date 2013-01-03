CREATE OR REPLACE function consultar_direccion (fkDireccion IN NUMBER, detalleDireccion IN VARCHAR2)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select p.nombre pais, e.nombre estado, c.nombre ciudad from lugar p, lugar c, lugar e where p.idlugar = e.fklugar and e.idlugar = c.fklugar and e.idlugar = fkDireccion;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP

     RESULTADO := 'Pais: '||AUX.PAIS ||' , Estado: '|| AUX.ESTADO ||' , Ciudad: '|| AUX.CIUDAD ||' , Detalle: '||detalleDireccion;

END LOOP;
    
RETURN (RESULTADO);
END;

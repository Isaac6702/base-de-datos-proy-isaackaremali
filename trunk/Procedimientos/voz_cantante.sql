CREATE OR REPLACE function voz_cantante (idcantante IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select v.nombre nombre, v.descripcion descripcion from cantante c, voz v, cantante_voz cv where c.idcantante = cv.pkcantante AND cv.pkvoz = v.idvoz AND idcantante = c.idcantante;
AUX �BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
 � � RESULTADO := 'Tipo de Voz: '||AUX.nombre|| ' , Descripcion: ' ||AUX.descripcion||'. ';
END LOOP;
 � �
RETURN (RESULTADO);
END;
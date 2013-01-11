CREATE OR REPLACE function estudios_musico (idmusico IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select i.nombre institucion, e.DESCRIPCION  
                    from estudio e, institucion i
                    where e.FKINSTITUCION = i.IDINSTITUCION AND e.FKmusico = idmusico;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
     RESULTADO := 'Institucion: '||AUX.institucion|| ' , Estudio: ' ||AUX.DESCRIPCION||'. ';
END LOOP;
    
RETURN (RESULTADO);
END;



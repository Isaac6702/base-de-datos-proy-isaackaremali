
CREATE OR REPLACE function consultar_obras_m(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select o.nombre obra
                    from musico m, fecha_presentacion fp, musico_obra mo, obra o
                    where  fp.idfp = mo.pkpresentacion AND mo.pkmusico = m.idmusico AND m.idmusico = id AND fp.fkobra = o.idobra  ;
AUX  BUSQUEDA % ROWTYPE;
BEGIN
FOR AUX IN BUSQUEDA LOOP
    if AUX.obra is not null then
        RESULTADO := 'Posicion: '||AUX.obra||' . ';
    else
        RESULTADO:=null;
    END IF;
END LOOP;
RETURN (RESULTADO);
END;



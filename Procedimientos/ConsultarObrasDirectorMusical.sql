CREATE OR REPLACE function consultar_obras_DM(id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select o.nombre obra
                    from director_musical dm, obra o
                    where  o.FKDM = dm.iddm AND dm.iddm = id ;
AUX  BUSQUEDA % ROWTYPE;

BEGIN

FOR AUX IN BUSQUEDA LOOP
    if AUX.obra is not null then
        RESULTADO :=AUX.OBRA||' , '|| RESULTADO;
    else
        RESULTADO:=null;
    END IF;
END LOOP;
    
RETURN (RESULTADO);
END;

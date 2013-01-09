create or replace PROCEDURE insertFechaPresentacion(idObra IN NUMBER, fecha IN DATE, costoZona IN NUMBER) IS

CURSOR BUSQUEDA IS select a.idubicacion idasiento, z.porcentaje 
                        from ubicacion a, ubicacion z 
                        where z.tipo='zona' AND a.FKUBICACION = z.IDUBICACION;
asiento BUSQUEDA % ROWTYPE;

CURSOR BUSQUEDAID IS select SEQFP.NEXTVAL  from dual;
ID BUSQUEDAID % ROWTYPE;

BEGIN

FOR ID IN BUSQUEDAID LOOP
    INSERT INTO FECHA_PRESENTACION
            (IDFP, FECHA, ZONAMASCARA, FKOBRA)
        VALUES
            (ID.NEXTVAL, fecha, costoZona, idObra);


    FOR asiento IN BUSQUEDA LOOP
        
        INSERT INTO ENTRADA
            (IDENTRADA, COSTO, PAGADA, FKUBICACION, FKPRESENTACION)
        VALUES
            (seqEntrada.NEXTVAL, costoZona * asiento.PORCENTAJE, 0, asiento.IDASIENTO, ID.NEXTVAL);
        
        
    END LOOP;
    
END LOOP;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;

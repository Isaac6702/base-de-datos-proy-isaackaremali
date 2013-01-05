CREATE TYPE Idaux AS OBJECT( id NUMBER);
/
CREATE TYPE listaIdAux AS TABLE OF Idaux;
/
create or replace PROCEDURE insertVentaEntrada(idEntradas listaIdAux, idUsuario NUMBER ) IS

CURSOR BUSQUEDA IS select SEQFACTURA.NEXTVAL  from dual;
IDF BUSQUEDA % ROWTYPE;
auxCostoEntrada NUMBER(12,2); 
BEGIN
FOR IDF IN BUSQUEDA LOOP

    insert into FACTURA
            (IDFACTURA, FECHA, FKUSUARIO)
        values
            (IDF.NEXTVAL, TO_DATE(SYSDATE,'dd/mm/yyyy'), idUsuario);
     
    IF idEntradas IS NOT NULL THEN    
        FOR i IN 1..idEntradas.COUNT LOOP
            select e.costo
            INTO  auxCostoEntrada
            from entrada e
            where e.identrada = idEntradas(i).id;      
            
            insert into detalle_Factura
                    (IDDF, MONTO, FKFACTURA, FKENTRADA)
                values
                    (seqdf.NEXTVAL, auxCostoEntrada, IDF.NEXTVAL, idEntradas(i).id);
            
        END LOOP;
    ELSE
        RAISE_APPLICATION_ERROR(-20000,'debe introduccir al menos una entrada');
    END IF;

END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;
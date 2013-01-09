CREATE TYPE auxPago AS OBJECT( idMoneda NUMBER, montoPagado NUMBER, formaPago VARCHAR2(10));
/

CREATE TYPE listaAuxPago AS TABLE OF auxPago;
/

create or replace PROCEDURE pagoFactura(idF NUMBER, pagos listaAuxPago ) IS

total NUMBER;
totalPago NUMBER;
valorMoneda NUMBER;
BEGIN
    select SUM(p.monto)
        INTO totalPago
        from pago p
        where p.fkFactura = idF;
        
        IF totalPago is null THEN
            totalPago:= 0;
        END IF;
    
    select SUM(df.monto)
        INTO total
        from factura f, detalle_factura df
        where df.fkfactura = f.idfactura AND f.idfactura = idF
        GROUP BY f.idfactura;
        
    IF totalPago < total THEN
        IF pagos IS NOT NULL THEN    
            FOR i IN 1..pagos.COUNT LOOP
                select valor
                    into valorMoneda 
                    from moneda
                    where idmoneda = pagos(i).idMoneda;
                    
                totalPago := totalPago + pagos(i).montoPagado*valorMoneda;
                
            END LOOP;
            
            IF total = totalPago THEN
                FOR i IN 1..pagos.COUNT LOOP
               
                    INSERT INTO PAGO
                        (IDPAGO, MONTO, FECHA, FORMAPAGO, FKMONEDA, FKFACTURA)
                    VALUES
                        (SEQPAGO.NEXTVAL, pagos(i).montoPagado, TO_DATE(SYSDATE,'dd/mm/yyyy'), pagos(i).formaPago, pagos(i).idMoneda, idF);
               
                END LOOP;
                update entrada 
                    set pagada = 1
                    where identrada in (select e.identrada
                                          from entrada e, detalle_factura dt  
                                         where dt.fkFactura = idF AND dt.fkentrada = e.identrada );
                        
                dbms_output.put_line('Pago completo');
            
            END IF;
            
            IF total > totalPago  THEN
                    RAISE_APPLICATION_ERROR(-20000,'FALTA PAGAR un monto de ' || to_char(total-totalPago));    
            END IF;
            
            IF total < totalPago  THEN
                    RAISE_APPLICATION_ERROR(-20000,'EL PAGO ESCEDIO un monto de ' || to_char(totalPago-total));    
            END IF;   
                
        ELSE
            RAISE_APPLICATION_ERROR(-20000,'Debe introducir al menos un pago');
        END IF;
        
    ELSE
        
        RAISE_APPLICATION_ERROR(-20000,'LA factura ya fue pagada');
    END IF;
    
    
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;


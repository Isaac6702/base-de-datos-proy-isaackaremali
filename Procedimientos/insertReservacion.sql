    create or replace PROCEDURE insertReservacion(idEntradas listaIdAux, idUsuario NUMBER ) IS
    
    CURSOR BUSQUEDA IS select SEQRESERVA.NEXTVAL  from dual;
    IDR BUSQUEDA % ROWTYPE;
    
    BEGIN
    FOR IDR IN BUSQUEDA LOOP
    
        insert into RESERVA
                (IDRESERVA, FECHA, FKUSUARIO)
            values
                (IDR.NEXTVAL, TO_DATE(SYSDATE,'dd/mm/yyyy'), idUsuario);
         
        IF idEntradas IS NOT NULL THEN    
            FOR i IN 1..idEntradas.COUNT LOOP
            
                insert into detalle_Reserva
                        (PKRESERVA, PKENTRADA, STATUS)
                    values
                        (IDR.NEXTVAL, idEntradas(i).id, 'a');
                
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
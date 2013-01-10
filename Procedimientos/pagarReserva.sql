reate or replace PROCEDURE pagoReserva(idR NUMBER, pagos listaAuxPago ) IS

CURSOR BUSQUEDA IS select e.identrada, u.idUsuario, r.idreserva 
                    from detalle_reserva dr, entrada e, usuario u, reserva r 
                    where dr.PKENTRADA = e.IDENTRADA AND dr.PKRESERVA = 1 AND  r.FKUSUARIO = u.idusuario;

AUX BUSQUEDA % ROWTYPE;
idU NUMBER;
idF NUMBER;
BEGIN
    FOR AUX IN BUSQUEDA LOOP
       insertVentaEntrada(listaIdAux(Idaux(AUX.IDENTRADA)), AUX.IDUSUARIO );
       idU := AUX.IDUSUARIO;
    END LOOP;

    select f.idfactura
        INTO idF
        from factura f, usuario u
        where f.FKUSUARIO = 1 AND TO_DATE(f.FECHA,'dd/mm/yyyy') = TO_DATE(sysdate,'dd/mm/yyyy') AND rownum <=1
        ORDER BY F.FECHA;

        
    pagoFactura(idF , pagos);
    idU := AUX.IDUSUARIO;
    
    FOR AUX IN BUSQUEDA LOOP
        UPDATE DETALLE_RESERVA
            SET STATUS = 'p'
            where PKRESERVA = AUX.IDRESERVA AND PKENTRADA = AUX.IDENTRADA;
    END LOOP;
    
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;

 
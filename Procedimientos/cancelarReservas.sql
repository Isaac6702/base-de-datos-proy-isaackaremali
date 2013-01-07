create or replace PROCEDURE cancelarReservas IS

CURSOR BUSQUEDA IS select r.idreserva, r.fecha fechareserva, fp.fecha fechapresentacion, e.identrada 
from reserva r, detalle_reserva dr, entrada e, fecha_presentacion fp
where dr.PKRESERVA = r.idreserva AND dr.PKENTRADA = e.identrada AND e.FKPRESENTACION = fp.idfp AND dr.status=1;

AUX BUSQUEDA % ROWTYPE;
diasPasados number;
BEGIN

FOR AUX IN BUSQUEDA LOOP
    
    diasPasados := to_Date(AUX.FECHAPRESENTACION,'dd/mm/yy') - to_Date(AUX.FECHARESERVA,'dd/mm/yy');
    IF diasPasados < 20 THEN
        dbms_output.put_line('fue cancelada la reserva n¼ ' || AUX.IDRESERVA);
        update DETALLE_RESERVA
            set status = 0
            where PKRESERVA = AUX.IDRESERVA AND PKENTRADA = AUX.IDENTRADA ;
        
        
    END IF;

END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;


begin
  dbms_scheduler.create_job(
      job_name => 'DEMO_CANCELAR_RESERVAS'
     ,job_type => 'PLSQL_BLOCK'
     ,job_action => 'begin cancelarReservas; end;'
     ,start_date => to_date('3/1/2013 20:59:00','dd/mm/yyyy hh24:mi:ss')
     ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=1;'
     ,enabled => TRUE
     ,comments => 'Demo for job schedule.');
end;
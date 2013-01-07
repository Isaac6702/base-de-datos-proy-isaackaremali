
create or replace PROCEDURE promocion IS

CURSOR BUSQUEDA IS select tc.FECHAINICIO , d.TIEMPOASCENSO, j.idcargo idjefe, t.idtrabajador 
from cargo c, cargo j, departamento d, trabajador t ,trabajador_cargo tc
where c.FKJEFE = j.idcargo AND c.fkDepartamento = d.iddepartamento AND c.TIPOASCENSO = 'tiempo' AND  tc.fktrabajador = t.idtrabajador and tc.fkcargo = c.idcargo AND tc.fechafin is null;

AUX BUSQUEDA % ROWTYPE;
antiguedad number;
BEGIN

FOR AUX IN BUSQUEDA LOOP
    
    antiguedad:= months_between(to_date(sysdate,'dd/mm/yy'), TO_DATE(AUX.FECHAINICIO,'dd/mm/yy'));
    IF antiguedad = AUX.TIEMPOASCENSO THEN
        dbms_output.put_line('el trabajador fue ascendido ' || AUX.IDTRABAJADOR);
        update TRABAJADOR_CARGO
            set FKCARGO = AUX.IDJEFE
            where FKTRABAJADOR = AUX.IDTRABAJADOR;
    
    END IF;

END LOOP;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;


begin
  dbms_scheduler.create_job(
      job_name => 'DEMO_promocion_trabajadores'
     ,job_type => 'PLSQL_BLOCK'
     ,job_action => 'begin promocion; end;'
     ,start_date => to_date('3/1/2013 20:59:00','dd/mm/yyyy hh24:mi:ss')
     ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=1;'
     ,enabled => TRUE
     ,comments => 'Demo for job schedule.');
end;



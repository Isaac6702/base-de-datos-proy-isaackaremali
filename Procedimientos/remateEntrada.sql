create or replace PROCEDURE remateEntrada IS

CURSOR BUSQUEDA IS select ( ((2258-count(e.identrada))*100)/2258) ventas, fp.FECHA, fp.idfp 
                    from entrada e, FECHA_PRESENTACION fp
                    where e.FKPRESENTACION = fp.IDFP AND e.PAGADA = 0
                    GROUP BY fp.FECHA, fp.idfp ;


AUX BUSQUEDA % ROWTYPE;

diasRestante NUMBER;

BEGIN

FOR AUX IN BUSQUEDA LOOP
    diasRestante := to_Date(AUX.FECHA,'dd/mm/yy') - to_Date(SYSDATE,'dd/mm/yy');
  
    IF diasRestante < 19 AND diasRestante >= 0 THEN
        
        IF AUX.VENTAS < 30 THEN
        
            UPDATE ENTRADA
            SET COSTO = COSTO - COSTO*0.03
            WHERE FKPRESENTACION = AUX.IDFP;           
                  
        END IF;
        
        IF AUX.VENTAS  >= 30 THEN
        
            UPDATE ENTRADA
            SET COSTO = COSTO + COSTO*0.03
            WHERE FKPRESENTACION = AUX.IDFP;
                    
                  
        END IF; 
        
    END IF;

END LOOP;

COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;


begin
  dbms_scheduler.create_job(
      job_name => 'DEMO_REMATAR_ENTRADAS'
     ,job_type => 'PLSQL_BLOCK'
     ,job_action => 'begin remateEntrada; end;'
     ,start_date => to_date('3/1/2013 20:59:00','dd/mm/yyyy hh24:mi:ss')
     ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=1;'
     ,enabled => TRUE
     ,comments => 'Demo for job schedule.');
end;
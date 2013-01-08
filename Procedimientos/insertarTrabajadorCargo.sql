create or replace PROCEDURE insertarTrabajadorCargo(sueldo IN NUMBER, cargo IN NUMBER, trabajador IN NUMBER, musico IN NUMBER, invitado IN NUMBER, bailarin IN NUMBER, cantante IN NUMBER, escenografo IN NUMBER, autor IN NUMBER, de IN NUMBER, director IN NUMBER, dm IN NUMBER, coreografo IN NUMBER) IS
BEGIN
    INSERT INTO TRABAJADOR_CARGO
        (idTC, fechaInicio, sueldo, fkCargo, fkTrabajador, fkMusico, fkInvitado, fkBailarin, fkCantante, fkEscenografo, fkAutor, fkDirectorEscenografia, fkCoreografo, fkDirector, fkDM)
    VALUES
        (seqTrabajadorCargo.NEXTVAL, SYSDATE, sueldo, cargo, trabajador, musico, invitado, bailarin, cantante, escenografo, autor, de, coreografo, director, dm);
COMMIT;
    
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;

END;  

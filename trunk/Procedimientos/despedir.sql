create or replace PROCEDURE despedirTrabajador (trabajador IN NUMBER, cargo IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkTrabajador = trabajador AND fkCargo = cargo;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE despedirMusico (musico IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkMusico = musico;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE despedirBailarin (bailarin IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkBailarin = bailarin;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
create or replace PROCEDURE despedirCantante (cantante IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkCantante = cantante;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE despedirEscenografo (escenografo IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkEscenografo = escenografo;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE despedirAutor (autor IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkAutor = autor;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE despedirDE (de IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkDirectorEscenografia = de;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE despedirCoreografo (coreografo IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkCoreografo = coreografo;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE despedirDirector (director IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkDirector = director;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE despedirDM (dm IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkDM = dm;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;

create or replace PROCEDURE despedirInvitado(invitado IN NUMBER) IS
BEGIN
    UPDATE TRABAJADOR_CARGO
    SET fechaFin = SYSDATE
    WHERE fkInvitado = invitado;
COMMIT;
 
EXCEPTION WHEN OTHERS THEN
   ROLLBACK;
   RAISE;
END;
   
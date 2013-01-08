create or replace trigger personaNotNull
before insert or update of fkTrabajador or
insert or update fkDirector or
insert or update fkDirectorEscenografia or
insert or update fkDM or
insert or update fkAutor or
insert or update fkCoreografo or
insert or update fkEscenografo or
insert or update fkBailarin or
insert or update fkMusico or
insert or update fkInvitado 
ON TRABAJADOR_CARGO
BEGIN
    if fkTrabajador IS NULL and fkDirector IS NULL and fkDirectorEscenografia IS NULL and fkDM IS NULL and fkAutor IS NULL and fkCoreografo IS NULL and fkEscenografo IS NULL and fkBailarin IS NULL and fkMusico IS NULL and fkInvitado IS NULL then
        RAISE_APPLICATION_ERROR(-20000,'Debe asignarse el cargo a algun empleado');
END;

create or replace trigger personaNotNull
    BEFORE INSERT ON TRABAJADOR_CARGO
    FOR EACH ROW
BEGIN
    if fkTrabajador IS NULL and fkDirector IS NULL and fkDirectorEscenografia IS NULL and fkDM IS NULL and fkAutor IS NULL and fkCoreografo IS NULL and fkEscenografo IS NULL and fkBailarin IS NULL and fkMusico IS NULL and fkInvitado IS NULL then
        RAISE_APPLICATION_ERROR(-20000,'Debe asignarse el cargo a algun empleado');
    END IF;
END;
CREATE TYPE id_cantidad_material AS OBJECT(idMaterial NUMBER, Cantidad NUMBER);
/
CREATE TYPE listaEscenografiaMaterial AS TABLE OF id_cantidad_material;
/

CREATE OR REPLACE procedure insertEscenografia (descripcionEscenografia VARCHAR2, fkObra NUMBER, fkEscenografo NUMBER, fkDirectorEscenografo NUMBER, tablaAux listaEscenografiaMaterial) IS

CURSOR BUSQUEDA IS select SEQESCENOGRAFIA.NEXTVAL  from dual;
IdE BUSQUEDA % ROWTYPE;

BEGIN
    FOR IdE IN BUSQUEDA LOOP
        insert into ESCENOGRAFIA
            (IDESCENOGRAFIA, DESCRIPCION, FKOBRA, FKESCENOGRAFO, FKDIRECTORESCENOGRAFIA)
        values 
            (IdE.NEXTVAL, descripcionEscenografia, fkObra, fkEscenografo, fkDirectorEscenografo);
        
        IF tablaAux IS NOT NULL THEN
        
            FOR i IN 1..tablaAux.COUNT LOOP
                insert into ESCENOGRAFIA_MATERIAL
                    (IDEM, COSTO, FKMATERIAL, FKESCENOGRAFIA)
                values
                    (SEQESCENOGRAFIAMATERIAL.NEXTVAL, tablaAux(i).Cantidad , tablaAux(i).idMaterial , idE.NEXTVAL);
                                
             END LOOP;
        
        ELSE
            RAISE_APPLICATION_ERROR(-20000,'Debe introducir los datos completos de los materiales de la escenografia');
        END IF;
            
    END LOOP;
END;


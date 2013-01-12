create or replace function musico_orquest(id IN NUMBER) RETURN VARCHAR2 IS RESULTADO VARCHAR2(1000); CURSOR BUSQUEDA IS select o.nombre orquesta, mo.posicion posicion, mo.fechainicio fechainicio, mo.fechafin fechafin from MUSICO_ORQUESTA mo, MUSICO m, ORQUESTA O where m.idmusico = mo.pkmusico AND mo.pkorquesta = o.idorquesta AND id = m.idmusico ; AUX BUSQUEDA % ROWTYPE; BEGIN FOR AUX IN BUSQUEDA LOOP RESULTADO := 'Orquesta: '||AUX.orquesta|| ' , Posicion: ' ||AUX.posicion|| ' , fecha Inicio: ' ||AUX.fechainicio|| ' , fecha fin: ' ||AUX.fechafin|| '. '; END LOOP; RETURN (RESULTADO); END;




create or replace function Bailarini_obras (idbailarin IN NUMBER) RETURN VARCHAR2 IS RESULTADO VARCHAR2(1000); CURSOR BUSQUEDA IS select o.nombre nombre from bailarin_ballet bb, ballet b, obra o where bb.pkballet = b.idballet AND bb.pkbailarin = idbailarin AND b.idballet = o.fkballet; AUX BUSQUEDA % ROWTYPE; BEGIN FOR AUX IN BUSQUEDA LOOP if AUX.nombre is not null then RESULTADO := AUX.nombre||'. '||RESULTADO; else RESULTADO:=null; END IF; END LOOP; RETURN (RESULTADO); END;
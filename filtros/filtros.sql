create or replace PROCEDURE FT_Asientos_Rest(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(2550);
  obra varchar2(2000);
  ubicacion varchar2(2000);
  
BEGIN
    obra:= split(buscador ,1,',');
    ubicacion:= split(buscador ,2,',');
  v_query := 'select o.nombre obra, z.nombre Zona, a.nombre asiento 
                        from entrada e, fecha_presentacion fp,ubicacion z, ubicacion a, OBRA o
                        where a.fkubicacion = z.idubicacion AND a.tipo = ''asiento'' AND e.fkubicacion = a.idubicacion AND  e.FKPRESENTACION = fp.idfp 
                        AND fp.FKOBRA = o.idobra AND e.FKPRESENTACION = fp.IDFP AND e.PAGADA = 0 and rownum<=5';
                        
    IF obra != 'null' THEN
     v_query := v_query || 'AND  o.nombre like ''%'||obra||'%''';
    END IF;
    IF ubicacion != 'null' THEN
     v_query := v_query || 'AND  z.nombre like''%'||ubicacion||'%''';
    END IF;
    
 
  OPEN REC_CUR FOR v_query;

END;
/
create or replace PROCEDURE FT_Asientos_vendidos(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(2550);
  obra varchar2(2000);
  ubicacion varchar2(2000);
  
BEGIN
    obra:= split(buscador ,1,',');
    ubicacion:= split(buscador ,2,',');
  v_query := 'select o.nombre obra, z.nombre Zona, a.nombre asiento 
                    from entrada e, fecha_presentacion fp,ubicacion z, ubicacion a, obra o  
                    where a.fkubicacion = z.idubicacion AND a.tipo = ''asiento'' AND e.fkubicacion = a.idubicacion
                    AND  e.FKPRESENTACION = fp.idfp AND fp.FKOBRA = o.idobra AND e.PAGADA = 1';
                        
    IF obra != 'null' THEN
     v_query := v_query || 'AND  o.nombre like ''%'||obra||'%''';
    END IF;
    IF ubicacion != 'null' THEN
     v_query := v_query || 'AND  z.nombre like''%'||ubicacion||'%''';
    END IF;
    
 
  OPEN REC_CUR FOR v_query;

END;
/
create or replace PROCEDURE FT_entradas_vendidas(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(4000);
  ubicacion varchar2(2000);
  costo1 varchar2(2000);
  costo2 varchar2(2000);
  
BEGIN
    ubicacion:= split(buscador ,1,',');
    costo1:= split(buscador ,2,',');
    costo2:= split(buscador ,3,',');
    v_query := 'select o.nombre opera, z.nombre Ubicacion,  (COUNT(a.idubicacion) - entradas_restantes(COUNT(a.idubicacion), Z.IDUBICACION, o.idobra)) total 
                        , entradas_restantes(COUNT(a.idubicacion), Z.IDUBICACION, o.idobra) restantes, e.COSTO
                        from ubicacion z, ubicacion a, ubicacion p, obra o, entrada e
                        where z.fkubicacion = p.idubicacion AND a.fkubicacion = z.idubicacion AND e.FKUBICACION = a.idubicacion ';
                        
    IF ubicacion != 'null' THEN
     v_query := v_query || ' AND  z.nombre like ''%'||ubicacion||'%''';
    END IF;
    IF costo1 != 'null' THEN
     v_query := v_query || ' AND  e.costo >='||costo1;
    END IF;
     IF costo2 != 'null' THEN
     v_query := v_query || ' AND  e.costo <='||costo2;
    END IF;
    v_query := v_query ||' GROUP BY z.idubicacion, z.nombre, o.nombre, o.idobra, e.COSTO';
 
  OPEN REC_CUR FOR v_query;

END;
/
    
create or replace PROCEDURE FT_entradas_vendidas_momento(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(2550);
  obra varchar2(2000);
  fecha1 varchar2(2000);
  fecha2 varchar2(2000);
  
BEGIN
    obra:= split(buscador ,1,',');
    fecha1:= split(buscador ,2,',');
    fecha2:= split(buscador ,3,',');
    v_query := 'select o.nombre obra, COUNT(e.identrada) "TOTAL ENTRADAS", to_char(fp.fecha,''dd/mm/yy'') "FECHA PRESENTACION", to_char(o.FECHAVENTA,''dd/mm/yy'') " FECHA DE VENTA" 
                    from entrada e, fecha_presentacion fp,ubicacion z, ubicacion a, obra o  
                    where a.fkubicacion = z.idubicacion AND a.tipo = ''asiento'' AND e.fkubicacion = a.idubicacion
                    AND  e.FKPRESENTACION = fp.idfp AND fp.FKOBRA = o.idobra AND e.PAGADA = 1 ';
                                            
    IF obra != 'null' THEN
     v_query := v_query || ' AND  o.nombre like ''%'||obra||'%''';
    END IF;
    IF fecha1 != 'null' THEN
     v_query := v_query || ' AND TO_DATE(fp.fecha,''dd/mm/yy'') = to_date('''||fecha1||''',''dd/mm/yy'')'; 
    END IF;
     IF fecha2 != 'null' THEN
     v_query := v_query || ' AND TO_DATE(o.FECHAVENTA,''dd/mm/yy'') = to_date('''||fecha2||''',''dd/mm/yy'')';
    END IF;
    v_query := v_query ||' GROUP BY o.nombre, fp.fecha, o.FECHAVENTA';
 
  OPEN REC_CUR FOR v_query;

END;
/
  
create or replace PROCEDURE FT_Bailarin_invitado(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(4000);
  nombre varchar2(2000);
  apellido varchar2(2000);
  antiguedad varchar2(2000);
  identificador varchar2(2000);
  nacionalidad varchar2(2000);
  obra varchar2(2000);
  
BEGIN
    nombre := split(buscador ,1,',');
    apellido := split(buscador ,2,',');
    antiguedad := split(buscador ,3,',');
    identificador := split(buscador ,4,',');
    nacionalidad := split(buscador ,5,',');
    obra := split(buscador ,6,',');
    v_query := 'select l.nombre pais, l.idlugar, b.pasaporte pasaporte, nombres(b.NOMBRECOMPLETO) nombres, apellidos(b.NOMBRECOMPLETO) apellidos, n.nombre nacionalidad,
                        consultar_direccion(b.FKLUGAR, b.DETALLEDIRECCION)direccion, consultar_telefonos(b.telefono) telefonos, antiguedad(tc.FECHAINICIO) antiguedad ,
                        ballet_anteriores(b.idbailarin) balletAnteriores, estudios_bailarin(idbailarin) estudios, Bailarini_obras(idbailarin) Obras, b.foto foto  
                        from BAILARIN b, NACIONALIDAD_BAILARIN nb, NACIONALIDAD n, trabajador_cargo tc, lugar l 
                        WHERE nb.PKBAILARIN = b.IDBAILARIN AND nb.PKNACIONALIDAD = n.IDNACIONALIDAD AND tc.FKBAILARIN = b.IDBAILARIN
                        AND n.fkpais = l.idlugar AND b.invitado = 1';
                                            
    IF nombre != 'null' THEN
        v_query := v_query || ' AND  nombres(b.NOMBRECOMPLETO)  like ''%'||nombre||'%''';
    END IF;
    
    IF apellido != 'null' THEN
        v_query := v_query || ' AND  apellidos(b.NOMBRECOMPLETO) like ''%'||apellido||'%''';
    END IF;
    
    IF antiguedad != 'null' THEN
        v_query := v_query || ' AND  antiguedad(tc.FECHAINICIO) like ''%'||antiguedad||'%''';
    END IF;
    
     IF identificador != 'null' THEN
        v_query := v_query || ' AND  b.pasaporte ='||identificador;
    END IF;
    
    IF nacionalidad != 'null' THEN
        v_query := v_query || ' AND  n.nombre like ''%'||nacionalidad||'%''';
    END IF;
    
    
    IF obra != 'null' THEN
        v_query := v_query || ' AND  Bailarini_obras(idbailarin) like ''%'||obra||'%''';
    END IF;
 
  OPEN REC_CUR FOR v_query;

END;
/
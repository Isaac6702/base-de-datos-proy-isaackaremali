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
  
create or replace PROCEDURE FT_Bailarin(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(4000);
  nombre varchar2(2000);
  apellido varchar2(2000);
  antiguedad varchar2(2000);
  identificador varchar2(2000);
  nacionalidad varchar2(2000);
  
BEGIN
    nombre := split(buscador ,1,',');
    apellido := split(buscador ,2,',');
    antiguedad := split(buscador ,3,',');
    identificador := split(buscador ,4,',');
    nacionalidad := split(buscador ,5,',');
    
    v_query := 'select  l.nombre pais, l.idlugar, b.pasaporte pasaporte, nombres(b.NOMBRECOMPLETO) nombres, apellidos(b.NOMBRECOMPLETO) apellidos,
                    n.nombre nacionalidad, consultar_direccion(b.FKLUGAR, b.DETALLEDIRECCION)direccion, consultar_telefonos(b.telefono) telefonos,
                    antiguedad(tc.FECHAINICIO) antiguedad , ballet_anteriores(b.idbailarin) balletAnteriores, estudios_bailarin(idBailarin) estudios,
                    b.foto
                    from BAILARIN b, NACIONALIDAD_BAILARIN nb, NACIONALIDAD n, trabajador_cargo tc, lugar l
                    WHERE nb.PKBAILARIN = b.IDBAILARIN AND nb.PKNACIONALIDAD = n.IDNACIONALIDAD AND tc.FKBAILARIN = b.IDBAILARIN
                    AND n.fkpais = l.idlugar AND b.invitado = 0';
                                            
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
    

  OPEN REC_CUR FOR v_query;

END;
/

create or replace PROCEDURE FT_Cantante(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(4000);
  nombre varchar2(2000);
  apellido varchar2(2000);
  antiguedad varchar2(2000);
  identificador varchar2(2000);
  nacionalidad varchar2(2000);
  voz varchar2(2000);
  
BEGIN
    nombre := split(buscador ,1,',');
    apellido := split(buscador ,2,',');
    antiguedad := split(buscador ,3,',');
    identificador := split(buscador ,4,',');
    nacionalidad := split(buscador ,5,',');
    voz := split(buscador ,6,',');
    
    v_query := 'select voz_cantante (c.idcantante) voz,c.pasaporte pasaporte, l.nombre pais, l.idlugar, nombres(c.NOMBRECOMPLETO) nombres,
        apellidos(c.NOMBRECOMPLETO) apellidos, n.nombre nacionalidad, consultar_direccion(c.FKLUGAR, c.DETALLEDIRECCION)direccion,
        consultar_telefonos(c.telefono) telefonos, antiguedad(tc.FECHAINICIO) antiguedad,  estudios_cantante(idcantante) estudios, c.foto
    from CANTANTE c, NACIONALIDAD_CANTANTE nc, NACIONALIDAD n, trabajador_cargo tc, lugar l
    WHERE nc.PKCANTANTE = c.IDCANTANTE AND nc.PKNACIONALIDAD = n.IDNACIONALIDAD AND tc.FKCANTANTE = c.IDCANTANTE
            AND n.fkpais = l.idlugar AND c.invitado = 0';
                                            
    IF nombre != 'null' THEN
        v_query := v_query || ' AND  nombres(c.NOMBRECOMPLETO)  like ''%'||nombre||'%''';
    END IF;
    
    IF apellido != 'null' THEN
        v_query := v_query || ' AND  apellidos(c.NOMBRECOMPLETO) like ''%'||apellido||'%''';
    END IF;
    
    IF antiguedad != 'null' THEN
        v_query := v_query || ' AND  antiguedad(tc.FECHAINICIO) like ''%'||antiguedad||'%''';
    END IF;
    
     IF identificador != 'null' THEN
        v_query := v_query || ' AND  c.pasaporte ='||identificador;
    END IF;
    
    IF nacionalidad != 'null' THEN
        v_query := v_query || ' AND  n.nombre like ''%'||nacionalidad||'%''';
    END IF;
    
    IF voz != 'null' THEN
        v_query := v_query || ' AND  voz_cantante (c.idcantante) like ''%'||voz||'%''';
    END IF;
    

  OPEN REC_CUR FOR v_query;

END;
/
create or replace PROCEDURE FT_Cargo(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(4000);
  tipoA varchar2(2000);
  cargo varchar2(2000);

  
BEGIN
    tipoA := split(buscador ,1,',');
    cargo := split(buscador ,2,',');

    
    v_query := 'select c.NOMBRE cargo, d.NOMBRE departamento, d.TIEMPOASCENSO tiempo, c.TIPOASCENSO "TIPO DE ASCENSO"
    from cargo c, departamento d 
    where c.FKDEPARTAMENTO = d.IDDEPARTAMENTO';
                                            
    IF tipoA != 'null' THEN
        v_query := v_query || ' AND  c.TIPOASCENSO  like ''%'||tipoA||'%''';
    END IF;
    
    IF cargo != 'null' THEN
        v_query := v_query || ' AND  c.NOMBRE like ''%'||cargo||'%''';
    END IF;
    

  OPEN REC_CUR FOR v_query;

END;
/
create or replace PROCEDURE FT_Coreografo(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(4000);
  nombre varchar2(2000);
  apellido varchar2(2000);
  identificador varchar2(2000);
  nacionalidad varchar2(2000);
  
BEGIN
    nombre := split(buscador ,1,',');
    apellido := split(buscador ,2,',');
    identificador := split(buscador ,3,',');
    nacionalidad := split(buscador ,4,',');
    v_query := 'select consultar_direccion(co.fklugar, co.detalleDireccion) direccion, idcoreografo id, co.pasaporte pasaporte ,
                    Nombres(NOMBRECOMPLETO) nombres, apellidos(NOMBRECOMPLETO) apellidos, consultar_telefonos(TELEFONO) telefonos,
                    c.nombre cargo, Antiguedad(tc.FECHAINICIO)antiguedad, n.nombre nacionalidad, co.foto
                    from coreografo co, cargo c, NACIONALIDAD_COREOGRAFO nc, nacionalidad n, trabajador_cargo tc
                    where tc.FKCARGO = c.IDCARGO AND co.idcoreografo = tc.FKCOREOGRAFO AND  invitado = 0 AND nc.PKCOREOGRAFO = co.idcoreografo
                        AND nc.PKNACIONALIDAD = n.idnacionalidad AND tc.FECHAFIN is NULL';
                                                            
    IF nombre != 'null' THEN
        v_query := v_query || ' AND  nombres(co.NOMBRECOMPLETO)  like ''%'||nombre||'%''';
    END IF;
    
    IF apellido != 'null' THEN
        v_query := v_query || ' AND  apellidos(co.NOMBRECOMPLETO) like ''%'||apellido||'%''';
    END IF;
    
     IF identificador != 'null' THEN
        v_query := v_query || ' AND  co.pasaporte = '||identificador;
    END IF;
    
    IF nacionalidad != 'null' THEN
        v_query := v_query || ' AND  n.nombre like ''%'||nacionalidad||'%''';
    END IF;

 
  OPEN REC_CUR FOR v_query;

END;
/
create or replace PROCEDURE FT_DM(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(4000);
  nombre varchar2(2000);
  apellido varchar2(2000);
  identificador varchar2(2000);
  nacionalidad varchar2(2000);
  
BEGIN
    nombre := split(buscador ,1,',');
    apellido := split(buscador ,2,',');
    identificador := split(buscador ,3,',');
    nacionalidad := split(buscador ,4,',');
    v_query := 'select consultar_direccion(dm.fklugar, dm.detalleDireccion) direccion, IDDM id, dm.pasaporte pasaporte ,
                    Nombres(NOMBRECOMPLETO) Nombres, Apellidos(NOMBRECOMPLETO) Apellidos, consultar_telefonos(TELEFONO) telefonos,
                    c.nombre cargo, Antiguedad(tc.FECHAINICIO) antiguedad, consultar_obras_DM(dm.iddm) obras, dm.FALLECIMIENTO,
                    n.nombre nacionalidad, dm.foto foto
                    from director_musical dm, cargo c, trabajador_cargo tc, nacionalidad n, NACIONALIDAD_DM nd
                    where tc.FKCARGO = c.IDCARGO AND dm.IDDM = tc.FKDM  AND invitado = 0  AND nd.PKDM = dm.iddm
                    AND nd.PKNACIONALIDAD = n.idnacionalidad';
                                                            
    IF nombre != 'null' THEN
        v_query := v_query || ' AND  nombres(dm.NOMBRECOMPLETO)  like ''%'||nombre||'%''';
    END IF;
    
    IF apellido != 'null' THEN
        v_query := v_query || ' AND  apellidos(dm.NOMBRECOMPLETO) like ''%'||apellido||'%''';
    END IF;
    
     IF identificador != 'null' THEN
        v_query := v_query || ' AND  dm.pasaporte = '||identificador;
    END IF;
    
    IF nacionalidad != 'null' THEN
        v_query := v_query || ' AND  n.nombre like ''%'||nacionalidad||'%''';
    END IF;

 
  OPEN REC_CUR FOR v_query;

END;
/
create or replace PROCEDURE FT_DO(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(4000);
  nombre varchar2(2000);
  apellido varchar2(2000);
  identificador varchar2(2000);
  nacionalidad varchar2(2000);
  
BEGIN
    nombre := split(buscador ,1,',');
    apellido := split(buscador ,2,',');
    identificador := split(buscador ,3,',');
    nacionalidad := split(buscador ,4,',');
    v_query := 'select d.pasaporte ,l.nombre pais, l.idlugar, nombres(d.NOMBRECOMPLETO) nombres, apellidos(d.NOMBRECOMPLETO) apellidos,
                    n.nombre nacionalidad, consultar_direccion(d.FKLUGAR, d.DETALLEDIRECCION)direccion, consultar_telefonos(d.telefono) telefonos,
                    antiguedad(tc.FECHAINICIO) antiguedad, consultar_obras_d(idDirector) obra, estudios_director(iddirector) estudios, d.foto foto
                    from DIRECTOR d, NACIONALIDAD_DIRECTOR nd, NACIONALIDAD n, trabajador_cargo tc, lugar l
                    WHERE nd.PKDIRECTOR = d.IDDIRECTOR AND nd.PKNACIONALIDAD = n.IDNACIONALIDAD AND tc.FKDIRECTOR = d.IDDIRECTOR
                    AND n.fkpais = l.idlugar AND d.invitado = 0';
                                                            
    IF nombre != 'null' THEN
        v_query := v_query || ' AND  nombres(d.NOMBRECOMPLETO)  like ''%'||nombre||'%''';
    END IF;
    
    IF apellido != 'null' THEN
        v_query := v_query || ' AND  apellidos(d.NOMBRECOMPLETO) like ''%'||apellido||'%''';
    END IF;
    
     IF identificador != 'null' THEN
        v_query := v_query || ' AND  d.pasaporte = '||identificador;
    END IF;
    
    IF nacionalidad != 'null' THEN
        v_query := v_query || ' AND  n.nombre like ''%'||nacionalidad||'%''';
    END IF;

 
  OPEN REC_CUR FOR v_query;

END;
/
create or replace PROCEDURE FT_Escenografo(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(4000);
  nombre varchar2(2000);
  apellido varchar2(2000);
  identificador varchar2(2000);
  nacionalidad varchar2(2000);
  
BEGIN
    nombre := split(buscador ,1,',');
    apellido := split(buscador ,2,',');
    identificador := split(buscador ,3,',');
    nacionalidad := split(buscador ,4,',');
    v_query := 'select consultar_direccion(e.fklugar, e.detalleDireccion) direccion, IDESCENOGRAFO id, e.pasaporte pasaporte ,
                    nombres(NOMBRECOMPLETO) nombres,  apellidos(NOMBRECOMPLETO) apellidos, consultar_telefonos(TELEFONO) telefonos,
                    c.nombre cargo, Antiguedad(tc.FECHAINICIO) antiguedad , n.nombre nacionalidad, e.foto foto
                    from ESCENOGRAFO e, cargo c, trabajador_cargo tc, nacionalidad n, NACIONALIDAD_ESCENOGRAFO ne
                    where tc.FKCARGO = c.IDCARGO AND e.IDESCENOGRAFO = tc.FKESCENOGRAFO AND tc.FECHAFIN is NULL
                    AND invitado = 0 AND ne.PKNACIONALIDAD = n.idnacionalidad AND ne.PKESCENOGRAFO = e.idescenografo';
                                                                        
    IF nombre != 'null' THEN
        v_query := v_query || ' AND  nombres(e.NOMBRECOMPLETO)  like ''%'||nombre||'%''';
    END IF;
    
    IF apellido != 'null' THEN
        v_query := v_query || ' AND  apellidos(e.NOMBRECOMPLETO) like ''%'||apellido||'%''';
    END IF;
    
     IF identificador != 'null' THEN
        v_query := v_query || ' AND  e.pasaporte = '||identificador;
    END IF;
    
    IF nacionalidad != 'null' THEN
        v_query := v_query || ' AND  n.nombre like ''%'||nacionalidad||'%''';
    END IF;

 
  OPEN REC_CUR FOR v_query;

END;
/
create or replace PROCEDURE FT_Musico(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(4000);
  nombre varchar2(2000);
  apellido varchar2(2000);
  identificador varchar2(2000);
  nacionalidad varchar2(2000);
  antiguedad varchar2(2000);
  orquesta varchar2(2000);
  obra varchar2(2000);
  
BEGIN
    nombre := split(buscador ,1,',');
    apellido := split(buscador ,2,',');
    antiguedad := split(buscador ,3,',');
    identificador := split(buscador ,4,',');
    nacionalidad := split(buscador ,5,',');
    orquesta:= split(buscador ,6,',');
    obra:= split(buscador ,7,',');
    
    
    v_query := 'select m.pasaporte, l.nombre pais, l.idlugar, nombres(m.NOMBRECOMPLETO) nombres, apellidos(m.NOMBRECOMPLETO) apellidos,
                    n.nombre nacionalidad, consultar_direccion(m.FKLUGAR, m.DETALLEDIRECCION)direccion, consultar_telefonos(m.telefono) telefonos,
                    antiguedad(tc.FECHAINICIO) antiguedad, consultar_obras_m(idMusico) "POSICION ORQUESTA", estudios_musico(idMusico) estudios,
                    musico_instrument(idMusico) instrumento, musico_orquest(idMusico) orquesta, consultar_obras_m(idMusico) obra,
                    musico_instrumentP(idMusico) " INSTRUMENTO POSICION", m.foto foto
                    from MUSICO m, NACIONALIDAD_MUSICO nm, NACIONALIDAD n, trabajador_cargo tc, lugar l
                    WHERE nm.PKMUSICO = m.IDMUSICO AND nm.PKNACIONALIDAD = n.IDNACIONALIDAD AND tc.FKMUSICO = m.IDMUSICO
                    AND n.fkpais = l.idlugar AND m.invitado = 0 ';
                                                                                        
    IF nombre != 'null' THEN
        v_query := v_query || ' AND  nombres(m.NOMBRECOMPLETO)  like ''%'||nombre||'%''';
    END IF;
    
    IF apellido != 'null' THEN
        v_query := v_query || ' AND  apellidos(m.NOMBRECOMPLETO) like ''%'||apellido||'%''';
    END IF;
    
    IF antiguedad != 'null' THEN
        v_query := v_query || ' AND  antiguedad(tc.FECHAINICIO) like ''%'||antiguedad||'%''';
    END IF;
    
     IF identificador != 'null' THEN
        v_query := v_query || ' AND  m.pasaporte = '||identificador;
    END IF;
    
    IF nacionalidad != 'null' THEN
        v_query := v_query || ' AND  n.nombre like ''%'||nacionalidad||'%''';
    END IF;
    
     IF orquesta != 'null' THEN
        v_query := v_query || ' AND  musico_orquest(idMusico)  like ''%'||orquesta||'%''';
    END IF;
    
    IF obra != 'null' THEN
        v_query := v_query || ' AND  consultar_obras_m(idMusico) like ''%'||obra||'%''';
    END IF;

 
  OPEN REC_CUR FOR v_query;

END;
/

create or replace PROCEDURE FT_Musico_invitado(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(4000);
  nombre varchar2(2000);
  apellido varchar2(2000);
  identificador varchar2(2000);
  nacionalidad varchar2(2000);
  antiguedad varchar2(2000);
  orquesta varchar2(2000);
  obra varchar2(2000);
  
BEGIN
    nombre := split(buscador ,1,',');
    apellido := split(buscador ,2,',');
    antiguedad := split(buscador ,3,',');
    identificador := split(buscador ,4,',');
    nacionalidad := split(buscador ,5,',');
    orquesta:= split(buscador ,6,',');
    obra:= split(buscador ,7,',');
    
    
    v_query := ' select m.pasaporte, l.nombre pais, l.idlugar, nombres(m.NOMBRECOMPLETO) nombres, apellidos(m.NOMBRECOMPLETO) apellidos,
                    n.nombre nacionalidad, consultar_direccion(m.FKLUGAR, m.DETALLEDIRECCION)direccion, consultar_telefonos(m.telefono) telefonos,
                    antiguedad(tc.FECHAINICIO) antiguedad, consultar_obras_m(idMusico) Posiconobra, estudios_musico(idMusico) estudios,
                    musico_instrument(idMusico) instrumento, musico_orquest(idMusico) orquesta, consultar_obras_m(idMusico) obra,
                    musico_instrumentP(idMusico) "INSTRUMENTO POSICION", m.foto foto
                    from MUSICO m, NACIONALIDAD_MUSICO nm, NACIONALIDAD n, trabajador_cargo tc, lugar l
                    WHERE nm.PKMUSICO = m.IDMUSICO AND nm.PKNACIONALIDAD = n.IDNACIONALIDAD AND tc.FKMUSICO = m.IDMUSICO
                    AND n.fkpais = l.idlugar AND m.invitado = 1 ';
                                                                                        
    IF nombre != 'null' THEN
        v_query := v_query || ' AND  nombres(m.NOMBRECOMPLETO)  like ''%'||nombre||'%''';
    END IF;
    
    IF apellido != 'null' THEN
        v_query := v_query || ' AND  apellidos(m.NOMBRECOMPLETO) like ''%'||apellido||'%''';
    END IF;
    
    IF antiguedad != 'null' THEN
        v_query := v_query || ' AND  antiguedad(tc.FECHAINICIO) like ''%'||antiguedad||'%''';
    END IF;
    
     IF identificador != 'null' THEN
        v_query := v_query || ' AND  m.pasaporte = '||identificador;
    END IF;
    
    IF nacionalidad != 'null' THEN
        v_query := v_query || ' AND  n.nombre like ''%'||nacionalidad||'%''';
    END IF;
    
     IF orquesta != 'null' THEN
        v_query := v_query || ' AND  musico_orquest(idMusico)  like ''%'||orquesta||'%''';
    END IF;
                
    IF obra != 'null' THEN
        v_query := v_query || ' AND  consultar_obras_m(idMusico) like ''%'||obra||'%''';
    END IF;

 
  OPEN REC_CUR FOR v_query;

END;
/
create or replace PROCEDURE FT_precios_entradas (buscador in varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query VARCHAR2(4000);
  v_nombre varchar2(2000);
  v_moneda varchar2(2000);
  auxMoneda varchar2(2000);
  v_fecha varchar2(2000);
  
BEGIN
    v_nombre := split(buscador,1,',');
    v_moneda := split(buscador,2,',');
    v_fecha := split(buscador,3,',');
    
    IF v_moneda = 'libra' THEN
        auxMoneda := '1';
    ELSE
        select m.valor
        INTO auxMoneda
            from moneda m
            where m.nombre = v_moneda;
    END IF;     
    
    v_query := 'select lower(o.nombre) nombre, to_char(fp.fecha, ''dd/mm/yyyy hh:mi:ssam'') presentacion, u.nombre ubicacion,
    (u.porcentaje*fp.zonamascara* '||auxMoneda||' ) precio
    from obra o, fecha_presentacion fp, ubicacion u
    where fp.fkObra = o.idObra and u.tipo = ''zona''';
                                                                                        
    IF v_nombre != 'todas' THEN
        v_query := v_query || ' AND  lower(o.nombre) = '''||v_nombre||'''';
    END IF;
    
    IF v_fecha != 'null' THEN
    
         v_query := v_query || ' AND  to_char(fp.fecha,''dd/mm/yy'') = to_char('''||v_fecha||''', ''dd/mm/yy'') ' ;
    END IF;
    

    v_query:= v_query || ' order by o.nombre, fp.fecha';
 
  OPEN REC_CUR FOR v_query;

END;
/

create or replace PROCEDURE FT_numero_programas (buscador in varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query VARCHAR2(4000);
  v_nombre varchar2(2000);  
BEGIN
    v_nombre := buscador;
      v_query := 'select lower(o.nombre) obra, ((2258 * a.nroPresentaciones) - count(fp.idfp)) programas
    from entrada e, obra o, fecha_presentacion fp, ( select o.idobra id, count(idFP) nroPresentaciones
                                                     from fecha_presentacion fp, obra o
                                                     where fp.fkObra = o.idObra group by o.idobra) a
    where fp.fkObra = o.idObra and e.pagada = 0 and fp.idfp = e.fkpresentacion and a.id = o.idObra';
                                                                                        
    IF v_nombre != 'todas' THEN
        v_query := v_query || ' AND  lower(o.nombre) = '''||v_nombre||'''';
    END IF;
    
    v_query := v_query|| ' group by o.nombre, a.nroPresentaciones';
  OPEN REC_CUR FOR v_query;

END;
/


create or replace PROCEDURE FT_numero_programas (buscador in varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query VARCHAR2(4000);
  v_nombre varchar2(2000);  
BEGIN
    v_nombre := buscador;
      v_query := 'select lower(o.nombre) obra, ((2258 * a.nroPresentaciones) - count(fp.idfp)) programas
    from entrada e, obra o, fecha_presentacion fp, ( select o.idobra id, count(idFP) nroPresentaciones
                                                     from fecha_presentacion fp, obra o
                                                     where fp.fkObra = o.idObra group by o.idobra) a
    where fp.fkObra = o.idObra and e.pagada = 0 and fp.idfp = e.fkpresentacion and a.id = o.idObra';
                                                                                        
    IF v_nombre != 'todas' THEN
        v_query := v_query || ' AND  lower(o.nombre) = '''||v_nombre||'''';
    END IF;
    
    v_query := v_query|| ' group by o.nombre, a.nroPresentaciones';
  OPEN REC_CUR FOR v_query;

END;
/
create or replace PROCEDURE FT_comprador (buscador in varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query VARCHAR2(4000);
  obra varchar2(2000);
  nombre varchar2(2000);
  apellidos varchar2(2000);
  
BEGIN
    obra := split(buscador,1,',');
    nombre := split(buscador,2,',');
    apellidos := split(buscador,3,',');
      v_query := 'select u.idUsuario "ID", nombres(u.nombre) "NOMBRES", apellidos(u.nombre) "APELLIDOS", n.nombre "NACIONALIDAD", consultar_direccion(u.fkLugar, u.detalleDireccion) "DIRECCION", metodoPagoFactura(u.idUsuario, f.idFactura) "METODO DE PAGO",
      datosObraComprador(u.idUsuario, f.idFactura) "OBRAS", ticketsComprados(f.idFactura) "NRO TICKETS", nombreUbicacion(f.idFactura) "UBICACION", nombreAsientos(f.idFactura) "ASIENTOS", aux.monto "TOTAL NACIONAL", montoExtranjero(f.idFactura) "TOTAL EXTRANJERO"
                    from usuario u, factura f, nacionalidad n, (select f.idFactura factura, sum(df.monto) monto
                                                                from factura f, detalle_factura df
                                                                where f.idFactura = df.fkfactura
                                                                group by idFactura) aux,
                    (select lower(o.nombre)obra, to_char(fp.fecha, ''dd/mm/yyyy hh24:mi:ss'') presentacion, f.idFactura factura
                     from fecha_presentacion fp, obra o, entrada e, detalle_factura df, factura f
                     where fp.fkobra = o.idobra
                     and df.fkEntrada = e.identrada
                     and e.fkpresentacion = fp.idfp
                     and f.idfactura = df.fkfactura) a
                    where u.idUsuario = f.fkUsuario
                    and n.idnacionalidad = u.fknacionalidad
                    and aux.factura = f.idFactura
                    and a.factura = f.idFactura';
                                                                                        
    IF nombre != 'null' THEN
        v_query := v_query || ' AND  nombres(u.nombre)  like ''%'||nombre||'%''';
    END IF;
    IF obra != 'null' THEN
        v_query := v_query || ' AND  datosObraComprador(u.idUsuario, f.idFactura)  like ''%'||obra||'%''';
    END IF;
    IF apellidos != 'null' THEN
        v_query := v_query || ' AND  apellidos(u.nombre)  like ''%'||apellidos||'%''';
    END IF;
    
    
    v_query := v_query|| ' order by u.idusuario, f.idfactura';
  OPEN REC_CUR FOR v_query;

END;
/
create or replace PROCEDURE FT_Audio(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(2550);
  obra varchar2(2000);
  autor varchar2(2000);
  fecha varchar2(2000);
  
BEGIN
    obra:= split(buscador ,1,',');
    autor:= split(buscador ,2,',');
    fecha:= split(buscador ,3,',');
  v_query := 'select a.idAudio "ID", datosObraAutor(o.idObra) "OBRA", datosDirectores(o.idObra) "DIRECTORES",
                    to_char(fp.fecha,''dd/mm/yyyy hh:mi:ssam'') "FECHA", datosOrquesta(o.idObra) "ORQUESTA", reparto_ppal(fp.idFP) "ELENCO", a.formato "FORMATO"
                    from obra o, fecha_presentacion fp, audio a
                    where fp.fkObra = o.idObra
                    and a.fkpresentacion = fp.idFP';
                        
    IF obra != 'null' THEN
     v_query := v_query || ' AND  datosObraAutor(o.idObra) like ''%'||obra||'%''';
    END IF;
    IF autor != 'null' THEN
     v_query := v_query || ' AND  datosObraAutor(o.idObra) like''%'||autor||'%''';
    END IF;
    IF fecha != 'null' THEN
     v_query := v_query || ' AND  to_date(fp.fecha,''dd/mm/yy'') = to_date('''||fecha||''',''dd/mm/yy'')';
    END IF;
    
    v_query := v_query ||' order by o.idObra, fp.fecha';
 
  OPEN REC_CUR FOR v_query;

END;
/
create or replace PROCEDURE FT_video(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(2550);
  obra varchar2(2000);
  autor varchar2(2000);
  fecha varchar2(2000);
  
BEGIN
    obra:= split(buscador ,1,',');
    autor:= split(buscador ,2,',');
    fecha:= split(buscador ,3,',');
  v_query := 'select v.idVideo "ID", datosObraAutor(o.idObra) "OBRA", datosDirectores(o.idObra) "DIRECTORES", to_char(fp.fecha,''dd/mm/yyyy hh:mi:ssam'') "FECHA", datosOrquesta(o.idObra) "ORQUESTA", reparto_ppal(fp.idFP) "ELENCO", v.formato "FORMATO"
                from obra o, fecha_presentacion fp, video v
                where fp.fkObra = o.idObra
                and v.fkpresentacion = fp.idFP';
                                    
    IF obra != 'null' THEN
     v_query := v_query || ' AND  datosObraAutor(o.idObra) like ''%'||obra||'%''';
    END IF;
    IF autor != 'null' THEN
     v_query := v_query || ' AND  datosObraAutor(o.idObra) like''%'||autor||'%''';
    END IF;
    IF fecha != 'null' THEN
     v_query := v_query || ' AND  to_date(fp.fecha,''dd/mm/yy'') = to_date('''||fecha||''',''dd/mm/yy'')';
    END IF;
    
    v_query := v_query ||' order by o.idObra, fp.fecha';
 
  OPEN REC_CUR FOR v_query;

END;
/
create or replace PROCEDURE FT_libreto(buscador varchar2, REC_CUR OUT SYS_REFCURSOR) is
  v_query     VARCHAR2(2550);
  obra varchar2(2000);
  idioma varchar2(2000);
  fecha varchar2(2000);
  
BEGIN
    obra:= split(buscador ,1,',');
    idioma:= split(buscador ,2,',');
    fecha:= split(buscador ,3,',');
  v_query := 'select o.idObra "ID", lower(o.nombre) "OBRA", to_char(fp.fecha, ''dd/mm/yyyy hh:mi:ssam'') "PRESENTACION", i.nombre
                from obra o, fecha_presentacion fp, libreto l, IDIOMA i idioma 
                where  fp.fkObra = o.idObra and l.fkObra = o.idObra and l.fkidioma = i.ididioma ';
                                    
    IF obra != 'null' THEN
     v_query := v_query || ' AND  lower(o.nombre)(o.idObra) like ''%'||obra||'%''';
    END IF;
    IF idioma != 'null' THEN
     v_query := v_query || ' AND  i.nombre(o.idObra) like''%'||idioma||'%''';
    END IF;
    IF fecha != 'null' THEN
     v_query := v_query || ' AND  to_date(fp.fecha,''dd/mm/yy'') = to_date('''||fecha||''',''dd/mm/yy'')';
    END IF;
    
    
 
  OPEN REC_CUR FOR v_query;

END;
/
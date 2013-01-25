create or replace procedure CT_obraMasVendida(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   SELECT lower(t.obra) "OBRA", total "CANTIDAD"
   FROM (select o.nombre obra, SUM(DF.CANTIDAD) TOTAL
        from obra o, FECHA_PRESENTACION fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where fp.fkobra = o.idobra AND a.FKPRESENTACION = fp.idfp
        AND v.FKPRESENTACION = fp.idfp AND (v.idvideo =df.fkvideo 
        or a.idaudio=df.fkaudio )
        GROUP BY o.nombre
        ORDER BY SUM(DF.CANTIDAD) desc) t
   where rownum<=1;
END;
/
create or replace procedure CT_balletMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(b.nombre) "BALLET", sum(d.cantidad) "CANTIDAD"
         from obra o, detalle_factura_digitalizada d, audio au, fecha_presentacion f, video v, ballet b
         where b.idBallet = o.fkBallet 
         and (d.fkAudio = au.idAudio or d.fkVideo = v.idVideo)
         and (au.fkPresentacion = f.idFP and v.fkPresentacion = f.idFP)
         and f.fkObra = o.idObra
         group by idBallet, b.nombre
         order by sum(d.cantidad) desc) aut
   where rownum <=1;
END;
/
create or replace procedure CT_orquestaMasVendida(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(orq.nombre) "ORQUESTA", sum(d.cantidad) "CANTIDAD"
         from obra o, detalle_factura_digitalizada d, audio au, fecha_presentacion f, video v, orquesta orq
         where orq.idOrquesta = o.fkOrquesta 
         and (d.fkAudio = au.idAudio or d.fkVideo = v.idVideo)
         and (au.fkPresentacion = f.idFP and v.fkPresentacion = f.idFP)
         and f.fkObra = o.idObra
   group by idOrquesta, orq.nombre
   order by sum(d.cantidad) desc) aut
   where rownum <=1;
END;
/
create or replace procedure CT_autorMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(nombreCompleto)) "NOMBRE", lower(apellidos(nombreCompleto)) "APELLIDO", sum(d.cantidad) "CANTIDAD"
         from autor a, obra o, detalle_factura_digitalizada d, audio au, fecha_presentacion f, video v
         where a.idAutor = o.fkAutor 
         and (d.fkAudio = au.idAudio or d.fkVideo = v.idVideo)
         and (au.fkPresentacion = f.idFP and v.fkPresentacion = f.idFP)
         and f.fkObra = o.idObra
         group by idAutor, a.pasaporte, nombres(nombreCompleto), apellidos(nombreCompleto)
         order by sum(d.cantidad) desc) aut
   where rownum <=1;
END;
/
create or replace procedure CT_directorMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   SELECT *
   FROM (select lower(nombres(d.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(d.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD" 
           from obra o, director d, FECHA_PRESENTACION fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
           where o.fkdirector = d.IDDIRECTOR AND fp.fkobra = o.idobra AND a.FKPRESENTACION = fp.IDFP AND v.FKPRESENTACION = fp.IDFP AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio)
           GROUP BY nombres(d.NOMBRECOMPLETO), apellidos(d.NOMBRECOMPLETO)
           ORDER BY sum(df.monto) DESC) t
   WHERE rownum <=1;
END;
/
create or replace procedure CT_mezzoMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 2 
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad) desc)aux
where rownum <=1;
END;
/
create or replace procedure CT_tenorMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 4 
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad) desc)aux
where rownum <=1;
END;
/
create or replace procedure CT_baritonoMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 5 
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad) desc)aux
where rownum <=1;
END;
/
create or replace procedure CT_bajoMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 2
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad) desc)aux
where rownum <=1;
END;
/
create or replace procedure CT_contraltoMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 3
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad) desc)aux
where rownum <=1;
END;
/
create or replace procedure CT_sopranoMasVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 1
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad) desc)aux
where rownum <=1;
END;
/
create or replace procedure CT_obraMenosVendida(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   SELECT lower(t.obra) "OBRA", total "CANTIDAD"
   FROM (select o.nombre obra, SUM(DF.CANTIDAD) TOTAL
        from obra o, FECHA_PRESENTACION fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where fp.fkobra = o.idobra AND a.FKPRESENTACION = fp.idfp
        AND v.FKPRESENTACION = fp.idfp AND (v.idvideo =df.fkvideo 
        or a.idaudio=df.fkaudio )
        GROUP BY o.nombre
        ORDER BY SUM(DF.CANTIDAD)  ) t
   where rownum<=1;
END;
/
create or replace procedure CT_balletMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(b.nombre) "BALLET", sum(d.cantidad) "CANTIDAD"
         from obra o, detalle_factura_digitalizada d, audio au, fecha_presentacion f, video v, ballet b
         where b.idBallet = o.fkBallet 
         and (d.fkAudio = au.idAudio or d.fkVideo = v.idVideo)
         and (au.fkPresentacion = f.idFP and v.fkPresentacion = f.idFP)
         and f.fkObra = o.idObra
         group by idBallet, b.nombre
         order by sum(d.cantidad)  ) aut
   where rownum <=1;
END;
/
create or replace procedure CT_orquestaMenosVendida(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(orq.nombre) "ORQUESTA", sum(d.cantidad) "CANTIDAD"
         from obra o, detalle_factura_digitalizada d, audio au, fecha_presentacion f, video v, orquesta orq
         where orq.idOrquesta = o.fkOrquesta 
         and (d.fkAudio = au.idAudio or d.fkVideo = v.idVideo)
         and (au.fkPresentacion = f.idFP and v.fkPresentacion = f.idFP)
         and f.fkObra = o.idObra
   group by idOrquesta, orq.nombre
   order by sum(d.cantidad)  ) aut
   where rownum <=1;
END;
/
create or replace procedure CT_autorMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(nombreCompleto)) "NOMBRE", lower(apellidos(nombreCompleto)) "APELLIDO", sum(d.cantidad) "CANTIDAD"
         from autor a, obra o, detalle_factura_digitalizada d, audio au, fecha_presentacion f, video v
         where a.idAutor = o.fkAutor 
         and (d.fkAudio = au.idAudio or d.fkVideo = v.idVideo)
         and (au.fkPresentacion = f.idFP and v.fkPresentacion = f.idFP)
         and f.fkObra = o.idObra
         group by idAutor, a.pasaporte, nombres(nombreCompleto), apellidos(nombreCompleto)
         order by sum(d.cantidad)  ) aut
   where rownum <=1;
END;
/
create or replace procedure CT_directorMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   SELECT *
   FROM (select lower(nombres(d.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(d.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD" 
           from obra o, director d, FECHA_PRESENTACION fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
           where o.fkdirector = d.IDDIRECTOR AND fp.fkobra = o.idobra AND a.FKPRESENTACION = fp.IDFP AND v.FKPRESENTACION = fp.IDFP AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio)
           GROUP BY nombres(d.NOMBRECOMPLETO), apellidos(d.NOMBRECOMPLETO)
           ORDER BY sum(df.monto)  ) t
   WHERE rownum <=1;
END;
/
create or replace procedure CT_mezzoMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 2 
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad)  )aux
where rownum <=1;
END;
/
create or replace procedure CT_tenorMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 4 
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad)  )aux
where rownum <=1;
END;
/
create or replace procedure CT_baritonoMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 5 
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad)  )aux
where rownum <=1;
END;
/
create or replace procedure CT_bajoMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 2
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad))aux
where rownum <=1;
END;
/
create or replace procedure CT_contraltoMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 3
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad))aux
where rownum <=1;
END;
/
create or replace procedure CT_sopranoMenosVendido(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
   select *
   from (select lower(nombres(c.NOMBRECOMPLETO)) "NOMBRE", lower(apellidos(c.NOMBRECOMPLETO)) "APELLIDO", sum(df.cantidad) "CANTIDAD"
        from cantante c, cantante_voz cv, elenco e, personaje p, obra o, fecha_presentacion fp, audio a, video v, DETALLE_FACTURA_DIGITALIZADA df 
        where cv.pkvoz = 1
        AND cv.pkcantante = c.idcantante 
        AND e.pkcantante = c.idcantante 
        AND e.pkpersonaje = p.idpersonaje 
        AND p.fkobra = o.idobra 
        AND fp.fkobra = o.idobra 
        AND a.fkpresentacion = fp.fkobra 
        AND v.fkpresentacion = fp.fkobra 
        AND (df.fkvideo = v.idvideo or df.fkaudio = a.idaudio )
        GROUP BY idCantante, c.pasaporte, nombres(c.NOMBRECOMPLETO), apellidos(c.NOMBRECOMPLETO)
        order by sum(df.cantidad))aux
where rownum <=1;
END;
/
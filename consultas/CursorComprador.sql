create or replace procedure CT_COMPRADOR(REC_CUR OUT SYS_REFCURSOR) is
BEGIN

OPEN REC_CUR FOR
select u.idUsuario "ID", nombres(u.nombre) "NOMBRES", apellidos(u.nombre) "APELLIDOS", n.nombre "NACIONALIDAD", consultar_direccion(u.fkLugar, u.detalleDireccion) "DIRECCION", metodoPagoFactura(u.idUsuario, f.idFactura) "METODO DE PAGO", datosObraComprador(u.idUsuario, f.idFactura) "OBRAS", ticketsComprados(f.idFactura) "NRO TICKETS", nombreUbicacion(f.idFactura) "UBICACION", nombreAsientos(f.idFactura) "ASIENTOS", aux.monto "TOTAL NACIONAL", montoExtranjero(f.idFactura) "TOTAL EXTRANJERO"
from usuario u, factura f, nacionalidad n, (select f.idFactura factura, sum(df.monto) monto
                                            from factura f, detalle_factura df
                                            where f.idFactura = df.fkfactura
                                            group by idFactura) aux,
(select lower(o.nombre)obra, to_char(fp.fecha, 'dd/mm/yyyy hh24:mi:ss') presentacion, f.idFactura factura
 from fecha_presentacion fp, obra o, entrada e, detalle_factura df, factura f
 where fp.fkobra = o.idobra
 and df.fkEntrada = e.identrada
 and e.fkpresentacion = fp.idfp
 and f.idfactura = df.fkfactura) a
where u.idUsuario = f.fkUsuario
and n.idnacionalidad = u.fknacionalidad
and aux.factura = f.idFactura
and a.factura = f.idFactura
order by u.idusuario, f.idfactura;

END;

CREATE OR REPLACE function montoExtranjero (id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
CURSOR BUSQUEDA IS select lower(m.nombre) nombre, p.costoExtranjero extranjero
                    from factura f, pago p, moneda m
                    where f.idFactura = id
                    and p.fkFactura = f.idFactura
                    and m.idMoneda = p.fkMoneda;
                   
AUX  BUSQUEDA % ROWTYPE;

BEGIN

FOR AUX IN BUSQUEDA LOOP
    if AUX.nombre = 'libra' then
        
        RESULTADO := 'no aplica';
    else
        RESULTADO := AUX.extranjero || ' ' || AUX.nombre || 's';
    end if;
    
END LOOP;
    
RETURN (RESULTADO);
END;

CREATE OR REPLACE function nombreAsientos (id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BOOLEAN NUMBER(1);
CURSOR BUSQUEDA IS select lower(x.nombre) ubicacion
                    from factura f, detalle_factura df, ubicacion x, entrada e
                    where f.idFactura = ID
                    and f.idFactura = df.fkFactura
                    and e.idEntrada = df.fkEntrada
                    and e.fkUbicacion = x.idUbicacion;
                   
AUX  BUSQUEDA % ROWTYPE;

BEGIN
BOOLEAN := 0;
FOR AUX IN BUSQUEDA LOOP
    if BOOLEAN = 0 then
        BOOLEAN := 1;
        RESULTADO := AUX.ubicacion;
    else
        RESULTADO := RESULTADO || ', ' || AUX.ubicacion;
    end if;
    
END LOOP;
    
RETURN (RESULTADO);
END;

CREATE OR REPLACE function nombreUbicacion (id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BOOLEAN NUMBER(1);
CURSOR BUSQUEDA IS select lower(u.nombre) ubicacion
                    from factura f, detalle_factura df, ubicacion u, ubicacion x, entrada e
                    where f.idFactura = ID
                    and f.idFactura = df.fkFactura
                    and e.idEntrada = df.fkEntrada
                    and e.fkUbicacion = x.idUbicacion
                    and x.fkUbicacion = u.idUbicacion;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
BOOLEAN := 0;
FOR AUX IN BUSQUEDA LOOP
    if BOOLEAN = 0 then
        BOOLEAN := 1;
        RESULTADO := AUX.ubicacion;
    else
        RESULTADO := RESULTADO || ', ' || AUX.ubicacion;
    end if;
    
END LOOP;
    
RETURN (RESULTADO);
END;

CREATE OR REPLACE function ticketsComprados (id IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BOOLEAN NUMBER(1);
CURSOR BUSQUEDA IS select count(*) ticket
                   from detalle_factura df, factura f
                   where f.idFactura = id
                   and f.idFactura = df.fkFactura;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
FOR AUX IN BUSQUEDA LOOP
    RESULTADO := AUX.ticket;
END LOOP;
    
RETURN (RESULTADO);
END;

CREATE OR REPLACE function datosObraComprador(id IN NUMBER, fact IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BOOLEAN NUMBER(1);
CURSOR BUSQUEDA IS select lower(o.nombre) obra, to_char(fp.fecha, 'dd/mm/yyyy hh24:mi:ssam') fecha
                    from obra o, fecha_presentacion fp, entrada e, detalle_factura df, factura f, usuario u
                    where u.idUsuario = id
                    and f.idFactura = fact
                    and o.idObra = fp.fkObra
                    and fp.idFP = e.fkPresentacion
                    and e.idEntrada = df.fkEntrada
                    and f.idFactura = df.fkFactura
                    and u.idUsuario = f.fkUsuario;
AUX  BUSQUEDA % ROWTYPE;

BEGIN
BOOLEAN := 0;
FOR AUX IN BUSQUEDA LOOP
    if BOOLEAN = 0 then
        BOOLEAN := 1;
        RESULTADO :=  '- '|| AUX.obra || ' ' || AUX.fecha;
    elsif BOOLEAN = 1 then 
        RESULTADO := RESULTADO ||'- '|| AUX.obra || ' ' || AUX.fecha;
    end if;
END LOOP;
    
RETURN (RESULTADO);
END;

CREATE OR REPLACE function metodoPagoFactura(id IN NUMBER, fact IN NUMBER)
RETURN VARCHAR2 IS
RESULTADO VARCHAR2(1000);
BOOLEAN NUMBER(1);
CURSOR BUSQUEDA IS select p.formaPago pago
                   from usuario u, pago p, factura f
                   where u.idUsuario = id
                   and u.idUsuario = f.fkUsuario
                   and p.fkFactura = fact 
                   and f.idFactura = p.fkFactura;
                
AUX  BUSQUEDA % ROWTYPE;

BEGIN
BOOLEAN:= 0;
FOR AUX IN BUSQUEDA LOOP
    if AUX.pago = 'tdc' and BOOLEAN = 0 then
        BOOLEAN := 1;
        RESULTADO := 'tarjeta de credito';
    elsif AUX.pago = 'tdd' and BOOLEAN = 0 then
        BOOLEAN := 1;
        RESULTADO := 'tarjeta de debito';
    elsif AUX.pago = 'efectivo' and BOOLEAN = 0 then
        BOOLEAN := 1;
        RESULTADO := 'efectivo';
    elsif AUX.pago = 'tdc' and BOOLEAN = 1 then
        BOOLEAN := 1;
        RESULTADO := RESULTADO  || ', tarjeta de credito';
    elsif AUX.pago = 'tdd' and BOOLEAN = 1 then
        BOOLEAN := 1;
        RESULTADO := RESULTADO  || ', tarjeta de debito';
    elsif AUX.pago = 'efectivo' and BOOLEAN = 1 then
        BOOLEAN := 1;
        RESULTADO := RESULTADO || ', efectivo';
    end if;
END LOOP;
    
RETURN (RESULTADO);
END;
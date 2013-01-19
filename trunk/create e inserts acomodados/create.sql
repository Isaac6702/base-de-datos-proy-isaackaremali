create or replace type datos_personales as object (
    primerNombre            varchar2(20),
    segundoNombre           varchar2(20),
    primerApellido          varchar2(20),
    segundoApellido         varchar2(20)
);
/
create or replace type telefono as object (
    codigo                  varchar2(4),
    numero                  varchar2(15)
);
/
create or replace type telefonos AS VARRAY(3) OF telefono;
/

create table DEPARTAMENTO (
    idDepartamento          number(10)                          not null,
    nombre                  varchar2(20)                        not null,
    tiempoAscenso           number(10)                                  ,
    CONSTRAINT              pkDepartamento_idDepartamento       PRIMARY KEY (idDepartamento)
);

create table CARGO (
    idCargo                 number(10)                          not null,
    nombre                  varchar2(200)                        not null,
    tipoAscenso             varchar2(100)                        not null,
    fkDepartamento          number(10)                          not null,
    fkJefe                  number(10)                                  ,
    CONSTRAINT              pkCargo_idCargo                     PRIMARY KEY (idCargo),
    CONSTRAINT              chCargo_tipoAscenso                 CHECK (tipoAscenso IN ('tiempo', 'nombrado'))
);

create table LUGAR (
    idLugar                 number(10)                          not null,
    nombre                  varchar2(50)                        not null,
    tipo                    varchar2(5)                         not null,
    bandera                 blob                                        ,
    fkLugar                 number(10)                                  ,
    CONSTRAINT              pkLugar_idLugar                    PRIMARY KEY (idLugar),
    CONSTRAINT              chLugar_tipoLugar                  CHECK (tipo IN ('p', 'c', 'e'))
);

create table INSTITUCION (
    idInstitucion          number(10)                          not null,
    nombre                 varchar2(2000)                        not null, 
    CONSTRAINT             pkInstitucion_idInstitucion         PRIMARY KEY (idInstitucion)
);

create table INSTRUMENTO (
    idInstrumento          number(10)                          not null,
    nombre                 varchar2(2000)                        not null, 
    CONSTRAINT             pkInstrumento_idInstrumento         PRIMARY KEY (idInstrumento)
);

create table VOZ (
    idVoz                   number(10)                          not null,
    nombre                  varchar2(2000)                        not null,
    descripcion             varchar2(100)                               ,
    fkVoz                   number(10)                                  , 
    CONSTRAINT              pkVoz_idVoz                         PRIMARY KEY (idVoz)
);

create table NACIONALIDAD (
    idNacionalidad          number(10)                          not null,
    nombre                  varchar2(2000)                        not null,
    sexo                    varchar2(5)                         not null,
    fkPais                  number(10)                          not null,  
    CONSTRAINT              pkNacionalidad_idNacionalidad       PRIMARY KEY (idNacionalidad),
    CONSTRAINT              chNacionalidad_sexo                 CHECK (sexo IN ('f', 'm', 'a'))
);

create table ORQUESTA (
    idOrquesta              number(10)                          not null,
    nombre                  varchar2(2000)                        not null,
    invitado                number(1)                           not null,
    CONSTRAINT              chbooleanInvitado                   CHECK (invitado IN (0,1)),
    CONSTRAINT              pkOrquesta_idOrquesta               PRIMARY KEY (idOrquesta)
);

create table BALLET (
    idBallet                number(10)                          not null,
    nombre                  varchar2(2000)                        not null,
    CONSTRAINT              pkBallet_idBallet                   PRIMARY KEY (idBallet)
);

create table IDIOMA (
    idIdioma                number(10)                          not null,
    nombre                  varchar2(2000)                        not null,
    CONSTRAINT              pkIdioma_idIdioma                   PRIMARY KEY (idIdioma)
);

create table MONEDA (
    idMoneda                number(10)                          not null,
    nombre                  varchar2(2000)                        not null,
    valor                   number(12,2)                        not null,   
    CONSTRAINT              pkMoneda_idMoneda                   PRIMARY KEY (idMoneda)
);

create table MATERIAL (
    idMaterial              number(10)                          not null,
    nombre                  varchar2(2000)                        not null,
    costo                   number(12,2)                        not null, 
    CONSTRAINT              pkMaterial_idMaterial               PRIMARY KEY (idMaterial)
);

create table BAILARIN_BALLET (
    pkBallet                number(10)                          not null,
    pkBailarin              number(10)                          not null,
    fechaInicio             date                                not null,
    fechaFin                date                                        ,
    CONSTRAINT              pkBB_idBB                           PRIMARY KEY (pkBallet, pkBailarin)
);

create table MUSICO_ORQUESTA (
    pkMusico                number(10)                          not null,
    pkOrquesta              number(10)                          not null,
    fechaInicio             date                                not null,
    fechaFin                date                                        ,
    posicion                varchar2(2000)                        not null, 
    CONSTRAINT              pkMO_idMO                           PRIMARY KEY (pkMusico, pkOrquesta)
);

create table DM_ORQUESTA (
    pkDM                    number(10)                          not null,
    pkOrquesta              number(10)                          not null,
    fechaInicio             date                                not null,
    fechaFin                date                                 ,
    CONSTRAINT              pkDMO_idDMO                           PRIMARY KEY (pkDM, pkOrquesta)
);

create table CANTANTE_VOZ (
    pkVoz                   number(10)                          not null,
    pkCantante              number(10)                          not null, 
    CONSTRAINT              pkCV_idCV                           PRIMARY KEY (pkVoz, pkCantante)
);

create table NACIONALIDAD_TRABAJADOR (
    pkNacionalidad          number(10)                          not null,
    pkTrabajador            number(10)                          not null,  
    CONSTRAINT              pkNT_idNT                           PRIMARY KEY (pkNacionalidad, pkTrabajador)
);

create table NACIONALIDAD_INVITADO (
    pkNacionalidad          number(10)                          not null,
    pkInvitado              number(10)                          not null,  
    CONSTRAINT              pkNI_idNI                           PRIMARY KEY (pkNacionalidad, pkInvitado)
);

create table NACIONALIDAD_DIRECTOR (
    pkNacionalidad          number(10)                          not null,
    pkDirector              number(10)                          not null,  
    CONSTRAINT              pkND_idND                           PRIMARY KEY (pkNacionalidad, pkDirector)
);

create table NACIONALIDAD_AUTOR (
    pkNacionalidad          number(10)                          not null,
    pkAutor                 number(10)                          not null,  
    CONSTRAINT              pkNA_idNA                           PRIMARY KEY (pkNacionalidad, pkAutor)
);

create table NACIONALIDAD_DM (
    pkNacionalidad          number(10)                          not null,
    pkDM                    number(10)                          not null,  
    CONSTRAINT              pkNDM_idNDM                         PRIMARY KEY (pkNacionalidad, pkDM)
);

create table NACIONALIDAD_DE (
    pkNacionalidad          number(10)                          not null,
    pkDE                    number(10)                          not null,  
    CONSTRAINT              pkNMDE_idNDE                        PRIMARY KEY (pkNacionalidad, pkDE)
);

create table NACIONALIDAD_COREOGRAFO (
    pkNacionalidad          number(10)                          not null,
    pkCoreografo            number(10)                          not null,  
    CONSTRAINT              pkNCO_idNCO                         PRIMARY KEY (pkNacionalidad, pkCoreografo)
);

create table NACIONALIDAD_BAILARIN (
    pkNacionalidad          number(10)                          not null,
    pkBailarin              number(10)                          not null,  
    CONSTRAINT              pkNB_idNB                           PRIMARY KEY (pkNacionalidad, pkBailarin)
);

create table NACIONALIDAD_CANTANTE (
    pkNacionalidad          number(10)                          not null,
    pkCantante              number(10)                          not null,  
    CONSTRAINT              pkNC_idNC                          PRIMARY KEY (pkNacionalidad, pkCantante)
);

create table NACIONALIDAD_MUSICO (
    pkNacionalidad          number(10)                          not null,
    pkMusico                number(10)                          not null,  
    CONSTRAINT              pkNM_idNM                          PRIMARY KEY (pkNacionalidad, pkMusico)
);

create table NACIONALIDAD_ESCENOGRAFO (
    pkNacionalidad          number(10)                          not null,
    pkEscenografo           number(10)                          not null,  
    CONSTRAINT              pkNe_idNE                          PRIMARY KEY (pkNacionalidad, pkEscenografo)
);

create table MUSICO_OBRA (
    pkInstrumento           number(10)                          not null,
    pkMusico                number(10)                          not null,
    pkPresentacion          number(10)                          not null,
    posicion                varchar2(2000)                        not null,
    CONSTRAINT              pkMOb_idMOb                         PRIMARY KEY (pkInstrumento, pkMusico, pkPresentacion)
);

create table BAILARIN_OBRA (
    pkBailarin              number(10)                          not null,
    pkPresentacion          number(10)                          not null,  
    CONSTRAINT              pkBO_idBO                           PRIMARY KEY (pkBailarin, pkPresentacion)
);

create table TRABAJADOR_OBRA (
    pkTrabajador            number(10)                          not null,
    pkPresentacion          number(10)                          not null,  
    CONSTRAINT              pkTO_idTO                           PRIMARY KEY (pkTrabajador, pkPresentacion)
);

create table INVITADO_OBRA (
    pkIE                    number(10)                          not null,
    pkPresentacion          number(10)                          not null,  
    CONSTRAINT              pkIO_idIO                           PRIMARY KEY (pkIE, pkPresentacion)
);

create table AUDICION_CANTANTE (
    idAC                    number(10)                          not null,
    fecha                   date                                not null,
    aprobo                  number(1)                           not null,
    fkCantante              number(10)                          not null,
    fkPersonaje             number(10)                          not null, 
    CONSTRAINT              pkAC_idAC                           PRIMARY KEY (idAC)
);

create table PARTE (
    idParte                 number(10)                          not null,
    nombre                  varchar2(2000)                        not null,
    tipo                    varchar2(1000)                        not null,
    fkParte                 number(10)                                  ,
    fkObra                  number(10)                          not null, 
    CONSTRAINT              pkParte_idParte                     PRIMARY KEY (idParte),
    CONSTRAINT              chParte_tipo                        CHECK (tipo IN ('acto', 'cavatina', 'barcarola', 'aria', 'obertura', 'recitativo', 'coro', 'duo', 'trio', 'cuarteto', 'concertante','romanza'))
);

create table AUDIO (
    idAudio                 number(10)                          not null,
    descripcion             varchar2(2000)                      not null,
    formato                 varchar2(1000)                      not null,
    contenido               blob                                not null,
    fkPresentacion          number(10)                          not null,
    precio                  number(12,2)                        not null,
    CONSTRAINT              pkAudio_idAudio                     PRIMARY KEY (idAudio),
    CONSTRAINT              chAudio_formato                     CHECK (formato IN ('mp3', 'wav', 'rmi', 'midi', 'amf', 'mtn', 'wma'))
);

create table VIDEO (
    idVideo                 number(10)                          not null,
    descripcion             varchar2(2000)                      not null,
    formato                 varchar2(2000)                      not null,
    contenido               blob                                not null,
    fkPresentacion          number(10)                          not null,
    precio                  number(12,2)                        not null,
    CONSTRAINT              pkVideo_idVideo                     PRIMARY KEY (idVideo),
    CONSTRAINT              chVideo_formato                     CHECK (formato IN ('3gp', 'aaf', 'asf', 'avi', 'camproj', 'divx', 'flv', 'mp4', 'mpg'))
);

create table OBRA (
    idObra                  number(10)                          not null,
    nombre                  varchar2(2000)                        not null,
    descripcion             varchar2(2000)                       not null,
    fechaVenta              date                                not null,
    fkDirector              number(10)                          not null,
    fkOrquesta              number(10)                                  ,
    fkBallet                number(10)                                  ,
    fkCoreografo            number(10)                          not null,
    fkDM                    number(10)                          not null,
    fkAutor                 number(10)                          not null,
    CONSTRAINT              pkObra_idObra                      PRIMARY KEY (idObra)
);

create table FECHA_PRESENTACION (
    idFP                    number(10)                          not null,
    fecha                   date                                not null,
    zonaMasCara             number(12,2)                        not null,
    fkObra                  number(10)                          not null, 
    CONSTRAINT              pkFP_idFP                           PRIMARY KEY (idFP)
);

create table USUARIO (
    idUsuario               number(10)                          not null,
    pasaporte               number(10)                          not null,
    nombre                  datos_personales                            ,
    detalleDireccion        varchar2(2000)                       not null,
    telefono                telefonos                                   ,
    sexo                    varchar2(100)                        not null,
    fechaNacimiento         date                                not null,
    fkLugar                 number(10)                          not null,
    fkIdioma                number(10)                                  ,
    fkNacionalidad          number(10)                          not null,
    CONSTRAINT              pkUsuario_idUsuario                 PRIMARY KEY (idUsuario),
    CONSTRAINT              chUsuario_sexo                      CHECK (sexo IN ('f', 'm')),
    CONSTRAINT              cPasaporte_usuario                  UNIQUE (pasaporte)   
);

create table UBICACION (
    idUbicacion             number(10)                          not null,
    tipo                    varchar2(1000)                       not null,
    nombre                  varchar2(1000)                      not null,
    porcentaje              number(12,2)                                ,
    fkUbicacion             number(10)                                  ,
    CONSTRAINT              pkUbicacion_idUbicacion             PRIMARY KEY (idUbicacion),
    CONSTRAINT              chUbicacion_tipo                    CHECK (tipo IN ('piso', 'zona', 'asiento'))
);

create table ENTRADA (
    idEntrada               number(10)                          not null,
    costo                   number(12,2)                        not null,
    pagada                  number(1)                           not null,
    fkUbicacion             number(10)                          not null,
    fkPresentacion          number(10)                          not null,
    CONSTRAINT              chbooleanPagada                     CHECK (pagada IN (0,1)),
    CONSTRAINT              pkEntrada_idEntrada                 PRIMARY KEY (idEntrada) 
);

create table RESERVA (
    idReserva               number(10)                          not null,
    fecha                   date                                not null,
    fkUsuario               number(10)                          not null,
    CONSTRAINT              pkReserva_idReserva                 PRIMARY KEY (idReserva)
);

create table DETALLE_RESERVA (
    pkReserva               number(10)                          not null,
    pkEntrada               number(10)                          not null,
    status                  varchar2(1000)                        not null,
    CONSTRAINT              chbooleanStatus                     CHECK (status IN ('a','p','c')),
    CONSTRAINT              pkDR_idDR                           PRIMARY KEY (pkReserva, pkEntrada)
);

create table FACTURA (
    idFactura               number(10)                          not null,
    fecha                   date                                not null,
    fkUsuario               number(10)                          not null,
    CONSTRAINT              pkFactura_idFactura                 PRIMARY KEY (idFactura)
);

create table DETALLE_FACTURA (
    idDF                    number(10)                          not null,
    cantidadLibreto         number(10)                                  ,
    monto                   number(12,2)                        not null,
    fkFactura               number(10)                          not null,
    fkEntrada               number(10)                                  ,
    fkLibreto               number(10)                                  ,
    CONSTRAINT              pkDF_idDF                           PRIMARY KEY (idDF)
);

create table PREMIACION (
    idPremiacion            number(10)                          not null,
    descripcion             varchar2(2000)                        not null,
    numeroEntradasCompradas number(10)                          not null,
    fkUsuario               number(10)                          not null,
    fkPresentacion          number(10)                          not null,
    CONSTRAINT              pkPremiacion_idPremiacion           PRIMARY KEY (idPremiacion)
);

create table PARTITURA (
    idPartitura             number(10)                          not null,
    contenido               blob                                not null,
    registroInstrumentoPerfecto blob                            not null,
    fkInstrumento           number(10)                          not null,
    fkObra                  number(10)                          not null,
    CONSTRAINT              pkPartitura_idPartitura             PRIMARY KEY (idPartitura)
);

create table AUDICION_MUSICO (
    idAM                    number(10)                          not null,
    fecha                   date                                not null,
    aprobo                  number(1)                           not null,
    fkPartitura             number(10)                          not null,
    fkMusico                number(10)                          not null,
    CONSTRAINT              chbooleanAprobo                     CHECK (aprobo IN (0,1)),
    CONSTRAINT              pkAM_idAM                           PRIMARY KEY (idAM)
);

create table LIBRETO (
    idLibreto               number(10)                          not null,
    contenido               varchar2(2000)                              ,
    pdf                     blob                                        ,
    costo                   number(12,2)                        not null,
    fkIdioma                number(10)                          not null,
    fkObra                  number(10)                          not null,
    fkAutor                 number(10)                          not null,
    idiomaOriginal          number(1)                           not null,
    CONSTRAINT              chbooleanIdiomaOriginal             CHECK (idiomaOriginal IN (0,1)),
    CONSTRAINT              pkLibreto_idLibreto                 PRIMARY KEY (idLibreto)
);

create table PAGO (
    idPago                  number(10)                          not null,
    monto                   number(12,2)                        not null,
    fecha                   date                                not null,
    formaPago               varchar2(2000)                        not null,
    costoExtranjero         number(12,2)                                ,
    fkMoneda                number(10)                                  ,
    fkFactura               number(10)                          not null,   
    CONSTRAINT              pkPago_idPago                       PRIMARY KEY (idPago),
    CONSTRAINT              chPago_formaPago                    CHECK (formaPago IN ('tdc', 'tdd', 'efectivo'))
);

create table ESCENOGRAFIA (
    idEscenografia          number(10)                          not null,
    descripcion             varchar2(2000)                       not null,
    fkObra                  number(10)                          not null,
    fkEscenografo           number(10)                          not null,
    fkDirectorEscenografia  number(10)                          not null,
    CONSTRAINT              pkEscenografia_idEscenografia       PRIMARY KEY (idEscenografia)
);

create table ESCENOGRAFIA_MATERIAL (
    idEM                    number(10)                          not null,
    costo                   number(12,2)                        not null,
    cantidad                number(12,2)                        not null,
    fkMaterial              number(10)                          not null,
    fkEscenografia          number(10)                          not null,
    CONSTRAINT              pkEM_idEM                           PRIMARY KEY (idEM)
);

create table PERSONAJE (
    idPersonaje             number(10)                          not null,
    nombre                  varchar2(2000)                        not null,
    descripcion             varchar2(1000)                               ,
    registroVoz             blob                                not null,
    principal               number(1)                           not null,
    fkVoz                   number(10)                          not null,
    fkObra                  number(10)                          not null, 
    CONSTRAINT              chbooleanPrincipal                  CHECK (principal IN (0,1)),
    CONSTRAINT              pkPersonaje_idPersonaje             PRIMARY KEY (idPersonaje)
);

create table ELENCO (
    pkPersonaje             number(10)                          not null,
    pkCantante              number(10)                          not null,
    pkFechaPresentacion     number(10)                          not null,
    CONSTRAINT              pkElenco_idElenco                   PRIMARY KEY (pkPersonaje, pkCantante, pkFechaPresentacion)
);

create table HECHO_BIOGRAFICO (
    idHB                    number(10)                          not null,
    fecha                   date                                not null,
    tipo                    varchar2(2000)                        not null,
    descripcion             varchar2(1000)                               ,
    fkLugar                 number(10)                          not null,
    fkAutor                 number(10)                                  ,
    fkInvitado              number(10)                          not null,
    CONSTRAINT              pkHB_idHB                           PRIMARY KEY (idHB)
);

create table MUSICO_INSTRUMENTO (
    pkMusico                number(10)                          not null,
    pkInstrumento           number(10)                          not null,
    instrumentoPrincipal    number(1)                           not null,
    fechaEjecucion          date                                not null,
    CONSTRAINT              chbooleanInstrumentoPrincipal       CHECK (instrumentoPrincipal IN (0,1)),
    CONSTRAINT              pkMI_idMI                           PRIMARY KEY (pkMusico, pkInstrumento)
);

create table ESTUDIO (
    idEstudio               number(10)                          not null,
    descripcion             varchar2(2000)                        not null,
    fechaInicio             date                                not null,
    fechaFin                date                                        ,
    fkInstitucion           number(10)                          not null,
    fkTrabajador            number(10)                                  ,
    fkMusico                number(10)                                  ,
    fkInvitado              number(10)                                  ,
    fkBailarin              number(10)                                  ,
    fkCantante              number(10)                                  ,
    fkEscenografo           number(10)                                  ,
    fkAutor                 number(10)                                  ,
    fkDirectorEscenografia  number(10)                                  ,
    fkCoreografo            number(10)                                  ,
    fkDirector              number(10)                                  ,
    fkDM                    number(10)                                  ,
    CONSTRAINT              pkEstudio_idEstudio                 PRIMARY KEY (idEstudio)
);

create table TRABAJADOR_CARGO (
    idTC                    number(10)                          not null,
    fechaInicio             date                                not null,
    fechaFin                date                                        ,
    sueldo                  number(12,2)                        not null,
    fkCargo                 number(10)                          not null,
    fkTrabajador            number(10)                                  ,
    fkMusico                number(10)                                  ,
    fkInvitado              number(10)                                  ,
    fkBailarin              number(10)                                  ,
    fkCantante              number(10)                                  ,
    fkEscenografo           number(10)                                  ,
    fkAutor                 number(10)                                  ,
    fkDirectorEscenografia  number(10)                                  ,
    fkCoreografo            number(10)                                  ,
    fkDirector              number(10)                                  ,
    fkDM                    number(10)                                  ,
    CONSTRAINT              pkTrabajadorCargo_idTC              PRIMARY KEY (idTC)
);

create table TRABAJADOR (
    idTrabajador            number(10)                          not null,
    pasaporte               number(10)                          not null,
    nombreCompleto          datos_personales                            ,
    telefono                telefonos                                   ,
    sexo                    varchar2(1000)                        not null,
    fechaNacimiento         date                                not null,
    fallecimiento           date                                        ,
    foto                    blob                                        ,
    fkLugar                 number(10)                          not null,
    detalleDireccion        varchar2(2000)                       not null,
    invitado                number(1)                           not null,
    CONSTRAINT              chTrabajador_booleanInvitado        CHECK (invitado IN (0,1)),
    CONSTRAINT              pkTrabajador_idTrabajador           PRIMARY KEY (idTrabajador),
    CONSTRAINT              chTrabajador_sexo                   CHECK (sexo IN ('f', 'm')),
    CONSTRAINT              cPasaporte_trabajador               UNIQUE (pasaporte)
);

create table MUSICO (
    idMusico                number(10)                          not null,
    pasaporte               number(10)                          not null,
    nombreCompleto          datos_personales                            ,
    telefono                telefonos                                   ,
    sexo                    varchar2(1000)                        not null,
    fechaNacimiento         date                                not null,
    fallecimiento           date                                        ,
    foto                    blob                                        ,
    fkLugar                 number(10)                          not null,
    detalleDireccion        varchar2(2000)                       not null,
    invitado                number(1)                           not null,
    CONSTRAINT              chMusico_booleanInvitado                CHECK (invitado IN (0,1)),
    CONSTRAINT              pkMusico_idMusico                   PRIMARY KEY (idMusico),
    CONSTRAINT              chMusico_sexo                       CHECK (sexo IN ('f', 'm')),
    CONSTRAINT              cPasaporte_musico                   UNIQUE (pasaporte)
);

create table CANTANTE (
    idCantante              number(10)                          not null,
    pasaporte               number(10)                          not null,
    nombreCompleto          datos_personales                            ,
    telefono                telefonos                                   ,
    sexo                    varchar2(1000)                        not null,
    fechaNacimiento         date                                not null,
    fallecimiento           date                                        ,
    foto                    blob                                        ,
    fkLugar                 number(10)                          not null,
    detalleDireccion        varchar2(2000)                       not null,
    invitado                number(1)                           not null,
    CONSTRAINT              chCantante_booleanInvitado                CHECK (invitado IN (0,1)),
    CONSTRAINT              pkCantante_idCantante               PRIMARY KEY (idCantante),
    CONSTRAINT              chCantante_sexo                     CHECK (sexo IN ('f', 'm')),
    CONSTRAINT              cPasaporte_Cantante                 UNIQUE (pasaporte)
);

create table BAILARIN (
    idBailarin              number(10)                          not null,
    pasaporte               number(10)                          not null,
    nombreCompleto          datos_personales                            ,
    telefono                telefonos                                   ,
    sexo                    varchar2(1000)                        not null,
    fechaNacimiento         date                                not null,
    fallecimiento           date                                        ,
    foto                    blob                                        ,
    fkLugar                 number(10)                          not null,
    detalleDireccion        varchar2(2000)                       not null,
    invitado                number(1)                           not null,
    CONSTRAINT              chBailarin_booleanInvitado         CHECK (invitado IN (0,1)),
    CONSTRAINT              pkBailarin_idBailarin              PRIMARY KEY (idBailarin),
    CONSTRAINT              chBailarin_sexo                    CHECK (sexo IN ('f', 'm')),
    CONSTRAINT              cBailarin_trabajador               UNIQUE (pasaporte)
); 

create table ESCENOGRAFO (
    idEscenografo           number(10)                          not null,
    pasaporte               number(10)                          not null,
    nombreCompleto          datos_personales                            ,
    telefono                telefonos                                   ,
    sexo                    varchar2(1000)                        not null,
    fechaNacimiento         date                                not null,
    fallecimiento           date                                        ,
    foto                    blob                                        ,
    fkLugar                 number(10)                          not null,
    detalleDireccion        varchar2(2000)                       not null,
    invitado                number(1)                           not null,
    CONSTRAINT              chEscenografo_booleanInvitado       CHECK (invitado IN (0,1)),
    CONSTRAINT              pkEscenografo_idEscenografo         PRIMARY KEY (idEscenografo),
    CONSTRAINT              chEscenografo_sexo                  CHECK (sexo IN ('f', 'm')),
    CONSTRAINT              cEscenografo_trabajador             UNIQUE (pasaporte)
);

create table INVITADO_ESPECIAL (
    idIE                    number(10)                          not null,
    pasaporte               number(10)                          not null,
    nombreCompleto          datos_personales                            ,
    telefono                telefono                                    ,
    sexo                    varchar2(1000)                        not null,
    fechaNacimiento         date                                not null,
    fallecimiento           date                                        ,
    foto                    blob                                        ,
    fkLugar                 number(10)                          not null,
    detalleDireccion        varchar2(2000)                       not null,
    CONSTRAINT              pkIE_idIE                           PRIMARY KEY (idIE),
    CONSTRAINT              chIE_sexo                           CHECK (sexo IN ('f', 'm')),
    CONSTRAINT              cPasaporte_invitado                 UNIQUE (pasaporte)
); 

create table AUTOR (
    idAutor                 number(10)                          not null,
    pasaporte               number(10)                          not null,
    nombreCompleto          datos_personales                            ,
    telefono                telefonos                                   ,
    sexo                    varchar2(1000)                        not null,
    fechaNacimiento         date                                not null,
    fallecimiento           date                                        ,
    foto                    blob                                        ,
    fkLugar                 number(10)                          not null,
    detalleDireccion        varchar2(2000)                       not null,
    invitado                number(1)                           not null,
    CONSTRAINT              chAutor_booleanInvitado             CHECK (invitado IN (0,1)),
    CONSTRAINT              pkAutor_idAutor                     PRIMARY KEY (idAutor),
    CONSTRAINT              chAutor_sexo                        CHECK (sexo IN ('f', 'm')),
    CONSTRAINT              cPasaporte_estudio                  UNIQUE (pasaporte)
);

create table DIRECTOR_ESCENOGRAFIA (
    idDE                    number(10)                          not null,
    pasaporte               number(10)                          not null,
    nombreCompleto          datos_personales                            ,
    telefono                telefonos                                   ,
    sexo                    varchar2(1000)                        not null,
    fechaNacimiento         date                                not null,
    fallecimiento           date                                        ,
    foto                    blob                                        ,
    fkLugar                 number(10)                          not null,
    detalleDireccion        varchar2(2000)                       not null,
    invitado                number(1)                           not null,
    CONSTRAINT              chDE_booleanInvitado                CHECK (invitado IN (0,1)),
    CONSTRAINT              pkDE_idDE                           PRIMARY KEY (idDE),
    CONSTRAINT              chDE_sexo                           CHECK (sexo IN ('f', 'm')),
    CONSTRAINT              cPasaporte_de                       UNIQUE (pasaporte)
);

create table COREOGRAFO (
    idCoreografo            number(10)                          not null,
    pasaporte               number(10)                          not null,
    nombreCompleto          datos_personales                            ,
    telefono                telefonos                                   ,
    sexo                    varchar2(1000)                        not null,
    fechaNacimiento         date                                not null,
    fallecimiento           date                                        ,
    foto                    blob                                        ,
    fkLugar                 number(10)                          not null,
    detalleDireccion        varchar2(2000)                       not null,
    invitado                number(1)                           not null,
    CONSTRAINT              chCoreografo_booleanInvitado        CHECK (invitado IN (0,1)),
    CONSTRAINT              pkCoreografo_idCoreografo           PRIMARY KEY (idCoreografo),
    CONSTRAINT              chCoreografo_sexo                   CHECK (sexo IN ('f', 'm')),
    CONSTRAINT              cPasaporte_Coreografo               UNIQUE (pasaporte)
);

create table DIRECTOR (
    idDirector              number(10)                          not null,
    pasaporte               number(10)                          not null,
    nombreCompleto          datos_personales                            ,
    telefono                telefonos                                   ,
    sexo                    varchar2(1000)                        not null,
    fechaNacimiento         date                                not null,
    fallecimiento           date                                        ,
    foto                    blob                                        ,
    fkLugar                 number(10)                          not null,   
    detalleDireccion        varchar2(2000)                       not null,
    invitado                number(1)                           not null,
    CONSTRAINT              chDirector_booleanInvitado          CHECK (invitado IN (0,1)),
    CONSTRAINT              pkDirector_idDirector               PRIMARY KEY (idDirector),
    CONSTRAINT              chDirector_sexo                     CHECK (sexo IN ('f', 'm')),
    CONSTRAINT              cPasaporte_director                 UNIQUE (pasaporte)
);

create table DIRECTOR_MUSICAL (
    idDM                    number(10)                          not null,
    pasaporte               number(10)                          not null,
    nombreCompleto          datos_personales                            ,
    telefono                telefonos                                   ,
    sexo                    varchar2(1000)                        not null,
    fechaNacimiento         date                                not null,
    fallecimiento           date                                        ,
    foto                    blob                                        ,
    fkLugar                 number(10)                          not null,   
    detalleDireccion        varchar2(2000)                       not null,
    invitado                number(1)                           not null,
    CONSTRAINT              pkDM_idDM                           PRIMARY KEY (idDM),
    CONSTRAINT              chDM_sexo                           CHECK (sexo IN ('f', 'm')),
    CONSTRAINT              chDM_booleanInvitado                CHECK (invitado IN (0,1)),
    CONSTRAINT              cPasaporte_dm                       UNIQUE (pasaporte)
);


create table FACTURA_DIGITALIZACION (
    idFD                    number(10)                          not null,
    fecha                   date                                not null,
    fkUsuario               number(10)                          not null,
    CONSTRAINT              pkFactura_idFD                      PRIMARY KEY (idFD)
);

create table DETALLE_FACTURA_DIGITALIZADA (
    idDFD                   number(10)                          not null,
    cantidad                number(10)                          not null,
    monto                   number(12,2)                        not null,
    fkFD                    number(10)                          not null,
    fkVideo                 number(10)                                  ,
    fkAudio                 number(10)                                  ,
    CONSTRAINT              pkDF_idDFD                           PRIMARY KEY (idDFD)
);

create table PAGO_DIGITALIZACION (
    idPD                    number(10)                          not null,
    monto                   number(12,2)                        not null,
    fecha                   date                                not null,
    formaPago               varchar2(2000)                      not null,
    costoExtranjero         number(12,2)                                ,
    fkMoneda                number(10)                                  ,
    fkFD                    number(10)                         not null,   
    CONSTRAINT              pkPagoD_idPD                       PRIMARY KEY (idPD),
    CONSTRAINT              chPagoD_formaPD                    CHECK (formaPago IN ('tdc', 'tdd', 'efectivo'))
);

create table REGISTRO_VOZ_PERSONAJE (
    idRVP                   number(10)                          not null,
    pkPersonaje             number(10)                          not null,
    x                       number(10)                          not null,
    y                       number(10)                          not null,
    CONSTRAINT              pkRVP_id                            PRIMARY KEY (idRVP, pkPersonaje)
);

create table REGISTRO_INSTRUMENTO (
    idRI                    number(10)                          not null,
    pkPartitura             number(10)                          not null,
    x                       number(10)                          not null,
    y                       number(10)                          not null,
    CONSTRAINT              pkRI_id                            PRIMARY KEY (idRI, pkPartitura)
);

create table VOZ_AUDICION (
    idVA                    number(10)                          not null,
    pkAC                    number(10)                          not null,
    x                       number(10)                          not null,
    y                       number(10)                          not null,
    CONSTRAINT              pkVA_id                            PRIMARY KEY (idVA, pkAC)
);

create table INSTRUMENTO_AUDICION (
    idIA                    number(10)                          not null,
    pkAM                    number(10)                          not null,
    x                       number(10)                          not null,
    y                       number(10)                          not null,
    CONSTRAINT              pkIA_id                            PRIMARY KEY (idIA, pkAM)
);

create table HISTORIAL_PAGO (
    idHP                    number(10)                          not null,
    fecha                   date                                not null,
    monto                   number(12,2)                        not null,
    fkFP                    number(10)                          not null,
    fkTrabajador            number(10)                                  ,
    fkMusico                number(10)                                  ,
    fkBailarin              number(10)                                  ,
    fkCantante              number(10)                                  ,
    fkEscenografo           number(10)                                  ,
    fkAutor                 number(10)                                  ,
    fkDirectorEscenografia  number(10)                                  ,
    fkCoreografo            number(10)                                  ,
    fkDirector              number(10)                                  ,
    fkDM                    number(10)                                  ,
    CONSTRAINT               pkHP_id                           PRIMARY KEY (idHP)
);

CREATE SEQUENCE seqDepartamento
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqCargo
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;     
     
CREATE SEQUENCE seqInstrumento
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqInstitucion
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqHechoBiografico
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqLugar
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqTrabajadorCargo
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqMaterial
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqEscenografiaMaterial
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqEscenografia
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqVoz
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;
     
CREATE SEQUENCE seqNacionalidad
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqOrquesta
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqBallet
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqMusicoObra
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqParte
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;
     
CREATE SEQUENCE seqObra
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqPersonaje
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqAudio
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqVideo
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;
     
CREATE SEQUENCE seqReserva
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;
     
CREATE SEQUENCE seqFactura
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqMoneda
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqPago
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqPremiacion
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqAudicionMusico
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;
     
CREATE SEQUENCE seqAudicionCantante
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqDirectorMusical
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqIdioma
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqBailarin
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqEstudio
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;
     
CREATE SEQUENCE seqEscenografo
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;
     
CREATE SEQUENCE seqCoreografo
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;
     
CREATE SEQUENCE seqDirector
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;
     
CREATE SEQUENCE seqTrabajador
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;
     
CREATE SEQUENCE seqDirectorEscenografia
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;
       
CREATE SEQUENCE seqUsuario
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;
     
CREATE SEQUENCE seqUbicacion
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqdf
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqFP
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;     

CREATE SEQUENCE seqEntrada
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;
     
CREATE SEQUENCE seqPartitura
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqFD
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;
     
CREATE SEQUENCE seqDFD
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;

CREATE SEQUENCE seqHP
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     NOMAXVALUE
     NOCYCLE
     CACHE 10;
     
CREATE SEQUENCE seqIA
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 100
     CYCLE
     CACHE 10;
     
CREATE SEQUENCE seqRI
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 100
     CYCLE
     CACHE 10;

CREATE SEQUENCE seqVA
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 100
     CYCLE
     CACHE 10;

CREATE SEQUENCE seqRVP
     START WITH 1
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 100
     CYCLE
     CACHE 10;
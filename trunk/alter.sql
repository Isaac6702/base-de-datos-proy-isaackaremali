alter table CARGO
add constraint cargo_fkDepartamento
foreign key (fkDepartamento)
references DEPARTAMENTO(idDepartamento)
on delete cascade;

alter table CARGO
add constraint cargo_fkJefe
foreign key (fkJefe)
references CARGO(idCargo)
on delete cascade;

alter table LUGAR
add constraint lugar_fkLugar
foreign key (fkLugar)
references LUGAR(idLugar)
on delete cascade;

alter table VOZ
add constraint voz_fkVoz
foreign key (fkVoz)
references VOZ(idVoz)
on delete cascade;

alter table NACIONALIDAD
add constraint nacionalidad_fkPais
foreign key (fkPais)
references LUGAR(idLugar)
on delete cascade;

alter table BAILARIN_BALLET
add constraint bb_fkBallet
foreign key (pkBallet)
references BALLET(idBallet)
on delete cascade;

alter table BAILARIN_BALLET
add constraint bb_fkBailarin
foreign key (pkBailarin)
references BAILARIN(idBailarin)
on delete cascade;

alter table MUSICO_ORQUESTA
add constraint mo_fkMusico
foreign key (pkMusico)
references MUSICO(idMusico)
on delete cascade;

alter table MUSICO_ORQUESTA
add constraint mo_fkOrquesta
foreign key (pkOrquesta)
references ORQUESTA(idOrquesta)
on delete cascade;

alter table CANTANTE_VOZ
add constraint cv_fkCantante
foreign key (pkCantante)
references CANTANTE(idCantante)
on delete cascade;

alter table NACIONALIDAD_TRABAJADOR
add constraint nt_fkNacionalidad
foreign key (pkNacionalidad)
references NACIONALIDAD(idNacionalidad)
on delete cascade;

alter table NACIONALIDAD_TRABAJADOR
add constraint nt_fkTrabajador
foreign key (pkTrabajador)
references TRABAJADOR(idTrabajador)
on delete cascade;

alter table MUSICO_OBRA
add constraint mo_fkInstrumento
foreign key (pkInstrumento)
references INSTRUMENTO(idInstrumento)
on delete cascade;

alter table MUSICO_OBRA
add constraint mo_fkPresentacion 
foreign key (pkPresentacion)
references FECHA_PRESENTACION(idFP)
on delete cascade;

alter table MUSICO_OBRA
add constraint MusObra_fkMusico
foreign key (pkMusico)
references MUSICO(idMusico)
on delete cascade;

alter table BAILARIN_OBRA
add constraint bo_fkBailarin
foreign key (pkBailarin)
references BAILARIN(idBailarin)
on delete cascade;

alter table BAILARIN_OBRA
add constraint bo_fkPresentacion
foreign key (pkPresentacion)
references FECHA_PRESENTACION(idFP)
on delete cascade;

alter table AUDICION_CANTANTE
add constraint ac_fkCantante
foreign key (fkCantante)
references CANTANTE(idCantante)
on delete cascade;

alter table AUDICION_CANTANTE
add constraint ac_fkPersonaje
foreign key (fkPersonaje)
references PERSONAJE(idPersonaje)
on delete cascade;

alter table PARTE
add constraint parte_fkParte
foreign key (fkParte)
references PARTE(idParte)
on delete cascade;

alter table PARTE
add constraint parte_fkObra
foreign key (fkObra)
references OBRA(idObra)
on delete cascade;

alter table AUDIO
add constraint audio_fkPresentacion
foreign key (fkPresentacion)
references FECHA_PRESENTACION(idFP)
on delete cascade;

alter table VIDEO
add constraint video_fkPresentacion
foreign key (fkPresentacion)
references FECHA_PRESENTACION(idFP)
on delete cascade;

alter table OBRA
add constraint obra_fkDirector
foreign key (fkDirector)
references DIRECTOR(idDirector)
on delete cascade;

alter table OBRA
add constraint obra_fkDM
foreign key (fkDM)
references DIRECTOR_MUSICAL(idDM)
on delete cascade;

alter table OBRA
add constraint obra_fkOrquesta
foreign key (fkOrquesta)
references ORQUESTA(idOrquesta)
on delete cascade;

alter table OBRA
add constraint obra_fkBallet
foreign key (fkBallet)
references BALLET(idBallet)
on delete cascade;

alter table OBRA
add constraint obra_fkCoreografo
foreign key (fkCoreografo)
references COREOGRAFO(idCoreografo)
on delete cascade;

alter table FECHA_PRESENTACION
add constraint fp_fkObra
foreign key (fkObra)
references OBRA(idObra)
on delete cascade;

alter table USUARIO
add constraint usuario_fkLugar
foreign key (fkLugar)
references LUGAR(idLugar)
on delete cascade;

alter table USUARIO
add constraint usuario_fkIdioma
foreign key (fkIdioma)
references IDIOMA(idIdioma)
on delete cascade;

alter table USUARIO
add constraint usuario_fkNacionalidad
foreign key (fkNacionalidad)
references NACIONALIDAD(idNacionalidad)
on delete cascade;

alter table UBICACION
add constraint ubicacion_fkUbicacion
foreign key (fkUbicacion)
references UBICACION(idUbicacion)
on delete cascade;

alter table ENTRADA
add constraint entrada_fkUbicacion
foreign key (fkUbicacion)
references UBICACION(idUbicacion)
on delete cascade;

alter table ENTRADA
add constraint entrada_fkPresentacion
foreign key (fkPresentacion)
references FECHA_PRESENTACION(idFP)
on delete cascade;

alter table RESERVA
add constraint reserva_fkUsuario
foreign key (fkUsuario)
references USUARIO(idUsuario)
on delete cascade;

alter table DETALLE_RESERVA 
add constraint dr_fkReserva
foreign key (pkReserva)
references RESERVA(idReserva)
on delete cascade;

alter table DETALLE_RESERVA
add constraint dr_fkEntrada
foreign key (pkEntrada)
references ENTRADA(idEntrada)
on delete cascade;

alter table FACTURA
add constraint factura_fkUsuario
foreign key (fkUsuario)
references USUARIO(idUsuario)
on delete cascade;

alter table DETALLE_FACTURA 
add constraint df_fkFactura
foreign key (fkFactura)
references FACTURA(idFactura)
on delete cascade;

alter table DETALLE_FACTURA
add constraint df_fkEntrada
foreign key (fkEntrada)
references ENTRADA(idEntrada)
on delete cascade;

alter table DETALLE_FACTURA
add constraint df_fkLibreto
foreign key (fkLibreto)
references LIBRETO(idLibreto)
on delete cascade;

alter table PREMIACION
add constraint premiacion_fkUsuario
foreign key (fkUsuario)
references USUARIO(idUsuario)
on delete cascade;

alter table PREMIACION
add constraint premiacion_fkPresentacion
foreign key (fkPresentacion)
references FECHA_PRESENTACION(idFP)
on delete cascade;

alter table PARTITURA
add constraint partitura_fkObra
foreign key (fkObra)
references OBRA(idObra)
on delete cascade;

alter table PARTITURA
add constraint partitura_fkInstrumento
foreign key (fkInstrumento)
references INSTRUMENTO(idInstrumento)
on delete cascade;

alter table AUDICION_MUSICO   
add constraint am_fkPartitura
foreign key (fkPartitura)
references PARTITURA(idPartitura)
on delete cascade;

alter table AUDICION_MUSICO
add constraint am_fkMusico
foreign key (fkMusico)
references MUSICO(idMusico)
on delete cascade;

alter table LIBRETO
add constraint libreto_fkIdioma
foreign key (fkIdioma)
references IDIOMA(idIdioma)
on delete cascade;

alter table LIBRETO
add constraint libreto_fkAutor
foreign key (fkAutor)
references AUTOR(idAutor)
on delete cascade;

alter table LIBRETO
add constraint libreto_fkObra
foreign key (fkObra)
references OBRA(idObra)
on delete cascade;

alter table PAGO
add constraint pago_fkMoneda
foreign key (fkMoneda)
references MONEDA(idMoneda)
on delete cascade;

alter table PAGO
add constraint pago_fkFactura
foreign key (fkFactura)
references FACTURA(idFactura)
on delete cascade;

alter table ESCENOGRAFIA
add constraint escenografia_fkObra
foreign key (fkObra)
references OBRA(idObra)
on delete cascade;

alter table ESCENOGRAFIA
add constraint escenografia_fkEscenografo
foreign key (fkEscenografo)
references ESCENOGRAFO(idEscenografo)
on delete cascade;

alter table ESCENOGRAFIA
add constraint esceno_fkDEsceno
foreign key (fkDirectorEscenografia)
references DIRECTOR_ESCENOGRAFIA(idDE)
on delete cascade;

alter table ESCENOGRAFIA_MATERIAL
add constraint em_fkMaterial
foreign key (fkMaterial)
references MATERIAL(idMaterial)
on delete cascade;

alter table ESCENOGRAFIA_MATERIAL
add constraint em_fkEscenografia
foreign key (fkEscenografia)
references ESCENOGRAFIA(idEscenografia)
on delete cascade;

alter table PERSONAJE
add constraint personaje_fkVoz
foreign key (fkVoz)
references VOZ(idVoz)
on delete cascade;

alter table PERSONAJE
add constraint personaje_fkObra
foreign key (fkObra)
references OBRA(idObra)
on delete cascade;

alter table ELENCO
add constraint elenco_fkPersonaje
foreign key (pkPersonaje)
references PERSONAJE(idPersonaje)
on delete cascade;

alter table ELENCO
add constraint elenco_fkCantante
foreign key (pkCantante)
references CANTANTE(idCantante)
on delete cascade;

alter table ELENCO
add constraint elenco_fkfechaPresentaicon
foreign key (pkFechaPresentacion)
references FECHA_PRESENTACION(idFP)
on delete cascade;

alter table HECHO_BIOGRAFICO
add constraint hb_fkLugar
foreign key (fkLugar)
references LUGAR(idLugar)
on delete cascade;

alter table HECHO_BIOGRAFICO
add constraint hb_fkAutor
foreign key (fkAutor)
references AUTOR(idAutor)
on delete cascade;

alter table HECHO_BIOGRAFICO
add constraint hb_fkInvitado
foreign key (fkInvitado)
references INVITADO_ESPECIAL(idIE)
on delete cascade;

alter table MUSICO_INSTRUMENTO
add constraint mi_fkMusico
foreign key (pkMusico)
references MUSICO(idMusico)
on delete cascade;

alter table MUSICO_INSTRUMENTO
add constraint mi_fkInstrumento
foreign key (pkInstrumento)
references INSTRUMENTO(idInstrumento)
on delete cascade;

alter table ESTUDIO
add constraint estudio_fkInstitucion
foreign key (fkInstitucion)
references INSTITUCION(idInstitucion)
on delete cascade;

alter table ESTUDIO
add constraint estudio_fkTrabajador
foreign key (fkTrabajador)
references TRABAJADOR(idTrabajador)
on delete cascade;

alter table ESTUDIO
add constraint estudio_fkMusico
foreign key (fkMusico)
references MUSICO(idMusico)
on delete cascade;

alter table ESTUDIO
add constraint estudio_fkInvitado
foreign key (fkInvitado)
references INVITADO_ESPECIAL(idIE)
on delete cascade;

alter table ESTUDIO
add constraint estudio_fkBailarin
foreign key (fkBailarin)
references BAILARIN(idBailarin)
on delete cascade;

alter table ESTUDIO
add constraint estudio_fkCantante
foreign key (fkCantante)
references CANTANTE(idCantante)
on delete cascade;

alter table ESTUDIO
add constraint estudio_fkEscenografo
foreign key (fkEscenografo)
references ESCENOGRAFO(idEscenografo)
on delete cascade;

alter table ESTUDIO
add constraint estudio_fkAutor
foreign key (fkAutor)
references AUTOR(idAutor)
on delete cascade;

alter table ESTUDIO
add constraint estudio_fkDirectorEscenografia
foreign key (fkDirectorEscenografia)
references DIRECTOR_ESCENOGRAFIA(idDE)
on delete cascade;

alter table ESTUDIO
add constraint estudio_fkCoreografo
foreign key (fkCoreografo)
references COREOGRAFO(idCoreografo)
on delete cascade;

alter table ESTUDIO
add constraint estudio_fkDirector
foreign key (fkDirector)
references DIRECTOR(idDirector)
on delete cascade;

alter table ESTUDIO
add constraint estudio_fkDM
foreign key (fkDM)
references DIRECTOR_MUSICAL(idDM)
on delete cascade;

alter table TRABAJADOR_CARGO
add constraint tc_fkCargo
foreign key (fkCargo)
references CARGO(idCargo)
on delete cascade;

alter table TRABAJADOR_CARGO
add constraint tc_fkTrabajador
foreign key (fkTrabajador)
references TRABAJADOR(idTrabajador)
on delete cascade;

alter table TRABAJADOR_CARGO
add constraint tc_fkMusico
foreign key (fkMusico)
references MUSICO(idMusico)
on delete cascade;

alter table TRABAJADOR_CARGO
add constraint tc_fkInvitado
foreign key (fkInvitado)
references INVITADO_ESPECIAL(idIE)
on delete cascade;

alter table TRABAJADOR_CARGO
add constraint tc_fkBailarin
foreign key (fkBailarin)
references BAILARIN(idBailarin)
on delete cascade;

alter table TRABAJADOR_CARGO
add constraint tc_fkCantante
foreign key (fkCantante)
references CANTANTE(idCantante)
on delete cascade;

alter table TRABAJADOR_CARGO
add constraint tc_fkEscenografo
foreign key (fkEscenografo)
references ESCENOGRAFO(idEscenografo)
on delete cascade;

alter table TRABAJADOR_CARGO
add constraint tc_fkAutor
foreign key (fkAutor)
references AUTOR(idAutor)
on delete cascade;

alter table TRABAJADOR_CARGO
add constraint tc_fkDirectorEscenografia
foreign key (fkDirectorEscenografia)
references DIRECTOR_ESCENOGRAFIA(idDE)
on delete cascade;

alter table TRABAJADOR_CARGO
add constraint tc_fkCoreografo
foreign key (fkCoreografo)
references COREOGRAFO(idCoreografo)
on delete cascade;

alter table TRABAJADOR_CARGO
add constraint tc_fkDirector
foreign key (fkDirector)
references DIRECTOR(idDirector)
on delete cascade;

alter table TRABAJADOR_CARGO
add constraint tc_fkDM
foreign key (fkDM)
references DIRECTOR_MUSICAL(idDM)
on delete cascade;

alter table TRABAJADOR
add constraint trabajador_fkLugar
foreign key (fkLugar)
references LUGAR(idLugar)
on delete cascade;

alter table MUSICO
add constraint musico_fkLugar
foreign key (fkLugar)
references LUGAR(idLugar)
on delete cascade;

alter table CANTANTE
add constraint cantante_fkLugar
foreign key (fkLugar)
references LUGAR(idLugar)
on delete cascade;

alter table BAILARIN
add constraint bailarin_fkLugar
foreign key (fkLugar)
references LUGAR(idLugar)
on delete cascade;

alter table INVITADO_ESPECIAL
add constraint ie_fkLugar
foreign key (fkLugar)
references LUGAR(idLugar)
on delete cascade;

alter table ESCENOGRAFO
add constraint escenografo_fkLugar
foreign key (fkLugar)
references LUGAR(idLugar)
on delete cascade;

alter table AUTOR
add constraint actor_fkLugar
foreign key (fkLugar)
references LUGAR(idLugar)
on delete cascade;

alter table DIRECTOR_ESCENOGRAFIA
add constraint de_fkLugar
foreign key (fkLugar)
references LUGAR(idLugar)
on delete cascade;

alter table COREOGRAFO
add constraint coreografo_fkLugar
foreign key (fkLugar)
references LUGAR(idLugar)
on delete cascade;

alter table DIRECTOR
add constraint director_fkLugar
foreign key (fkLugar)
references LUGAR(idLugar)
on delete cascade;

alter table DIRECTOR_MUSICAL
add constraint directorMusical_fkLugar
foreign key (fkLugar)
references LUGAR(idLugar)
on delete cascade;


CREATE OR REPLACE 
PACKAGE pkg_memorizacion
/* Formatted on 17-jul.-2017 3:04:40 (QP5 v5.126) */
IS
    TYPE cursortype IS REF CURSOR;

    TYPE var_array IS TABLE OF VARCHAR2 (30);

    FUNCTION devuelve_fecha
        RETURN VARCHAR2;

    FUNCTION reporte_control (prm_tipo        VARCHAR2,
                              prm_gerencia    VARCHAR2,
                              prm_fecini      VARCHAR2,
                              prm_fecfin      VARCHAR2)
        RETURN cursortype;

    FUNCTION graba_tram_dec (prm_id              VARCHAR2,
                             prm_tipo_tramite    VARCHAR2,
                             prm_gestion         VARCHAR2,
                             prm_aduana          VARCHAR2,
                             prm_numero          VARCHAR2,
                             prm_operador        VARCHAR2,
                             prm_tipo_etapa      VARCHAR2,
                             prm_usuario         VARCHAR2,
                             prm_valor           VARCHAR2,
                             prm_partida         VARCHAR2,
                             prm_origen          VARCHAR2,
                             prm_otro            VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_tramite_dec (prm_id              VARCHAR2,
                                prm_tipo_tramite    VARCHAR2,
                                prm_gestion         VARCHAR2,
                                prm_aduana          VARCHAR2,
                                prm_numero          VARCHAR2,
                                prm_usuario         VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_tramite_factura (prm_id              VARCHAR2,
                                    prm_tipo_tramite    VARCHAR2,
                                    prm_numero          VARCHAR2,
                                    prm_fecha           VARCHAR2,
                                    prm_proveedor       VARCHAR2,
                                    prm_origen          VARCHAR2,
                                    prm_usuario         VARCHAR2,
                                    prm_tipo_etapa      VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_tramite_transferencia (prm_id              VARCHAR2,
                                          prm_tipo_tramite    VARCHAR2,
                                          prm_gestion         VARCHAR2,
                                          prm_fecha           VARCHAR2,
                                          prm_proveedor       VARCHAR2,
                                          prm_usuario         VARCHAR2,
                                          prm_tipo_etapa      VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_tramite_otro (prm_id                VARCHAR2,
                                 prm_tipo_tramite      VARCHAR2,
                                 prm_gestion           VARCHAR2,
                                 prm_fecha             VARCHAR2,
                                 prm_proveedor         VARCHAR2,
                                 prm_tipo_documento    VARCHAR2,
                                 prm_usuario           VARCHAR2,
                                 prm_tipo_etapa        VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION actualiza_alcance_tramite (prm_id         VARCHAR2,
                                        prm_item       VARCHAR2,
                                        prm_valor      VARCHAR2,
                                        prm_origen     VARCHAR2,
                                        prm_partida    VARCHAR2,
                                        prm_otro       VARCHAR2,
                                        prm_usuario    VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION verifica_alcance_item (prm_tipo       VARCHAR2,
                                    prm_gestion    VARCHAR2,
                                    prm_aduana     VARCHAR2,
                                    prm_numero     VARCHAR2,
                                    prm_item       VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION verifica_alcance_dec (prm_tipo       VARCHAR2,
                                   prm_gestion    VARCHAR2,
                                   prm_aduana     VARCHAR2,
                                   prm_numero     VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_memorizacion_diferido (
        prm_tipo_documento        IN VARCHAR2,
        prm_nro_documento         IN VARCHAR2,
        prm_fecha_documento       IN VARCHAR2,
        prm_obs_documento         IN VARCHAR2,
        prm_riesgo_identificado   IN VARCHAR2,
        prm_tipo_doc_identidad    IN VARCHAR2,
        prm_nit                   IN VARCHAR2,
        prm_razon_social          IN VARCHAR2,
        prm_ci                    IN VARCHAR2,
        prm_ci_exp                IN VARCHAR2,
        prm_nombres               IN VARCHAR2,
        prm_appat                 IN VARCHAR2,
        prm_apmat                 IN VARCHAR2,
        prm_direccion             IN VARCHAR2,
        prm_actividad_principal   IN VARCHAR2,
        prm_usuario               IN VARCHAR2,
        prm_tipo_operador         IN VARCHAR2,
        prm_tribtodos             IN VARCHAR2,
        prm_tribga                IN VARCHAR2,
        prm_tribiva               IN VARCHAR2,
        prm_tribice               IN VARCHAR2,
        prm_tribiehd              IN VARCHAR2,
        prm_tribicd               IN VARCHAR2,
        prm_tribnoaplica          IN VARCHAR2,
        prm_periodo               IN VARCHAR2,
        prm_riesgodelito          IN VARCHAR2,
        prm_riesgosubval          IN VARCHAR2,
        prm_riesgoclas            IN VARCHAR2,
        prm_riesgocontrab         IN VARCHAR2,
        prm_gerencia              IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_memorizacion_posterior (
        prm_tipo_documento        IN VARCHAR2,
        prm_nro_documento         IN VARCHAR2,
        prm_fecha_documento       IN VARCHAR2,
        prm_obs_documento         IN VARCHAR2,
        prm_riesgo_identificado   IN VARCHAR2,
        prm_tipo_doc_identidad    IN VARCHAR2,
        prm_nit                   IN VARCHAR2,
        prm_razon_social          IN VARCHAR2,
        prm_ci                    IN VARCHAR2,
        prm_ci_exp                IN VARCHAR2,
        prm_nombres               IN VARCHAR2,
        prm_appat                 IN VARCHAR2,
        prm_apmat                 IN VARCHAR2,
        prm_direccion             IN VARCHAR2,
        prm_actividad_principal   IN VARCHAR2,
        prm_usuario               IN VARCHAR2,
        prm_tipo_operador         IN VARCHAR2,
        prm_tribtodos             IN VARCHAR2,
        prm_tribga                IN VARCHAR2,
        prm_tribiva               IN VARCHAR2,
        prm_tribice               IN VARCHAR2,
        prm_tribiehd              IN VARCHAR2,
        prm_tribicd               IN VARCHAR2,
        prm_tribnoaplica          IN VARCHAR2,
        prm_periodo               IN VARCHAR2,
        prm_riesgodelito          IN VARCHAR2,
        prm_riesgosubval          IN VARCHAR2,
        prm_riesgoclas            IN VARCHAR2,
        prm_riesgocontrab         IN VARCHAR2,
        prm_gerencia              IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_memorizacion_ampliatoria (
        prm_cod_gestion           IN VARCHAR2,
        prm_cod_gerencia          IN VARCHAR2,
        prm_cod_numero            IN VARCHAR2,
        prm_tipo_doc_identidad    IN VARCHAR2,
        prm_nit                   IN VARCHAR2,
        prm_razon_social          IN VARCHAR2,
        prm_ci                    IN VARCHAR2,
        prm_ci_exp                IN VARCHAR2,
        prm_nombres               IN VARCHAR2,
        prm_appat                 IN VARCHAR2,
        prm_apmat                 IN VARCHAR2,
        prm_direccion             IN VARCHAR2,
        prm_actividad_principal   IN VARCHAR2,
        prm_usuario               IN VARCHAR2,
        prm_tipo_operador         IN VARCHAR2,
        prm_cod_control           IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION numero_control (p_gestion VARCHAR2)
        RETURN NUMBER;

    FUNCTION devuelve_duis (prm_fecini       IN     VARCHAR2,
                            prm_fecfin       IN     VARCHAR2,
                            prm_aduana       IN     VARCHAR2,
                            prm_partida      IN     VARCHAR2,
                            prm_agencia      IN     VARCHAR2,
                            prm_importador   IN     VARCHAR2,
                            prm_proveedor    IN     VARCHAR2,
                            prm_origen       IN     VARCHAR2,
                            prm_tipo         IN     VARCHAR2,
                            prm_reg          IN     VARCHAR2,
                            ct                  OUT cursortype)
        RETURN VARCHAR2;

    FUNCTION devuelve_duis_item (prm_fecini       IN     VARCHAR2,
                                 prm_fecfin       IN     VARCHAR2,
                                 prm_aduana       IN     VARCHAR2,
                                 prm_partida      IN     VARCHAR2,
                                 prm_agencia      IN     VARCHAR2,
                                 prm_importador   IN     VARCHAR2,
                                 prm_proveedor    IN     VARCHAR2,
                                 prm_origen       IN     VARCHAR2,
                                 prm_tipo         IN     VARCHAR2,
                                 prm_reg          IN     VARCHAR2,
                                 ct                  OUT cursortype)
        RETURN VARCHAR2;


    FUNCTION existe_tramite (prm_gestion   IN VARCHAR2,
                             prm_aduana    IN VARCHAR2,
                             prm_numero    IN VARCHAR2,
                             prm_tipo      IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_tramite_iditem (prm_alcance_id    IN     VARCHAR2,
                                      prm_numero_item   IN     VARCHAR2,
                                      ct                   OUT cursortype)
        RETURN VARCHAR2;

    FUNCTION devuelve_tramites (prm_codigocontrol   IN     VARCHAR2,
                                ct                     OUT cursortype)
        RETURN VARCHAR2;

    FUNCTION devuelve_tramitespadreamp (
        prm_codigocontrol   IN     VARCHAR2,
        ct                     OUT cursortype)
        RETURN VARCHAR2;

    FUNCTION devuelve_tramitesamp (prm_codigocontrol   IN     VARCHAR2,
                                   ct                     OUT cursortype)
        RETURN VARCHAR2;

    FUNCTION devuelve_tramitesrepampliacion (
        prm_codigocontrol   IN     VARCHAR2,
        ct                     OUT cursortype)
        RETURN VARCHAR2;

    FUNCTION devuelve_tramitesrep (prm_codigocontrol   IN     VARCHAR2,
                                   ct                     OUT cursortype)
        RETURN VARCHAR2;

    FUNCTION devuelve_tramitesreporte (prm_codigocontrol   IN     VARCHAR2,
                                       ct                     OUT cursortype)
        RETURN VARCHAR2;

    FUNCTION devuelve_tramitesrepamp (prm_codigocontrol   IN     VARCHAR2,
                                      ct                     OUT cursortype)
        RETURN VARCHAR2;

    FUNCTION graba_duis_selec (prm_id              VARCHAR2,
                               prm_ids_concat      VARCHAR2,
                               prm_tipo_tramite    VARCHAR2,
                               prm_usuario         VARCHAR2,
                               prm_tipo_etapa      VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_duis_selec2 (prm_id                 VARCHAR2,
                                prm_ids_concat         VARCHAR2,
                                prm_tipo_tramite       VARCHAR2,
                                prm_usuario            VARCHAR2,
                                prm_tipo_etapa         VARCHAR2,
                                prm_numero_operador    VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_duis_selecitem (prm_id               VARCHAR2,
                                   prm_ids_concatval    VARCHAR2,
                                   prm_ids_concatpar    VARCHAR2,
                                   prm_ids_concatori    VARCHAR2,
                                   prm_ids_concatotr    VARCHAR2,
                                   prm_tipo_tramite     VARCHAR2,
                                   prm_usuario          VARCHAR2,
                                   prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_duis_selecitemval (prm_id               VARCHAR2,
                                      prm_ids_concatval    VARCHAR2,
                                      prm_tipo_tramite     VARCHAR2,
                                      prm_usuario          VARCHAR2,
                                      prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_duis_selecitempar (prm_id               VARCHAR2,
                                      prm_ids_concatval    VARCHAR2,
                                      prm_tipo_tramite     VARCHAR2,
                                      prm_usuario          VARCHAR2,
                                      prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_duis_selecitempori (prm_id               VARCHAR2,
                                       prm_ids_concatval    VARCHAR2,
                                       prm_tipo_tramite     VARCHAR2,
                                       prm_usuario          VARCHAR2,
                                       prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_duis_selecitemotr (prm_id               VARCHAR2,
                                      prm_ids_concatotr    VARCHAR2,
                                      prm_tipo_tramite     VARCHAR2,
                                      prm_usuario          VARCHAR2,
                                      prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_duis_selecdecval (prm_id               VARCHAR2,
                                     prm_ids_concatval    VARCHAR2,
                                     prm_tipo_tramite     VARCHAR2,
                                     prm_usuario          VARCHAR2,
                                     prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_duis_selecdecamp (prm_id               VARCHAR2,
                                     prm_ids_concatval    VARCHAR2,
                                     prm_tipo_tramite     VARCHAR2,
                                     prm_usuario          VARCHAR2,
                                     prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_duis_selecdecotr (prm_id               VARCHAR2,
                                     prm_ids_concatotr    VARCHAR2,
                                     prm_tipo_tramite     VARCHAR2,
                                     prm_usuario          VARCHAR2,
                                     prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_duis_selecdecpar (prm_id               VARCHAR2,
                                     prm_ids_concatval    VARCHAR2,
                                     prm_tipo_tramite     VARCHAR2,
                                     prm_usuario          VARCHAR2,
                                     prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_duis_selecdecori (prm_id               VARCHAR2,
                                     prm_ids_concatval    VARCHAR2,
                                     prm_tipo_tramite     VARCHAR2,
                                     prm_usuario          VARCHAR2,
                                     prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_tramite_selec (prm_id VARCHAR2, prm_usuario VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_tramite_selecamp (prm_id VARCHAR2, prm_usuario VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_tramite_selecitem (prm_id VARCHAR2, prm_usuario VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_tramite_todo (prm_codigo VARCHAR2, prm_usuario VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION numero_control_gen (p_gestion       VARCHAR2,
                                 prm_tipo        VARCHAR2,
                                 prm_gerencia    VARCHAR2)
        RETURN NUMBER;

    FUNCTION numero_control_asig (p_gestion VARCHAR2)
        RETURN NUMBER;

    FUNCTION numero_control_amp (p_gestion VARCHAR2)
        RETURN NUMBER;

    FUNCTION verifica_registra_control (prm_codigo      VARCHAR2,
                                        prm_gerencia    VARCHAR2,
                                        prm_usuario     VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION verifica_alcance_control (prm_codigo VARCHAR2)
        RETURN VARCHAR2;


    FUNCTION verifica_ampliacion_control (prm_codigo     VARCHAR2,
                                          prm_usuario    VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION verifica_asigna_control (prm_codigo VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION registra_controlant (prm_codigo      VARCHAR2,
                                  prm_gerencia    VARCHAR2,
                                  prm_usuario     VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION registra_control (prm_codigo                    VARCHAR2,
                               prm_gerencia                  VARCHAR2,
                               prm_usuario                   VARCHAR2,
                               prm_inn_1                     VARCHAR2,
                               prm_inn_2                     VARCHAR2,
                               prm_inn_3                     VARCHAR2,
                               prm_inn_4                     VARCHAR2,
                               prm_inn_5                     VARCHAR2,
                               prm_inn_6                     VARCHAR2,
                               prm_inn_7                     VARCHAR2,
                               prm_inn_8                     VARCHAR2,
                               prm_inn_9                     VARCHAR2,
                               prm_inn_10                    VARCHAR2,
                               prm_inn_11                    VARCHAR2,
                               prm_inn_12                    VARCHAR2,
                               prm_inn_13                    VARCHAR2,
                               prm_inn_14                    VARCHAR2,
                               prm_inn_15                    VARCHAR2,
                               prm_inn_16                    VARCHAR2,
                               prm_inn_17                    VARCHAR2,
                               prm_inn_18                    VARCHAR2,
                               prm_inn_19                    VARCHAR2,
                               prm_inn_20                    VARCHAR2,
                               prm_inn_21                    VARCHAR2,
                               prm_inn_plazo_conclusion      VARCHAR2,
                               prm_tribga                 IN VARCHAR2,
                               prm_tribiva                IN VARCHAR2,
                               prm_tribice                IN VARCHAR2,
                               prm_tribiehd               IN VARCHAR2,
                               prm_tribicd                IN VARCHAR2,
                               prm_tribnoaplica           IN VARCHAR2,
                               prm_peridodosolicitar      IN VARCHAR2,
                               prm_nrodocumento           IN VARCHAR2,
                               prm_fecdocumento           IN VARCHAR2,
                               prm_riesgodelito           IN VARCHAR2,
                               prm_riesgosubval           IN VARCHAR2,
                               prm_riesgoclas             IN VARCHAR2,
                               prm_riesgocontrab          IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_asignacion (prm_id         VARCHAR2,
                               prm_usufis     VARCHAR2,
                               prm_cargo      VARCHAR2,
                               prm_usuario    VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_asignacion (prm_id VARCHAR2, prm_usuario VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_acceso (prm_id         VARCHAR2,
                           prm_usufis     VARCHAR2,
                           prm_cargo      VARCHAR2,
                           prm_usuario    VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_acceso (prm_id VARCHAR2, prm_usuario VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION numero_control_alc (p_gestion VARCHAR2)
        RETURN NUMBER;

    FUNCTION verifica_alcance_control2 (prm_codigo     VARCHAR2,
                                        prm_usuario    VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION verifica_asigna_control2 (prm_codigo     VARCHAR2,
                                       prm_usuario    VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION verifica_acceso_control2 (prm_codigo     VARCHAR2,
                                       prm_usuario    VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION verifica_anulacion_control (prm_codigo      VARCHAR2,
                                         prm_gerencia    VARCHAR2,
                                         prm_usuario     VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION anula_control (prm_codigo           VARCHAR2,
                            prm_gerencia         VARCHAR2,
                            prm_usuario          VARCHAR2,
                            prm_justificacion    VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_dif_duis1 (prm_fecini   IN     VARCHAR2,
                                 prm_fecfin   IN     VARCHAR2,
                                 prm_aduana   IN     VARCHAR2,
                                 prm_reg      IN     VARCHAR2,
                                 ct              OUT cursortype)
        RETURN VARCHAR2;

    FUNCTION devuelve_dif_duis2 (prm_fecini       IN     VARCHAR2,
                                 prm_fecfin       IN     VARCHAR2,
                                 prm_aduana       IN     VARCHAR2,
                                 prm_importador   IN     VARCHAR2,
                                 prm_reg          IN     VARCHAR2,
                                 ct                  OUT cursortype)
        RETURN VARCHAR2;

    FUNCTION devuelve_dif_duis3 (prm_gestion   IN     VARCHAR2,
                                 prm_aduana    IN     VARCHAR2,
                                 prm_numero    IN     VARCHAR2,
                                 prm_reg       IN     VARCHAR2,
                                 ct               OUT cursortype)
        RETURN VARCHAR2;

    FUNCTION devuelve_ficha_inf (prm_gestion   IN VARCHAR2,
                                 prm_aduana    IN VARCHAR2,
                                 prm_numero    IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_fecha_levante (prm_key_year   IN VARCHAR2,
                                     prm_key_cuo    IN VARCHAR2,
                                     prm_key_dec    IN VARCHAR2,
                                     prm_key_nber   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_fecha_pase (prm_key_year   IN VARCHAR2,
                                  prm_key_cuo    IN VARCHAR2,
                                  prm_key_dec    IN VARCHAR2,
                                  prm_key_nber   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_datos_importador (prm_importador   IN     VARCHAR2,
                                        prm_razon           OUT VARCHAR2,
                                        prm_direccion       OUT VARCHAR2,
                                        prm_actividad       OUT VARCHAR2,
                                        prm_tipo            OUT VARCHAR2,
                                        prm_nombre          OUT VARCHAR2,
                                        prm_appat           OUT VARCHAR2,
                                        prm_apmat           OUT VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION verifica_registro_recibos (prm_codigo      VARCHAR2,
                                        prm_gerencia    VARCHAR2,
                                        prm_usuario     VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_recibo (prm_id         VARCHAR2,
                           prm_gestion    VARCHAR2,
                           prm_aduana     VARCHAR2,
                           prm_numero     VARCHAR2,
                           prm_tipo       VARCHAR2,
                           prm_fecha      VARCHAR2,
                           prm_importe    VARCHAR2,
                           prm_usuario    VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_recibos (prm_codigocontrol   IN     VARCHAR2,
                                ct                     OUT cursortype)
        RETURN VARCHAR2;

    FUNCTION borra_recibo (prm_id VARCHAR2, prm_usuario VARCHAR2)
        RETURN VARCHAR2;
END;
/

CREATE OR REPLACE 
PACKAGE BODY pkg_memorizacion
/* Formatted on 17-jul.-2017 12:38:18 (QP5 v5.126) */
AS
    FUNCTION devuelve_fecha
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (50);
    BEGIN
        SELECT   TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') INTO res FROM DUAL;

        RETURN res;
    END;

    FUNCTION reporte_control (prm_tipo        VARCHAR2,
                              prm_gerencia    VARCHAR2,
                              prm_fecini      VARCHAR2,
                              prm_fecfin      VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   a.ctl_cod_gestion,
                       a.ctl_cod_tipo,
                       DECODE (a.ctl_cod_gerencia,
                               'GRL', 'GERENCIA REGIONAL LA PAZ',
                               'GRP', 'GERENCIA REGIONAL POTOSI',
                               'GRT', 'GERENCIA REGIONAL TARIJA',
                               'GRS', 'GERENCIA REGIONAL SANTA CRUZ',
                               'GRC', 'GERENCIA REGIONAL COCHABAMBA',
                               'GRO', 'GERENCIA REGIONAL ORURO',
                               '-')
                           ger,
                       a.ctl_cod_numero,
                       a.ctl_control_id meorizado,
                       NVL (TO_CHAR (me.est_fecsys, 'dd/mm/yyyy hh24:mi'), '-')
                           fec_mem,
                       DECODE (
                           e.est_estado,
                           'MEMORIZADO',
                           '-',
                           a.ctl_cod_gestion
                           || DECODE (a.ctl_cod_tipo,
                                      'DIFERIDO', 'CD',
                                      'POSTERIOR', 'FP',
                                      'AMPLIATORIA DIFERIDO', 'CD',
                                      'AMPLIATORIA POSTERIOR', 'FP',
                                      '-')
                           || a.ctl_cod_gerencia
                           || DECODE (
                                  a.ctl_amp_correlativo,
                                  NULL,
                                  '00',
                                  DECODE (LENGTH (a.ctl_amp_correlativo),
                                          1, '0' || a.ctl_amp_correlativo,
                                          a.ctl_amp_correlativo))
                           || DECODE (LENGTH (a.ctl_cod_numero),
                                      1, '0000' || a.ctl_cod_numero,
                                      2, '000' || a.ctl_cod_numero,
                                      3, '00' || a.ctl_cod_numero,
                                      4, '0' || a.ctl_cod_numero,
                                      a.ctl_cod_numero))
                           codigo_control,
                       NVL (TO_CHAR (re.est_fecsys, 'dd/mm/yyyy hh24:mi'), '-')
                           fec_reg,
                       DECODE (a.ctl_tipo_doc_identidad,
                               'NIT', TO_CHAR (a.ctl_nit),
                               TO_CHAR (a.ctl_ci) || ' ' || a.ctl_ci_exp)
                           identidad_doc,
                       DECODE (
                           a.ctl_tipo_doc_identidad,
                           'NIT',
                           a.ctl_razon_social,
                              a.ctl_nombres
                           || ' '
                           || a.ctl_appat
                           || ' '
                           || a.ctl_apmat)
                           identidad_nombre,
                       e.est_estado,
                       a.ctl_usuario
                FROM   fis_control a,
                       fis_estado e,
                       fis_estado me,
                       fis_estado re
               WHERE       a.ctl_cod_gerencia LIKE prm_gerencia
                       AND a.ctl_cod_tipo LIKE prm_tipo
                       AND a.ctl_num = 0
                       AND a.ctl_lstope = 'U'
                       AND a.ctl_control_id = e.ctl_control_id
                       AND e.est_num = 0
                       AND e.est_lstope = 'U'
                       AND a.ctl_cod_tipo LIKE '%'
                       AND me.ctl_control_id = a.ctl_control_id
                       AND me.est_estado = 'MEMORIZADO'
                       AND me.est_lstope = 'U'
                       AND TRUNC (me.est_fecsys) BETWEEN TO_DATE (prm_fecini,
                                                                  'dd/mm/yyyy')
                                                     AND  TO_DATE (
                                                              prm_fecfin,
                                                              'dd/mm/yyyy')
                       AND re.ctl_control_id(+) = a.ctl_control_id
                       AND re.est_estado(+) = 'REGISTRADO'
                       AND re.est_lstope(+) = 'U'
            ORDER BY   1,
                       2,
                       3,
                       4 DESC;

        RETURN cr;
    END;

    FUNCTION verifica_alcance_item (prm_tipo       VARCHAR2,
                                    prm_gestion    VARCHAR2,
                                    prm_aduana     VARCHAR2,
                                    prm_numero     VARCHAR2,
                                    prm_item       VARCHAR2)
        RETURN VARCHAR2
    IS
        res       VARCHAR2 (100);
        valor     VARCHAR2 (5);
        partida   VARCHAR2 (5);
        origen    VARCHAR2 (5);
        otro      VARCHAR2 (5);
        existe    NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   valor
          FROM   fis_alcance a, fis_alcance_item b
         WHERE       a.alc_tipo_tramite = prm_tipo
                 AND a.alc_gestion = prm_gestion
                 AND a.alc_aduana = prm_aduana
                 AND a.alc_numero = prm_numero
                 AND a.alc_num = 0
                 AND a.alc_lstope = 'U'
                 AND a.alc_alcance_id = b.alc_alcance_id
                 AND b.ali_num = 0
                 AND b.ali_lstope = 'U'
                 AND b.ali_numero_item = prm_item
                 AND b.ali_obs_valor = 'x';

        SELECT   COUNT (1)
          INTO   partida
          FROM   fis_alcance a, fis_alcance_item b
         WHERE       a.alc_tipo_tramite = prm_tipo
                 AND a.alc_gestion = prm_gestion
                 AND a.alc_aduana = prm_aduana
                 AND a.alc_numero = prm_numero
                 AND a.alc_num = 0
                 AND a.alc_lstope = 'U'
                 AND a.alc_alcance_id = b.alc_alcance_id
                 AND b.ali_num = 0
                 AND b.ali_lstope = 'U'
                 AND b.ali_numero_item = prm_item
                 AND b.ali_obs_partida = 'x';

        SELECT   COUNT (1)
          INTO   origen
          FROM   fis_alcance a, fis_alcance_item b
         WHERE       a.alc_tipo_tramite = prm_tipo
                 AND a.alc_gestion = prm_gestion
                 AND a.alc_aduana = prm_aduana
                 AND a.alc_numero = prm_numero
                 AND a.alc_num = 0
                 AND a.alc_lstope = 'U'
                 AND a.alc_alcance_id = b.alc_alcance_id
                 AND b.ali_num = 0
                 AND b.ali_lstope = 'U'
                 AND b.ali_numero_item = prm_item
                 AND b.ali_obs_origen = 'x';

        SELECT   COUNT (1)
          INTO   otro
          FROM   fis_alcance a, fis_alcance_item b
         WHERE       a.alc_tipo_tramite = prm_tipo
                 AND a.alc_gestion = prm_gestion
                 AND a.alc_aduana = prm_aduana
                 AND a.alc_numero = prm_numero
                 AND a.alc_num = 0
                 AND a.alc_lstope = 'U'
                 AND a.alc_alcance_id = b.alc_alcance_id
                 AND b.ali_num = 0
                 AND b.ali_lstope = 'U'
                 AND b.ali_numero_item = prm_item
                 AND b.ali_obs_otro = 'x';

        SELECT      DECODE (valor, '0', '0', '1')
                 || DECODE (partida, '0', '0', '1')
                 || DECODE (origen, '0', '0', '1')
                 || DECODE (otro, '0', '0', '1')
          INTO   res
          FROM   DUAL;

        RETURN res;
    END;

    FUNCTION verifica_alcance_dec (prm_tipo       VARCHAR2,
                                   prm_gestion    VARCHAR2,
                                   prm_aduana     VARCHAR2,
                                   prm_numero     VARCHAR2)
        RETURN VARCHAR2
    IS
        res       VARCHAR2 (100);
        valor     VARCHAR2 (5);
        partida   VARCHAR2 (5);
        origen    VARCHAR2 (5);
        otro      VARCHAR2 (5);
        existe    NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   valor
          FROM   fis_alcance a, fis_alcance_item b
         WHERE       a.alc_tipo_tramite = prm_tipo
                 AND a.alc_gestion = prm_gestion
                 AND a.alc_aduana = prm_aduana
                 AND a.alc_numero = prm_numero
                 AND a.alc_num = 0
                 AND a.alc_lstope = 'U'
                 AND a.alc_alcance_id = b.alc_alcance_id
                 AND b.ali_num = 0
                 AND b.ali_lstope = 'U'
                 AND b.ali_obs_valor = 'x';

        SELECT   COUNT (1)
          INTO   partida
          FROM   fis_alcance a, fis_alcance_item b
         WHERE       a.alc_tipo_tramite = prm_tipo
                 AND a.alc_gestion = prm_gestion
                 AND a.alc_aduana = prm_aduana
                 AND a.alc_numero = prm_numero
                 AND a.alc_num = 0
                 AND a.alc_lstope = 'U'
                 AND a.alc_alcance_id = b.alc_alcance_id
                 AND b.ali_num = 0
                 AND b.ali_lstope = 'U'
                 AND b.ali_obs_partida = 'x';

        SELECT   COUNT (1)
          INTO   origen
          FROM   fis_alcance a, fis_alcance_item b
         WHERE       a.alc_tipo_tramite = prm_tipo
                 AND a.alc_gestion = prm_gestion
                 AND a.alc_aduana = prm_aduana
                 AND a.alc_numero = prm_numero
                 AND a.alc_num = 0
                 AND a.alc_lstope = 'U'
                 AND a.alc_alcance_id = b.alc_alcance_id
                 AND b.ali_num = 0
                 AND b.ali_lstope = 'U'
                 AND b.ali_obs_origen = 'x';

        SELECT   COUNT (1)
          INTO   otro
          FROM   fis_alcance a, fis_alcance_item b
         WHERE       a.alc_tipo_tramite = prm_tipo
                 AND a.alc_gestion = prm_gestion
                 AND a.alc_aduana = prm_aduana
                 AND a.alc_numero = prm_numero
                 AND a.alc_num = 0
                 AND a.alc_lstope = 'U'
                 AND a.alc_alcance_id = b.alc_alcance_id
                 AND b.ali_num = 0
                 AND b.ali_lstope = 'U'
                 AND b.ali_obs_otro = 'x';

        SELECT      DECODE (valor, '0', '0', '1')
                 || DECODE (partida, '0', '0', '1')
                 || DECODE (origen, '0', '0', '1')
                 || DECODE (otro, '0', '0', '1')
          INTO   res
          FROM   DUAL;

        RETURN res;
    END;

    FUNCTION graba_tram_dec (prm_id              VARCHAR2,
                             prm_tipo_tramite    VARCHAR2,
                             prm_gestion         VARCHAR2,
                             prm_aduana          VARCHAR2,
                             prm_numero          VARCHAR2,
                             prm_operador        VARCHAR2,
                             prm_tipo_etapa      VARCHAR2,
                             prm_usuario         VARCHAR2,
                             prm_valor           VARCHAR2,
                             prm_partida         VARCHAR2,
                             prm_origen          VARCHAR2,
                             prm_otro            VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (100);
        existe       NUMBER;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        declarante   VARCHAR2 (30);
        importador   VARCHAR2 (30);
        totitem      NUMBER := 0;
        v_item       NUMBER (10);
        v_codigo     NUMBER (18, 0);
        existetram   VARCHAR2 (300);
        v_valor      VARCHAR2 (1) := '';
        v_partida    VARCHAR2 (1) := '';
        v_origen     VARCHAR2 (1) := '';
        v_otro       VARCHAR2 (1) := '';
        sw           NUMBER (4) := 0;
    BEGIN
        IF prm_valor = 'on'
        THEN
            sw := 1;
            v_valor := 'x';
        END IF;

        IF prm_partida = 'on'
        THEN
            sw := 1;
            v_partida := 'x';
        END IF;

        IF prm_origen = 'on'
        THEN
            sw := 1;
            v_origen := 'x';
        END IF;

        IF prm_otro = 'on'
        THEN
            sw := 1;
            v_otro := 'x';
        END IF;

        IF sw = 0
        THEN
            RETURN 'Debe marcar un tipo de observacion (valor, partida, origen u otro)';
        END IF;

        IF prm_gestion > TO_CHAR (SYSDATE, 'YYYY')
        THEN
            RETURN 'La Gesti&oacute;n no puede ser mayor a la actual';
        END IF;

        IF prm_tipo_tramite = 'DUI'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   ops$asy.sad_gen a
             WHERE       a.sad_flw = 1
                     AND a.sad_num = 0
                     AND a.sad_reg_year = prm_gestion
                     AND a.key_cuo = prm_aduana
                     AND a.sad_reg_serial = 'C'
                     AND a.sad_reg_nber = prm_numero;

            IF existe > 0
            THEN
                SELECT   a.key_dec, a.sad_consignee, a.sad_itm_total
                  INTO   declarante, importador, totitem
                  FROM   ops$asy.sad_gen a
                 WHERE       a.sad_flw = 1
                         AND a.sad_num = 0
                         AND a.sad_reg_year = prm_gestion
                         AND a.key_cuo = prm_aduana
                         AND a.sad_reg_serial = 'C'
                         AND a.sad_reg_nber = prm_numero;

                IF prm_operador = declarante OR prm_operador = importador
                THEN
                    existetram :=
                        pkg_memorizacion.existe_tramite (prm_gestion,
                                                         prm_aduana,
                                                         prm_numero,
                                                         prm_tipo_tramite);

                    /*SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_alcance b
                     WHERE       b.alc_gestion = prm_gestion
                             AND b.alc_aduana = prm_aduana
                             AND b.alc_numero = prm_numero
                             AND b.alc_tipo_tramite = prm_tipo_tramite
                             AND b.alc_num = 0
                             AND b.alc_lstope = 'U';*/

                    IF NOT existetram = 'SIN CONTROL'
                    THEN
                        RETURN existetram;
                    ELSE
                        v_item := 1;

                        WHILE (v_item <= totitem)
                        LOOP
                            SELECT   COUNT (1)
                              INTO   existe
                              FROM   fis_alcance b
                             WHERE       b.alc_gestion = prm_gestion
                                     AND b.alc_aduana = prm_aduana
                                     AND b.alc_numero = prm_numero
                                     AND b.alc_tipo_tramite =
                                            prm_tipo_tramite
                                     AND b.alc_num = 0
                                     AND b.alc_lstope = 'U'
                                     AND b.ctl_control_id = prm_id;

                            IF existe = 0
                            THEN
                                v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                                v_numero := numero_control_alc (v_gestion);

                                INSERT INTO fis_alcance (alc_alcance_id,
                                                         alc_tipo_alcance,
                                                         alc_tipo_tramite,
                                                         alc_gestion,
                                                         alc_aduana,
                                                         alc_numero,
                                                         alc_num,
                                                         alc_lstope,
                                                         alc_usuario,
                                                         alc_fecsys,
                                                         ctl_control_id,
                                                         alc_tipo_etapa)
                                  VALUES   (v_gestion || TO_CHAR (v_numero),
                                            'DECLARACION',
                                            prm_tipo_tramite,
                                            prm_gestion,
                                            prm_aduana,
                                            prm_numero,
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE,
                                            prm_id,
                                            prm_tipo_etapa);

                                INSERT INTO fis_alcance_item (alc_alcance_id,
                                                              ali_numero_item,
                                                              ali_obs_valor,
                                                              ali_obs_partida,
                                                              ali_obs_origen,
                                                              ali_num,
                                                              ali_lstope,
                                                              ali_usuario,
                                                              ali_fecsys,
                                                              ali_obs_otro,
                                                              ali_tipo_etapa)
                                  VALUES   (v_gestion || TO_CHAR (v_numero),
                                            v_item,
                                            v_valor,
                                            v_partida,
                                            v_origen,
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE,
                                            v_otro,
                                            prm_tipo_etapa);
                            ELSE
                                SELECT   b.alc_alcance_id
                                  INTO   v_codigo
                                  FROM   fis_alcance b
                                 WHERE       b.alc_gestion = prm_gestion
                                         AND b.alc_aduana = prm_aduana
                                         AND b.alc_numero = prm_numero
                                         AND b.alc_tipo_tramite =
                                                prm_tipo_tramite
                                         AND b.alc_num = 0
                                         AND b.alc_lstope = 'U'
                                         AND b.ctl_control_id = prm_id;

                                SELECT   COUNT (1)
                                  INTO   existe
                                  FROM   fis_alcance_item b
                                 WHERE   b.alc_alcance_id = v_codigo
                                         AND b.ali_numero_item = v_item;

                                IF existe = 0
                                THEN
                                    INSERT INTO fis_alcance_item (alc_alcance_id,
                                                                  ali_numero_item,
                                                                  ali_obs_valor,
                                                                  ali_obs_partida,
                                                                  ali_obs_origen,
                                                                  ali_num,
                                                                  ali_lstope,
                                                                  ali_usuario,
                                                                  ali_fecsys,
                                                                  ali_obs_otro,
                                                                  ali_tipo_etapa)
                                      VALUES   (v_codigo,
                                                v_item,
                                                v_valor,
                                                v_partida,
                                                v_origen,
                                                0,
                                                'U',
                                                prm_usuario,
                                                SYSDATE,
                                                v_otro,
                                                prm_tipo_etapa);
                                ELSE
                                    UPDATE   fis_alcance_item
                                       SET   ali_num = existe
                                     WHERE       alc_alcance_id = v_codigo
                                             AND ali_numero_item = v_item
                                             AND ali_num = 0;

                                    INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                                    a.ali_numero_item,
                                                                    a.ali_obs_valor,
                                                                    a.ali_obs_partida,
                                                                    a.ali_obs_origen,
                                                                    a.ali_num,
                                                                    a.ali_lstope,
                                                                    a.ali_usuario,
                                                                    a.ali_fecsys,
                                                                    a.ali_obs_otro,
                                                                    a.ali_tipo_etapa)
                                      VALUES   (v_codigo,
                                                v_item,
                                                v_valor,
                                                v_partida,
                                                v_origen,
                                                0,
                                                'U',
                                                prm_usuario,
                                                SYSDATE,
                                                v_otro,
                                                prm_tipo_etapa);
                                END IF;
                            END IF;

                            v_item := v_item + 1;
                            COMMIT;
                        END LOOP;
                    END IF;

                    COMMIT;
                    res :=
                           'CORRECTOSe grab&oacute; correctamente la DUI '
                        || prm_gestion
                        || '/'
                        || prm_aduana
                        || '/C-'
                        || prm_numero;
                ELSE
                    RETURN 'La DUI no corresponde al Operador';
                END IF;
            ELSE
                RETURN 'La DUI no es v&aacute;lida';
            END IF;
        END IF;

        IF prm_tipo_tramite = 'DUE'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   ops$asy.sad_gen a
             WHERE       a.sad_typ_dec = 'EX'
                     AND a.sad_num = 0
                     AND a.sad_reg_year = prm_gestion
                     AND a.key_cuo = prm_aduana
                     AND a.sad_reg_serial = 'C'
                     AND a.sad_reg_nber = prm_numero;

            IF existe > 0
            THEN
                SELECT   a.key_dec, a.sad_exporter, a.sad_itm_total
                  INTO   declarante, importador, totitem
                  FROM   ops$asy.sad_gen a
                 WHERE       a.sad_typ_dec = 'EX'
                         AND a.sad_num = 0
                         AND a.sad_reg_year = prm_gestion
                         AND a.key_cuo = prm_aduana
                         AND a.sad_reg_serial = 'C'
                         AND a.sad_reg_nber = prm_numero;

                IF prm_operador = declarante OR prm_operador = importador
                THEN
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_alcance b
                     WHERE       b.alc_gestion = prm_gestion
                             AND b.alc_aduana = prm_aduana
                             AND b.alc_numero = prm_numero
                             AND b.alc_tipo_tramite = prm_tipo_tramite
                             AND b.alc_num = 0
                             AND b.alc_lstope = 'U';

                    IF existe > 0
                    THEN
                        RETURN 'El tr&aacute;mite ya fue registrado en otro Control';
                    ELSE
                        v_item := 1;

                        WHILE (v_item <= totitem)
                        LOOP
                            SELECT   COUNT (1)
                              INTO   existe
                              FROM   fis_alcance b
                             WHERE       b.alc_gestion = prm_gestion
                                     AND b.alc_aduana = prm_aduana
                                     AND b.alc_numero = prm_numero
                                     AND b.alc_tipo_tramite =
                                            prm_tipo_tramite
                                     AND b.alc_num = 0
                                     AND b.alc_lstope = 'U'
                                     AND b.ctl_control_id = prm_id;

                            IF existe = 0
                            THEN
                                v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                                v_numero := numero_control_alc (v_gestion);

                                INSERT INTO fis_alcance (alc_alcance_id,
                                                         alc_tipo_alcance,
                                                         alc_tipo_tramite,
                                                         alc_gestion,
                                                         alc_aduana,
                                                         alc_numero,
                                                         alc_num,
                                                         alc_lstope,
                                                         alc_usuario,
                                                         alc_fecsys,
                                                         ctl_control_id,
                                                         alc_tipo_etapa)
                                  VALUES   (v_gestion || TO_CHAR (v_numero),
                                            'DECLARACION',
                                            prm_tipo_tramite,
                                            prm_gestion,
                                            prm_aduana,
                                            prm_numero,
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE,
                                            prm_id,
                                            prm_tipo_etapa);

                                INSERT INTO fis_alcance_item (alc_alcance_id,
                                                              ali_numero_item,
                                                              ali_obs_valor,
                                                              ali_obs_partida,
                                                              ali_obs_origen,
                                                              ali_num,
                                                              ali_lstope,
                                                              ali_usuario,
                                                              ali_fecsys,
                                                              ali_obs_otro,
                                                              ali_tipo_etapa)
                                  VALUES   (v_gestion || TO_CHAR (v_numero),
                                            v_item,
                                            v_valor,
                                            v_partida,
                                            v_origen,
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE,
                                            v_otro,
                                            prm_tipo_etapa);
                            ELSE
                                SELECT   b.alc_alcance_id
                                  INTO   v_codigo
                                  FROM   fis_alcance b
                                 WHERE       b.alc_gestion = prm_gestion
                                         AND b.alc_aduana = prm_aduana
                                         AND b.alc_numero = prm_numero
                                         AND b.alc_tipo_tramite =
                                                prm_tipo_tramite
                                         AND b.alc_num = 0
                                         AND b.alc_lstope = 'U'
                                         AND b.ctl_control_id = prm_id;

                                SELECT   COUNT (1)
                                  INTO   existe
                                  FROM   fis_alcance_item b
                                 WHERE   b.alc_alcance_id = v_codigo
                                         AND b.ali_numero_item = v_item;

                                IF existe = 0
                                THEN
                                    INSERT INTO fis_alcance_item (alc_alcance_id,
                                                                  ali_numero_item,
                                                                  ali_obs_valor,
                                                                  ali_obs_partida,
                                                                  ali_obs_origen,
                                                                  ali_num,
                                                                  ali_lstope,
                                                                  ali_usuario,
                                                                  ali_fecsys,
                                                                  ali_obs_otro,
                                                                  ali_tipo_etapa)
                                      VALUES   (v_codigo,
                                                v_item,
                                                v_valor,
                                                v_partida,
                                                v_origen,
                                                0,
                                                'U',
                                                prm_usuario,
                                                SYSDATE,
                                                v_otro,
                                                prm_tipo_etapa);
                                ELSE
                                    UPDATE   fis_alcance_item
                                       SET   ali_num = existe
                                     WHERE       alc_alcance_id = v_codigo
                                             AND ali_numero_item = v_item
                                             AND ali_num = 0;

                                    INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                                    a.ali_numero_item,
                                                                    a.ali_obs_valor,
                                                                    a.ali_obs_partida,
                                                                    a.ali_obs_origen,
                                                                    a.ali_num,
                                                                    a.ali_lstope,
                                                                    a.ali_usuario,
                                                                    a.ali_fecsys,
                                                                    a.ali_obs_otro,
                                                                    a.ali_tipo_etapa)
                                      VALUES   (v_codigo,
                                                v_item,
                                                v_valor,
                                                v_partida,
                                                v_origen,
                                                0,
                                                'U',
                                                prm_usuario,
                                                SYSDATE,
                                                v_otro,
                                                prm_tipo_etapa);
                                END IF;
                            END IF;

                            v_item := v_item + 1;
                            COMMIT;
                        END LOOP;
                    END IF;

                    COMMIT;
                    res :=
                           'CORRECTOSe grab&oacute; correctamente la DUE '
                        || prm_gestion
                        || '/'
                        || prm_aduana
                        || '/C-'
                        || prm_numero;
                ELSE
                    RETURN 'La DUE no corresponde al operador';
                END IF;
            ELSE
                RETURN 'La DUE no es v&aacute;lida';
            END IF;
        END IF;

        IF prm_tipo_tramite = 'MIC'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   ops$asy.car_gen a
             WHERE       a.car_reg_year = prm_gestion
                     AND a.key_cuo = prm_aduana
                     AND a.car_reg_nber = prm_numero;

            IF existe > 0
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   ops$asy.car_gen a, ops$asy.car_bol_gen b
                 WHERE       a.key_cuo = b.key_cuo
                         AND a.key_voy_nber = b.key_voy_nber
                         AND a.key_dep_date = b.key_dep_date
                         AND a.car_reg_year = prm_gestion
                         AND a.key_cuo = prm_aduana
                         AND a.car_reg_nber = prm_numero
                         AND (a.car_car_cod = prm_operador
                              OR b.carbol_cons_cod = prm_operador);

                IF existe > 0
                THEN
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_alcance b
                     WHERE       b.alc_gestion = prm_gestion
                             AND b.alc_aduana = prm_aduana
                             AND b.alc_numero = prm_numero
                             AND b.alc_tipo_tramite = prm_tipo_tramite
                             AND b.alc_num = 0
                             AND b.alc_lstope = 'U';

                    IF existe > 0
                    THEN
                        RETURN 'El tr&aacute;mite ya fue registrado en otro Control';
                    ELSE
                        SELECT   COUNT (1)
                          INTO   existe
                          FROM   fis_alcance b
                         WHERE       b.alc_gestion = prm_gestion
                                 AND b.alc_aduana = prm_aduana
                                 AND b.alc_numero = prm_numero
                                 AND b.alc_tipo_tramite = prm_tipo_tramite
                                 AND b.alc_num = 0
                                 AND b.alc_lstope = 'U'
                                 AND b.ctl_control_id = prm_id;

                        IF existe = 0
                        THEN
                            v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                            v_numero := numero_control_alc (v_gestion);

                            INSERT INTO fis_alcance (alc_alcance_id,
                                                     alc_tipo_alcance,
                                                     alc_tipo_tramite,
                                                     alc_gestion,
                                                     alc_aduana,
                                                     alc_numero,
                                                     alc_num,
                                                     alc_lstope,
                                                     alc_usuario,
                                                     alc_fecsys,
                                                     ctl_control_id,
                                                     alc_tipo_etapa)
                              VALUES   (v_gestion || TO_CHAR (v_numero),
                                        'MANIFIESTO',
                                        prm_tipo_tramite,
                                        prm_gestion,
                                        prm_aduana,
                                        prm_numero,
                                        0,
                                        'U',
                                        prm_usuario,
                                        SYSDATE,
                                        prm_id,
                                        prm_tipo_etapa);

                            INSERT INTO fis_alcance_item (alc_alcance_id,
                                                          ali_numero_item,
                                                          ali_obs_valor,
                                                          ali_obs_partida,
                                                          ali_obs_origen,
                                                          ali_num,
                                                          ali_lstope,
                                                          ali_usuario,
                                                          ali_fecsys,
                                                          ali_obs_otro,
                                                          ali_tipo_etapa)
                              VALUES   (v_gestion || TO_CHAR (v_numero),
                                        1,
                                        v_valor,
                                        v_partida,
                                        v_origen,
                                        0,
                                        'U',
                                        prm_usuario,
                                        SYSDATE,
                                        v_otro,
                                        prm_tipo_etapa);
                        ELSE
                            SELECT   b.alc_alcance_id
                              INTO   v_codigo
                              FROM   fis_alcance b
                             WHERE       b.alc_gestion = prm_gestion
                                     AND b.alc_aduana = prm_aduana
                                     AND b.alc_numero = prm_numero
                                     AND b.alc_tipo_tramite =
                                            prm_tipo_tramite
                                     AND b.alc_num = 0
                                     AND b.alc_lstope = 'U'
                                     AND b.ctl_control_id = prm_id;

                            SELECT   COUNT (1)
                              INTO   existe
                              FROM   fis_alcance_item b
                             WHERE       b.alc_alcance_id = v_codigo
                                     AND b.ali_numero_item = 1
                                     AND b.ali_num = 0
                                     AND b.ali_lstope = 'U';

                            IF existe = 0
                            THEN
                                INSERT INTO fis_alcance_item (alc_alcance_id,
                                                              ali_numero_item,
                                                              ali_obs_valor,
                                                              ali_obs_partida,
                                                              ali_obs_origen,
                                                              ali_num,
                                                              ali_lstope,
                                                              ali_usuario,
                                                              ali_fecsys,
                                                              ali_obs_otro,
                                                              ali_tipo_etapa)
                                  VALUES   (v_codigo,
                                            1,
                                            v_valor,
                                            v_partida,
                                            v_origen,
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE,
                                            v_otro,
                                            prm_tipo_etapa);
                            ELSE
                                UPDATE   fis_alcance_item
                                   SET   ali_num = existe
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = 1
                                         AND ali_num = 0;

                                INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                                a.ali_numero_item,
                                                                a.ali_obs_valor,
                                                                a.ali_obs_partida,
                                                                a.ali_obs_origen,
                                                                a.ali_num,
                                                                a.ali_lstope,
                                                                a.ali_usuario,
                                                                a.ali_fecsys,
                                                                a.ali_obs_otro,
                                                                a.ali_tipo_etapa)
                                  VALUES   (v_codigo,
                                            1,
                                            v_valor,
                                            v_partida,
                                            v_origen,
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE,
                                            v_otro,
                                            prm_tipo_etapa);
                            END IF;
                        END IF;


                        COMMIT;
                    END IF;

                    COMMIT;
                    res :=
                        'CORRECTOSe grab&oacute; correctamente el MANIFIESTO '
                        || prm_gestion
                        || '/'
                        || prm_aduana
                        || '/'
                        || prm_numero;
                ELSE
                    RETURN 'El MANIFIESTO no corresponde al Operador';
                END IF;
            ELSE
                RETURN 'El MANIFIESTO no es v&aacute;lido';
            END IF;
        END IF;

        RETURN res;
    END;


    FUNCTION graba_memorizacion_diferido (
        prm_tipo_documento        IN VARCHAR2,
        prm_nro_documento         IN VARCHAR2,
        prm_fecha_documento       IN VARCHAR2,
        prm_obs_documento         IN VARCHAR2,
        prm_riesgo_identificado   IN VARCHAR2,
        prm_tipo_doc_identidad    IN VARCHAR2,
        prm_nit                   IN VARCHAR2,
        prm_razon_social          IN VARCHAR2,
        prm_ci                    IN VARCHAR2,
        prm_ci_exp                IN VARCHAR2,
        prm_nombres               IN VARCHAR2,
        prm_appat                 IN VARCHAR2,
        prm_apmat                 IN VARCHAR2,
        prm_direccion             IN VARCHAR2,
        prm_actividad_principal   IN VARCHAR2,
        prm_usuario               IN VARCHAR2,
        prm_tipo_operador         IN VARCHAR2,
        prm_tribtodos             IN VARCHAR2,
        prm_tribga                IN VARCHAR2,
        prm_tribiva               IN VARCHAR2,
        prm_tribice               IN VARCHAR2,
        prm_tribiehd              IN VARCHAR2,
        prm_tribicd               IN VARCHAR2,
        prm_tribnoaplica          IN VARCHAR2,
        prm_periodo               IN VARCHAR2,
        prm_riesgodelito          IN VARCHAR2,
        prm_riesgosubval          IN VARCHAR2,
        prm_riesgoclas            IN VARCHAR2,
        prm_riesgocontrab         IN VARCHAR2,
        prm_gerencia              IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res         VARCHAR2 (50);
        v_gestion   VARCHAR2 (4);
        v_numero    NUMBER;
    BEGIN
        IF prm_tipo_doc_identidad = 'NIT'
        THEN
            IF pkg_general.f_validadigitoverificador (prm_nit) = 0
            THEN
                RETURN    'El n&uacute;mero de NIT: '
                       || prm_nit
                       || ', no es v&aacute;lido';
            END IF;
        END IF;

        --RETURN 'No se encuentra habilitado el registro de Controles Diferidos, los mismos deben realizarse en el sistema SICODIF';
        /* IF     prm_riesgodelito IS NULL
            AND prm_riesgosubval IS NULL
            AND prm_riesgoclas IS NULL
            AND prm_riesgocontrab IS NULL
         THEN
             RETURN 'Debe seleccionar por lo menos un riesgo identificado';
         END IF;*/

        IF     prm_tribga IS NULL
           AND prm_tribiva IS NULL
           AND prm_tribice IS NULL
           AND prm_tribiehd IS NULL
           AND prm_tribicd IS NULL
        THEN
            IF prm_tribnoaplica IS NULL
            THEN
                RETURN 'Si no desea seleccionar ning&uacute;n tributo a fiscalizar, debe marcar la casilla de no aplica'
;
            END IF;
        ELSE
            IF NOT prm_tribnoaplica IS NULL
            THEN
                RETURN 'Si seleccion&oacute; uno de los tributos a fiscalizar, no debe marcar la casilla de no aplica'
;
            END IF;
        END IF;

        v_gestion := TO_CHAR (SYSDATE, 'yyyy');
        v_numero := numero_control (v_gestion);

        INSERT INTO fis_control (ctl_control_id,
                                 ctl_cod_tipo,
                                 ctl_tipo_documento,
                                 ctl_nro_documento,
                                 ctl_fecha_documento,
                                 ctl_obs_documento,
                                 ctl_riesgo_identificado,
                                 ctl_tipo_doc_identidad,
                                 ctl_nit,
                                 ctl_razon_social,
                                 ctl_ci,
                                 ctl_ci_exp,
                                 ctl_nombres,
                                 ctl_appat,
                                 ctl_apmat,
                                 ctl_direccion,
                                 ctl_actividad_principal,
                                 ctl_num,
                                 ctl_lstope,
                                 ctl_usuario,
                                 ctl_fecsys,
                                 ctl_tipo_operador,
                                 ctl_tribtodos,
                                 ctl_tribga,
                                 ctl_tribiva,
                                 ctl_tribice,
                                 ctl_tribiehd,
                                 ctl_tribicd,
                                 ctl_tribnoaplica,
                                 ctl_periodo,
                                 ctl_riesgodelito,
                                 ctl_riesgosubval,
                                 ctl_riesgoclas,
                                 ctl_riesgocontrab,
                                 ctl_cod_gerencia)
          VALUES   (v_gestion || v_numero,
                    'DIFERIDO',
                    prm_tipo_documento,
                    prm_nro_documento,
                    TO_DATE (prm_fecha_documento, 'dd/mm/yyyy'),
                    prm_obs_documento,
                    prm_riesgo_identificado,
                    prm_tipo_doc_identidad,
                    prm_nit,
                    prm_razon_social,
                    prm_ci,
                    prm_ci_exp,
                    prm_nombres,
                    prm_appat,
                    prm_apmat,
                    prm_direccion,
                    prm_actividad_principal,
                    0,
                    'U',
                    prm_usuario,
                    SYSDATE,
                    prm_tipo_operador,
                    prm_tribtodos,
                    prm_tribga,
                    prm_tribiva,
                    prm_tribice,
                    prm_tribiehd,
                    prm_tribicd,
                    prm_tribnoaplica,
                    prm_periodo,
                    prm_riesgodelito,
                    prm_riesgosubval,
                    prm_riesgoclas,
                    prm_riesgocontrab,
                    prm_gerencia);



        INSERT INTO fis_estado (ctl_control_id,
                                est_estado,
                                est_num,
                                est_lstope,
                                est_usuario,
                                est_fecsys)
          VALUES   (v_gestion || v_numero,
                    'MEMORIZADO',
                    0,
                    'U',
                    prm_usuario,
                    SYSDATE);

        COMMIT;
        RETURN 'CORRECTO' || v_gestion || v_numero;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            ROLLBACK;
            RETURN 'No se pudo memorizar el control';
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_memorizacion_posterior (
        prm_tipo_documento        IN VARCHAR2,
        prm_nro_documento         IN VARCHAR2,
        prm_fecha_documento       IN VARCHAR2,
        prm_obs_documento         IN VARCHAR2,
        prm_riesgo_identificado   IN VARCHAR2,
        prm_tipo_doc_identidad    IN VARCHAR2,
        prm_nit                   IN VARCHAR2,
        prm_razon_social          IN VARCHAR2,
        prm_ci                    IN VARCHAR2,
        prm_ci_exp                IN VARCHAR2,
        prm_nombres               IN VARCHAR2,
        prm_appat                 IN VARCHAR2,
        prm_apmat                 IN VARCHAR2,
        prm_direccion             IN VARCHAR2,
        prm_actividad_principal   IN VARCHAR2,
        prm_usuario               IN VARCHAR2,
        prm_tipo_operador         IN VARCHAR2,
        prm_tribtodos             IN VARCHAR2,
        prm_tribga                IN VARCHAR2,
        prm_tribiva               IN VARCHAR2,
        prm_tribice               IN VARCHAR2,
        prm_tribiehd              IN VARCHAR2,
        prm_tribicd               IN VARCHAR2,
        prm_tribnoaplica          IN VARCHAR2,
        prm_periodo               IN VARCHAR2,
        prm_riesgodelito          IN VARCHAR2,
        prm_riesgosubval          IN VARCHAR2,
        prm_riesgoclas            IN VARCHAR2,
        prm_riesgocontrab         IN VARCHAR2,
        prm_gerencia              IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (50);
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        vr_gestion   VARCHAR2 (4);
        vr_numero    NUMBER;
    BEGIN
        IF prm_tipo_doc_identidad = 'NIT'
        THEN
            IF pkg_general.f_validadigitoverificador (prm_nit) = 0
            THEN
                RETURN    'El n&uacute;mero de NIT: '
                       || prm_nit
                       || ', no es v&aacute;lido';
            END IF;
        END IF;

        IF     prm_riesgodelito IS NULL
           AND prm_riesgosubval IS NULL
           AND prm_riesgoclas IS NULL
           AND prm_riesgocontrab IS NULL
        THEN
            RETURN 'Debe seleccionar por lo menos un riesgo identificado';
        END IF;

        IF     prm_tribga IS NULL
           AND prm_tribiva IS NULL
           AND prm_tribice IS NULL
           AND prm_tribiehd IS NULL
           AND prm_tribicd IS NULL
        THEN
            IF prm_tribnoaplica IS NULL
            THEN
                RETURN 'Si no desea seleccionar ning&uacute;n tributo a fiscalizar, debe marcar la casilla de no aplica'
;
            END IF;
        ELSE
            IF NOT prm_tribnoaplica IS NULL
            THEN
                RETURN 'Si seleccion&oacute; uno de los tributos a fiscalizar, no debe marcar la casilla de no aplica'
;
            END IF;
        END IF;

        v_gestion := TO_CHAR (SYSDATE, 'yyyy');
        v_numero := numero_control (v_gestion);

        INSERT INTO fis_control (ctl_control_id,
                                 ctl_cod_tipo,
                                 ctl_tipo_documento,
                                 ctl_nro_documento,
                                 ctl_fecha_documento,
                                 ctl_obs_documento,
                                 ctl_riesgo_identificado,
                                 ctl_tipo_doc_identidad,
                                 ctl_nit,
                                 ctl_razon_social,
                                 ctl_ci,
                                 ctl_ci_exp,
                                 ctl_nombres,
                                 ctl_appat,
                                 ctl_apmat,
                                 ctl_direccion,
                                 ctl_actividad_principal,
                                 ctl_num,
                                 ctl_lstope,
                                 ctl_usuario,
                                 ctl_fecsys,
                                 ctl_tipo_operador,
                                 ctl_tribtodos,
                                 ctl_tribga,
                                 ctl_tribiva,
                                 ctl_tribice,
                                 ctl_tribiehd,
                                 ctl_tribicd,
                                 ctl_tribnoaplica,
                                 ctl_periodo,
                                 ctl_riesgodelito,
                                 ctl_riesgosubval,
                                 ctl_riesgoclas,
                                 ctl_riesgocontrab,
                                 ctl_cod_gerencia)
          VALUES   (v_gestion || v_numero,
                    'POSTERIOR',
                    prm_tipo_documento,
                    prm_nro_documento,
                    TO_DATE (prm_fecha_documento, 'dd/mm/yyyy'),
                    prm_obs_documento,
                    prm_riesgo_identificado,
                    prm_tipo_doc_identidad,
                    prm_nit,
                    prm_razon_social,
                    prm_ci,
                    prm_ci_exp,
                    prm_nombres,
                    prm_appat,
                    prm_apmat,
                    prm_direccion,
                    prm_actividad_principal,
                    0,
                    'U',
                    prm_usuario,
                    SYSDATE,
                    prm_tipo_operador,
                    prm_tribtodos,
                    prm_tribga,
                    prm_tribiva,
                    prm_tribice,
                    prm_tribiehd,
                    prm_tribicd,
                    prm_tribnoaplica,
                    prm_periodo,
                    prm_riesgodelito,
                    prm_riesgosubval,
                    prm_riesgoclas,
                    prm_riesgocontrab,
                    prm_gerencia);


        INSERT INTO fis_estado (ctl_control_id,
                                est_estado,
                                est_num,
                                est_lstope,
                                est_usuario,
                                est_fecsys)
          VALUES   (v_gestion || v_numero,
                    'MEMORIZADO',
                    0,
                    'U',
                    prm_usuario,
                    SYSDATE);

        COMMIT;
        RETURN 'CORRECTO' || v_gestion || v_numero;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            ROLLBACK;
            RETURN 'No se pudo memorizar el Control';
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_memorizacion_ampliatoria (
        prm_cod_gestion           IN VARCHAR2,
        prm_cod_gerencia          IN VARCHAR2,
        prm_cod_numero            IN VARCHAR2,
        prm_tipo_doc_identidad    IN VARCHAR2,
        prm_nit                   IN VARCHAR2,
        prm_razon_social          IN VARCHAR2,
        prm_ci                    IN VARCHAR2,
        prm_ci_exp                IN VARCHAR2,
        prm_nombres               IN VARCHAR2,
        prm_appat                 IN VARCHAR2,
        prm_apmat                 IN VARCHAR2,
        prm_direccion             IN VARCHAR2,
        prm_actividad_principal   IN VARCHAR2,
        prm_usuario               IN VARCHAR2,
        prm_tipo_operador         IN VARCHAR2,
        prm_cod_control           IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res                     VARCHAR2 (50);
        existe                  NUMBER;
        v_gestion               VARCHAR2 (4);
        v_numero                NUMBER;
        v_tipo_documento        VARCHAR2 (50);
        v_nro_documento         VARCHAR2 (100);
        v_fecha_documento       VARCHAR2 (10);
        v_obs_documento         VARCHAR2 (500);
        v_riesgo_identificado   VARCHAR2 (30);

        v_ctl_tribtodos         VARCHAR2 (30);
        v_ctl_tribga            VARCHAR2 (30);
        v_ctl_tribiva           VARCHAR2 (30);
        v_ctl_tribice           VARCHAR2 (30);
        v_ctl_tribiehd          VARCHAR2 (30);
        v_ctl_tribicd           VARCHAR2 (30);
        v_ctl_tribnoaplica      VARCHAR2 (30);
        v_ctl_periodo           VARCHAR2 (30);
        v_ctl_riesgodelito      VARCHAR2 (30);
        v_ctl_riesgosubval      VARCHAR2 (30);
        v_ctl_riesgoclas        VARCHAR2 (30);
        v_ctl_riesgocontrab     VARCHAR2 (30);

        v_tipo_operador         VARCHAR2 (30);
    BEGIN
        IF prm_tipo_doc_identidad = 'NIT'
        THEN
            IF pkg_general.f_validadigitoverificador (prm_nit) = 0
            THEN
                RETURN    'El n&uacute;mero de NIT: '
                       || prm_nit
                       || ', no es v&aacute;lido';
            END IF;
        END IF;

        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_control a
         WHERE       a.ctl_cod_gestion = prm_cod_gestion
                 AND a.ctl_cod_tipo = prm_cod_control
                 AND a.ctl_cod_gerencia = prm_cod_gerencia
                 AND a.ctl_cod_numero = prm_cod_numero
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';



        IF existe > 0
        THEN
            IF prm_tipo_doc_identidad = 'NIT'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_control a
                 WHERE   a.ctl_cod_gestion = prm_cod_gestion
                         AND a.ctl_cod_tipo =
                                'AMPLIATORIA ' || prm_cod_control
                         AND a.ctl_cod_gerencia = prm_cod_gerencia
                         AND a.ctl_cod_numero = prm_cod_numero
                         AND a.ctl_amp_control = prm_cod_control
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U'
                         AND a.ctl_tipo_doc_identidad = 'NIT'
                         AND a.ctl_nit = prm_nit;
            ELSE
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_control a
                 WHERE   a.ctl_cod_gestion = prm_cod_gestion
                         AND a.ctl_cod_tipo =
                                'AMPLIATORIA ' || prm_cod_control
                         AND a.ctl_cod_gerencia = prm_cod_gerencia
                         AND a.ctl_cod_numero = prm_cod_numero
                         AND a.ctl_amp_control = prm_cod_control
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U'
                         AND a.ctl_tipo_doc_identidad = 'CI'
                         AND a.ctl_ci = prm_ci;
            END IF;

            IF existe > 0
            THEN
                RETURN 'Ya se registr&oacute; una orden ampliatoria al mismo Operador';
            ELSE
                SELECT   a.ctl_tipo_documento,
                         a.ctl_nro_documento,
                         TO_DATE (a.ctl_fecha_documento, 'dd/mm/yyyy'),
                         a.ctl_obs_documento,
                         a.ctl_riesgo_identificado,
                         a.ctl_tipo_operador,
                         a.ctl_tribtodos,
                         a.ctl_tribga,
                         a.ctl_tribiva,
                         a.ctl_tribice,
                         a.ctl_tribiehd,
                         a.ctl_tribicd,
                         a.ctl_tribnoaplica,
                         a.ctl_periodo,
                         a.ctl_riesgodelito,
                         a.ctl_riesgosubval,
                         a.ctl_riesgoclas,
                         a.ctl_riesgocontrab
                  INTO   v_tipo_documento,
                         v_nro_documento,
                         v_fecha_documento,
                         v_obs_documento,
                         v_riesgo_identificado,
                         v_tipo_operador,
                         v_ctl_tribtodos,
                         v_ctl_tribga,
                         v_ctl_tribiva,
                         v_ctl_tribice,
                         v_ctl_tribiehd,
                         v_ctl_tribicd,
                         v_ctl_tribnoaplica,
                         v_ctl_periodo,
                         v_ctl_riesgodelito,
                         v_ctl_riesgosubval,
                         v_ctl_riesgoclas,
                         v_ctl_riesgocontrab
                  FROM   fis_control a
                 WHERE       a.ctl_cod_gestion = prm_cod_gestion
                         AND a.ctl_cod_tipo = prm_cod_control
                         AND a.ctl_cod_gerencia = prm_cod_gerencia
                         AND a.ctl_cod_numero = prm_cod_numero
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U';



                IF v_tipo_operador = prm_tipo_operador
                THEN
                    RETURN 'No se puede registrar una orden ampliatoria al mismo tipo de operador'
;
                ELSE
                    v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                    v_numero := numero_control (v_gestion);

                    INSERT INTO fis_control (ctl_control_id,
                                             ctl_cod_gestion,
                                             ctl_cod_tipo,
                                             ctl_cod_gerencia,
                                             ctl_cod_numero,
                                             ctl_tipo_documento,
                                             ctl_nro_documento,
                                             ctl_fecha_documento,
                                             ctl_obs_documento,
                                             ctl_riesgo_identificado,
                                             ctl_tipo_doc_identidad,
                                             ctl_nit,
                                             ctl_razon_social,
                                             ctl_ci,
                                             ctl_ci_exp,
                                             ctl_nombres,
                                             ctl_appat,
                                             ctl_apmat,
                                             ctl_direccion,
                                             ctl_actividad_principal,
                                             ctl_num,
                                             ctl_lstope,
                                             ctl_usuario,
                                             ctl_fecsys,
                                             ctl_tipo_operador,
                                             ctl_amp_control,
                                             ctl_tribtodos,
                                             ctl_tribga,
                                             ctl_tribiva,
                                             ctl_tribice,
                                             ctl_tribiehd,
                                             ctl_tribicd,
                                             ctl_tribnoaplica,
                                             ctl_periodo,
                                             ctl_riesgodelito,
                                             ctl_riesgosubval,
                                             ctl_riesgoclas,
                                             ctl_riesgocontrab)
                      VALUES   (v_gestion || v_numero,
                                prm_cod_gestion,
                                'AMPLIATORIA ' || prm_cod_control,
                                prm_cod_gerencia,
                                prm_cod_numero,
                                v_tipo_documento,
                                v_nro_documento,
                                TO_DATE (v_fecha_documento, 'dd/mm/yyyy'),
                                v_obs_documento,
                                v_riesgo_identificado,
                                prm_tipo_doc_identidad,
                                prm_nit,
                                prm_razon_social,
                                prm_ci,
                                prm_ci_exp,
                                prm_nombres,
                                prm_appat,
                                prm_apmat,
                                prm_direccion,
                                prm_actividad_principal,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_tipo_operador,
                                prm_cod_control,
                                v_ctl_tribtodos,
                                v_ctl_tribga,
                                v_ctl_tribiva,
                                v_ctl_tribice,
                                v_ctl_tribiehd,
                                v_ctl_tribicd,
                                v_ctl_tribnoaplica,
                                v_ctl_periodo,
                                v_ctl_riesgodelito,
                                v_ctl_riesgosubval,
                                v_ctl_riesgoclas,
                                v_ctl_riesgocontrab);



                    INSERT INTO fis_estado (ctl_control_id,
                                            est_estado,
                                            est_num,
                                            est_lstope,
                                            est_usuario,
                                            est_fecsys)
                      VALUES   (v_gestion || v_numero,
                                'MEMORIZADO',
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE);

                    COMMIT;
                    RETURN 'CORRECTO' || v_gestion || v_numero;
                END IF;
            END IF;
        ELSE
            RETURN 'No se pudo memorizar la orden ampliatoria, porque no existe la Orden Padre '
                   || prm_cod_gestion
                   || '-'
                   || prm_cod_control
                   || '-'
                   || prm_cod_gerencia
                   || '-'
                   || prm_cod_numero;
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            ROLLBACK;
            RETURN 'No se pudo memorizar el control';
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION numero_control (p_gestion VARCHAR2)
        RETURN NUMBER
    IS
        v_numero   NUMBER := 1;
        v_tipo     VARCHAR2 (1) := 'M';
    BEGIN
            ---- inicio cambio
            SELECT   app_numero + 1
              INTO   v_numero
              FROM   app_ser
             WHERE       app_gestion = p_gestion
                     AND app_gerencia IS NULL
                     AND app_tipo = v_tipo
        FOR UPDATE   ;

           ---- fin cambio

           UPDATE   app_ser
              SET   app_numero = v_numero
            WHERE       app_gestion = p_gestion
                    AND app_gerencia IS NULL
                    AND app_tipo = v_tipo
        RETURNING   app_numero
             INTO   v_numero;

        IF sql%ROWCOUNT = 0
        THEN
            INSERT INTO app_ser (app_gestion, app_tipo, app_numero)
              VALUES   (p_gestion, v_tipo, v_numero);
        END IF;

        RETURN v_numero;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            INSERT INTO app_ser (app_gestion, app_tipo, app_numero)
              VALUES   (p_gestion, v_tipo, v_numero);

            RETURN 1;
    END numero_control;

    FUNCTION numero_control_alc (p_gestion VARCHAR2)
        RETURN NUMBER
    IS
        v_numero   NUMBER := 1;
        v_tipo     VARCHAR2 (1) := 'A';
    BEGIN
            ---- inicio cambio
            SELECT   app_numero + 1
              INTO   v_numero
              FROM   app_ser
             WHERE       app_gestion = p_gestion
                     AND app_gerencia IS NULL
                     AND app_tipo = v_tipo
        FOR UPDATE   ;

           ---- fin cambio

           UPDATE   app_ser
              SET   app_numero = v_numero
            WHERE       app_gestion = p_gestion
                    AND app_gerencia IS NULL
                    AND app_tipo = v_tipo
        RETURNING   app_numero
             INTO   v_numero;

        IF sql%ROWCOUNT = 0
        THEN
            INSERT INTO app_ser (app_gestion, app_tipo, app_numero)
              VALUES   (p_gestion, v_tipo, v_numero);
        END IF;

        RETURN v_numero;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            INSERT INTO app_ser (app_gestion, app_tipo, app_numero)
              VALUES   (p_gestion, v_tipo, v_numero);

            RETURN 1;
    END numero_control_alc;

    FUNCTION numero_control_amp (p_gestion VARCHAR2)
        RETURN NUMBER
    IS
        v_numero   NUMBER := 1;
        v_tipo     VARCHAR2 (3) := 'AMP';
    BEGIN
            ---- inicio cambio
            SELECT   app_numero + 1
              INTO   v_numero
              FROM   app_ser
             WHERE       app_gestion = p_gestion
                     AND app_gerencia IS NULL
                     AND app_tipo = v_tipo
        FOR UPDATE   ;

           ---- fin cambio

           UPDATE   app_ser
              SET   app_numero = v_numero
            WHERE       app_gestion = p_gestion
                    AND app_gerencia IS NULL
                    AND app_tipo = v_tipo
        RETURNING   app_numero
             INTO   v_numero;

        IF sql%ROWCOUNT = 0
        THEN
            INSERT INTO app_ser (app_gestion, app_tipo, app_numero)
              VALUES   (p_gestion, v_tipo, v_numero);
        END IF;

        RETURN v_numero;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            INSERT INTO app_ser (app_gestion, app_tipo, app_numero)
              VALUES   (p_gestion, v_tipo, v_numero);

            RETURN 1;
    END numero_control_amp;

    FUNCTION numero_control_asig (p_gestion VARCHAR2)
        RETURN NUMBER
    IS
        v_numero   NUMBER := 1;
        v_tipo     VARCHAR2 (1) := 'F';
    BEGIN
            ---- inicio cambio
            SELECT   app_numero + 1
              INTO   v_numero
              FROM   app_ser
             WHERE       app_gestion = p_gestion
                     AND app_gerencia IS NULL
                     AND app_tipo = v_tipo
        FOR UPDATE   ;

           ---- fin cambio

           UPDATE   app_ser
              SET   app_numero = v_numero
            WHERE       app_gestion = p_gestion
                    AND app_gerencia IS NULL
                    AND app_tipo = v_tipo
        RETURNING   app_numero
             INTO   v_numero;

        IF sql%ROWCOUNT = 0
        THEN
            INSERT INTO app_ser (app_gestion, app_tipo, app_numero)
              VALUES   (p_gestion, v_tipo, v_numero);
        END IF;

        RETURN v_numero;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            INSERT INTO app_ser (app_gestion, app_tipo, app_numero)
              VALUES   (p_gestion, v_tipo, v_numero);

            RETURN 1;
    END numero_control_asig;

    FUNCTION numero_control_gen (p_gestion       VARCHAR2,
                                 prm_tipo        VARCHAR2,
                                 prm_gerencia    VARCHAR2)
        RETURN NUMBER
    IS
        v_numero   NUMBER := 1;
    BEGIN
            ---- inicio cambio
            SELECT   app_numero + 1
              INTO   v_numero
              FROM   app_ser
             WHERE       app_gestion = p_gestion
                     AND app_gerencia = prm_gerencia
                     AND app_tipo = prm_tipo
        FOR UPDATE   ;

           ---- fin cambio

           UPDATE   app_ser
              SET   app_numero = v_numero
            WHERE       app_gestion = p_gestion
                    AND app_gerencia = prm_gerencia
                    AND app_tipo = prm_tipo
        RETURNING   app_numero
             INTO   v_numero;

        IF sql%ROWCOUNT = 0
        THEN
            INSERT INTO app_ser (app_gestion,
                                 app_tipo,
                                 app_gerencia,
                                 app_numero)
              VALUES   (p_gestion,
                        prm_tipo,
                        prm_gerencia,
                        v_numero);
        END IF;

        RETURN v_numero;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            INSERT INTO app_ser (app_gestion,
                                 app_tipo,
                                 app_gerencia,
                                 app_numero)
              VALUES   (p_gestion,
                        prm_tipo,
                        prm_gerencia,
                        v_numero);

            RETURN 1;
    END numero_control_gen;

    FUNCTION numero_control_rec (p_gestion VARCHAR2)
        RETURN NUMBER
    IS
        v_numero   NUMBER := 1;
        v_tipo     VARCHAR2 (3) := 'REC';
    BEGIN
            ---- inicio cambio
            SELECT   app_numero + 1
              INTO   v_numero
              FROM   app_ser
             WHERE       app_gestion = p_gestion
                     AND app_gerencia IS NULL
                     AND app_tipo = v_tipo
        FOR UPDATE   ;

           ---- fin cambio

           UPDATE   app_ser
              SET   app_numero = v_numero
            WHERE       app_gestion = p_gestion
                    AND app_gerencia IS NULL
                    AND app_tipo = v_tipo
        RETURNING   app_numero
             INTO   v_numero;

        IF sql%ROWCOUNT = 0
        THEN
            INSERT INTO app_ser (app_gestion, app_tipo, app_numero)
              VALUES   (p_gestion, v_tipo, v_numero);
        END IF;

        RETURN v_numero;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            INSERT INTO app_ser (app_gestion, app_tipo, app_numero)
              VALUES   (p_gestion, v_tipo, v_numero);

            RETURN 1;
    END numero_control_rec;

    FUNCTION devuelve_duis (prm_fecini       IN     VARCHAR2,
                            prm_fecfin       IN     VARCHAR2,
                            prm_aduana       IN     VARCHAR2,
                            prm_partida      IN     VARCHAR2,
                            prm_agencia      IN     VARCHAR2,
                            prm_importador   IN     VARCHAR2,
                            prm_proveedor    IN     VARCHAR2,
                            prm_origen       IN     VARCHAR2,
                            prm_tipo         IN     VARCHAR2,
                            prm_reg          IN     VARCHAR2,
                            ct                  OUT cursortype)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (300) := 0;
    BEGIN
        IF prm_tipo = 'DUI'
        THEN
            IF prm_agencia = '%'
            THEN
                IF prm_aduana = '%'
                THEN
                    OPEN ct FOR
                          SELECT   *
                            FROM   (SELECT   DISTINCT
                                                gen.key_year
                                             || '/'
                                             || gen.key_cuo
                                             || '/'
                                             || gen.sad_reg_serial
                                             || '-'
                                             || gen.sad_reg_nber
                                                 tramite,
                                             gen.key_year,
                                             gen.key_cuo,
                                             gen.sad_reg_nber,
                                             TO_CHAR (gen.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (gen.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_zip,
                                                     gen.sad_consignee)
                                                 nro_doc,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_nam,
                                                     cmp.cmp_nam)
                                                 importador,
                                             --5
                                             gen.key_dec doc_dec,
                                             de.dec_nam nombre_dec,
                                             cty.cty_dsc origen,
                                                gen.key_year
                                             || gen.key_cuo
                                             || gen.sad_reg_nber
                                                 dui,
                                             existe_tramite (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.sad_reg_nber,
                                                             prm_tipo),   --13
                                             verifica_alcance_dec (
                                                 prm_tipo,
                                                 gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber),
                                             --14 vertifitem
                                             '-' partida,
                                                ex.sad_exp_zip
                                             || ':'
                                             || ex.sad_exp_nam
                                                 proveedor,               --15
                                             DECODE (spy1.sad_clr,
                                                     0,
                                                     'VERDE',
                                                     1,
                                                     'AZUL',
                                                     2,
                                                     'AMARILLO',
                                                     3,
                                                     'ROJO')
                                                 canal,                   --16
                                             devuelve_ficha_inf (
                                                 gen.sad_reg_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber)
                                                 ficha
                                      FROM   ops$asy.sad_gen gen,
                                             ops$asy.sad_itm itm,
                                             ops$asy.sad_occ_cns cns,
                                             ops$asy.uncmptab cmp,
                                             ops$asy.undectab de,
                                             ops$asy.unctytab cty,
                                             ops$asy.sad_occ_exp ex,
                                             ops$asy.sad_spy spy1
                                     WHERE   gen.sad_flw = 1
                                             AND gen.sad_asmt_serial IS NOT NULL
                                             AND gen.lst_ope = 'U'
                                             AND gen.sad_num = '0'
                                             AND gen.key_year = itm.key_year
                                             AND gen.key_cuo = itm.key_cuo
                                             AND gen.key_dec = itm.key_dec
                                             AND gen.key_nber = itm.key_nber
                                             AND itm.sad_num = '0'
                                             AND gen.key_dec = de.dec_cod
                                             AND gen.key_year = cns.key_year(+)
                                             AND gen.key_cuo = cns.key_cuo(+)
                                             AND gen.key_dec = cns.key_dec(+)
                                             AND gen.key_nber = cns.key_nber(+)
                                             AND gen.sad_num = cns.sad_num(+)
                                             AND cns.sad_num(+) = '0'
                                             AND gen.key_year = ex.key_year(+)
                                             AND gen.key_cuo = ex.key_cuo(+)
                                             AND gen.key_dec = ex.key_dec(+)
                                             AND gen.key_nber = ex.key_nber(+)
                                             AND gen.sad_num = ex.sad_num(+)
                                             AND ex.sad_num(+) = '0'
                                             AND gen.key_year =
                                                    spy1.key_year(+)
                                             AND gen.key_cuo = spy1.key_cuo(+)
                                             AND gen.key_dec = spy1.key_dec(+)
                                             AND gen.key_nber =
                                                    spy1.key_nber(+)
                                             AND spy1.spy_sta(+) = '10'
                                             AND spy1.spy_act(+) = '24'
                                             AND itm.saditm_cty_origcod =
                                                    cty.cty_cod
                                             AND cty.lst_ope = 'U'
                                             AND gen.sad_consignee =
                                                    cmp.cmp_cod(+)
                                             AND cmp.lst_ope(+) = 'U'
                                             AND gen.key_dec IS NOT NULL
                                             AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                              prm_fecini,
                                                                              'DD/MM/YYYY')
                                                                      AND  TO_DATE (
                                                                               prm_fecfin,
                                                                               'DD/MM/YYYY')
                                             AND (gen.sad_consignee LIKE
                                                      prm_importador
                                                  OR cns.sad_con_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND itm.saditm_cty_origcod LIKE
                                                    prm_origen
                                             AND itm.itm_nber = 1
                                    UNION
                                    SELECT   DISTINCT
                                                gen.key_year
                                             || '/'
                                             || gen.key_cuo
                                             || '/'
                                             || gen.sad_reg_serial
                                             || '-'
                                             || gen.sad_reg_nber
                                                 tramite,
                                             gen.key_year,
                                             gen.key_cuo,
                                             gen.sad_reg_nber,
                                             TO_CHAR (gen.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (gen.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_zip,
                                                     gen.sad_consignee)
                                                 nro_doc,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_nam,
                                                     cmp.cmp_nam)
                                                 importador,
                                             gen.key_dec doc_dec,
                                             deo.sad_dec_nam nombre_dec,
                                             cty.cty_dsc origen,
                                                gen.key_year
                                             || gen.key_cuo
                                             || gen.sad_reg_nber
                                                 dui,
                                             existe_tramite (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.sad_reg_nber,
                                                             prm_tipo),
                                             verifica_alcance_dec (
                                                 prm_tipo,
                                                 gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber),
                                             '-' partida,
                                                ex.sad_exp_zip
                                             || ':'
                                             || ex.sad_exp_nam
                                                 proveedor,
                                             DECODE (spy1.sad_clr,
                                                     0,
                                                     'VERDE',
                                                     1,
                                                     'AZUL',
                                                     2,
                                                     'AMARILLO',
                                                     3,
                                                     'ROJO')
                                                 canal,                   --16
                                             devuelve_ficha_inf (
                                                 gen.sad_reg_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber)
                                                 ficha
                                      FROM   ops$asy.sad_gen gen,
                                             ops$asy.sad_itm itm,
                                             ops$asy.sad_occ_cns cns,
                                             ops$asy.uncmptab cmp,
                                             ops$asy.sad_occ_dec deo,
                                             ops$asy.unctytab cty,
                                             ops$asy.sad_occ_exp ex,
                                             ops$asy.sad_spy spy1
                                     WHERE   gen.sad_flw = 1
                                             AND gen.sad_asmt_serial IS NOT NULL
                                             AND gen.lst_ope = 'U'
                                             AND gen.sad_num = '0'
                                             AND gen.key_year = itm.key_year
                                             AND gen.key_cuo = itm.key_cuo
                                             AND itm.key_dec IS NULL
                                             AND gen.key_nber = itm.key_nber
                                             AND itm.sad_num = '0'
                                             AND gen.key_year = deo.key_year
                                             AND gen.key_cuo = deo.key_cuo
                                             AND deo.key_dec IS NULL
                                             AND gen.key_nber = deo.key_nber
                                             AND gen.sad_num = deo.sad_num
                                             AND gen.key_year = cns.key_year(+)
                                             AND gen.key_cuo = cns.key_cuo(+)
                                             AND cns.key_dec(+) IS NULL
                                             AND gen.key_nber = cns.key_nber(+)
                                             AND gen.sad_num = cns.sad_num(+)
                                             AND cns.sad_num(+) = '0'
                                             AND gen.key_year = ex.key_year(+)
                                             AND gen.key_cuo = ex.key_cuo(+)
                                             AND ex.key_dec(+) IS NULL
                                             AND gen.key_nber = ex.key_nber(+)
                                             AND gen.sad_num = ex.sad_num(+)
                                             AND ex.sad_num(+) = '0'
                                             AND gen.key_year =
                                                    spy1.key_year(+)
                                             AND gen.key_cuo = spy1.key_cuo(+)
                                             AND spy1.key_dec(+) IS NULL
                                             AND gen.key_nber =
                                                    spy1.key_nber(+)
                                             AND spy1.spy_sta(+) = '10'
                                             AND spy1.spy_act(+) = '24'
                                             AND itm.saditm_cty_origcod =
                                                    cty.cty_cod
                                             AND cty.lst_ope = 'U'
                                             AND gen.sad_consignee =
                                                    cmp.cmp_cod(+)
                                             AND cmp.lst_ope(+) = 'U'
                                             AND gen.key_dec IS NULL
                                             AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                              prm_fecini,
                                                                              'DD/MM/YYYY')
                                                                      AND  TO_DATE (
                                                                               prm_fecfin,
                                                                               'DD/MM/YYYY')
                                             AND (gen.sad_consignee LIKE
                                                      prm_importador
                                                  OR cns.sad_con_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND itm.saditm_cty_origcod LIKE
                                                    prm_origen
                                             AND itm.itm_nber = 1) tbl
                        ORDER BY   2, 3, 4;
                ELSE
                    OPEN ct FOR
                          SELECT   *
                            FROM   (SELECT   DISTINCT
                                                gen.key_year
                                             || '/'
                                             || gen.key_cuo
                                             || '/'
                                             || gen.sad_reg_serial
                                             || '-'
                                             || gen.sad_reg_nber
                                                 tramite,
                                             gen.key_year,
                                             gen.key_cuo,
                                             gen.sad_reg_nber,
                                             TO_CHAR (gen.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (gen.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_zip,
                                                     gen.sad_consignee)
                                                 nro_doc,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_nam,
                                                     cmp.cmp_nam)
                                                 importador,
                                             --5
                                             gen.key_dec doc_dec,
                                             de.dec_nam nombre_dec,
                                             cty.cty_dsc origen,
                                                gen.key_year
                                             || gen.key_cuo
                                             || gen.sad_reg_nber
                                                 dui,
                                             existe_tramite (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.sad_reg_nber,
                                                             prm_tipo),
                                             verifica_alcance_dec (
                                                 prm_tipo,
                                                 gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber),
                                             '-' partida,
                                                ex.sad_exp_zip
                                             || ':'
                                             || ex.sad_exp_nam
                                                 proveedor,
                                             DECODE (spy1.sad_clr,
                                                     0,
                                                     'VERDE',
                                                     1,
                                                     'AZUL',
                                                     2,
                                                     'AMARILLO',
                                                     3,
                                                     'ROJO')
                                                 canal,                   --16
                                             devuelve_ficha_inf (
                                                 gen.sad_reg_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber)
                                                 ficha
                                      FROM   ops$asy.sad_gen gen,
                                             ops$asy.sad_itm itm,
                                             ops$asy.sad_occ_cns cns,
                                             ops$asy.uncmptab cmp,
                                             ops$asy.undectab de,
                                             ops$asy.unctytab cty,
                                             ops$asy.sad_occ_exp ex,
                                             ops$asy.sad_spy spy1
                                     WHERE   gen.sad_flw = 1
                                             AND gen.sad_asmt_serial IS NOT NULL
                                             AND gen.lst_ope = 'U'
                                             AND gen.sad_num = '0'
                                             AND gen.key_year = itm.key_year
                                             AND gen.key_cuo = itm.key_cuo
                                             AND gen.key_dec = itm.key_dec
                                             AND gen.key_nber = itm.key_nber
                                             AND itm.sad_num = '0'
                                             AND gen.key_dec = de.dec_cod
                                             AND gen.key_year = cns.key_year(+)
                                             AND gen.key_cuo = cns.key_cuo(+)
                                             AND gen.key_dec = cns.key_dec(+)
                                             AND gen.key_nber = cns.key_nber(+)
                                             AND gen.sad_num = cns.sad_num(+)
                                             AND cns.sad_num(+) = '0'
                                             AND gen.key_year = ex.key_year(+)
                                             AND gen.key_cuo = ex.key_cuo(+)
                                             AND gen.key_dec = ex.key_dec(+)
                                             AND gen.key_nber = ex.key_nber(+)
                                             AND gen.sad_num = ex.sad_num(+)
                                             AND ex.sad_num(+) = '0'
                                             AND gen.key_year =
                                                    spy1.key_year(+)
                                             AND gen.key_cuo = spy1.key_cuo(+)
                                             AND gen.key_dec = spy1.key_dec(+)
                                             AND gen.key_nber =
                                                    spy1.key_nber(+)
                                             AND spy1.spy_sta(+) = '10'
                                             AND spy1.spy_act(+) = '24'
                                             AND itm.saditm_cty_origcod =
                                                    cty.cty_cod
                                             AND cty.lst_ope = 'U'
                                             AND gen.sad_consignee =
                                                    cmp.cmp_cod(+)
                                             AND cmp.lst_ope(+) = 'U'
                                             AND gen.key_dec IS NOT NULL
                                             AND gen.key_cuo = prm_aduana
                                             AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                              prm_fecini,
                                                                              'DD/MM/YYYY')
                                                                      AND  TO_DATE (
                                                                               prm_fecfin,
                                                                               'DD/MM/YYYY')
                                             AND (gen.sad_consignee LIKE
                                                      prm_importador
                                                  OR cns.sad_con_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND itm.saditm_cty_origcod LIKE
                                                    prm_origen
                                             AND itm.itm_nber = 1
                                    UNION
                                    SELECT   DISTINCT
                                                gen.key_year
                                             || '/'
                                             || gen.key_cuo
                                             || '/'
                                             || gen.sad_reg_serial
                                             || '-'
                                             || gen.sad_reg_nber
                                                 tramite,
                                             gen.key_year,
                                             gen.key_cuo,
                                             gen.sad_reg_nber,
                                             TO_CHAR (gen.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (gen.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_zip,
                                                     gen.sad_consignee)
                                                 nro_doc,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_nam,
                                                     cmp.cmp_nam)
                                                 importador,
                                             gen.key_dec doc_dec,
                                             deo.sad_dec_nam nombre_dec,
                                             cty.cty_dsc origen,
                                                gen.key_year
                                             || gen.key_cuo
                                             || gen.sad_reg_nber
                                                 dui,
                                             existe_tramite (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.sad_reg_nber,
                                                             prm_tipo),
                                             verifica_alcance_dec (
                                                 prm_tipo,
                                                 gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber),
                                             '-' partida,
                                                ex.sad_exp_zip
                                             || ':'
                                             || ex.sad_exp_nam
                                                 proveedor,
                                             DECODE (spy1.sad_clr,
                                                     0,
                                                     'VERDE',
                                                     1,
                                                     'AZUL',
                                                     2,
                                                     'AMARILLO',
                                                     3,
                                                     'ROJO')
                                                 canal,                   --16
                                             devuelve_ficha_inf (
                                                 gen.sad_reg_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber)
                                                 ficha
                                      FROM   ops$asy.sad_gen gen,
                                             ops$asy.sad_itm itm,
                                             ops$asy.sad_occ_cns cns,
                                             ops$asy.uncmptab cmp,
                                             ops$asy.sad_occ_dec deo,
                                             ops$asy.unctytab cty,
                                             ops$asy.sad_occ_exp ex,
                                             ops$asy.sad_spy spy1
                                     WHERE   gen.sad_flw = 1
                                             AND gen.sad_asmt_serial IS NOT NULL
                                             AND gen.lst_ope = 'U'
                                             AND gen.sad_num = '0'
                                             AND gen.key_year = itm.key_year
                                             AND gen.key_cuo = itm.key_cuo
                                             AND itm.key_dec IS NULL
                                             AND gen.key_nber = itm.key_nber
                                             AND itm.sad_num = '0'
                                             AND gen.key_year = deo.key_year
                                             AND gen.key_cuo = deo.key_cuo
                                             AND deo.key_dec IS NULL
                                             AND gen.key_nber = deo.key_nber
                                             AND gen.sad_num = deo.sad_num
                                             AND gen.key_year = cns.key_year(+)
                                             AND gen.key_cuo = cns.key_cuo(+)
                                             AND cns.key_dec(+) IS NULL
                                             AND gen.key_nber = cns.key_nber(+)
                                             AND gen.sad_num = cns.sad_num(+)
                                             AND cns.sad_num(+) = '0'
                                             AND gen.key_year = ex.key_year(+)
                                             AND gen.key_cuo = ex.key_cuo(+)
                                             AND ex.key_dec(+) IS NULL
                                             AND gen.key_nber = ex.key_nber(+)
                                             AND gen.sad_num = ex.sad_num(+)
                                             AND ex.sad_num(+) = '0'
                                             AND gen.key_year =
                                                    spy1.key_year(+)
                                             AND gen.key_cuo = spy1.key_cuo(+)
                                             AND spy1.key_dec(+) IS NULL
                                             AND gen.key_nber =
                                                    spy1.key_nber(+)
                                             AND spy1.spy_sta(+) = '10'
                                             AND spy1.spy_act(+) = '24'
                                             AND itm.saditm_cty_origcod =
                                                    cty.cty_cod
                                             AND cty.lst_ope = 'U'
                                             AND gen.sad_consignee =
                                                    cmp.cmp_cod(+)
                                             AND cmp.lst_ope(+) = 'U'
                                             AND gen.key_dec IS NULL
                                             AND gen.key_cuo = prm_aduana
                                             AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                              prm_fecini,
                                                                              'DD/MM/YYYY')
                                                                      AND  TO_DATE (
                                                                               prm_fecfin,
                                                                               'DD/MM/YYYY')
                                             AND (gen.sad_consignee LIKE
                                                      prm_importador
                                                  OR cns.sad_con_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND itm.saditm_cty_origcod LIKE
                                                    prm_origen
                                             AND itm.itm_nber = 1) tbl
                        ORDER BY   2, 3, 4;
                END IF;
            ELSE
                IF prm_aduana = '%'
                THEN
                    OPEN ct FOR
                          SELECT   DISTINCT
                                      gen.key_year
                                   || '/'
                                   || gen.key_cuo
                                   || '/'
                                   || gen.sad_reg_serial
                                   || '-'
                                   || gen.sad_reg_nber
                                       tramite,
                                   gen.key_year,
                                   gen.key_cuo,
                                   gen.sad_reg_nber,
                                   TO_CHAR (gen.sad_reg_date, 'dd/mm/yyyy')
                                       fecha_registro,
                                   TO_CHAR (gen.sad_asmt_date, 'dd/mm/yyyy')
                                       fecha_valid,
                                   DECODE (gen.sad_consignee,
                                           NULL, cns.sad_con_zip,
                                           gen.sad_consignee)
                                       nro_doc,
                                   DECODE (gen.sad_consignee,
                                           NULL, cns.sad_con_nam,
                                           cmp.cmp_nam)
                                       importador,
                                   --5
                                   gen.key_dec doc_dec,
                                   de.dec_nam nombre_dec,
                                   cty.cty_dsc origen,
                                      gen.key_year
                                   || gen.key_cuo
                                   || gen.sad_reg_nber
                                       dui,
                                   existe_tramite (gen.key_year,
                                                   gen.key_cuo,
                                                   gen.sad_reg_nber,
                                                   prm_tipo),
                                   verifica_alcance_dec (prm_tipo,
                                                         gen.key_year,
                                                         gen.key_cuo,
                                                         gen.sad_reg_nber),
                                   '-' partida,
                                   ex.sad_exp_zip || ':' || ex.sad_exp_nam
                                       proveedor,
                                   DECODE (spy1.sad_clr,
                                           0,
                                           'VERDE',
                                           1,
                                           'AZUL',
                                           2,
                                           'AMARILLO',
                                           3,
                                           'ROJO')
                                       canal,                             --16
                                   devuelve_ficha_inf (gen.sad_reg_year,
                                                       gen.key_cuo,
                                                       gen.sad_reg_nber)
                                       ficha
                            FROM   ops$asy.sad_gen gen,
                                   ops$asy.sad_itm itm,
                                   ops$asy.sad_occ_cns cns,
                                   ops$asy.uncmptab cmp,
                                   ops$asy.undectab de,
                                   ops$asy.unctytab cty,
                                   ops$asy.sad_occ_exp ex,
                                   ops$asy.sad_spy spy1
                           WHERE       gen.sad_flw = 1
                                   AND gen.sad_asmt_serial IS NOT NULL
                                   AND gen.lst_ope = 'U'
                                   AND gen.sad_num = '0'
                                   AND gen.key_year = itm.key_year
                                   AND gen.key_cuo = itm.key_cuo
                                   AND gen.key_dec = itm.key_dec
                                   AND gen.key_nber = itm.key_nber
                                   AND itm.sad_num = '0'
                                   AND gen.key_dec = de.dec_cod
                                   AND gen.key_year = cns.key_year(+)
                                   AND gen.key_cuo = cns.key_cuo(+)
                                   AND gen.key_dec = cns.key_dec(+)
                                   AND gen.key_nber = cns.key_nber(+)
                                   AND gen.sad_num = cns.sad_num(+)
                                   AND cns.sad_num(+) = '0'
                                   AND gen.key_year = ex.key_year(+)
                                   AND gen.key_cuo = ex.key_cuo(+)
                                   AND gen.key_dec = ex.key_dec(+)
                                   AND gen.key_nber = ex.key_nber(+)
                                   AND gen.sad_num = ex.sad_num(+)
                                   AND ex.sad_num(+) = '0'
                                   AND gen.key_year = spy1.key_year(+)
                                   AND gen.key_cuo = spy1.key_cuo(+)
                                   AND gen.key_dec = spy1.key_dec(+)
                                   AND gen.key_nber = spy1.key_nber(+)
                                   AND spy1.spy_sta(+) = '10'
                                   AND spy1.spy_act(+) = '24'
                                   AND itm.saditm_cty_origcod = cty.cty_cod
                                   AND cty.lst_ope = 'U'
                                   AND gen.sad_consignee = cmp.cmp_cod(+)
                                   AND cmp.lst_ope(+) = 'U'
                                   AND gen.key_dec IS NOT NULL
                                   AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                    prm_fecini,
                                                                    'DD/MM/YYYY')
                                                            AND  TO_DATE (
                                                                     prm_fecfin,
                                                                     'DD/MM/YYYY')
                                   AND gen.key_dec = prm_agencia
                                   AND (gen.sad_consignee LIKE prm_importador
                                        OR cns.sad_con_zip LIKE
                                              '%' || prm_importador || '%')
                                   AND itm.saditm_cty_origcod LIKE prm_origen
                                   AND itm.itm_nber = 1
                        ORDER BY   2, 3, 4;
                ELSE
                    OPEN ct FOR
                          SELECT   DISTINCT
                                      gen.key_year
                                   || '/'
                                   || gen.key_cuo
                                   || '/'
                                   || gen.sad_reg_serial
                                   || '-'
                                   || gen.sad_reg_nber
                                       tramite,
                                   gen.key_year,
                                   gen.key_cuo,
                                   gen.sad_reg_nber,
                                   TO_CHAR (gen.sad_reg_date, 'dd/mm/yyyy')
                                       fecha_registro,
                                   TO_CHAR (gen.sad_asmt_date, 'dd/mm/yyyy')
                                       fecha_valid,
                                   DECODE (gen.sad_consignee,
                                           NULL, cns.sad_con_zip,
                                           gen.sad_consignee)
                                       nro_doc,
                                   DECODE (gen.sad_consignee,
                                           NULL, cns.sad_con_nam,
                                           cmp.cmp_nam)
                                       importador,
                                   --5
                                   gen.key_dec doc_dec,
                                   de.dec_nam nombre_dec,
                                   cty.cty_dsc origen,
                                      gen.key_year
                                   || gen.key_cuo
                                   || gen.sad_reg_nber
                                       dui,
                                   existe_tramite (gen.key_year,
                                                   gen.key_cuo,
                                                   gen.sad_reg_nber,
                                                   prm_tipo),
                                   verifica_alcance_dec (prm_tipo,
                                                         gen.key_year,
                                                         gen.key_cuo,
                                                         gen.sad_reg_nber),
                                   '-' partida,
                                   ex.sad_exp_zip || ':' || ex.sad_exp_nam
                                       proveedor,
                                   DECODE (spy1.sad_clr,
                                           0,
                                           'VERDE',
                                           1,
                                           'AZUL',
                                           2,
                                           'AMARILLO',
                                           3,
                                           'ROJO')
                                       canal,                             --16
                                   devuelve_ficha_inf (gen.sad_reg_year,
                                                       gen.key_cuo,
                                                       gen.sad_reg_nber)
                                       ficha
                            FROM   ops$asy.sad_gen gen,
                                   ops$asy.sad_itm itm,
                                   ops$asy.sad_occ_cns cns,
                                   ops$asy.uncmptab cmp,
                                   ops$asy.undectab de,
                                   ops$asy.unctytab cty,
                                   ops$asy.sad_occ_exp ex,
                                   ops$asy.sad_spy spy1
                           WHERE       gen.sad_flw = 1
                                   AND gen.sad_asmt_serial IS NOT NULL
                                   AND gen.lst_ope = 'U'
                                   AND gen.sad_num = '0'
                                   AND gen.key_year = itm.key_year
                                   AND gen.key_cuo = itm.key_cuo
                                   AND gen.key_dec = itm.key_dec
                                   AND gen.key_nber = itm.key_nber
                                   AND itm.sad_num = '0'
                                   AND gen.key_dec = de.dec_cod
                                   AND gen.key_year = cns.key_year(+)
                                   AND gen.key_cuo = cns.key_cuo(+)
                                   AND gen.key_dec = cns.key_dec(+)
                                   AND gen.key_nber = cns.key_nber(+)
                                   AND gen.sad_num = cns.sad_num(+)
                                   AND cns.sad_num(+) = '0'
                                   AND gen.key_year = ex.key_year(+)
                                   AND gen.key_cuo = ex.key_cuo(+)
                                   AND gen.key_dec = ex.key_dec(+)
                                   AND gen.key_nber = ex.key_nber(+)
                                   AND gen.sad_num = ex.sad_num(+)
                                   AND ex.sad_num(+) = '0'
                                   AND gen.key_year = spy1.key_year(+)
                                   AND gen.key_cuo = spy1.key_cuo(+)
                                   AND gen.key_dec = spy1.key_dec(+)
                                   AND gen.key_nber = spy1.key_nber(+)
                                   AND spy1.spy_sta(+) = '10'
                                   AND spy1.spy_act(+) = '24'
                                   AND itm.saditm_cty_origcod = cty.cty_cod
                                   AND cty.lst_ope = 'U'
                                   AND gen.sad_consignee = cmp.cmp_cod(+)
                                   AND cmp.lst_ope(+) = 'U'
                                   AND gen.key_dec IS NOT NULL
                                   AND gen.key_cuo = prm_aduana
                                   AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                    prm_fecini,
                                                                    'DD/MM/YYYY')
                                                            AND  TO_DATE (
                                                                     prm_fecfin,
                                                                     'DD/MM/YYYY')
                                   AND gen.key_dec LIKE prm_agencia
                                   AND (gen.sad_consignee LIKE prm_importador
                                        OR cns.sad_con_zip LIKE
                                              '%' || prm_importador || '%')
                                   AND itm.saditm_cty_origcod LIKE prm_origen
                                   AND itm.itm_nber = 1
                        ORDER BY   2, 3, 4;
                END IF;
            END IF;

            res := 'CORRECTO';
        END IF;


        IF prm_tipo = 'DUE'
        THEN
            IF prm_aduana = '%'
            THEN
                OPEN ct FOR
                      SELECT   *
                        FROM   (SELECT   DISTINCT
                                            s.sad_reg_year
                                         || '/'
                                         || s.key_cuo
                                         || '/'
                                         || s.sad_reg_serial
                                         || '-'
                                         || s.sad_reg_nber
                                             tramite,
                                         s.key_year,
                                         s.key_cuo,
                                         s.sad_reg_nber,
                                         TO_CHAR (s.sad_reg_date, 'dd/mm/yyyy')
                                             fecha_registro,
                                         TO_CHAR (s.sad_asmt_date,
                                                  'dd/mm/yyyy')
                                             fecha_valid,
                                         s.sad_exporter || m.sad_exp_zip
                                             nro_doc,
                                         cmp1.cmp_nam || m.sad_exp_nam
                                             exportador,
                                         sad_dec.key_dec doc_dec,
                                         sad_dec.sad_dec_nam nombre_dec,
                                         pais.cty_dsc destino,
                                            s.key_year
                                         || s.key_cuo
                                         || s.sad_reg_nber
                                             dui,
                                         existe_tramite (s.sad_reg_year,
                                                         s.key_cuo,
                                                         s.sad_reg_nber,
                                                         prm_tipo),
                                         verifica_alcance_dec (prm_tipo,
                                                               s.key_year,
                                                               s.key_cuo,
                                                               s.sad_reg_nber),
                                         '-' partida,
                                         '-' proveedor,
                                         '-' canal,
                                         '-' ficha
                                  FROM   ops$asy.sad_itm itm,
                                         ops$asy.sad_gen s,
                                         ops$asy.sad_occ_exp m,
                                         ops$asy.uncmptab cmp1,
                                         ops$asy.sad_occ_dec sad_dec,
                                         ops$asy.unctytab pais
                                 WHERE       s.sad_num = 0
                                         AND s.lst_ope = 'U'
                                         AND s.sad_typ_dec = 'EX'
                                         --and s.sad_typ_proc = 1
                                         AND s.key_year = itm.key_year
                                         AND s.key_cuo = itm.key_cuo
                                         AND s.key_nber = itm.key_nber
                                         AND (s.key_dec IS NULL
                                              AND itm.key_dec IS NULL)
                                         AND s.sad_num = itm.sad_num
                                         AND itm.itm_nber = 1
                                         AND s.sad_exporter = cmp1.cmp_cod(+)
                                         -- exp. no ocasionales
                                         AND cmp1.lst_ope(+) = 'U'
                                         AND s.key_year = m.key_year(+)
                                         -- exp. ocasionales
                                         AND s.key_cuo = m.key_cuo(+)
                                         AND (s.key_dec IS NULL
                                              AND m.key_dec(+) IS NULL)
                                         AND s.key_nber = m.key_nber(+)
                                         AND s.sad_num = m.sad_num(+)
                                         AND m.sad_num(+) = 0
                                         AND s.key_year = sad_dec.key_year(+)
                                         --para declarantes ocasionales
                                         AND s.key_cuo = sad_dec.key_cuo(+)
                                         AND s.key_dec IS NULL
                                         AND sad_dec.key_dec(+) IS NULL
                                         AND s.key_nber = sad_dec.key_nber(+)
                                         AND s.sad_num = sad_dec.sad_num(+)
                                         AND s.sad_cty_destcod = pais.cty_cod
                                         AND s.sad_reg_date BETWEEN TO_DATE (
                                                                        prm_fecini,
                                                                        'DD/MM/YYYY')
                                                                AND  TO_DATE (
                                                                         prm_fecfin,
                                                                         'DD/MM/YYYY')
                                         AND s.key_dec LIKE prm_agencia
                                         AND (s.sad_exporter LIKE
                                                  prm_importador
                                              OR m.sad_exp_zip LIKE
                                                       '%'
                                                    || prm_importador
                                                    || '%')
                                         AND s.sad_cty_destcod LIKE prm_origen
                                UNION
                                SELECT   DISTINCT
                                            s.sad_reg_year
                                         || '/'
                                         || s.key_cuo
                                         || '/'
                                         || s.sad_reg_serial
                                         || '-'
                                         || s.sad_reg_nber
                                             tramite,
                                         s.key_year,
                                         s.key_cuo,
                                         s.sad_reg_nber,
                                         TO_CHAR (s.sad_reg_date, 'dd/mm/yyyy')
                                             fecha_registro,
                                         TO_CHAR (s.sad_asmt_date,
                                                  'dd/mm/yyyy')
                                             fecha_valid,
                                         s.sad_exporter || m.sad_exp_zip
                                             nro_doc,
                                         cmp1.cmp_nam || m.sad_exp_nam
                                             exportador,
                                         dec.dec_cod doc_dec,
                                         dec.dec_nam nombre_dec,
                                         pais.cty_dsc destino,
                                            s.key_year
                                         || s.key_cuo
                                         || s.sad_reg_nber
                                             dui,
                                         existe_tramite (s.sad_reg_year,
                                                         s.key_cuo,
                                                         s.sad_reg_nber,
                                                         prm_tipo),
                                         verifica_alcance_dec (prm_tipo,
                                                               s.key_year,
                                                               s.key_cuo,
                                                               s.sad_reg_nber),
                                         '-' partida,
                                         '-' proveedor,
                                         '-' canal,
                                         '-' ficha
                                  FROM   ops$asy.sad_itm itm,
                                         ops$asy.sad_gen s,
                                         ops$asy.sad_occ_exp m,
                                         ops$asy.uncmptab cmp1,
                                         ops$asy.undectab dec,
                                         ops$asy.unctytab pais
                                 WHERE       s.sad_num = 0
                                         AND s.lst_ope = 'U'
                                         AND s.sad_typ_dec = 'EX'
                                         --AND s.sad_typ_proc = 1
                                         AND s.key_year = itm.key_year
                                         AND s.key_cuo = itm.key_cuo
                                         AND s.key_dec = itm.key_dec
                                         AND s.key_nber = itm.key_nber
                                         AND s.sad_num = itm.sad_num
                                         AND itm.itm_nber = 1
                                         AND s.sad_exporter = cmp1.cmp_cod(+)
                                         -- exp. no ocasionales
                                         AND cmp1.lst_ope(+) = 'U'
                                         AND s.key_year = m.key_year(+)
                                         -- exp. ocasionales
                                         AND s.key_cuo = m.key_cuo(+)
                                         AND s.key_dec = m.key_dec(+)
                                         AND s.key_nber = m.key_nber(+)
                                         AND s.sad_num = m.sad_num(+)
                                         AND m.sad_num(+) = 0
                                         AND s.sad_cty_destcod = pais.cty_cod
                                         AND s.key_dec = dec.dec_cod(+)
                                         --para declarantes registrados
                                         AND dec.lst_ope = 'U'
                                         AND s.sad_reg_date BETWEEN TO_DATE (
                                                                        prm_fecini,
                                                                        'DD/MM/YYYY')
                                                                AND  TO_DATE (
                                                                         prm_fecfin,
                                                                         'DD/MM/YYYY')
                                         AND s.key_dec LIKE prm_agencia
                                         AND (s.sad_exporter LIKE
                                                  prm_importador
                                              OR m.sad_exp_zip LIKE
                                                       '%'
                                                    || prm_importador
                                                    || '%')
                                         AND s.sad_cty_destcod LIKE prm_origen)
                               tbl
                    ORDER BY   2, 3, 4;
            ELSE
                OPEN ct FOR
                      SELECT   *
                        FROM   (SELECT   DISTINCT
                                            s.sad_reg_year
                                         || '/'
                                         || s.key_cuo
                                         || '/'
                                         || s.sad_reg_serial
                                         || '-'
                                         || s.sad_reg_nber
                                             tramite,
                                         s.key_year,
                                         s.key_cuo,
                                         s.sad_reg_nber,
                                         TO_CHAR (s.sad_reg_date, 'dd/mm/yyyy')
                                             fecha_registro,
                                         TO_CHAR (s.sad_asmt_date,
                                                  'dd/mm/yyyy')
                                             fecha_valid,
                                         s.sad_exporter || m.sad_exp_zip
                                             nro_doc,
                                         cmp1.cmp_nam || m.sad_exp_nam
                                             exportador,
                                         sad_dec.key_dec doc_dec,
                                         sad_dec.sad_dec_nam nombre_dec,
                                         pais.cty_dsc destino,
                                            s.key_year
                                         || s.key_cuo
                                         || s.sad_reg_nber
                                             dui,
                                         existe_tramite (s.sad_reg_year,
                                                         s.key_cuo,
                                                         s.sad_reg_nber,
                                                         prm_tipo),
                                         verifica_alcance_dec (prm_tipo,
                                                               s.key_year,
                                                               s.key_cuo,
                                                               s.sad_reg_nber),
                                         '-' partida,
                                         '-' proveedor,
                                         '-' canal,
                                         '-' ficha
                                  FROM   ops$asy.sad_itm itm,
                                         ops$asy.sad_gen s,
                                         ops$asy.sad_occ_exp m,
                                         ops$asy.uncmptab cmp1,
                                         ops$asy.sad_occ_dec sad_dec,
                                         ops$asy.unctytab pais
                                 WHERE       s.sad_num = 0
                                         AND s.lst_ope = 'U'
                                         AND s.sad_typ_dec = 'EX'
                                         --and s.sad_typ_proc = 1
                                         AND s.key_year = itm.key_year
                                         AND s.key_cuo = itm.key_cuo
                                         AND s.key_nber = itm.key_nber
                                         AND (s.key_dec IS NULL
                                              AND itm.key_dec IS NULL)
                                         AND s.sad_num = itm.sad_num
                                         AND itm.itm_nber = 1
                                         AND s.sad_exporter = cmp1.cmp_cod(+)
                                         -- exp. no ocasionales
                                         AND cmp1.lst_ope(+) = 'U'
                                         AND s.key_year = m.key_year(+)
                                         -- exp. ocasionales
                                         AND s.key_cuo = m.key_cuo(+)
                                         AND (s.key_dec IS NULL
                                              AND m.key_dec(+) IS NULL)
                                         AND s.key_nber = m.key_nber(+)
                                         AND s.sad_num = m.sad_num(+)
                                         AND m.sad_num(+) = 0
                                         AND s.key_year = sad_dec.key_year(+)
                                         --para declarantes ocasionales
                                         AND s.key_cuo = sad_dec.key_cuo(+)
                                         AND s.key_dec IS NULL
                                         AND sad_dec.key_dec(+) IS NULL
                                         AND s.key_nber = sad_dec.key_nber(+)
                                         AND s.sad_num = sad_dec.sad_num(+)
                                         AND s.sad_cty_destcod = pais.cty_cod
                                         AND s.sad_reg_date BETWEEN TO_DATE (
                                                                        prm_fecini,
                                                                        'DD/MM/YYYY')
                                                                AND  TO_DATE (
                                                                         prm_fecfin,
                                                                         'DD/MM/YYYY')
                                         AND s.key_dec LIKE prm_agencia
                                         AND s.key_cuo = prm_aduana
                                         AND (s.sad_exporter LIKE
                                                  prm_importador
                                              OR m.sad_exp_zip LIKE
                                                       '%'
                                                    || prm_importador
                                                    || '%')
                                         AND s.sad_cty_destcod LIKE prm_origen
                                UNION
                                SELECT   DISTINCT
                                            s.sad_reg_year
                                         || '/'
                                         || s.key_cuo
                                         || '/'
                                         || s.sad_reg_serial
                                         || '-'
                                         || s.sad_reg_nber
                                             tramite,
                                         s.key_year,
                                         s.key_cuo,
                                         s.sad_reg_nber,
                                         TO_CHAR (s.sad_reg_date, 'dd/mm/yyyy')
                                             fecha_registro,
                                         TO_CHAR (s.sad_asmt_date,
                                                  'dd/mm/yyyy')
                                             fecha_valid,
                                         s.sad_exporter || m.sad_exp_zip
                                             nro_doc,
                                         cmp1.cmp_nam || m.sad_exp_nam
                                             exportador,
                                         dec.dec_cod doc_dec,
                                         dec.dec_nam nombre_dec,
                                         pais.cty_dsc destino,
                                            s.key_year
                                         || s.key_cuo
                                         || s.sad_reg_nber
                                             dui,
                                         existe_tramite (s.sad_reg_year,
                                                         s.key_cuo,
                                                         s.sad_reg_nber,
                                                         prm_tipo),
                                         verifica_alcance_dec (prm_tipo,
                                                               s.key_year,
                                                               s.key_cuo,
                                                               s.sad_reg_nber),
                                         '-' partida,
                                         '-' proveedor,
                                         '-' canal,
                                         '-' ficha
                                  FROM   ops$asy.sad_itm itm,
                                         ops$asy.sad_gen s,
                                         ops$asy.sad_occ_exp m,
                                         ops$asy.uncmptab cmp1,
                                         ops$asy.undectab dec,
                                         ops$asy.unctytab pais
                                 WHERE       s.sad_num = 0
                                         AND s.lst_ope = 'U'
                                         AND s.sad_typ_dec = 'EX'
                                         --AND s.sad_typ_proc = 1
                                         AND s.key_year = itm.key_year
                                         AND s.key_cuo = itm.key_cuo
                                         AND s.key_dec = itm.key_dec
                                         AND s.key_nber = itm.key_nber
                                         AND s.sad_num = itm.sad_num
                                         AND itm.itm_nber = 1
                                         AND s.sad_exporter = cmp1.cmp_cod(+)
                                         -- exp. no ocasionales
                                         AND cmp1.lst_ope(+) = 'U'
                                         AND s.key_year = m.key_year(+)
                                         -- exp. ocasionales
                                         AND s.key_cuo = m.key_cuo(+)
                                         AND s.key_dec = m.key_dec(+)
                                         AND s.key_nber = m.key_nber(+)
                                         AND s.sad_num = m.sad_num(+)
                                         AND m.sad_num(+) = 0
                                         AND s.sad_cty_destcod = pais.cty_cod
                                         AND s.key_dec = dec.dec_cod(+)
                                         --para declarantes registrados
                                         AND dec.lst_ope = 'U'
                                         AND s.sad_reg_date BETWEEN TO_DATE (
                                                                        prm_fecini,
                                                                        'DD/MM/YYYY')
                                                                AND  TO_DATE (
                                                                         prm_fecfin,
                                                                         'DD/MM/YYYY')
                                         AND s.key_dec LIKE prm_agencia
                                         AND s.key_cuo = prm_aduana
                                         AND (s.sad_exporter LIKE
                                                  prm_importador
                                              OR m.sad_exp_zip LIKE
                                                       '%'
                                                    || prm_importador
                                                    || '%')
                                         AND s.sad_cty_destcod LIKE prm_origen)
                               tbl
                    ORDER BY   2, 3, 4;
            END IF;

            res := 'CORRECTO';
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION devuelve_duis_item (prm_fecini       IN     VARCHAR2,
                                 prm_fecfin       IN     VARCHAR2,
                                 prm_aduana       IN     VARCHAR2,
                                 prm_partida      IN     VARCHAR2,
                                 prm_agencia      IN     VARCHAR2,
                                 prm_importador   IN     VARCHAR2,
                                 prm_proveedor    IN     VARCHAR2,
                                 prm_origen       IN     VARCHAR2,
                                 prm_tipo         IN     VARCHAR2,
                                 prm_reg          IN     VARCHAR2,
                                 ct                  OUT cursortype)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (300) := 0;
    BEGIN
        IF prm_tipo = 'DUI'
        THEN
            IF prm_agencia = '%'
            THEN
                IF prm_aduana = '%'
                THEN
                    OPEN ct FOR
                          SELECT   *
                            FROM   (SELECT   DISTINCT
                                                gen.key_year
                                             || '/'
                                             || gen.key_cuo
                                             || '/'
                                             || gen.sad_reg_serial
                                             || '-'
                                             || gen.sad_reg_nber
                                                 tramite,
                                             gen.key_year,
                                             gen.key_cuo,
                                             gen.sad_reg_nber,
                                             TO_CHAR (gen.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (gen.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_zip,
                                                     gen.sad_consignee)
                                                 nro_doc,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_nam,
                                                     cmp.cmp_nam)
                                                 importador,
                                             --5
                                             gen.key_dec doc_dec,
                                             de.dec_nam nombre_dec,
                                             cty.cty_dsc origen,
                                                itm.itm_nber
                                             || '-'
                                             || gen.key_year
                                             || gen.key_cuo
                                             || gen.sad_reg_nber
                                                 dui,
                                             existe_tramite (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber,
                                                 itm.itm_nber),           --15
                                             itm.saditm_hs_cod
                                             || itm.saditm_hsprec_cod
                                                 partida,                 --16
                                                ex.sad_exp_zip
                                             || ':'
                                             || ex.sad_exp_nam
                                                 proveedor,               --17
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                                 descrip,                 --18
                                             DECODE (spy1.sad_clr,
                                                     0,
                                                     'VERDE',
                                                     1,
                                                     'AZUL',
                                                     2,
                                                     'AMARILLO',
                                                     3,
                                                     'ROJO')
                                                 canal,                   --16
                                             devuelve_ficha_inf (
                                                 gen.sad_reg_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber)
                                                 ficha
                                      FROM   ops$asy.sad_gen gen,
                                             ops$asy.sad_itm itm,
                                             ops$asy.sad_occ_cns cns,
                                             ops$asy.uncmptab cmp,
                                             ops$asy.undectab de,
                                             ops$asy.unctytab cty,
                                             ops$asy.sad_occ_exp ex,
                                             ops$asy.sad_spy spy1
                                     WHERE   gen.sad_flw = 1
                                             AND gen.sad_asmt_serial IS NOT NULL
                                             AND gen.lst_ope = 'U'
                                             AND gen.sad_num = '0'
                                             AND gen.key_year = itm.key_year
                                             AND gen.key_cuo = itm.key_cuo
                                             AND gen.key_dec = itm.key_dec
                                             AND gen.key_nber = itm.key_nber
                                             AND itm.sad_num = '0'
                                             AND gen.key_dec = de.dec_cod
                                             AND gen.key_year = cns.key_year(+)
                                             AND gen.key_cuo = cns.key_cuo(+)
                                             AND gen.key_dec = cns.key_dec(+)
                                             AND gen.key_nber = cns.key_nber(+)
                                             AND gen.sad_num = cns.sad_num(+)
                                             AND cns.sad_num(+) = '0'
                                             AND gen.key_year = ex.key_year(+)
                                             AND gen.key_cuo = ex.key_cuo(+)
                                             AND gen.key_dec = ex.key_dec(+)
                                             AND gen.key_nber = ex.key_nber(+)
                                             AND gen.sad_num = ex.sad_num(+)
                                             AND gen.key_year =
                                                    spy1.key_year(+)
                                             AND gen.key_cuo = spy1.key_cuo(+)
                                             AND gen.key_dec = spy1.key_dec(+)
                                             AND gen.key_nber =
                                                    spy1.key_nber(+)
                                             AND spy1.spy_sta(+) = '10'
                                             AND spy1.spy_act(+) = '24'
                                             AND ex.sad_num(+) = '0'
                                             AND itm.saditm_cty_origcod =
                                                    cty.cty_cod
                                             AND cty.lst_ope = 'U'
                                             AND gen.sad_consignee =
                                                    cmp.cmp_cod(+)
                                             AND cmp.lst_ope(+) = 'U'
                                             AND gen.key_dec IS NOT NULL
                                             AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                              prm_fecini,
                                                                              'DD/MM/YYYY')
                                                                      AND  TO_DATE (
                                                                               prm_fecfin,
                                                                               'DD/MM/YYYY')
                                             AND (gen.sad_consignee LIKE
                                                      prm_importador
                                                  OR cns.sad_con_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND itm.saditm_cty_origcod LIKE
                                                    prm_origen
                                    UNION
                                    SELECT   DISTINCT
                                                gen.key_year
                                             || '/'
                                             || gen.key_cuo
                                             || '/'
                                             || gen.sad_reg_serial
                                             || '-'
                                             || gen.sad_reg_nber
                                                 tramite,
                                             gen.key_year,
                                             gen.key_cuo,
                                             gen.sad_reg_nber,
                                             TO_CHAR (gen.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (gen.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_zip,
                                                     gen.sad_consignee)
                                                 nro_doc,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_nam,
                                                     cmp.cmp_nam)
                                                 importador,
                                             gen.key_dec doc_dec,
                                             deo.sad_dec_nam nombre_dec,
                                             cty.cty_dsc origen,
                                                itm.itm_nber
                                             || '-'
                                             || gen.key_year
                                             || gen.key_cuo
                                             || gen.sad_reg_nber
                                                 dui,
                                             existe_tramite (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber,
                                                 itm.itm_nber),
                                             itm.saditm_hs_cod
                                             || itm.saditm_hsprec_cod
                                                 partida,
                                                ex.sad_exp_zip
                                             || ':'
                                             || ex.sad_exp_nam
                                                 proveedor,
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                                 descrip,
                                             DECODE (spy1.sad_clr,
                                                     0,
                                                     'VERDE',
                                                     1,
                                                     'AZUL',
                                                     2,
                                                     'AMARILLO',
                                                     3,
                                                     'ROJO')
                                                 canal,                   --16
                                             devuelve_ficha_inf (
                                                 gen.sad_reg_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber)
                                                 ficha
                                      FROM   ops$asy.sad_gen gen,
                                             ops$asy.sad_itm itm,
                                             ops$asy.sad_occ_cns cns,
                                             ops$asy.uncmptab cmp,
                                             ops$asy.sad_occ_dec deo,
                                             ops$asy.unctytab cty,
                                             ops$asy.sad_occ_exp ex,
                                             ops$asy.sad_spy spy1
                                     WHERE   gen.sad_flw = 1
                                             AND gen.sad_asmt_serial IS NOT NULL
                                             AND gen.lst_ope = 'U'
                                             AND gen.sad_num = '0'
                                             AND gen.key_year = itm.key_year
                                             AND gen.key_cuo = itm.key_cuo
                                             AND itm.key_dec IS NULL
                                             AND gen.key_nber = itm.key_nber
                                             AND itm.sad_num = '0'
                                             AND gen.key_year = deo.key_year
                                             AND gen.key_cuo = deo.key_cuo
                                             AND deo.key_dec IS NULL
                                             AND gen.key_nber = deo.key_nber
                                             AND gen.sad_num = deo.sad_num
                                             AND gen.key_year = cns.key_year(+)
                                             AND gen.key_cuo = cns.key_cuo(+)
                                             AND cns.key_dec(+) IS NULL
                                             AND gen.key_nber = cns.key_nber(+)
                                             AND gen.sad_num = cns.sad_num(+)
                                             AND cns.sad_num(+) = '0'
                                             AND gen.key_year = ex.key_year(+)
                                             AND gen.key_cuo = ex.key_cuo(+)
                                             AND ex.key_dec(+) IS NULL
                                             AND gen.key_nber = ex.key_nber(+)
                                             AND gen.sad_num = ex.sad_num(+)
                                             AND ex.sad_num(+) = '0'
                                             AND gen.key_year =
                                                    spy1.key_year(+)
                                             AND gen.key_cuo = spy1.key_cuo(+)
                                             AND spy1.key_dec(+) IS NULL
                                             AND gen.key_nber =
                                                    spy1.key_nber(+)
                                             AND spy1.spy_sta(+) = '10'
                                             AND spy1.spy_act(+) = '24'
                                             AND itm.saditm_cty_origcod =
                                                    cty.cty_cod
                                             AND cty.lst_ope = 'U'
                                             AND gen.sad_consignee =
                                                    cmp.cmp_cod(+)
                                             AND cmp.lst_ope(+) = 'U'
                                             AND gen.key_dec IS NULL
                                             AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                              prm_fecini,
                                                                              'DD/MM/YYYY')
                                                                      AND  TO_DATE (
                                                                               prm_fecfin,
                                                                               'DD/MM/YYYY')
                                             AND (gen.sad_consignee LIKE
                                                      prm_importador
                                                  OR cns.sad_con_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND itm.saditm_cty_origcod LIKE
                                                    prm_origen) tbl
                        ORDER BY   2, 3, 4;
                ELSE
                    OPEN ct FOR
                          SELECT   *
                            FROM   (SELECT   DISTINCT
                                                gen.key_year
                                             || '/'
                                             || gen.key_cuo
                                             || '/'
                                             || gen.sad_reg_serial
                                             || '-'
                                             || gen.sad_reg_nber
                                                 tramite,
                                             gen.key_year,
                                             gen.key_cuo,
                                             gen.sad_reg_nber,
                                             TO_CHAR (gen.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (gen.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_zip,
                                                     gen.sad_consignee)
                                                 nro_doc,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_nam,
                                                     cmp.cmp_nam)
                                                 importador,
                                             --5
                                             gen.key_dec doc_dec,
                                             de.dec_nam nombre_dec,
                                             cty.cty_dsc origen,
                                                itm.itm_nber
                                             || '-'
                                             || gen.key_year
                                             || gen.key_cuo
                                             || gen.sad_reg_nber
                                                 dui,
                                             existe_tramite (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber,
                                                 itm.itm_nber),
                                             itm.saditm_hs_cod
                                             || itm.saditm_hsprec_cod
                                                 partida,
                                                ex.sad_exp_zip
                                             || ':'
                                             || ex.sad_exp_nam
                                                 proveedor,
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                                 descrip,
                                             DECODE (spy1.sad_clr,
                                                     0,
                                                     'VERDE',
                                                     1,
                                                     'AZUL',
                                                     2,
                                                     'AMARILLO',
                                                     3,
                                                     'ROJO')
                                                 canal,                   --16
                                             devuelve_ficha_inf (
                                                 gen.sad_reg_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber)
                                                 ficha
                                      FROM   ops$asy.sad_gen gen,
                                             ops$asy.sad_itm itm,
                                             ops$asy.sad_occ_cns cns,
                                             ops$asy.uncmptab cmp,
                                             ops$asy.undectab de,
                                             ops$asy.unctytab cty,
                                             ops$asy.sad_occ_exp ex,
                                             ops$asy.sad_spy spy1
                                     WHERE   gen.sad_flw = 1
                                             AND gen.sad_asmt_serial IS NOT NULL
                                             AND gen.lst_ope = 'U'
                                             AND gen.sad_num = '0'
                                             AND gen.key_year = itm.key_year
                                             AND gen.key_cuo = itm.key_cuo
                                             AND gen.key_dec = itm.key_dec
                                             AND gen.key_nber = itm.key_nber
                                             AND itm.sad_num = '0'
                                             AND gen.key_dec = de.dec_cod
                                             AND gen.key_year = cns.key_year(+)
                                             AND gen.key_cuo = cns.key_cuo(+)
                                             AND gen.key_dec = cns.key_dec(+)
                                             AND gen.key_nber = cns.key_nber(+)
                                             AND gen.sad_num = cns.sad_num(+)
                                             AND cns.sad_num(+) = '0'
                                             AND gen.key_year = ex.key_year(+)
                                             AND gen.key_cuo = ex.key_cuo(+)
                                             AND gen.key_dec = ex.key_dec(+)
                                             AND gen.key_nber = ex.key_nber(+)
                                             AND gen.sad_num = ex.sad_num(+)
                                             AND ex.sad_num(+) = '0'
                                             AND gen.key_year =
                                                    spy1.key_year(+)
                                             AND gen.key_cuo = spy1.key_cuo(+)
                                             AND gen.key_dec = spy1.key_dec(+)
                                             AND gen.key_nber =
                                                    spy1.key_nber(+)
                                             AND spy1.spy_sta(+) = '10'
                                             AND spy1.spy_act(+) = '24'
                                             AND itm.saditm_cty_origcod =
                                                    cty.cty_cod
                                             AND cty.lst_ope = 'U'
                                             AND gen.sad_consignee =
                                                    cmp.cmp_cod(+)
                                             AND cmp.lst_ope(+) = 'U'
                                             AND gen.key_dec IS NOT NULL
                                             AND gen.key_cuo = prm_aduana
                                             AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                              prm_fecini,
                                                                              'DD/MM/YYYY')
                                                                      AND  TO_DATE (
                                                                               prm_fecfin,
                                                                               'DD/MM/YYYY')
                                             AND (gen.sad_consignee LIKE
                                                      prm_importador
                                                  OR cns.sad_con_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND itm.saditm_cty_origcod LIKE
                                                    prm_origen
                                    UNION
                                    SELECT   DISTINCT
                                                gen.key_year
                                             || '/'
                                             || gen.key_cuo
                                             || '/'
                                             || gen.sad_reg_serial
                                             || '-'
                                             || gen.sad_reg_nber
                                                 tramite,
                                             gen.key_year,
                                             gen.key_cuo,
                                             gen.sad_reg_nber,
                                             TO_CHAR (gen.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (gen.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_zip,
                                                     gen.sad_consignee)
                                                 nro_doc,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_nam,
                                                     cmp.cmp_nam)
                                                 importador,
                                             gen.key_dec doc_dec,
                                             deo.sad_dec_nam nombre_dec,
                                             cty.cty_dsc origen,
                                                itm.itm_nber
                                             || '-'
                                             || gen.key_year
                                             || gen.key_cuo
                                             || gen.sad_reg_nber
                                                 dui,
                                             existe_tramite (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber,
                                                 itm.itm_nber),
                                             itm.saditm_hs_cod
                                             || itm.saditm_hsprec_cod
                                                 partida,
                                                ex.sad_exp_zip
                                             || ':'
                                             || ex.sad_exp_nam
                                                 proveedor,
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                                 descrip,
                                             DECODE (spy1.sad_clr,
                                                     0,
                                                     'VERDE',
                                                     1,
                                                     'AZUL',
                                                     2,
                                                     'AMARILLO',
                                                     3,
                                                     'ROJO')
                                                 canal,                   --16
                                             devuelve_ficha_inf (
                                                 gen.sad_reg_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber)
                                                 ficha
                                      FROM   ops$asy.sad_gen gen,
                                             ops$asy.sad_itm itm,
                                             ops$asy.sad_occ_cns cns,
                                             ops$asy.uncmptab cmp,
                                             ops$asy.sad_occ_dec deo,
                                             ops$asy.unctytab cty,
                                             ops$asy.sad_occ_exp ex,
                                             ops$asy.sad_spy spy1
                                     WHERE   gen.sad_flw = 1
                                             AND gen.sad_asmt_serial IS NOT NULL
                                             AND gen.lst_ope = 'U'
                                             AND gen.sad_num = '0'
                                             AND gen.key_year = itm.key_year
                                             AND gen.key_cuo = itm.key_cuo
                                             AND itm.key_dec IS NULL
                                             AND gen.key_nber = itm.key_nber
                                             AND itm.sad_num = '0'
                                             AND gen.key_year = deo.key_year
                                             AND gen.key_cuo = deo.key_cuo
                                             AND deo.key_dec IS NULL
                                             AND gen.key_nber = deo.key_nber
                                             AND gen.sad_num = deo.sad_num
                                             AND gen.key_year = cns.key_year(+)
                                             AND gen.key_cuo = cns.key_cuo(+)
                                             AND cns.key_dec(+) IS NULL
                                             AND gen.key_nber = cns.key_nber(+)
                                             AND gen.sad_num = cns.sad_num(+)
                                             AND cns.sad_num(+) = '0'
                                             AND gen.key_year = ex.key_year(+)
                                             AND gen.key_cuo = ex.key_cuo(+)
                                             AND ex.key_dec(+) IS NULL
                                             AND gen.key_nber = ex.key_nber(+)
                                             AND gen.sad_num = ex.sad_num(+)
                                             AND ex.sad_num(+) = '0'
                                             AND gen.key_year =
                                                    spy1.key_year(+)
                                             AND gen.key_cuo = spy1.key_cuo(+)
                                             AND spy1.key_dec(+) IS NULL
                                             AND gen.key_nber =
                                                    spy1.key_nber(+)
                                             AND spy1.spy_sta(+) = '10'
                                             AND spy1.spy_act(+) = '24'
                                             AND itm.saditm_cty_origcod =
                                                    cty.cty_cod
                                             AND cty.lst_ope = 'U'
                                             AND gen.sad_consignee =
                                                    cmp.cmp_cod(+)
                                             AND cmp.lst_ope(+) = 'U'
                                             AND gen.key_dec IS NULL
                                             AND gen.key_cuo = prm_aduana
                                             AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                              prm_fecini,
                                                                              'DD/MM/YYYY')
                                                                      AND  TO_DATE (
                                                                               prm_fecfin,
                                                                               'DD/MM/YYYY')
                                             AND (gen.sad_consignee LIKE
                                                      prm_importador
                                                  OR cns.sad_con_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND itm.saditm_cty_origcod LIKE
                                                    prm_origen) tbl
                        ORDER BY   2, 3, 4;
                END IF;
            ELSE
                IF prm_aduana = '%'
                THEN
                    OPEN ct FOR
                          SELECT   DISTINCT
                                      gen.key_year
                                   || '/'
                                   || gen.key_cuo
                                   || '/'
                                   || gen.sad_reg_serial
                                   || '-'
                                   || gen.sad_reg_nber
                                       tramite,
                                   gen.key_year,
                                   gen.key_cuo,
                                   gen.sad_reg_nber,
                                   TO_CHAR (gen.sad_reg_date, 'dd/mm/yyyy')
                                       fecha_registro,
                                   TO_CHAR (gen.sad_asmt_date, 'dd/mm/yyyy')
                                       fecha_valid,
                                   DECODE (gen.sad_consignee,
                                           NULL, cns.sad_con_zip,
                                           gen.sad_consignee)
                                       nro_doc,
                                   DECODE (gen.sad_consignee,
                                           NULL, cns.sad_con_nam,
                                           cmp.cmp_nam)
                                       importador,
                                   --5
                                   gen.key_dec doc_dec,
                                   de.dec_nam nombre_dec,
                                   cty.cty_dsc origen,
                                      itm.itm_nber
                                   || '-'
                                   || gen.key_year
                                   || gen.key_cuo
                                   || gen.sad_reg_nber
                                       dui,
                                   existe_tramite (gen.key_year,
                                                   gen.key_cuo,
                                                   gen.sad_reg_nber,
                                                   prm_tipo),
                                   itm.itm_nber,
                                   verifica_alcance_item (prm_tipo,
                                                          gen.key_year,
                                                          gen.key_cuo,
                                                          gen.sad_reg_nber,
                                                          itm.itm_nber),
                                   itm.saditm_hs_cod || itm.saditm_hsprec_cod
                                       partida,
                                   ex.sad_exp_zip || ':' || ex.sad_exp_nam
                                       proveedor,
                                      itm.saditm_goods_desc1
                                   || itm.saditm_goods_desc2
                                   || itm.saditm_goods_desc3
                                       descrip,
                                   DECODE (spy1.sad_clr,
                                           0,
                                           'VERDE',
                                           1,
                                           'AZUL',
                                           2,
                                           'AMARILLO',
                                           3,
                                           'ROJO')
                                       canal,                             --16
                                   devuelve_ficha_inf (gen.sad_reg_year,
                                                       gen.key_cuo,
                                                       gen.sad_reg_nber)
                                       ficha
                            FROM   ops$asy.sad_gen gen,
                                   ops$asy.sad_itm itm,
                                   ops$asy.sad_occ_cns cns,
                                   ops$asy.uncmptab cmp,
                                   ops$asy.undectab de,
                                   ops$asy.unctytab cty,
                                   ops$asy.sad_occ_exp ex,
                                   ops$asy.sad_spy spy1
                           WHERE       gen.sad_flw = 1
                                   AND gen.sad_asmt_serial IS NOT NULL
                                   AND gen.lst_ope = 'U'
                                   AND gen.sad_num = '0'
                                   AND gen.key_year = itm.key_year
                                   AND gen.key_cuo = itm.key_cuo
                                   AND gen.key_dec = itm.key_dec
                                   AND gen.key_nber = itm.key_nber
                                   AND itm.sad_num = '0'
                                   AND gen.key_dec = de.dec_cod
                                   AND gen.key_year = cns.key_year(+)
                                   AND gen.key_cuo = cns.key_cuo(+)
                                   AND gen.key_dec = cns.key_dec(+)
                                   AND gen.key_nber = cns.key_nber(+)
                                   AND gen.sad_num = cns.sad_num(+)
                                   AND cns.sad_num(+) = '0'
                                   AND gen.key_year = ex.key_year(+)
                                   AND gen.key_cuo = ex.key_cuo(+)
                                   AND gen.key_dec = ex.key_dec(+)
                                   AND gen.key_nber = ex.key_nber(+)
                                   AND gen.sad_num = ex.sad_num(+)
                                   AND ex.sad_num(+) = '0'
                                   AND gen.key_year = spy1.key_year(+)
                                   AND gen.key_cuo = spy1.key_cuo(+)
                                   AND gen.key_dec = spy1.key_dec(+)
                                   AND gen.key_nber = spy1.key_nber(+)
                                   AND spy1.spy_sta(+) = '10'
                                   AND spy1.spy_act(+) = '24'
                                   AND itm.saditm_cty_origcod = cty.cty_cod
                                   AND cty.lst_ope = 'U'
                                   AND gen.sad_consignee = cmp.cmp_cod(+)
                                   AND cmp.lst_ope(+) = 'U'
                                   AND gen.key_dec IS NOT NULL
                                   AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                    prm_fecini,
                                                                    'DD/MM/YYYY')
                                                            AND  TO_DATE (
                                                                     prm_fecfin,
                                                                     'DD/MM/YYYY')
                                   AND gen.key_dec = prm_agencia
                                   AND (gen.sad_consignee LIKE prm_importador
                                        OR cns.sad_con_zip LIKE
                                              '%' || prm_importador || '%')
                                   AND itm.saditm_cty_origcod LIKE prm_origen
                        ORDER BY   2, 3, 4;
                ELSE
                    OPEN ct FOR
                          SELECT   DISTINCT
                                      gen.key_year
                                   || '/'
                                   || gen.key_cuo
                                   || '/'
                                   || gen.sad_reg_serial
                                   || '-'
                                   || gen.sad_reg_nber
                                       tramite,
                                   gen.key_year,
                                   gen.key_cuo,
                                   gen.sad_reg_nber,
                                   TO_CHAR (gen.sad_reg_date, 'dd/mm/yyyy')
                                       fecha_registro,
                                   TO_CHAR (gen.sad_asmt_date, 'dd/mm/yyyy')
                                       fecha_valid,
                                   DECODE (gen.sad_consignee,
                                           NULL, cns.sad_con_zip,
                                           gen.sad_consignee)
                                       nro_doc,
                                   DECODE (gen.sad_consignee,
                                           NULL, cns.sad_con_nam,
                                           cmp.cmp_nam)
                                       importador,
                                   --5
                                   gen.key_dec doc_dec,
                                   de.dec_nam nombre_dec,
                                   cty.cty_dsc origen,
                                      itm.itm_nber
                                   || '-'
                                   || gen.key_year
                                   || gen.key_cuo
                                   || gen.sad_reg_nber
                                       dui,
                                   existe_tramite (gen.key_year,
                                                   gen.key_cuo,
                                                   gen.sad_reg_nber,
                                                   prm_tipo),
                                   itm.itm_nber,
                                   verifica_alcance_item (prm_tipo,
                                                          gen.key_year,
                                                          gen.key_cuo,
                                                          gen.sad_reg_nber,
                                                          itm.itm_nber),
                                   itm.saditm_hs_cod || itm.saditm_hsprec_cod
                                       partida,
                                   ex.sad_exp_zip || ':' || ex.sad_exp_nam
                                       proveedor,
                                      itm.saditm_goods_desc1
                                   || itm.saditm_goods_desc2
                                   || itm.saditm_goods_desc3
                                       descrip,
                                   DECODE (spy1.sad_clr,
                                           0,
                                           'VERDE',
                                           1,
                                           'AZUL',
                                           2,
                                           'AMARILLO',
                                           3,
                                           'ROJO')
                                       canal,                             --16
                                   devuelve_ficha_inf (gen.sad_reg_year,
                                                       gen.key_cuo,
                                                       gen.sad_reg_nber)
                                       ficha
                            FROM   ops$asy.sad_gen gen,
                                   ops$asy.sad_itm itm,
                                   ops$asy.sad_occ_cns cns,
                                   ops$asy.uncmptab cmp,
                                   ops$asy.undectab de,
                                   ops$asy.unctytab cty,
                                   ops$asy.sad_occ_exp ex,
                                   ops$asy.sad_spy spy1
                           WHERE       gen.sad_flw = 1
                                   AND gen.sad_asmt_serial IS NOT NULL
                                   AND gen.lst_ope = 'U'
                                   AND gen.sad_num = '0'
                                   AND gen.key_year = itm.key_year
                                   AND gen.key_cuo = itm.key_cuo
                                   AND gen.key_dec = itm.key_dec
                                   AND gen.key_nber = itm.key_nber
                                   AND itm.sad_num = '0'
                                   AND gen.key_dec = de.dec_cod
                                   AND gen.key_year = cns.key_year(+)
                                   AND gen.key_cuo = cns.key_cuo(+)
                                   AND gen.key_dec = cns.key_dec(+)
                                   AND gen.key_nber = cns.key_nber(+)
                                   AND gen.sad_num = cns.sad_num(+)
                                   AND cns.sad_num(+) = '0'
                                   AND gen.key_year = ex.key_year(+)
                                   AND gen.key_cuo = ex.key_cuo(+)
                                   AND gen.key_dec = ex.key_dec(+)
                                   AND gen.key_nber = ex.key_nber(+)
                                   AND gen.sad_num = ex.sad_num(+)
                                   AND ex.sad_num(+) = '0'
                                   AND gen.key_year = spy1.key_year(+)
                                   AND gen.key_cuo = spy1.key_cuo(+)
                                   AND gen.key_dec = spy1.key_dec(+)
                                   AND gen.key_nber = spy1.key_nber(+)
                                   AND spy1.spy_sta(+) = '10'
                                   AND spy1.spy_act(+) = '24'
                                   AND itm.saditm_cty_origcod = cty.cty_cod
                                   AND cty.lst_ope = 'U'
                                   AND gen.sad_consignee = cmp.cmp_cod(+)
                                   AND cmp.lst_ope(+) = 'U'
                                   AND gen.key_dec IS NOT NULL
                                   AND gen.key_cuo = prm_aduana
                                   AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                    prm_fecini,
                                                                    'DD/MM/YYYY')
                                                            AND  TO_DATE (
                                                                     prm_fecfin,
                                                                     'DD/MM/YYYY')
                                   AND gen.key_dec LIKE prm_agencia
                                   AND (gen.sad_consignee LIKE prm_importador
                                        OR cns.sad_con_zip LIKE
                                              '%' || prm_importador || '%')
                                   AND itm.saditm_cty_origcod LIKE prm_origen
                        ORDER BY   2, 3, 4;
                END IF;
            END IF;

            res := 'CORRECTO';
        END IF;

        IF prm_tipo = 'DUE'
        THEN
            IF prm_aduana = '%'
            THEN
                OPEN ct FOR
                      SELECT   *
                        FROM   (SELECT   DISTINCT
                                            s.sad_reg_year
                                         || '/'
                                         || s.key_cuo
                                         || '/'
                                         || s.sad_reg_serial
                                         || '-'
                                         || s.sad_reg_nber
                                             tramite,
                                         s.key_year,
                                         s.key_cuo,
                                         s.sad_reg_nber,
                                         TO_CHAR (s.sad_reg_date, 'dd/mm/yyyy')
                                             fecha_registro,
                                         TO_CHAR (s.sad_asmt_date,
                                                  'dd/mm/yyyy')
                                             fecha_valid,
                                         s.sad_exporter || m.sad_exp_zip
                                             nro_doc,
                                         cmp1.cmp_nam || m.sad_exp_nam
                                             exportador,
                                         sad_dec.key_dec doc_dec,
                                         sad_dec.sad_dec_nam nombre_dec,
                                         pais.cty_dsc destino,
                                            itm.itm_nber
                                         || '-'
                                         || s.key_year
                                         || s.key_cuo
                                         || s.sad_reg_nber
                                             dui,
                                         existe_tramite (s.sad_reg_year,
                                                         s.key_cuo,
                                                         s.sad_reg_nber,
                                                         prm_tipo),
                                         itm.itm_nber,
                                         verifica_alcance_item (prm_tipo,
                                                                s.key_year,
                                                                s.key_cuo,
                                                                s.sad_reg_nber,
                                                                itm.itm_nber),
                                         itm.saditm_hs_cod
                                         || itm.saditm_hsprec_cod
                                             partida,
                                         '-' proveedor,
                                            itm.saditm_goods_desc1
                                         || itm.saditm_goods_desc2
                                         || itm.saditm_goods_desc3
                                             descrip,
                                         '-' canal,
                                         '-' ficha
                                  FROM   ops$asy.sad_itm itm,
                                         ops$asy.sad_gen s,
                                         ops$asy.sad_occ_exp m,
                                         ops$asy.uncmptab cmp1,
                                         ops$asy.sad_occ_dec sad_dec,
                                         ops$asy.unctytab pais
                                 WHERE       s.sad_num = 0
                                         AND s.lst_ope = 'U'
                                         AND s.sad_typ_dec = 'EX'
                                         --and s.sad_typ_proc = 1
                                         AND s.key_year = itm.key_year
                                         AND s.key_cuo = itm.key_cuo
                                         AND s.key_nber = itm.key_nber
                                         AND (s.key_dec IS NULL
                                              AND itm.key_dec IS NULL)
                                         AND s.sad_num = itm.sad_num
                                         AND s.sad_exporter = cmp1.cmp_cod(+)
                                         -- exp. no ocasionales
                                         AND cmp1.lst_ope(+) = 'U'
                                         AND s.key_year = m.key_year(+)
                                         -- exp. ocasionales
                                         AND s.key_cuo = m.key_cuo(+)
                                         AND (s.key_dec IS NULL
                                              AND m.key_dec(+) IS NULL)
                                         AND s.key_nber = m.key_nber(+)
                                         AND s.sad_num = m.sad_num(+)
                                         AND m.sad_num(+) = 0
                                         AND s.key_year = sad_dec.key_year(+)
                                         --para declarantes ocasionales
                                         AND s.key_cuo = sad_dec.key_cuo(+)
                                         AND s.key_dec IS NULL
                                         AND sad_dec.key_dec(+) IS NULL
                                         AND s.key_nber = sad_dec.key_nber(+)
                                         AND s.sad_num = sad_dec.sad_num(+)
                                         AND s.sad_cty_destcod = pais.cty_cod
                                         AND s.sad_reg_date BETWEEN TO_DATE (
                                                                        prm_fecini,
                                                                        'DD/MM/YYYY')
                                                                AND  TO_DATE (
                                                                         prm_fecfin,
                                                                         'DD/MM/YYYY')
                                         AND s.key_dec LIKE prm_agencia
                                         AND (s.sad_exporter LIKE
                                                  prm_importador
                                              OR m.sad_exp_zip LIKE
                                                       '%'
                                                    || prm_importador
                                                    || '%')
                                         AND s.sad_cty_destcod LIKE prm_origen
                                UNION
                                SELECT   DISTINCT
                                            s.sad_reg_year
                                         || '/'
                                         || s.key_cuo
                                         || '/'
                                         || s.sad_reg_serial
                                         || '-'
                                         || s.sad_reg_nber
                                             tramite,
                                         s.key_year,
                                         s.key_cuo,
                                         s.sad_reg_nber,
                                         TO_CHAR (s.sad_reg_date, 'dd/mm/yyyy')
                                             fecha_registro,
                                         TO_CHAR (s.sad_asmt_date,
                                                  'dd/mm/yyyy')
                                             fecha_valid,
                                         s.sad_exporter || m.sad_exp_zip
                                             nro_doc,
                                         cmp1.cmp_nam || m.sad_exp_nam
                                             exportador,
                                         dec.dec_cod doc_dec,
                                         dec.dec_nam nombre_dec,
                                         pais.cty_dsc destino,
                                            itm.itm_nber
                                         || '-'
                                         || s.key_year
                                         || s.key_cuo
                                         || s.sad_reg_nber
                                             dui,
                                         existe_tramite (s.sad_reg_year,
                                                         s.key_cuo,
                                                         s.sad_reg_nber,
                                                         prm_tipo),
                                         itm.itm_nber,
                                         verifica_alcance_item (prm_tipo,
                                                                s.key_year,
                                                                s.key_cuo,
                                                                s.sad_reg_nber,
                                                                itm.itm_nber),
                                         itm.saditm_hs_cod
                                         || itm.saditm_hsprec_cod
                                             partida,
                                         '-' proveedor,
                                            itm.saditm_goods_desc1
                                         || itm.saditm_goods_desc2
                                         || itm.saditm_goods_desc3
                                             descrip,
                                         '-' canal,
                                         '-' ficha
                                  FROM   ops$asy.sad_itm itm,
                                         ops$asy.sad_gen s,
                                         ops$asy.sad_occ_exp m,
                                         ops$asy.uncmptab cmp1,
                                         ops$asy.undectab dec,
                                         ops$asy.unctytab pais
                                 WHERE       s.sad_num = 0
                                         AND s.lst_ope = 'U'
                                         AND s.sad_typ_dec = 'EX'
                                         --AND s.sad_typ_proc = 1
                                         AND s.key_year = itm.key_year
                                         AND s.key_cuo = itm.key_cuo
                                         AND s.key_dec = itm.key_dec
                                         AND s.key_nber = itm.key_nber
                                         AND s.sad_num = itm.sad_num
                                         AND s.sad_exporter = cmp1.cmp_cod(+)
                                         -- exp. no ocasionales
                                         AND cmp1.lst_ope(+) = 'U'
                                         AND s.key_year = m.key_year(+)
                                         -- exp. ocasionales
                                         AND s.key_cuo = m.key_cuo(+)
                                         AND s.key_dec = m.key_dec(+)
                                         AND s.key_nber = m.key_nber(+)
                                         AND s.sad_num = m.sad_num(+)
                                         AND m.sad_num(+) = 0
                                         AND s.sad_cty_destcod = pais.cty_cod
                                         AND s.key_dec = dec.dec_cod(+)
                                         --para declarantes registrados
                                         AND dec.lst_ope = 'U'
                                         AND s.sad_reg_date BETWEEN TO_DATE (
                                                                        prm_fecini,
                                                                        'DD/MM/YYYY')
                                                                AND  TO_DATE (
                                                                         prm_fecfin,
                                                                         'DD/MM/YYYY')
                                         AND s.key_dec LIKE prm_agencia
                                         AND (s.sad_exporter LIKE
                                                  prm_importador
                                              OR m.sad_exp_zip LIKE
                                                       '%'
                                                    || prm_importador
                                                    || '%')
                                         AND s.sad_cty_destcod LIKE prm_origen)
                               tbl
                    ORDER BY   2, 3, 4;
            ELSE
                OPEN ct FOR
                      SELECT   *
                        FROM   (SELECT   DISTINCT
                                            s.sad_reg_year
                                         || '/'
                                         || s.key_cuo
                                         || '/'
                                         || s.sad_reg_serial
                                         || '-'
                                         || s.sad_reg_nber
                                             tramite,
                                         s.key_year,
                                         s.key_cuo,
                                         s.sad_reg_nber,
                                         TO_CHAR (s.sad_reg_date, 'dd/mm/yyyy')
                                             fecha_registro,
                                         TO_CHAR (s.sad_asmt_date,
                                                  'dd/mm/yyyy')
                                             fecha_valid,
                                         s.sad_exporter || m.sad_exp_zip
                                             nro_doc,
                                         cmp1.cmp_nam || m.sad_exp_nam
                                             exportador,
                                         sad_dec.key_dec doc_dec,
                                         sad_dec.sad_dec_nam nombre_dec,
                                         pais.cty_dsc destino,
                                            itm.itm_nber
                                         || '-'
                                         || s.key_year
                                         || s.key_cuo
                                         || s.sad_reg_nber
                                             dui,
                                         existe_tramite (s.sad_reg_year,
                                                         s.key_cuo,
                                                         s.sad_reg_nber,
                                                         prm_tipo),
                                         itm.itm_nber,
                                         verifica_alcance_item (prm_tipo,
                                                                s.key_year,
                                                                s.key_cuo,
                                                                s.sad_reg_nber,
                                                                itm.itm_nber),
                                         itm.saditm_hs_cod
                                         || itm.saditm_hsprec_cod
                                             partida,
                                         '-' proveedor,
                                            itm.saditm_goods_desc1
                                         || itm.saditm_goods_desc2
                                         || itm.saditm_goods_desc3
                                             descrip,
                                         '-' canal,
                                         '-' ficha
                                  FROM   ops$asy.sad_itm itm,
                                         ops$asy.sad_gen s,
                                         ops$asy.sad_occ_exp m,
                                         ops$asy.uncmptab cmp1,
                                         ops$asy.sad_occ_dec sad_dec,
                                         ops$asy.unctytab pais
                                 WHERE       s.sad_num = 0
                                         AND s.lst_ope = 'U'
                                         AND s.sad_typ_dec = 'EX'
                                         --and s.sad_typ_proc = 1
                                         AND s.key_year = itm.key_year
                                         AND s.key_cuo = itm.key_cuo
                                         AND s.key_nber = itm.key_nber
                                         AND (s.key_dec IS NULL
                                              AND itm.key_dec IS NULL)
                                         AND s.sad_num = itm.sad_num
                                         AND s.sad_exporter = cmp1.cmp_cod(+)
                                         -- exp. no ocasionales
                                         AND cmp1.lst_ope(+) = 'U'
                                         AND s.key_year = m.key_year(+)
                                         -- exp. ocasionales
                                         AND s.key_cuo = m.key_cuo(+)
                                         AND (s.key_dec IS NULL
                                              AND m.key_dec(+) IS NULL)
                                         AND s.key_nber = m.key_nber(+)
                                         AND s.sad_num = m.sad_num(+)
                                         AND m.sad_num(+) = 0
                                         AND s.key_year = sad_dec.key_year(+)
                                         --para declarantes ocasionales
                                         AND s.key_cuo = sad_dec.key_cuo(+)
                                         AND s.key_dec IS NULL
                                         AND sad_dec.key_dec(+) IS NULL
                                         AND s.key_nber = sad_dec.key_nber(+)
                                         AND s.sad_num = sad_dec.sad_num(+)
                                         AND s.sad_cty_destcod = pais.cty_cod
                                         AND s.sad_reg_date BETWEEN TO_DATE (
                                                                        prm_fecini,
                                                                        'DD/MM/YYYY')
                                                                AND  TO_DATE (
                                                                         prm_fecfin,
                                                                         'DD/MM/YYYY')
                                         AND s.key_dec LIKE prm_agencia
                                         AND s.key_cuo = prm_aduana
                                         AND (s.sad_exporter LIKE
                                                  prm_importador
                                              OR m.sad_exp_zip LIKE
                                                       '%'
                                                    || prm_importador
                                                    || '%')
                                         AND s.sad_cty_destcod LIKE prm_origen
                                UNION
                                SELECT   DISTINCT
                                            s.sad_reg_year
                                         || '/'
                                         || s.key_cuo
                                         || '/'
                                         || s.sad_reg_serial
                                         || '-'
                                         || s.sad_reg_nber
                                             tramite,
                                         s.key_year,
                                         s.key_cuo,
                                         s.sad_reg_nber,
                                         TO_CHAR (s.sad_reg_date, 'dd/mm/yyyy')
                                             fecha_registro,
                                         TO_CHAR (s.sad_asmt_date,
                                                  'dd/mm/yyyy')
                                             fecha_valid,
                                         s.sad_exporter || m.sad_exp_zip
                                             nro_doc,
                                         cmp1.cmp_nam || m.sad_exp_nam
                                             exportador,
                                         dec.dec_cod doc_dec,
                                         dec.dec_nam nombre_dec,
                                         pais.cty_dsc destino,
                                            itm.itm_nber
                                         || '-'
                                         || s.key_year
                                         || s.key_cuo
                                         || s.sad_reg_nber
                                             dui,
                                         existe_tramite (s.sad_reg_year,
                                                         s.key_cuo,
                                                         s.sad_reg_nber,
                                                         prm_tipo),
                                         itm.itm_nber,
                                         verifica_alcance_item (prm_tipo,
                                                                s.key_year,
                                                                s.key_cuo,
                                                                s.sad_reg_nber,
                                                                itm.itm_nber),
                                         itm.saditm_hs_cod
                                         || itm.saditm_hsprec_cod
                                             partida,
                                         '-' proveedor,
                                            itm.saditm_goods_desc1
                                         || itm.saditm_goods_desc2
                                         || itm.saditm_goods_desc3
                                             descrip,
                                         '-' canal,
                                         '-' ficha
                                  FROM   ops$asy.sad_itm itm,
                                         ops$asy.sad_gen s,
                                         ops$asy.sad_occ_exp m,
                                         ops$asy.uncmptab cmp1,
                                         ops$asy.undectab dec,
                                         ops$asy.unctytab pais
                                 WHERE       s.sad_num = 0
                                         AND s.lst_ope = 'U'
                                         AND s.sad_typ_dec = 'EX'
                                         --AND s.sad_typ_proc = 1
                                         AND s.key_year = itm.key_year
                                         AND s.key_cuo = itm.key_cuo
                                         AND s.key_dec = itm.key_dec
                                         AND s.key_nber = itm.key_nber
                                         AND s.sad_num = itm.sad_num
                                         AND s.sad_exporter = cmp1.cmp_cod(+)
                                         -- exp. no ocasionales
                                         AND cmp1.lst_ope(+) = 'U'
                                         AND s.key_year = m.key_year(+)
                                         -- exp. ocasionales
                                         AND s.key_cuo = m.key_cuo(+)
                                         AND s.key_dec = m.key_dec(+)
                                         AND s.key_nber = m.key_nber(+)
                                         AND s.sad_num = m.sad_num(+)
                                         AND m.sad_num(+) = 0
                                         AND s.sad_cty_destcod = pais.cty_cod
                                         AND s.key_dec = dec.dec_cod(+)
                                         --para declarantes registrados
                                         AND dec.lst_ope = 'U'
                                         AND s.sad_reg_date BETWEEN TO_DATE (
                                                                        prm_fecini,
                                                                        'DD/MM/YYYY')
                                                                AND  TO_DATE (
                                                                         prm_fecfin,
                                                                         'DD/MM/YYYY')
                                         AND s.key_dec LIKE prm_agencia
                                         AND s.key_cuo = prm_aduana
                                         AND (s.sad_exporter LIKE
                                                  prm_importador
                                              OR m.sad_exp_zip LIKE
                                                       '%'
                                                    || prm_importador
                                                    || '%')
                                         AND s.sad_cty_destcod LIKE prm_origen)
                               tbl
                    ORDER BY   2, 3, 4;
            END IF;

            res := 'CORRECTO';
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;


    FUNCTION devuelve_duis_item_ant (prm_fecini       IN     VARCHAR2,
                                     prm_fecfin       IN     VARCHAR2,
                                     prm_aduana       IN     VARCHAR2,
                                     prm_partida      IN     VARCHAR2,
                                     prm_agencia      IN     VARCHAR2,
                                     prm_importador   IN     VARCHAR2,
                                     prm_proveedor    IN     VARCHAR2,
                                     prm_origen       IN     VARCHAR2,
                                     prm_tipo         IN     VARCHAR2,
                                     prm_reg          IN     VARCHAR2,
                                     ct                  OUT cursortype)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (300) := 0;
    BEGIN
        IF prm_tipo = 'DUI'
        THEN
            IF prm_aduana = '%' AND NOT prm_reg = '%'
            THEN
                IF prm_partida = '%'
                THEN
                    OPEN ct FOR
                          SELECT   *
                            FROM   (SELECT   DISTINCT
                                                gen.key_year
                                             || '/'
                                             || gen.key_cuo
                                             || '/'
                                             || gen.sad_reg_serial
                                             || '-'
                                             || gen.sad_reg_nber
                                                 tramite,
                                             gen.key_year,
                                             gen.key_cuo,
                                             gen.sad_reg_nber,
                                             TO_CHAR (gen.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (gen.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_zip,
                                                     gen.sad_consignee)
                                                 nro_doc,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_nam,
                                                     cmp.cmp_nam)
                                                 importador,
                                             --5
                                             gen.key_dec doc_dec,
                                             de.dec_nam nombre_dec,
                                             cty.cty_dsc origen,
                                                itm.itm_nber
                                             || '-'
                                             || gen.key_year
                                             || gen.key_cuo
                                             || gen.sad_reg_nber
                                                 dui,
                                             existe_tramite (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber,
                                                 itm.itm_nber),
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                      FROM   ops$asy.sad_gen gen,
                                             ops$asy.sad_itm itm,
                                             ops$asy.sad_occ_cns cns,
                                             ops$asy.uncmptab cmp,
                                             ops$asy.undectab de,
                                             ops$asy.unctytab cty,
                                             ops$asy.uncuoreg reg
                                     WHERE   gen.sad_flw = 1
                                             AND gen.sad_asmt_serial IS NOT NULL
                                             AND gen.lst_ope = 'U'
                                             AND gen.sad_num = '0'
                                             AND gen.key_year = itm.key_year
                                             AND gen.key_cuo = itm.key_cuo
                                             AND gen.key_dec = itm.key_dec
                                             AND gen.key_nber = itm.key_nber
                                             AND itm.sad_num = '0'
                                             AND gen.key_dec = de.dec_cod
                                             AND gen.key_year = cns.key_year(+)
                                             AND gen.key_cuo = cns.key_cuo(+)
                                             AND gen.key_dec = cns.key_dec(+)
                                             AND gen.key_nber = cns.key_nber(+)
                                             AND gen.sad_num = cns.sad_num(+)
                                             AND cns.sad_num(+) = '0'
                                             AND itm.saditm_cty_origcod =
                                                    cty.cty_cod
                                             AND cty.lst_ope = 'U'
                                             AND gen.sad_consignee =
                                                    cmp.cmp_cod(+)
                                             AND cmp.lst_ope(+) = 'U'
                                             AND gen.key_dec IS NOT NULL
                                             AND gen.key_cuo = reg.cuo_cod
                                             AND reg.reg_cod = prm_reg
                                             AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                              prm_fecini,
                                                                              'DD/MM/YYYY')
                                                                      AND  TO_DATE (
                                                                               prm_fecfin,
                                                                               'DD/MM/YYYY')
                                             AND gen.key_dec LIKE prm_agencia
                                             AND (gen.sad_consignee LIKE
                                                      prm_importador
                                                  OR cns.sad_con_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND itm.saditm_cty_origcod LIKE
                                                    prm_origen
                                    UNION
                                    SELECT   DISTINCT
                                                gen.key_year
                                             || '/'
                                             || gen.key_cuo
                                             || '/'
                                             || gen.sad_reg_serial
                                             || '-'
                                             || gen.sad_reg_nber
                                                 tramite,
                                             gen.key_year,
                                             gen.key_cuo,
                                             gen.sad_reg_nber,
                                             TO_CHAR (gen.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (gen.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_zip,
                                                     gen.sad_consignee)
                                                 nro_doc,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_nam,
                                                     cmp.cmp_nam)
                                                 importador,
                                             gen.key_dec doc_dec,
                                             deo.sad_dec_nam nombre_dec,
                                             cty.cty_dsc origen,
                                                itm.itm_nber
                                             || '-'
                                             || gen.key_year
                                             || gen.key_cuo
                                             || gen.sad_reg_nber
                                                 dui,
                                             existe_tramite (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber,
                                                 itm.itm_nber),
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                      FROM   ops$asy.sad_gen gen,
                                             ops$asy.sad_itm itm,
                                             ops$asy.sad_occ_cns cns,
                                             ops$asy.uncmptab cmp,
                                             ops$asy.sad_occ_dec deo,
                                             ops$asy.unctytab cty,
                                             ops$asy.uncuoreg reg
                                     WHERE   gen.sad_flw = 1
                                             AND gen.sad_asmt_serial IS NOT NULL
                                             AND gen.lst_ope = 'U'
                                             AND gen.sad_num = '0'
                                             AND gen.key_year = itm.key_year
                                             AND gen.key_cuo = itm.key_cuo
                                             AND itm.key_dec IS NULL
                                             AND gen.key_nber = itm.key_nber
                                             AND itm.sad_num = '0'
                                             AND gen.key_year = deo.key_year
                                             AND gen.key_cuo = deo.key_cuo
                                             AND deo.key_dec IS NULL
                                             AND gen.key_nber = deo.key_nber
                                             AND gen.sad_num = deo.sad_num
                                             AND gen.key_year = cns.key_year(+)
                                             AND gen.key_cuo = cns.key_cuo(+)
                                             AND cns.key_dec(+) IS NULL
                                             AND gen.key_nber = cns.key_nber(+)
                                             AND gen.sad_num = cns.sad_num(+)
                                             AND cns.sad_num(+) = '0'
                                             AND itm.saditm_cty_origcod =
                                                    cty.cty_cod
                                             AND cty.lst_ope = 'U'
                                             AND gen.sad_consignee =
                                                    cmp.cmp_cod(+)
                                             AND cmp.lst_ope(+) = 'U'
                                             AND gen.key_dec IS NULL
                                             AND gen.key_cuo = reg.cuo_cod
                                             AND reg.reg_cod = prm_reg
                                             AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                              prm_fecini,
                                                                              'DD/MM/YYYY')
                                                                      AND  TO_DATE (
                                                                               prm_fecfin,
                                                                               'DD/MM/YYYY')
                                             AND gen.key_dec LIKE prm_agencia
                                             AND (gen.sad_consignee LIKE
                                                      prm_importador
                                                  OR cns.sad_con_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND itm.saditm_cty_origcod LIKE
                                                    prm_origen) tbl
                        ORDER BY   2, 3, 4;
                ELSE
                    OPEN ct FOR
                          SELECT   *
                            FROM   (SELECT   DISTINCT
                                                gen.key_year
                                             || '/'
                                             || gen.key_cuo
                                             || '/'
                                             || gen.sad_reg_serial
                                             || '-'
                                             || gen.sad_reg_nber
                                                 tramite,
                                             gen.key_year,
                                             gen.key_cuo,
                                             gen.sad_reg_nber,
                                             TO_CHAR (gen.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (gen.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_zip,
                                                     gen.sad_consignee)
                                                 nro_doc,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_nam,
                                                     cmp.cmp_nam)
                                                 importador,
                                             --5
                                             gen.key_dec doc_dec,
                                             de.dec_nam nombre_dec,
                                             cty.cty_dsc origen,
                                                itm.itm_nber
                                             || '-'
                                             || gen.key_year
                                             || gen.key_cuo
                                             || gen.sad_reg_nber
                                                 dui,
                                             existe_tramite (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber,
                                                 itm.itm_nber),
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                      FROM   ops$asy.sad_gen gen,
                                             ops$asy.sad_itm itm,
                                             ops$asy.sad_occ_cns cns,
                                             ops$asy.uncmptab cmp,
                                             ops$asy.undectab de,
                                             ops$asy.unctytab cty,
                                             ops$asy.uncuoreg reg
                                     WHERE   gen.sad_flw = 1
                                             AND gen.sad_asmt_serial IS NOT NULL
                                             AND gen.lst_ope = 'U'
                                             AND gen.sad_num = '0'
                                             AND gen.key_year = itm.key_year
                                             AND gen.key_cuo = itm.key_cuo
                                             AND gen.key_dec = itm.key_dec
                                             AND gen.key_nber = itm.key_nber
                                             AND itm.sad_num = '0'
                                             AND gen.key_dec = de.dec_cod
                                             AND gen.key_year = cns.key_year(+)
                                             AND gen.key_cuo = cns.key_cuo(+)
                                             AND gen.key_dec = cns.key_dec(+)
                                             AND gen.key_nber = cns.key_nber(+)
                                             AND gen.sad_num = cns.sad_num(+)
                                             AND cns.sad_num(+) = '0'
                                             AND itm.saditm_cty_origcod =
                                                    cty.cty_cod
                                             AND cty.lst_ope = 'U'
                                             AND gen.sad_consignee =
                                                    cmp.cmp_cod(+)
                                             AND cmp.lst_ope(+) = 'U'
                                             AND gen.key_dec IS NOT NULL
                                             AND gen.key_cuo = reg.cuo_cod
                                             AND reg.reg_cod = prm_reg
                                             AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                              prm_fecini,
                                                                              'DD/MM/YYYY')
                                                                      AND  TO_DATE (
                                                                               prm_fecfin,
                                                                               'DD/MM/YYYY')
                                             AND gen.key_dec LIKE prm_agencia
                                             AND (gen.sad_consignee LIKE
                                                      prm_importador
                                                  OR cns.sad_con_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND itm.saditm_cty_origcod LIKE
                                                    prm_origen
                                             AND itm.saditm_hs_cod
                                                || itm.saditm_hsprec_cod LIKE
                                                    prm_partida
                                    UNION
                                    SELECT   DISTINCT
                                                gen.key_year
                                             || '/'
                                             || gen.key_cuo
                                             || '/'
                                             || gen.sad_reg_serial
                                             || '-'
                                             || gen.sad_reg_nber
                                                 tramite,
                                             gen.key_year,
                                             gen.key_cuo,
                                             gen.sad_reg_nber,
                                             TO_CHAR (gen.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (gen.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_zip,
                                                     gen.sad_consignee)
                                                 nro_doc,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_nam,
                                                     cmp.cmp_nam)
                                                 importador,
                                             gen.key_dec doc_dec,
                                             deo.sad_dec_nam nombre_dec,
                                             cty.cty_dsc origen,
                                                itm.itm_nber
                                             || '-'
                                             || gen.key_year
                                             || gen.key_cuo
                                             || gen.sad_reg_nber
                                                 dui,
                                             existe_tramite (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber,
                                                 itm.itm_nber),
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                      FROM   ops$asy.sad_gen gen,
                                             ops$asy.sad_itm itm,
                                             ops$asy.sad_occ_cns cns,
                                             ops$asy.uncmptab cmp,
                                             ops$asy.sad_occ_dec deo,
                                             ops$asy.unctytab cty,
                                             ops$asy.uncuoreg reg
                                     WHERE   gen.sad_flw = 1
                                             AND gen.sad_asmt_serial IS NOT NULL
                                             AND gen.lst_ope = 'U'
                                             AND gen.sad_num = '0'
                                             AND gen.key_year = itm.key_year
                                             AND gen.key_cuo = itm.key_cuo
                                             AND itm.key_dec IS NULL
                                             AND gen.key_nber = itm.key_nber
                                             AND itm.sad_num = '0'
                                             AND gen.key_year = deo.key_year
                                             AND gen.key_cuo = deo.key_cuo
                                             AND deo.key_dec IS NULL
                                             AND gen.key_nber = deo.key_nber
                                             AND gen.sad_num = deo.sad_num
                                             AND gen.key_year = cns.key_year(+)
                                             AND gen.key_cuo = cns.key_cuo(+)
                                             AND cns.key_dec(+) IS NULL
                                             AND gen.key_nber = cns.key_nber(+)
                                             AND gen.sad_num = cns.sad_num(+)
                                             AND cns.sad_num(+) = '0'
                                             AND itm.saditm_cty_origcod =
                                                    cty.cty_cod
                                             AND cty.lst_ope = 'U'
                                             AND gen.sad_consignee =
                                                    cmp.cmp_cod(+)
                                             AND cmp.lst_ope(+) = 'U'
                                             AND gen.key_dec IS NULL
                                             AND gen.key_cuo = reg.cuo_cod
                                             AND reg.reg_cod = prm_reg
                                             AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                              prm_fecini,
                                                                              'DD/MM/YYYY')
                                                                      AND  TO_DATE (
                                                                               prm_fecfin,
                                                                               'DD/MM/YYYY')
                                             AND gen.key_dec LIKE prm_agencia
                                             AND (gen.sad_consignee LIKE
                                                      prm_importador
                                                  OR cns.sad_con_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND itm.saditm_cty_origcod LIKE
                                                    prm_origen
                                             AND itm.saditm_hs_cod
                                                || itm.saditm_hsprec_cod LIKE
                                                    prm_partida) tbl
                        ORDER BY   2, 3, 4;
                END IF;
            ELSE
                IF prm_partida = '%'
                THEN
                    OPEN ct FOR
                          SELECT   *
                            FROM   (SELECT   DISTINCT
                                                gen.key_year
                                             || '/'
                                             || gen.key_cuo
                                             || '/'
                                             || gen.sad_reg_serial
                                             || '-'
                                             || gen.sad_reg_nber
                                                 tramite,
                                             gen.key_year,
                                             gen.key_cuo,
                                             gen.sad_reg_nber,
                                             TO_CHAR (gen.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (gen.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_zip,
                                                     gen.sad_consignee)
                                                 nro_doc,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_nam,
                                                     cmp.cmp_nam)
                                                 importador,
                                             --5
                                             gen.key_dec doc_dec,
                                             de.dec_nam nombre_dec,
                                             cty.cty_dsc origen,
                                                itm.itm_nber
                                             || '-'
                                             || gen.key_year
                                             || gen.key_cuo
                                             || gen.sad_reg_nber
                                                 dui,
                                             existe_tramite (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber,
                                                 itm.itm_nber),
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                      FROM   ops$asy.sad_gen gen,
                                             ops$asy.sad_itm itm,
                                             ops$asy.sad_occ_cns cns,
                                             ops$asy.uncmptab cmp,
                                             ops$asy.undectab de,
                                             ops$asy.unctytab cty
                                     WHERE   gen.sad_flw = 1
                                             AND gen.sad_asmt_serial IS NOT NULL
                                             AND gen.lst_ope = 'U'
                                             AND gen.sad_num = '0'
                                             AND gen.key_year = itm.key_year
                                             AND gen.key_cuo = itm.key_cuo
                                             AND gen.key_dec = itm.key_dec
                                             AND gen.key_nber = itm.key_nber
                                             AND itm.sad_num = '0'
                                             AND gen.key_dec = de.dec_cod
                                             AND gen.key_year = cns.key_year(+)
                                             AND gen.key_cuo = cns.key_cuo(+)
                                             AND gen.key_dec = cns.key_dec(+)
                                             AND gen.key_nber = cns.key_nber(+)
                                             AND gen.sad_num = cns.sad_num(+)
                                             AND cns.sad_num(+) = '0'
                                             AND itm.saditm_cty_origcod =
                                                    cty.cty_cod
                                             AND cty.lst_ope = 'U'
                                             AND gen.sad_consignee =
                                                    cmp.cmp_cod(+)
                                             AND cmp.lst_ope(+) = 'U'
                                             AND gen.key_dec IS NOT NULL
                                             AND gen.key_cuo LIKE prm_aduana
                                             AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                              prm_fecini,
                                                                              'DD/MM/YYYY')
                                                                      AND  TO_DATE (
                                                                               prm_fecfin,
                                                                               'DD/MM/YYYY')
                                             AND gen.key_dec LIKE prm_agencia
                                             AND (gen.sad_consignee LIKE
                                                      prm_importador
                                                  OR cns.sad_con_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND itm.saditm_cty_origcod LIKE
                                                    prm_origen
                                    UNION
                                    SELECT   DISTINCT
                                                gen.key_year
                                             || '/'
                                             || gen.key_cuo
                                             || '/'
                                             || gen.sad_reg_serial
                                             || '-'
                                             || gen.sad_reg_nber
                                                 tramite,
                                             gen.key_year,
                                             gen.key_cuo,
                                             gen.sad_reg_nber,
                                             TO_CHAR (gen.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (gen.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_zip,
                                                     gen.sad_consignee)
                                                 nro_doc,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_nam,
                                                     cmp.cmp_nam)
                                                 importador,
                                             gen.key_dec doc_dec,
                                             deo.sad_dec_nam nombre_dec,
                                             cty.cty_dsc origen,
                                                itm.itm_nber
                                             || '-'
                                             || gen.key_year
                                             || gen.key_cuo
                                             || gen.sad_reg_nber
                                                 dui,
                                             existe_tramite (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber,
                                                 itm.itm_nber),
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                      FROM   ops$asy.sad_gen gen,
                                             ops$asy.sad_itm itm,
                                             ops$asy.sad_occ_cns cns,
                                             ops$asy.uncmptab cmp,
                                             ops$asy.sad_occ_dec deo,
                                             ops$asy.unctytab cty
                                     WHERE   gen.sad_flw = 1
                                             AND gen.sad_asmt_serial IS NOT NULL
                                             AND gen.lst_ope = 'U'
                                             AND gen.sad_num = '0'
                                             AND gen.key_year = itm.key_year
                                             AND gen.key_cuo = itm.key_cuo
                                             AND itm.key_dec IS NULL
                                             AND gen.key_nber = itm.key_nber
                                             AND itm.sad_num = '0'
                                             AND gen.key_year = deo.key_year
                                             AND gen.key_cuo = deo.key_cuo
                                             AND deo.key_dec IS NULL
                                             AND gen.key_nber = deo.key_nber
                                             AND gen.sad_num = deo.sad_num
                                             AND gen.key_year = cns.key_year(+)
                                             AND gen.key_cuo = cns.key_cuo(+)
                                             AND cns.key_dec(+) IS NULL
                                             AND gen.key_nber = cns.key_nber(+)
                                             AND gen.sad_num = cns.sad_num(+)
                                             AND cns.sad_num(+) = '0'
                                             AND itm.saditm_cty_origcod =
                                                    cty.cty_cod
                                             AND cty.lst_ope = 'U'
                                             AND gen.sad_consignee =
                                                    cmp.cmp_cod(+)
                                             AND cmp.lst_ope(+) = 'U'
                                             AND gen.key_dec IS NULL
                                             AND gen.key_cuo LIKE prm_aduana
                                             AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                              prm_fecini,
                                                                              'DD/MM/YYYY')
                                                                      AND  TO_DATE (
                                                                               prm_fecfin,
                                                                               'DD/MM/YYYY')
                                             AND gen.key_dec LIKE prm_agencia
                                             AND (gen.sad_consignee LIKE
                                                      prm_importador
                                                  OR cns.sad_con_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND itm.saditm_cty_origcod LIKE
                                                    prm_origen) tbl
                        ORDER BY   2, 3, 4;
                ELSE
                    OPEN ct FOR
                          SELECT   *
                            FROM   (SELECT   DISTINCT
                                                gen.key_year
                                             || '/'
                                             || gen.key_cuo
                                             || '/'
                                             || gen.sad_reg_serial
                                             || '-'
                                             || gen.sad_reg_nber
                                                 tramite,
                                             gen.key_year,
                                             gen.key_cuo,
                                             gen.sad_reg_nber,
                                             TO_CHAR (gen.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (gen.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_zip,
                                                     gen.sad_consignee)
                                                 nro_doc,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_nam,
                                                     cmp.cmp_nam)
                                                 importador,
                                             --5
                                             gen.key_dec doc_dec,
                                             de.dec_nam nombre_dec,
                                             cty.cty_dsc origen,
                                                itm.itm_nber
                                             || '-'
                                             || gen.key_year
                                             || gen.key_cuo
                                             || gen.sad_reg_nber
                                                 dui,
                                             existe_tramite (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber,
                                                 itm.itm_nber),
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                      FROM   ops$asy.sad_gen gen,
                                             ops$asy.sad_itm itm,
                                             ops$asy.sad_occ_cns cns,
                                             ops$asy.uncmptab cmp,
                                             ops$asy.undectab de,
                                             ops$asy.unctytab cty
                                     WHERE   gen.sad_flw = 1
                                             AND gen.sad_asmt_serial IS NOT NULL
                                             AND gen.lst_ope = 'U'
                                             AND gen.sad_num = '0'
                                             AND gen.key_year = itm.key_year
                                             AND gen.key_cuo = itm.key_cuo
                                             AND gen.key_dec = itm.key_dec
                                             AND gen.key_nber = itm.key_nber
                                             AND itm.sad_num = '0'
                                             AND gen.key_dec = de.dec_cod
                                             AND gen.key_year = cns.key_year(+)
                                             AND gen.key_cuo = cns.key_cuo(+)
                                             AND gen.key_dec = cns.key_dec(+)
                                             AND gen.key_nber = cns.key_nber(+)
                                             AND gen.sad_num = cns.sad_num(+)
                                             AND cns.sad_num(+) = '0'
                                             AND itm.saditm_cty_origcod =
                                                    cty.cty_cod
                                             AND cty.lst_ope = 'U'
                                             AND gen.sad_consignee =
                                                    cmp.cmp_cod(+)
                                             AND cmp.lst_ope(+) = 'U'
                                             AND gen.key_dec IS NOT NULL
                                             AND gen.key_cuo LIKE prm_aduana
                                             AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                              prm_fecini,
                                                                              'DD/MM/YYYY')
                                                                      AND  TO_DATE (
                                                                               prm_fecfin,
                                                                               'DD/MM/YYYY')
                                             AND gen.key_dec LIKE prm_agencia
                                             AND (gen.sad_consignee LIKE
                                                      prm_importador
                                                  OR cns.sad_con_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND itm.saditm_cty_origcod LIKE
                                                    prm_origen
                                             AND itm.saditm_hs_cod
                                                || itm.saditm_hsprec_cod LIKE
                                                    prm_partida
                                    UNION
                                    SELECT   DISTINCT
                                                gen.key_year
                                             || '/'
                                             || gen.key_cuo
                                             || '/'
                                             || gen.sad_reg_serial
                                             || '-'
                                             || gen.sad_reg_nber
                                                 tramite,
                                             gen.key_year,
                                             gen.key_cuo,
                                             gen.sad_reg_nber,
                                             TO_CHAR (gen.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (gen.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_zip,
                                                     gen.sad_consignee)
                                                 nro_doc,
                                             DECODE (gen.sad_consignee,
                                                     NULL, cns.sad_con_nam,
                                                     cmp.cmp_nam)
                                                 importador,
                                             gen.key_dec doc_dec,
                                             deo.sad_dec_nam nombre_dec,
                                             cty.cty_dsc origen,
                                                itm.itm_nber
                                             || '-'
                                             || gen.key_year
                                             || gen.key_cuo
                                             || gen.sad_reg_nber
                                                 dui,
                                             existe_tramite (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber,
                                                 itm.itm_nber),
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                      FROM   ops$asy.sad_gen gen,
                                             ops$asy.sad_itm itm,
                                             ops$asy.sad_occ_cns cns,
                                             ops$asy.uncmptab cmp,
                                             ops$asy.sad_occ_dec deo,
                                             ops$asy.unctytab cty
                                     WHERE   gen.sad_flw = 1
                                             AND gen.sad_asmt_serial IS NOT NULL
                                             AND gen.lst_ope = 'U'
                                             AND gen.sad_num = '0'
                                             AND gen.key_year = itm.key_year
                                             AND gen.key_cuo = itm.key_cuo
                                             AND itm.key_dec IS NULL
                                             AND gen.key_nber = itm.key_nber
                                             AND itm.sad_num = '0'
                                             AND gen.key_year = deo.key_year
                                             AND gen.key_cuo = deo.key_cuo
                                             AND deo.key_dec IS NULL
                                             AND gen.key_nber = deo.key_nber
                                             AND gen.sad_num = deo.sad_num
                                             AND gen.key_year = cns.key_year(+)
                                             AND gen.key_cuo = cns.key_cuo(+)
                                             AND cns.key_dec(+) IS NULL
                                             AND gen.key_nber = cns.key_nber(+)
                                             AND gen.sad_num = cns.sad_num(+)
                                             AND cns.sad_num(+) = '0'
                                             AND itm.saditm_cty_origcod =
                                                    cty.cty_cod
                                             AND cty.lst_ope = 'U'
                                             AND gen.sad_consignee =
                                                    cmp.cmp_cod(+)
                                             AND cmp.lst_ope(+) = 'U'
                                             AND gen.key_dec IS NULL
                                             AND gen.key_cuo LIKE prm_aduana
                                             AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                              prm_fecini,
                                                                              'DD/MM/YYYY')
                                                                      AND  TO_DATE (
                                                                               prm_fecfin,
                                                                               'DD/MM/YYYY')
                                             AND gen.key_dec LIKE prm_agencia
                                             AND (gen.sad_consignee LIKE
                                                      prm_importador
                                                  OR cns.sad_con_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND itm.saditm_cty_origcod LIKE
                                                    prm_origen
                                             AND itm.saditm_hs_cod
                                                || itm.saditm_hsprec_cod LIKE
                                                    prm_partida) tbl
                        ORDER BY   2, 3, 4;
                END IF;
            END IF;

            res := 'CORRECTO';
        END IF;


        IF prm_tipo = 'DUE'
        THEN
            IF prm_aduana = '%' AND NOT prm_reg = '%'
            THEN
                IF prm_partida = '%'
                THEN
                    OPEN ct FOR
                          SELECT   *
                            FROM   (SELECT   DISTINCT
                                                s.sad_reg_year
                                             || '/'
                                             || s.key_cuo
                                             || '/'
                                             || s.sad_reg_serial
                                             || '-'
                                             || s.sad_reg_nber
                                                 tramite,
                                             s.key_year,
                                             s.key_cuo,
                                             s.sad_reg_nber,
                                             TO_CHAR (s.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (s.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             s.sad_exporter || m.sad_exp_zip
                                                 nro_doc,
                                             cmp1.cmp_nam || m.sad_exp_nam
                                                 exportador,
                                             sad_dec.key_dec doc_dec,
                                             sad_dec.sad_dec_nam nombre_dec,
                                             pais.cty_dsc destino,
                                                itm.itm_nber
                                             || '-'
                                             || s.key_year
                                             || s.key_cuo
                                             || s.sad_reg_nber
                                                 dui,
                                             existe_tramite (s.sad_reg_year,
                                                             s.key_cuo,
                                                             s.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 s.sad_reg_year,
                                                 s.key_cuo,
                                                 s.sad_reg_nber,
                                                 itm.itm_nber),
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                      FROM   ops$asy.sad_itm itm,
                                             ops$asy.sad_gen s,
                                             ops$asy.sad_occ_exp m,
                                             ops$asy.uncmptab cmp1,
                                             ops$asy.sad_occ_dec sad_dec,
                                             ops$asy.unctytab pais,
                                             ops$asy.uncuoreg reg
                                     WHERE       s.sad_num = 0
                                             AND s.lst_ope = 'U'
                                             AND s.sad_typ_dec = 'EX'
                                             --and s.sad_typ_proc = 1
                                             AND s.key_year = itm.key_year
                                             AND s.key_cuo = itm.key_cuo
                                             AND s.key_nber = itm.key_nber
                                             AND (s.key_dec IS NULL
                                                  AND itm.key_dec IS NULL)
                                             AND s.sad_num = itm.sad_num
                                             AND s.sad_exporter =
                                                    cmp1.cmp_cod(+)
                                             -- exp. no ocasionales
                                             AND cmp1.lst_ope(+) = 'U'
                                             AND s.key_year = m.key_year(+)
                                             -- exp. ocasionales
                                             AND s.key_cuo = m.key_cuo(+)
                                             AND (s.key_dec IS NULL
                                                  AND m.key_dec(+) IS NULL)
                                             AND s.key_nber = m.key_nber(+)
                                             AND s.sad_num = m.sad_num(+)
                                             AND m.sad_num(+) = 0
                                             AND s.key_year =
                                                    sad_dec.key_year(+)
                                             --para declarantes ocasionales
                                             AND s.key_cuo = sad_dec.key_cuo(+)
                                             AND s.key_dec IS NULL
                                             AND sad_dec.key_dec(+) IS NULL
                                             AND s.key_nber =
                                                    sad_dec.key_nber(+)
                                             AND s.sad_num = sad_dec.sad_num(+)
                                             AND s.sad_cty_destcod =
                                                    pais.cty_cod
                                             AND s.sad_reg_date BETWEEN TO_DATE (
                                                                            prm_fecini,
                                                                            'DD/MM/YYYY')
                                                                    AND  TO_DATE (
                                                                             prm_fecfin,
                                                                             'DD/MM/YYYY')
                                             AND s.key_dec LIKE prm_agencia
                                             AND s.key_cuo = reg.cuo_cod
                                             AND reg.reg_cod = prm_reg
                                             AND (s.sad_exporter LIKE
                                                      prm_importador
                                                  OR m.sad_exp_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND s.sad_cty_destcod LIKE
                                                    prm_origen
                                    UNION
                                    SELECT   DISTINCT
                                                s.sad_reg_year
                                             || '/'
                                             || s.key_cuo
                                             || '/'
                                             || s.sad_reg_serial
                                             || '-'
                                             || s.sad_reg_nber
                                                 tramite,
                                             s.key_year,
                                             s.key_cuo,
                                             s.sad_reg_nber,
                                             TO_CHAR (s.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (s.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             s.sad_exporter || m.sad_exp_zip
                                                 nro_doc,
                                             cmp1.cmp_nam || m.sad_exp_nam
                                                 exportador,
                                             dec.dec_cod doc_dec,
                                             dec.dec_nam nombre_dec,
                                             pais.cty_dsc destino,
                                                itm.itm_nber
                                             || '-'
                                             || s.key_year
                                             || s.key_cuo
                                             || s.sad_reg_nber
                                                 dui,
                                             existe_tramite (s.sad_reg_year,
                                                             s.key_cuo,
                                                             s.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 s.sad_reg_year,
                                                 s.key_cuo,
                                                 s.sad_reg_nber,
                                                 itm.itm_nber),
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                      FROM   ops$asy.sad_itm itm,
                                             ops$asy.sad_gen s,
                                             ops$asy.sad_occ_exp m,
                                             ops$asy.uncmptab cmp1,
                                             ops$asy.undectab dec,
                                             ops$asy.unctytab pais,
                                             ops$asy.uncuoreg reg
                                     WHERE       s.sad_num = 0
                                             AND s.lst_ope = 'U'
                                             AND s.sad_typ_dec = 'EX'
                                             --AND s.sad_typ_proc = 1
                                             AND s.key_year = itm.key_year
                                             AND s.key_cuo = itm.key_cuo
                                             AND s.key_dec = itm.key_dec
                                             AND s.key_nber = itm.key_nber
                                             AND s.sad_num = itm.sad_num
                                             AND s.sad_exporter =
                                                    cmp1.cmp_cod(+)
                                             -- exp. no ocasionales
                                             AND cmp1.lst_ope(+) = 'U'
                                             AND s.key_year = m.key_year(+)
                                             -- exp. ocasionales
                                             AND s.key_cuo = m.key_cuo(+)
                                             AND s.key_dec = m.key_dec(+)
                                             AND s.key_nber = m.key_nber(+)
                                             AND s.sad_num = m.sad_num(+)
                                             AND m.sad_num(+) = 0
                                             AND s.sad_cty_destcod =
                                                    pais.cty_cod
                                             AND s.key_dec = dec.dec_cod(+)
                                             --para declarantes registrados
                                             AND dec.lst_ope = 'U'
                                             AND s.sad_reg_date BETWEEN TO_DATE (
                                                                            prm_fecini,
                                                                            'DD/MM/YYYY')
                                                                    AND  TO_DATE (
                                                                             prm_fecfin,
                                                                             'DD/MM/YYYY')
                                             AND s.key_dec LIKE prm_agencia
                                             AND s.key_cuo = reg.cuo_cod
                                             AND reg.reg_cod = prm_reg
                                             AND (s.sad_exporter LIKE
                                                      prm_importador
                                                  OR m.sad_exp_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND s.sad_cty_destcod LIKE
                                                    prm_origen) tbl
                        ORDER BY   2, 3, 4;
                ELSE
                    OPEN ct FOR
                          SELECT   *
                            FROM   (SELECT   DISTINCT
                                                s.sad_reg_year
                                             || '/'
                                             || s.key_cuo
                                             || '/'
                                             || s.sad_reg_serial
                                             || '-'
                                             || s.sad_reg_nber
                                                 tramite,
                                             s.key_year,
                                             s.key_cuo,
                                             s.sad_reg_nber,
                                             TO_CHAR (s.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (s.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             s.sad_exporter || m.sad_exp_zip
                                                 nro_doc,
                                             cmp1.cmp_nam || m.sad_exp_nam
                                                 exportador,
                                             sad_dec.key_dec doc_dec,
                                             sad_dec.sad_dec_nam nombre_dec,
                                             pais.cty_dsc destino,
                                                itm.itm_nber
                                             || '-'
                                             || s.key_year
                                             || s.key_cuo
                                             || s.sad_reg_nber
                                                 dui,
                                             existe_tramite (s.sad_reg_year,
                                                             s.key_cuo,
                                                             s.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 s.sad_reg_year,
                                                 s.key_cuo,
                                                 s.sad_reg_nber,
                                                 itm.itm_nber),
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                      FROM   ops$asy.sad_itm itm,
                                             ops$asy.sad_gen s,
                                             ops$asy.sad_occ_exp m,
                                             ops$asy.uncmptab cmp1,
                                             ops$asy.sad_occ_dec sad_dec,
                                             ops$asy.unctytab pais,
                                             ops$asy.uncuoreg reg
                                     WHERE       s.sad_num = 0
                                             AND s.lst_ope = 'U'
                                             AND s.sad_typ_dec = 'EX'
                                             --and s.sad_typ_proc = 1
                                             AND s.key_year = itm.key_year
                                             AND s.key_cuo = itm.key_cuo
                                             AND s.key_nber = itm.key_nber
                                             AND (s.key_dec IS NULL
                                                  AND itm.key_dec IS NULL)
                                             AND s.sad_num = itm.sad_num
                                             AND s.sad_exporter =
                                                    cmp1.cmp_cod(+)
                                             -- exp. no ocasionales
                                             AND cmp1.lst_ope(+) = 'U'
                                             AND s.key_year = m.key_year(+)
                                             -- exp. ocasionales
                                             AND s.key_cuo = m.key_cuo(+)
                                             AND (s.key_dec IS NULL
                                                  AND m.key_dec(+) IS NULL)
                                             AND s.key_nber = m.key_nber(+)
                                             AND s.sad_num = m.sad_num(+)
                                             AND m.sad_num(+) = 0
                                             AND s.key_year =
                                                    sad_dec.key_year(+)
                                             --para declarantes ocasionales
                                             AND s.key_cuo = sad_dec.key_cuo(+)
                                             AND s.key_dec IS NULL
                                             AND sad_dec.key_dec(+) IS NULL
                                             AND s.key_nber =
                                                    sad_dec.key_nber(+)
                                             AND s.sad_num = sad_dec.sad_num(+)
                                             AND s.sad_cty_destcod =
                                                    pais.cty_cod
                                             AND s.sad_reg_date BETWEEN TO_DATE (
                                                                            prm_fecini,
                                                                            'DD/MM/YYYY')
                                                                    AND  TO_DATE (
                                                                             prm_fecfin,
                                                                             'DD/MM/YYYY')
                                             AND s.key_dec LIKE prm_agencia
                                             AND s.key_cuo = reg.cuo_cod
                                             AND reg.reg_cod = prm_reg
                                             AND (s.sad_exporter LIKE
                                                      prm_importador
                                                  OR m.sad_exp_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND s.sad_cty_destcod LIKE
                                                    prm_origen
                                             AND itm.saditm_hs_cod
                                                || itm.saditm_hsprec_cod LIKE
                                                    prm_partida
                                    UNION
                                    SELECT   DISTINCT
                                                s.sad_reg_year
                                             || '/'
                                             || s.key_cuo
                                             || '/'
                                             || s.sad_reg_serial
                                             || '-'
                                             || s.sad_reg_nber
                                                 tramite,
                                             s.key_year,
                                             s.key_cuo,
                                             s.sad_reg_nber,
                                             TO_CHAR (s.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (s.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             s.sad_exporter || m.sad_exp_zip
                                                 nro_doc,
                                             cmp1.cmp_nam || m.sad_exp_nam
                                                 exportador,
                                             dec.dec_cod doc_dec,
                                             dec.dec_nam nombre_dec,
                                             pais.cty_dsc destino,
                                                itm.itm_nber
                                             || '-'
                                             || s.key_year
                                             || s.key_cuo
                                             || s.sad_reg_nber
                                                 dui,
                                             existe_tramite (s.sad_reg_year,
                                                             s.key_cuo,
                                                             s.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 s.sad_reg_year,
                                                 s.key_cuo,
                                                 s.sad_reg_nber,
                                                 itm.itm_nber),
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                      FROM   ops$asy.sad_itm itm,
                                             ops$asy.sad_gen s,
                                             ops$asy.sad_occ_exp m,
                                             ops$asy.uncmptab cmp1,
                                             ops$asy.undectab dec,
                                             ops$asy.unctytab pais,
                                             ops$asy.uncuoreg reg
                                     WHERE       s.sad_num = 0
                                             AND s.lst_ope = 'U'
                                             AND s.sad_typ_dec = 'EX'
                                             --AND s.sad_typ_proc = 1
                                             AND s.key_year = itm.key_year
                                             AND s.key_cuo = itm.key_cuo
                                             AND s.key_dec = itm.key_dec
                                             AND s.key_nber = itm.key_nber
                                             AND s.sad_num = itm.sad_num
                                             AND s.sad_exporter =
                                                    cmp1.cmp_cod(+)
                                             -- exp. no ocasionales
                                             AND cmp1.lst_ope(+) = 'U'
                                             AND s.key_year = m.key_year(+)
                                             -- exp. ocasionales
                                             AND s.key_cuo = m.key_cuo(+)
                                             AND s.key_dec = m.key_dec(+)
                                             AND s.key_nber = m.key_nber(+)
                                             AND s.sad_num = m.sad_num(+)
                                             AND m.sad_num(+) = 0
                                             AND s.sad_cty_destcod =
                                                    pais.cty_cod
                                             AND s.key_dec = dec.dec_cod(+)
                                             --para declarantes registrados
                                             AND dec.lst_ope = 'U'
                                             AND s.sad_reg_date BETWEEN TO_DATE (
                                                                            prm_fecini,
                                                                            'DD/MM/YYYY')
                                                                    AND  TO_DATE (
                                                                             prm_fecfin,
                                                                             'DD/MM/YYYY')
                                             AND s.key_dec LIKE prm_agencia
                                             AND s.key_cuo = reg.cuo_cod
                                             AND reg.reg_cod = prm_reg
                                             AND (s.sad_exporter LIKE
                                                      prm_importador
                                                  OR m.sad_exp_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND s.sad_cty_destcod LIKE
                                                    prm_origen
                                             AND itm.saditm_hs_cod
                                                || itm.saditm_hsprec_cod LIKE
                                                    prm_partida) tbl
                        ORDER BY   2, 3, 4;
                END IF;
            ELSE
                IF prm_partida = '%'
                THEN
                    OPEN ct FOR
                          SELECT   *
                            FROM   (SELECT   DISTINCT
                                                s.sad_reg_year
                                             || '/'
                                             || s.key_cuo
                                             || '/'
                                             || s.sad_reg_serial
                                             || '-'
                                             || s.sad_reg_nber
                                                 tramite,
                                             s.key_year,
                                             s.key_cuo,
                                             s.sad_reg_nber,
                                             TO_CHAR (s.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (s.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             s.sad_exporter || m.sad_exp_zip
                                                 nro_doc,
                                             cmp1.cmp_nam || m.sad_exp_nam
                                                 exportador,
                                             sad_dec.key_dec doc_dec,
                                             sad_dec.sad_dec_nam nombre_dec,
                                             pais.cty_dsc destino,
                                                itm.itm_nber
                                             || '-'
                                             || s.key_year
                                             || s.key_cuo
                                             || s.sad_reg_nber
                                                 dui,
                                             existe_tramite (s.sad_reg_year,
                                                             s.key_cuo,
                                                             s.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 s.sad_reg_year,
                                                 s.key_cuo,
                                                 s.sad_reg_nber,
                                                 itm.itm_nber),
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                      FROM   ops$asy.sad_itm itm,
                                             ops$asy.sad_gen s,
                                             ops$asy.sad_occ_exp m,
                                             ops$asy.uncmptab cmp1,
                                             ops$asy.sad_occ_dec sad_dec,
                                             ops$asy.unctytab pais
                                     WHERE       s.sad_num = 0
                                             AND s.lst_ope = 'U'
                                             AND s.sad_typ_dec = 'EX'
                                             --and s.sad_typ_proc = 1
                                             AND s.key_year = itm.key_year
                                             AND s.key_cuo = itm.key_cuo
                                             AND s.key_nber = itm.key_nber
                                             AND (s.key_dec IS NULL
                                                  AND itm.key_dec IS NULL)
                                             AND s.sad_num = itm.sad_num
                                             AND s.sad_exporter =
                                                    cmp1.cmp_cod(+)
                                             -- exp. no ocasionales
                                             AND cmp1.lst_ope(+) = 'U'
                                             AND s.key_year = m.key_year(+)
                                             -- exp. ocasionales
                                             AND s.key_cuo = m.key_cuo(+)
                                             AND (s.key_dec IS NULL
                                                  AND m.key_dec(+) IS NULL)
                                             AND s.key_nber = m.key_nber(+)
                                             AND s.sad_num = m.sad_num(+)
                                             AND m.sad_num(+) = 0
                                             AND s.key_year =
                                                    sad_dec.key_year(+)
                                             --para declarantes ocasionales
                                             AND s.key_cuo = sad_dec.key_cuo(+)
                                             AND s.key_dec IS NULL
                                             AND sad_dec.key_dec(+) IS NULL
                                             AND s.key_nber =
                                                    sad_dec.key_nber(+)
                                             AND s.sad_num = sad_dec.sad_num(+)
                                             AND s.sad_cty_destcod =
                                                    pais.cty_cod
                                             AND s.sad_reg_date BETWEEN TO_DATE (
                                                                            prm_fecini,
                                                                            'DD/MM/YYYY')
                                                                    AND  TO_DATE (
                                                                             prm_fecfin,
                                                                             'DD/MM/YYYY')
                                             AND s.key_dec LIKE prm_agencia
                                             AND (s.sad_exporter LIKE
                                                      prm_importador
                                                  OR m.sad_exp_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND s.sad_cty_destcod LIKE
                                                    prm_origen
                                    UNION
                                    SELECT   DISTINCT
                                                s.sad_reg_year
                                             || '/'
                                             || s.key_cuo
                                             || '/'
                                             || s.sad_reg_serial
                                             || '-'
                                             || s.sad_reg_nber
                                                 tramite,
                                             s.key_year,
                                             s.key_cuo,
                                             s.sad_reg_nber,
                                             TO_CHAR (s.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (s.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             s.sad_exporter || m.sad_exp_zip
                                                 nro_doc,
                                             cmp1.cmp_nam || m.sad_exp_nam
                                                 exportador,
                                             dec.dec_cod doc_dec,
                                             dec.dec_nam nombre_dec,
                                             pais.cty_dsc destino,
                                                itm.itm_nber
                                             || '-'
                                             || s.key_year
                                             || s.key_cuo
                                             || s.sad_reg_nber
                                                 dui,
                                             existe_tramite (s.sad_reg_year,
                                                             s.key_cuo,
                                                             s.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 s.sad_reg_year,
                                                 s.key_cuo,
                                                 s.sad_reg_nber,
                                                 itm.itm_nber),
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                      FROM   ops$asy.sad_itm itm,
                                             ops$asy.sad_gen s,
                                             ops$asy.sad_occ_exp m,
                                             ops$asy.uncmptab cmp1,
                                             ops$asy.undectab dec,
                                             ops$asy.unctytab pais
                                     WHERE       s.sad_num = 0
                                             AND s.lst_ope = 'U'
                                             AND s.sad_typ_dec = 'EX'
                                             --AND s.sad_typ_proc = 1
                                             AND s.key_year = itm.key_year
                                             AND s.key_cuo = itm.key_cuo
                                             AND s.key_dec = itm.key_dec
                                             AND s.key_nber = itm.key_nber
                                             AND s.sad_num = itm.sad_num
                                             AND s.sad_exporter =
                                                    cmp1.cmp_cod(+)
                                             -- exp. no ocasionales
                                             AND cmp1.lst_ope(+) = 'U'
                                             AND s.key_year = m.key_year(+)
                                             -- exp. ocasionales
                                             AND s.key_cuo = m.key_cuo(+)
                                             AND s.key_dec = m.key_dec(+)
                                             AND s.key_nber = m.key_nber(+)
                                             AND s.sad_num = m.sad_num(+)
                                             AND m.sad_num(+) = 0
                                             AND s.sad_cty_destcod =
                                                    pais.cty_cod
                                             AND s.key_dec = dec.dec_cod(+)
                                             --para declarantes registrados
                                             AND dec.lst_ope = 'U'
                                             AND s.sad_reg_date BETWEEN TO_DATE (
                                                                            prm_fecini,
                                                                            'DD/MM/YYYY')
                                                                    AND  TO_DATE (
                                                                             prm_fecfin,
                                                                             'DD/MM/YYYY')
                                             AND s.key_dec LIKE prm_agencia
                                             AND (s.sad_exporter LIKE
                                                      prm_importador
                                                  OR m.sad_exp_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND s.sad_cty_destcod LIKE
                                                    prm_origen) tbl
                        ORDER BY   2, 3, 4;
                ELSE
                    OPEN ct FOR
                          SELECT   *
                            FROM   (SELECT   DISTINCT
                                                s.sad_reg_year
                                             || '/'
                                             || s.key_cuo
                                             || '/'
                                             || s.sad_reg_serial
                                             || '-'
                                             || s.sad_reg_nber
                                                 tramite,
                                             s.key_year,
                                             s.key_cuo,
                                             s.sad_reg_nber,
                                             TO_CHAR (s.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (s.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             s.sad_exporter || m.sad_exp_zip
                                                 nro_doc,
                                             cmp1.cmp_nam || m.sad_exp_nam
                                                 exportador,
                                             sad_dec.key_dec doc_dec,
                                             sad_dec.sad_dec_nam nombre_dec,
                                             pais.cty_dsc destino,
                                                itm.itm_nber
                                             || '-'
                                             || s.key_year
                                             || s.key_cuo
                                             || s.sad_reg_nber
                                                 dui,
                                             existe_tramite (s.sad_reg_year,
                                                             s.key_cuo,
                                                             s.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 s.sad_reg_year,
                                                 s.key_cuo,
                                                 s.sad_reg_nber,
                                                 itm.itm_nber),
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                      FROM   ops$asy.sad_itm itm,
                                             ops$asy.sad_gen s,
                                             ops$asy.sad_occ_exp m,
                                             ops$asy.uncmptab cmp1,
                                             ops$asy.sad_occ_dec sad_dec,
                                             ops$asy.unctytab pais
                                     WHERE       s.sad_num = 0
                                             AND s.lst_ope = 'U'
                                             AND s.sad_typ_dec = 'EX'
                                             --and s.sad_typ_proc = 1
                                             AND s.key_year = itm.key_year
                                             AND s.key_cuo = itm.key_cuo
                                             AND s.key_nber = itm.key_nber
                                             AND (s.key_dec IS NULL
                                                  AND itm.key_dec IS NULL)
                                             AND s.sad_num = itm.sad_num
                                             AND s.sad_exporter =
                                                    cmp1.cmp_cod(+)
                                             -- exp. no ocasionales
                                             AND cmp1.lst_ope(+) = 'U'
                                             AND s.key_year = m.key_year(+)
                                             -- exp. ocasionales
                                             AND s.key_cuo = m.key_cuo(+)
                                             AND (s.key_dec IS NULL
                                                  AND m.key_dec(+) IS NULL)
                                             AND s.key_nber = m.key_nber(+)
                                             AND s.sad_num = m.sad_num(+)
                                             AND m.sad_num(+) = 0
                                             AND s.key_year =
                                                    sad_dec.key_year(+)
                                             --para declarantes ocasionales
                                             AND s.key_cuo = sad_dec.key_cuo(+)
                                             AND s.key_dec IS NULL
                                             AND sad_dec.key_dec(+) IS NULL
                                             AND s.key_nber =
                                                    sad_dec.key_nber(+)
                                             AND s.sad_num = sad_dec.sad_num(+)
                                             AND s.sad_cty_destcod =
                                                    pais.cty_cod
                                             AND s.sad_reg_date BETWEEN TO_DATE (
                                                                            prm_fecini,
                                                                            'DD/MM/YYYY')
                                                                    AND  TO_DATE (
                                                                             prm_fecfin,
                                                                             'DD/MM/YYYY')
                                             AND s.key_dec LIKE prm_agencia
                                             AND (s.sad_exporter LIKE
                                                      prm_importador
                                                  OR m.sad_exp_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND s.sad_cty_destcod LIKE
                                                    prm_origen
                                             AND itm.saditm_hs_cod
                                                || itm.saditm_hsprec_cod LIKE
                                                    prm_partida
                                    UNION
                                    SELECT   DISTINCT
                                                s.sad_reg_year
                                             || '/'
                                             || s.key_cuo
                                             || '/'
                                             || s.sad_reg_serial
                                             || '-'
                                             || s.sad_reg_nber
                                                 tramite,
                                             s.key_year,
                                             s.key_cuo,
                                             s.sad_reg_nber,
                                             TO_CHAR (s.sad_reg_date,
                                                      'dd/mm/yyyy')
                                                 fecha_registro,
                                             TO_CHAR (s.sad_asmt_date,
                                                      'dd/mm/yyyy')
                                                 fecha_valid,
                                             s.sad_exporter || m.sad_exp_zip
                                                 nro_doc,
                                             cmp1.cmp_nam || m.sad_exp_nam
                                                 exportador,
                                             dec.dec_cod doc_dec,
                                             dec.dec_nam nombre_dec,
                                             pais.cty_dsc destino,
                                                itm.itm_nber
                                             || '-'
                                             || s.key_year
                                             || s.key_cuo
                                             || s.sad_reg_nber
                                                 dui,
                                             existe_tramite (s.sad_reg_year,
                                                             s.key_cuo,
                                                             s.sad_reg_nber,
                                                             prm_tipo),
                                             itm.itm_nber,
                                             verifica_alcance_item (
                                                 prm_tipo,
                                                 s.sad_reg_year,
                                                 s.key_cuo,
                                                 s.sad_reg_nber,
                                                 itm.itm_nber),
                                                itm.saditm_goods_desc1
                                             || itm.saditm_goods_desc2
                                             || itm.saditm_goods_desc3
                                      FROM   ops$asy.sad_itm itm,
                                             ops$asy.sad_gen s,
                                             ops$asy.sad_occ_exp m,
                                             ops$asy.uncmptab cmp1,
                                             ops$asy.undectab dec,
                                             ops$asy.unctytab pais
                                     WHERE       s.sad_num = 0
                                             AND s.lst_ope = 'U'
                                             AND s.sad_typ_dec = 'EX'
                                             --AND s.sad_typ_proc = 1
                                             AND s.key_year = itm.key_year
                                             AND s.key_cuo = itm.key_cuo
                                             AND s.key_dec = itm.key_dec
                                             AND s.key_nber = itm.key_nber
                                             AND s.sad_num = itm.sad_num
                                             AND s.sad_exporter =
                                                    cmp1.cmp_cod(+)
                                             -- exp. no ocasionales
                                             AND cmp1.lst_ope(+) = 'U'
                                             AND s.key_year = m.key_year(+)
                                             -- exp. ocasionales
                                             AND s.key_cuo = m.key_cuo(+)
                                             AND s.key_dec = m.key_dec(+)
                                             AND s.key_nber = m.key_nber(+)
                                             AND s.sad_num = m.sad_num(+)
                                             AND m.sad_num(+) = 0
                                             AND s.sad_cty_destcod =
                                                    pais.cty_cod
                                             AND s.key_dec = dec.dec_cod(+)
                                             --para declarantes registrados
                                             AND dec.lst_ope = 'U'
                                             AND s.sad_reg_date BETWEEN TO_DATE (
                                                                            prm_fecini,
                                                                            'DD/MM/YYYY')
                                                                    AND  TO_DATE (
                                                                             prm_fecfin,
                                                                             'DD/MM/YYYY')
                                             AND s.key_dec LIKE prm_agencia
                                             AND (s.sad_exporter LIKE
                                                      prm_importador
                                                  OR m.sad_exp_zip LIKE
                                                           '%'
                                                        || prm_importador
                                                        || '%')
                                             AND s.sad_cty_destcod LIKE
                                                    prm_origen
                                             AND itm.saditm_hs_cod
                                                || itm.saditm_hsprec_cod LIKE
                                                    prm_partida) tbl
                        ORDER BY   2, 3, 4;
                END IF;
            END IF;

            res := 'CORRECTO';
        END IF;


        IF prm_tipo = 'MANIFIESTO'
        THEN
            OPEN ct FOR
                  SELECT   DISTINCT
                              a.car_reg_year
                           || '/'
                           || a.key_cuo
                           || '/'
                           || a.car_reg_nber
                               tramite,
                           a.car_reg_year,
                           a.key_cuo,
                           a.car_reg_nber,
                           TO_CHAR (a.car_reg_date, 'dd/mm/yyyy'),
                           a.car_arr_date,
                           NVL (b.carbol_cons_cod, '-'),
                           b.carbol_cons_nam,
                           a.car_car_cod,
                           a.car_car_nam,
                           cty.cty_dsc,
                           a.car_reg_year || a.key_cuo || a.car_reg_nber dui,
                           existe_tramite (a.car_reg_year,
                                           a.key_cuo,
                                           a.car_reg_nber,
                                           'MANIFIESTO')
                    FROM   ops$asy.car_gen a,
                           ops$asy.car_bol_gen b,
                           ops$asy.unctytab cty
                   WHERE   a.car_reg_date BETWEEN TO_DATE (prm_fecini,
                                                           'DD/MM/YYYY')
                                              AND  TO_DATE (prm_fecfin,
                                                            'DD/MM/YYYY')
                           AND a.key_cuo LIKE prm_aduana
                           AND b.carbol_nat_cod = '24'
                           AND a.key_cuo = b.key_cuo
                           AND a.key_voy_nber = b.key_voy_nber
                           AND a.key_dep_date = b.key_dep_date
                           AND a.car_car_cod = prm_agencia
                           --AND NVL (b.carbol_cons_cod, '-') LIKE '%'
                           AND SUBSTR (a.car_dep_cod, 1, 2) = cty.cty_cod
                           AND cty.lst_ope = 'U'
                           AND cty.cty_cod LIKE prm_origen
                ORDER BY   a.car_reg_year, a.key_cuo, a.car_reg_nber;

            res := 'CORRECTO';
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION existe_tramite (prm_gestion   IN VARCHAR2,
                             prm_aduana    IN VARCHAR2,
                             prm_numero    IN VARCHAR2,
                             prm_tipo      IN VARCHAR2)
        RETURN VARCHAR2
    IS
        existe   NUMBER (8) := 0;
        res      VARCHAR2 (300) := 'SIN CONTROL';
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_alcance a, fis_control b
         WHERE       a.alc_lstope = 'U'
                 AND a.alc_num = 0
                 AND b.ctl_lstope = 'U'
                 AND b.ctl_num = 0
                 AND a.ctl_control_id = b.ctl_control_id
                 AND a.alc_tipo_tramite = prm_tipo
                 AND a.alc_gestion = prm_gestion
                 AND a.alc_aduana = prm_aduana
                 AND a.alc_numero = prm_numero;

        IF existe > 0
        THEN
            SELECT   DECODE (
                         b.ctl_cod_tipo,
                         'AMPLIATORIA DIFERIDO',
                         DECODE (b.ctl_amp_correlativo,
                                 NULL, 'ORDEN AMPLIATORIA MEMORIZADA',
                                 'ORDEN AMPLIATORIA REGISTRADA'),
                         'AMPLIATORIA POSTERIOR',
                         DECODE (b.ctl_amp_correlativo,
                                 NULL, 'ORDEN AMPLIATORIA MEMORIZADA',
                                 'ORDEN AMPLIATORIA REGISTRADA'),
                         'POSTERIOR',
                         DECODE (b.ctl_cod_gestion,
                                 NULL, 'ORDEN POSTERIOR MEMORIZADA',
                                 'ORDEN POSTERIOR REGISTRADA'),
                         DECODE (b.ctl_cod_gestion,
                                 NULL, 'CONTROL DIFERIDO MEMORIZADO',
                                 'CONTROL DIFERIDO REGISTRADO'))
                     || ' '
                     || b.ctl_control_id
              INTO   res
              FROM   fis_alcance a, fis_control b
             WHERE       a.alc_lstope = 'U'
                     AND a.alc_num = 0
                     AND b.ctl_lstope = 'U'
                     AND b.ctl_num = 0
                     AND a.ctl_control_id = b.ctl_control_id
                     AND a.alc_tipo_tramite = prm_tipo
                     AND a.alc_gestion = prm_gestion
                     AND a.alc_aduana = prm_aduana
                     AND a.alc_numero = prm_numero
                     AND ROWNUM = 1;
        ELSE
            IF prm_tipo = 'DUI'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   sicodif.cd_fiscalizacion a
                 WHERE       a.sad_reg_year = prm_gestion
                         AND a.fis_key_cuo = prm_aduana
                         AND a.sad_reg_serial = 'C'
                         AND a.sad_reg_nber = prm_numero
                         AND a.fis_lst_ope = 'U'
                         AND a.fis_numver = 0;

                IF existe > 0
                THEN
                    SELECT   DECODE (
                                 a.fis_nro_control,
                                 0,
                                    'SICODIF MEMORIZADO '
                                 || a.fis_gestion
                                 || '-'
                                 || a.fis_gerencia,
                                    'SICODIF '
                                 || a.fis_gestion
                                 || 'CD'
                                 || a.fis_gerencia
                                 || a.fis_nro_control)
                      INTO   res
                      FROM   sicodif.cd_fiscalizacion a
                     WHERE       a.sad_reg_year = prm_gestion
                             AND a.fis_key_cuo = prm_aduana
                             AND a.sad_reg_serial = 'C'
                             AND a.sad_reg_nber = prm_numero
                             AND a.fis_lst_ope = 'U'
                             AND a.fis_numver = 0;

                    res := 'SIN CONTROL';
                ELSE
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_fap a
                     WHERE       a.sad_reg_year = prm_gestion
                             AND a.key_cuo = prm_aduana
                             AND a.sad_reg_serial = 'C'
                             AND a.sad_reg_nber = prm_numero
                             AND a.fap_num = 0;

                    IF existe > 0
                    THEN
                        SELECT   'FAP ' || a.fap_nro_control
                          INTO   res
                          FROM   fis_fap a
                         WHERE       a.sad_reg_year = prm_gestion
                                 AND a.key_cuo = prm_aduana
                                 AND a.sad_reg_serial = 'C'
                                 AND a.sad_reg_nber = prm_numero
                                 AND a.fap_num = 0;
                    ELSE
                        res := 'SIN CONTROL';
                    END IF;
                END IF;
            END IF;
        END IF;



        RETURN res;
    END;

    FUNCTION devuelve_tramite_iditem (prm_alcance_id    IN     VARCHAR2,
                                      prm_numero_item   IN     VARCHAR2,
                                      ct                   OUT cursortype)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_codigo        VARCHAR2 (20);
        v_tipocontrol   VARCHAR2 (30);
        v_item          VARCHAR2 (30);
    BEGIN
        SELECT   SUBSTR (prm_alcance_id, 0, INSTR (prm_alcance_id, '-') - 1),
                 SUBSTR (
                     prm_alcance_id,
                     INSTR (prm_alcance_id, '-') + 1,
                     LENGTH (prm_alcance_id) - INSTR (prm_alcance_id, '-'))
          INTO   v_codigo, v_item
          FROM   DUAL;


        OPEN ct FOR
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '/'
                     || b.alc_aduana
                     || '/'
                     || 'C-'
                     || b.alc_numero
                         tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (g.sad_reg_date, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item,
                     a.ctl_control_id
              FROM   fis_control a,
                     fis_alcance b,
                     fis_alcance_item c,
                     ops$asy.sad_gen g
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND (b.alc_tipo_alcance = 'ITEM'
                          OR b.alc_tipo_alcance = 'DECLARACION')
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND b.alc_gestion = g.sad_reg_year
                     AND b.alc_aduana = g.key_cuo
                     AND g.sad_reg_serial = 'C'
                     AND b.alc_numero = g.sad_reg_nber
                     AND g.sad_num = 0
                     AND b.alc_alcance_id = v_codigo
                     AND c.ali_numero_item = prm_numero_item
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_numero
                     || '-'
                     || b.alc_proveedor
                     || '-'
                     || pkg_general.devuelve_pais (b.alc_pais)
                         tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item,
                     a.ctl_control_id
              FROM   fis_control a, fis_alcance b, fis_alcance_item c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'FACTURA'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND b.alc_alcance_id = v_codigo
                     AND c.ali_numero_item = prm_numero_item
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '/'
                     || b.alc_aduana
                     || '/'
                     || b.alc_numero
                         tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item,
                     a.ctl_control_id
              FROM   fis_control a, fis_alcance b, fis_alcance_item c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'MANIFIESTO'
                     AND b.alc_tipo_tramite = 'MIC'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND b.alc_alcance_id = v_codigo
                     AND c.ali_numero_item = prm_numero_item
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                     b.alc_gestion || '-' || b.alc_proveedor tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item,
                     a.ctl_control_id
              FROM   fis_control a, fis_alcance b, fis_alcance_item c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'TRANSFERENCIA'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND b.alc_alcance_id = v_codigo
                     AND c.ali_numero_item = prm_numero_item
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '-'
                     || b.alc_proveedor
                     || '-'
                     || b.alc_tipo_documento
                         tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item,
                     a.ctl_control_id
              FROM   fis_control a, fis_alcance b, fis_alcance_item c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'OTROS'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND b.alc_alcance_id = v_codigo
                     AND c.ali_numero_item = prm_numero_item
            ORDER BY   2, 3;

        RETURN res;
    END;


    FUNCTION devuelve_tramites (prm_codigocontrol   IN     VARCHAR2,
                                ct                     OUT cursortype)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_codigo        VARCHAR2 (20);
        v_tipocontrol   VARCHAR2 (30);
    BEGIN
        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigocontrol
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            SELECT   c.ctl_control_id
              INTO   v_codigo
              FROM   fis_control a, fis_control c
             WHERE       a.ctl_control_id = prm_codigocontrol
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND a.ctl_cod_gestion = c.ctl_cod_gestion
                     AND a.ctl_amp_control = c.ctl_cod_tipo
                     AND a.ctl_cod_gerencia = c.ctl_cod_gerencia
                     AND a.ctl_cod_numero = c.ctl_cod_numero
                     AND c.ctl_num = 0
                     AND c.ctl_lstope = 'U';
        ELSE
            v_codigo := prm_codigocontrol;
        END IF;

        OPEN ct FOR
              SELECT   b.alc_alcance_id,
                       b.alc_tipo_tramite,
                          b.alc_gestion
                       || '/'
                       || b.alc_aduana
                       || '/'
                       || 'C-'
                       || b.alc_numero
                           tramite,
                       b.alc_tipo_alcance,
                       COUNT (ali_numero_item),
                       b.alc_tipo_etapa
                FROM   fis_control a, fis_alcance b, fis_alcance_item c
               WHERE       a.ctl_control_id = b.ctl_control_id
                       AND a.ctl_num = 0
                       AND a.ctl_lstope = 'U'
                       AND b.alc_tipo_alcance = 'ITEM'
                       AND b.alc_num = 0
                       AND b.alc_lstope = 'U'
                       AND c.ali_num = 0
                       AND c.ali_lstope = 'U'
                       AND c.alc_alcance_id = b.alc_alcance_id
                       AND a.ctl_control_id = v_codigo
            GROUP BY   b.alc_alcance_id,
                       b.alc_tipo_tramite,
                          b.alc_gestion
                       || '/'
                       || b.alc_aduana
                       || '/'
                       || 'C-'
                       || b.alc_numero,
                       b.alc_tipo_alcance,
                       b.alc_tipo_etapa
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '/'
                     || b.alc_aduana
                     || '/'
                     || 'C-'
                     || b.alc_numero
                         tramite,
                     'DECLARACION',
                     0,
                     b.alc_tipo_etapa
              FROM   fis_control a, fis_alcance b
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'DECLARACION'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = v_codigo
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_numero
                     || '-'
                     || TO_CHAR (b.alc_fecha, 'dd/mm/yyyy')
                     || '-'
                     || b.alc_proveedor
                     || '-'
                     || pkg_general.devuelve_pais (b.alc_pais)
                         tramite,
                     b.alc_tipo_alcance,
                     0,
                     b.alc_tipo_etapa
              FROM   fis_control a, fis_alcance b
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'FACTURA'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = v_codigo
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '/'
                     || b.alc_aduana
                     || '/'
                     || b.alc_numero
                         tramite,
                     b.alc_tipo_alcance,
                     0,
                     b.alc_tipo_etapa
              FROM   fis_control a, fis_alcance b
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'MANIFIESTO'
                     AND b.alc_tipo_tramite = 'MIC'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = v_codigo
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '-'
                     || TO_CHAR (b.alc_fecha, 'dd/mm/yyyy')
                     || '-'
                     || b.alc_proveedor
                         tramite,
                     b.alc_tipo_alcance,
                     0,
                     b.alc_tipo_etapa
              FROM   fis_control a, fis_alcance b
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'TRANSFERENCIA'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = v_codigo
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '-'
                     || TO_CHAR (b.alc_fecha, 'dd/mm/yyyy')
                     || '-'
                     || b.alc_proveedor
                     || '-'
                     || b.alc_tipo_documento
                         tramite,
                     b.alc_tipo_alcance,
                     0,
                     b.alc_tipo_etapa
              FROM   fis_control a, fis_alcance b
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'OTROS'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = v_codigo
            ORDER BY   2, 3;

        RETURN res;
    END;

    FUNCTION devuelve_tramitespadreamp (
        prm_codigocontrol   IN     VARCHAR2,
        ct                     OUT cursortype)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_codigo        VARCHAR2 (20);
        v_tipocontrol   VARCHAR2 (30);
        v_tipoope       VARCHAR2 (20);
        v_tipodoc       VARCHAR2 (20);
        v_openum        VARCHAR2 (20);
    BEGIN
        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigocontrol
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            SELECT   ctl_tipo_operador,
                     ctl_tipo_doc_identidad,
                     DECODE (ctl_tipo_doc_identidad,
                             'NIT',
                             ctl_nit,
                             'CI',
                             ctl_ci)
              INTO   v_tipoope, v_tipodoc, v_openum
              FROM   fis_control a
             WHERE       a.ctl_control_id = prm_codigocontrol
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U';


            SELECT   ctl_cod_tipo
              INTO   v_tipocontrol
              FROM   fis_control a
             WHERE       a.ctl_control_id = prm_codigocontrol
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U';

            SELECT   c.ctl_control_id
              INTO   v_codigo
              FROM   fis_control a, fis_control c
             WHERE       a.ctl_control_id = prm_codigocontrol
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND a.ctl_cod_gestion = c.ctl_cod_gestion
                     AND a.ctl_amp_control = c.ctl_cod_tipo
                     AND a.ctl_cod_gerencia = c.ctl_cod_gerencia
                     AND a.ctl_cod_numero = c.ctl_cod_numero
                     AND c.ctl_num = 0
                     AND c.ctl_lstope = 'U';
        ELSE
            v_codigo := prm_codigocontrol;
        END IF;

        OPEN ct FOR
              SELECT   b.alc_alcance_id,
                       b.alc_tipo_tramite,
                          b.alc_gestion
                       || '/'
                       || b.alc_aduana
                       || '/'
                       || 'C-'
                       || b.alc_numero
                           tramite,
                       b.alc_tipo_alcance,
                       COUNT (ali_numero_item),
                       b.alc_tipo_etapa,
                       DECODE (d.amp_alcanceamp_id, NULL, 1, 0),
                       s.sad_consignee,
                       s.key_dec
                FROM   fis_control a,
                       fis_alcance b,
                       fis_alcance_item c,
                       fis_alcance_amp d,
                       ops$asy.sad_gen s
               WHERE       a.ctl_control_id = b.ctl_control_id
                       AND a.ctl_num = 0
                       AND a.ctl_lstope = 'U'
                       AND b.alc_tipo_alcance = 'ITEM'
                       AND b.alc_num = 0
                       AND b.alc_lstope = 'U'
                       AND c.ali_num = 0
                       AND c.ali_lstope = 'U'
                       AND c.alc_alcance_id = b.alc_alcance_id
                       AND a.ctl_control_id = v_codigo
                       AND d.amp_num(+) = 0
                       AND d.amp_lstope(+) = 'U'
                       AND d.ctl_control_id(+) = prm_codigocontrol
                       AND d.alc_alcance_id(+) = b.alc_alcance_id
                       AND s.sad_reg_year = b.alc_gestion
                       AND s.key_cuo = b.alc_aduana
                       AND s.sad_reg_serial = 'C'
                       AND s.sad_reg_nber = b.alc_numero
                       AND s.sad_num = 0
            GROUP BY   b.alc_alcance_id,
                       b.alc_tipo_tramite,
                          b.alc_gestion
                       || '/'
                       || b.alc_aduana
                       || '/'
                       || 'C-'
                       || b.alc_numero,
                       b.alc_tipo_alcance,
                       b.alc_tipo_etapa,
                       DECODE (d.amp_alcanceamp_id, NULL, 1, 0),
                       s.sad_consignee,
                       s.key_dec
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '/'
                     || b.alc_aduana
                     || '/'
                     || 'C-'
                     || b.alc_numero
                         tramite,
                     'DECLARACI&Oacute;N',
                     0,
                     b.alc_tipo_etapa,
                     DECODE (c.amp_alcanceamp_id, NULL, 1, 0),
                     s.sad_consignee,
                     s.key_dec
              FROM   fis_control a,
                     fis_alcance b,
                     fis_alcance_amp c,
                     ops$asy.sad_gen s
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'DECLARACION'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = v_codigo
                     AND c.amp_num(+) = 0
                     AND c.amp_lstope(+) = 'U'
                     AND c.ctl_control_id(+) = prm_codigocontrol
                     AND c.alc_alcance_id(+) = b.alc_alcance_id
                     AND s.sad_reg_year = b.alc_gestion
                     AND s.key_cuo = b.alc_aduana
                     AND s.sad_reg_serial = 'C'
                     AND s.sad_reg_nber = b.alc_numero
                     AND s.sad_num = 0
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_numero
                     || '-'
                     || TO_CHAR (b.alc_fecha, 'dd/mm/yyyy')
                     || '-'
                     || b.alc_proveedor
                     || '-'
                     || pkg_general.devuelve_pais (b.alc_pais)
                         tramite,
                     b.alc_tipo_alcance,
                     0,
                     b.alc_tipo_etapa,
                     DECODE (c.amp_alcanceamp_id, NULL, 1, 0),
                     '',
                     ''
              FROM   fis_control a, fis_alcance b, fis_alcance_amp c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'FACTURA'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = v_codigo
                     AND c.amp_num(+) = 0
                     AND c.amp_lstope(+) = 'U'
                     AND c.ctl_control_id(+) = prm_codigocontrol
                     AND c.alc_alcance_id(+) = b.alc_alcance_id
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '/'
                     || b.alc_aduana
                     || '/'
                     || b.alc_numero
                         tramite,
                     b.alc_tipo_alcance,
                     0,
                     b.alc_tipo_etapa,
                     DECODE (c.amp_alcanceamp_id, NULL, 1, 0),
                     '',
                     ''
              FROM   fis_control a, fis_alcance b, fis_alcance_amp c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'MANIFIESTO'
                     AND b.alc_tipo_tramite = 'MIC'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = v_codigo
                     AND c.amp_num(+) = 0
                     AND c.amp_lstope(+) = 'U'
                     AND c.ctl_control_id(+) = prm_codigocontrol
                     AND c.alc_alcance_id(+) = b.alc_alcance_id
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '-'
                     || TO_CHAR (b.alc_fecha, 'dd/mm/yyyy')
                     || '-'
                     || b.alc_proveedor
                         tramite,
                     b.alc_tipo_alcance,
                     0,
                     b.alc_tipo_etapa,
                     DECODE (c.amp_alcanceamp_id, NULL, 1, 0),
                     '',
                     ''
              FROM   fis_control a, fis_alcance b, fis_alcance_amp c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'TRANSFERENCIA'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = v_codigo
                     AND c.amp_num(+) = 0
                     AND c.amp_lstope(+) = 'U'
                     AND c.ctl_control_id(+) = prm_codigocontrol
                     AND c.alc_alcance_id(+) = b.alc_alcance_id
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '-'
                     || TO_CHAR (b.alc_fecha, 'dd/mm/yyyy')
                     || '-'
                     || b.alc_proveedor
                     || '-'
                     || b.alc_tipo_documento
                         tramite,
                     b.alc_tipo_alcance,
                     0,
                     b.alc_tipo_etapa,
                     DECODE (c.amp_alcanceamp_id, NULL, 1, 0),
                     '',
                     ''
              FROM   fis_control a, fis_alcance b, fis_alcance_amp c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'OTROS'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = v_codigo
                     AND c.amp_num(+) = 0
                     AND c.amp_lstope(+) = 'U'
                     AND c.ctl_control_id(+) = prm_codigocontrol
                     AND c.alc_alcance_id(+) = b.alc_alcance_id
            ORDER BY   2, 3;



        RETURN res;
    END;

    FUNCTION devuelve_tramitesamp (prm_codigocontrol   IN     VARCHAR2,
                                   ct                     OUT cursortype)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := '0';
        v_codigo        VARCHAR2 (20);
        v_tipocontrol   VARCHAR2 (30);
    BEGIN
        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigocontrol
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            OPEN ct FOR
                  SELECT   a.amp_alcanceamp_id,
                           b.alc_tipo_tramite,
                              b.alc_gestion
                           || '/'
                           || b.alc_aduana
                           || '/'
                           || 'C-'
                           || b.alc_numero
                               tramite,
                           b.alc_tipo_alcance,
                           COUNT (ali_numero_item),
                           b.alc_tipo_etapa
                    FROM   fis_alcance_amp a, fis_alcance b, fis_alcance_item c
                   WHERE       a.alc_alcance_id = b.alc_alcance_id
                           AND a.amp_num = 0
                           AND a.amp_lstope = 'U'
                           AND b.alc_tipo_alcance = 'ITEM'
                           AND b.alc_num = 0
                           AND b.alc_lstope = 'U'
                           AND c.ali_num = 0
                           AND c.ali_lstope = 'U'
                           AND c.alc_alcance_id = b.alc_alcance_id
                           AND a.ctl_control_id = prm_codigocontrol
                GROUP BY   a.amp_alcanceamp_id,
                           b.alc_tipo_tramite,
                              b.alc_gestion
                           || '/'
                           || b.alc_aduana
                           || '/'
                           || 'C-'
                           || b.alc_numero,
                           b.alc_tipo_alcance,
                           b.alc_tipo_etapa
                UNION
                SELECT   a.amp_alcanceamp_id,
                         b.alc_tipo_tramite,
                            b.alc_gestion
                         || '/'
                         || b.alc_aduana
                         || '/'
                         || 'C-'
                         || b.alc_numero
                             tramite,
                         'DECLARACI&Oacute;N',
                         0,
                         b.alc_tipo_etapa
                  FROM   fis_alcance_amp a, fis_alcance b
                 WHERE       a.alc_alcance_id = b.alc_alcance_id
                         AND a.amp_num = 0
                         AND a.amp_lstope = 'U'
                         AND b.alc_tipo_alcance = 'DECLARACION'
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND a.ctl_control_id = prm_codigocontrol
                UNION
                SELECT   a.amp_alcanceamp_id,
                         b.alc_tipo_tramite,
                            b.alc_numero
                         || '-'
                         || TO_CHAR (b.alc_fecha, 'dd/mm/yyyy')
                         || '-'
                         || b.alc_proveedor
                         || '-'
                         || pkg_general.devuelve_pais (b.alc_pais)
                             tramite,
                         b.alc_tipo_alcance,
                         0,
                         b.alc_tipo_etapa
                  FROM   fis_alcance_amp a, fis_alcance b
                 WHERE       a.alc_alcance_id = b.alc_alcance_id
                         AND a.amp_num = 0
                         AND a.amp_lstope = 'U'
                         AND b.alc_tipo_alcance = 'TRAMITE'
                         AND b.alc_tipo_tramite = 'FACTURA'
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND a.ctl_control_id = prm_codigocontrol
                UNION
                SELECT   a.amp_alcanceamp_id,
                         b.alc_tipo_tramite,
                            b.alc_gestion
                         || '/'
                         || b.alc_aduana
                         || '/'
                         || b.alc_numero
                             tramite,
                         b.alc_tipo_alcance,
                         0,
                         b.alc_tipo_etapa
                  FROM   fis_alcance_amp a, fis_alcance b
                 WHERE       a.alc_alcance_id = b.alc_alcance_id
                         AND a.amp_num = 0
                         AND a.amp_lstope = 'U'
                         AND b.alc_tipo_alcance = 'MANIFIESTO'
                         AND b.alc_tipo_tramite = 'MIC'
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND a.ctl_control_id = prm_codigocontrol
                UNION
                SELECT   a.amp_alcanceamp_id,
                         b.alc_tipo_tramite,
                            b.alc_gestion
                         || '-'
                         || TO_CHAR (b.alc_fecha, 'dd/mm/yyyy')
                         || '-'
                         || b.alc_proveedor
                             tramite,
                         b.alc_tipo_alcance,
                         0,
                         b.alc_tipo_etapa
                  FROM   fis_alcance_amp a, fis_alcance b
                 WHERE       a.alc_alcance_id = b.alc_alcance_id
                         AND a.amp_num = 0
                         AND a.amp_lstope = 'U'
                         AND b.alc_tipo_alcance = 'TRAMITE'
                         AND b.alc_tipo_tramite = 'TRANSFERENCIA'
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND a.ctl_control_id = prm_codigocontrol
                UNION
                SELECT   a.amp_alcanceamp_id,
                         b.alc_tipo_tramite,
                            b.alc_gestion
                         || '-'
                         || TO_CHAR (b.alc_fecha, 'dd/mm/yyyy')
                         || '-'
                         || b.alc_proveedor
                         || '-'
                         || b.alc_tipo_documento
                             tramite,
                         b.alc_tipo_alcance,
                         0,
                         b.alc_tipo_etapa
                  FROM   fis_alcance_amp a, fis_alcance b
                 WHERE       a.alc_alcance_id = b.alc_alcance_id
                         AND a.amp_num = 0
                         AND a.amp_lstope = 'U'
                         AND b.alc_tipo_alcance = 'TRAMITE'
                         AND b.alc_tipo_tramite = 'OTROS'
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND a.ctl_control_id = prm_codigocontrol
                ORDER BY   2, 3;
        ELSE
            res := 'NO CORRESPONDE';
        END IF;

        RETURN res;
    END;



    FUNCTION devuelve_tramitesrep (prm_codigocontrol   IN     VARCHAR2,
                                   ct                     OUT cursortype)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_codigo        VARCHAR2 (20);
        v_tipocontrol   VARCHAR2 (30);
    BEGIN
        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigocontrol
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            SELECT   c.ctl_control_id
              INTO   v_codigo
              FROM   fis_control a, fis_control c
             WHERE       a.ctl_control_id = prm_codigocontrol
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND a.ctl_cod_gestion = c.ctl_cod_gestion
                     AND a.ctl_amp_control = c.ctl_cod_tipo
                     AND a.ctl_cod_gerencia = c.ctl_cod_gerencia
                     AND a.ctl_cod_numero = c.ctl_cod_numero
                     AND c.ctl_num = 0
                     AND c.ctl_lstope = 'U';
        ELSE
            v_codigo := prm_codigocontrol;
        END IF;

        OPEN ct FOR
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '/'
                     || b.alc_aduana
                     || '/'
                     || 'C-'
                     || b.alc_numero
                         tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (g.sad_reg_date, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item
              FROM   fis_control a,
                     fis_alcance b,
                     fis_alcance_item c,
                     ops$asy.sad_gen g
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND (b.alc_tipo_alcance = 'ITEM'
                          OR b.alc_tipo_alcance = 'DECLARACION')
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND b.alc_gestion = g.sad_reg_year
                     AND b.alc_aduana = g.key_cuo
                     AND g.sad_reg_serial = 'C'
                     AND b.alc_numero = g.sad_reg_nber
                     AND g.sad_num = 0
                     AND a.ctl_control_id = v_codigo
                     AND c.ali_tipo_etapa = 'NORMAL'
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_numero
                     || '-'
                     || b.alc_proveedor
                     || '-'
                     || pkg_general.devuelve_pais (b.alc_pais)
                         tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item
              FROM   fis_control a, fis_alcance b, fis_alcance_item c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'FACTURA'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND a.ctl_control_id = v_codigo
                     AND c.ali_tipo_etapa = 'NORMAL'
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '/'
                     || b.alc_aduana
                     || '/'
                     || b.alc_numero
                         tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item
              FROM   fis_control a, fis_alcance b, fis_alcance_item c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'MANIFIESTO'
                     AND b.alc_tipo_tramite = 'MIC'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND a.ctl_control_id = v_codigo
                     AND c.ali_tipo_etapa = 'NORMAL'
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                     b.alc_gestion || '-' || b.alc_proveedor tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item
              FROM   fis_control a, fis_alcance b, fis_alcance_item c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'TRANSFERENCIA'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = v_codigo
                     AND c.ali_tipo_etapa = 'NORMAL'
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '-'
                     || b.alc_proveedor
                     || '-'
                     || b.alc_tipo_documento
                         tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item
              FROM   fis_control a, fis_alcance b, fis_alcance_item c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'OTROS'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND a.ctl_control_id = v_codigo
                     AND c.ali_tipo_etapa = 'NORMAL'
            ORDER BY   2, 3;

        RETURN res;
    END;



    FUNCTION devuelve_tramitesreporte (prm_codigocontrol   IN     VARCHAR2,
                                       ct                     OUT cursortype)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_codigo        VARCHAR2 (20);
        v_tipocontrol   VARCHAR2 (30);
    BEGIN
        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigocontrol
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            OPEN ct FOR
                SELECT   a.amp_alcanceamp_id,
                         b.alc_tipo_tramite,
                            b.alc_gestion
                         || '/'
                         || b.alc_aduana
                         || '/'
                         || 'C-'
                         || b.alc_numero
                             tramite,
                         b.alc_tipo_alcance,
                         b.alc_tipo_etapa,
                         c.ali_numero_item,
                         DECODE (c.ali_obs_valor, 'x', 'X', ''),
                         DECODE (c.ali_obs_origen, 'x', 'X', ''),
                         DECODE (c.ali_obs_partida, 'x', 'X', ''),
                         DECODE (c.ali_obs_otro, 'x', 'X', ''),
                         TO_CHAR (g.sad_reg_date, 'dd/mm/yyyy'),
                         b.alc_alcance_id || '-' || c.ali_numero_item
                  FROM   fis_alcance_amp a,
                         fis_alcance b,
                         fis_alcance_item c,
                         ops$asy.sad_gen g
                 WHERE       a.alc_alcance_id = b.alc_alcance_id
                         AND a.amp_num = 0
                         AND a.amp_lstope = 'U'
                         AND (b.alc_tipo_alcance = 'ITEM'
                              OR b.alc_tipo_alcance = 'DECLARACION')
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND c.ali_num = 0
                         AND c.ali_lstope = 'U'
                         AND c.alc_alcance_id = b.alc_alcance_id
                         AND b.alc_gestion = g.sad_reg_year
                         AND b.alc_aduana = g.key_cuo
                         AND g.sad_reg_serial = 'C'
                         AND b.alc_numero = g.sad_reg_nber
                         AND g.sad_num = 0
                         AND a.ctl_control_id = prm_codigocontrol
                         AND c.ali_tipo_etapa = 'NORMAL'
                UNION
                SELECT   a.amp_alcanceamp_id,
                         b.alc_tipo_tramite,
                            b.alc_numero
                         || '-'
                         || TO_CHAR (b.alc_fecha, 'dd/mm/yyyy')
                         || '-'
                         || b.alc_proveedor
                         || '-'
                         || pkg_general.devuelve_pais (b.alc_pais)
                             tramite,
                         b.alc_tipo_alcance,
                         b.alc_tipo_etapa,
                         c.ali_numero_item,
                         DECODE (c.ali_obs_valor, 'x', 'X', ''),
                         DECODE (c.ali_obs_origen, 'x', 'X', ''),
                         DECODE (c.ali_obs_partida, 'x', 'X', ''),
                         DECODE (c.ali_obs_otro, 'x', 'X', ''),
                         TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                         b.alc_alcance_id || '-' || c.ali_numero_item
                  FROM   fis_alcance_amp a, fis_alcance b, fis_alcance_item c
                 WHERE       a.alc_alcance_id = b.alc_alcance_id
                         AND a.amp_num = 0
                         AND a.amp_lstope = 'U'
                         AND a.amp_num = 0
                         AND a.amp_lstope = 'U'
                         AND b.alc_tipo_alcance = 'TRAMITE'
                         AND b.alc_tipo_tramite = 'FACTURA'
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND c.ali_num = 0
                         AND c.ali_lstope = 'U'
                         AND c.alc_alcance_id = b.alc_alcance_id
                         AND a.ctl_control_id = prm_codigocontrol
                         AND c.ali_tipo_etapa = 'NORMAL'
                UNION
                SELECT   a.amp_alcanceamp_id,
                         b.alc_tipo_tramite,
                            b.alc_gestion
                         || '/'
                         || b.alc_aduana
                         || '/'
                         || b.alc_numero
                             tramite,
                         b.alc_tipo_alcance,
                         b.alc_tipo_etapa,
                         c.ali_numero_item,
                         DECODE (c.ali_obs_valor, 'x', 'X', ''),
                         DECODE (c.ali_obs_origen, 'x', 'X', ''),
                         DECODE (c.ali_obs_partida, 'x', 'X', ''),
                         DECODE (c.ali_obs_otro, 'x', 'X', ''),
                         TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                         b.alc_alcance_id || '-' || c.ali_numero_item
                  FROM   fis_alcance_amp a, fis_alcance b, fis_alcance_item c
                 WHERE       a.alc_alcance_id = b.alc_alcance_id
                         AND a.amp_num = 0
                         AND a.amp_lstope = 'U'
                         AND b.alc_tipo_alcance = 'MANIFIESTO'
                         AND b.alc_tipo_tramite = 'MIC'
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND c.ali_num = 0
                         AND c.ali_lstope = 'U'
                         AND c.alc_alcance_id = b.alc_alcance_id
                         AND a.ctl_control_id = prm_codigocontrol
                         AND c.ali_tipo_etapa = 'NORMAL'
                UNION
                SELECT   a.amp_alcanceamp_id,
                         b.alc_tipo_tramite,
                            b.alc_gestion
                         || '-'
                         || TO_CHAR (b.alc_fecha, 'dd/mm/yyyy')
                         || '-'
                         || b.alc_proveedor
                             tramite,
                         b.alc_tipo_alcance,
                         b.alc_tipo_etapa,
                         c.ali_numero_item,
                         DECODE (c.ali_obs_valor, 'x', 'X', ''),
                         DECODE (c.ali_obs_origen, 'x', 'X', ''),
                         DECODE (c.ali_obs_partida, 'x', 'X', ''),
                         DECODE (c.ali_obs_otro, 'x', 'X', ''),
                         TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                         b.alc_alcance_id || '-' || c.ali_numero_item
                  FROM   fis_alcance_amp a, fis_alcance b, fis_alcance_item c
                 WHERE       a.alc_alcance_id = b.alc_alcance_id
                         AND a.amp_num = 0
                         AND a.amp_lstope = 'U'
                         AND b.alc_tipo_alcance = 'TRAMITE'
                         AND b.alc_tipo_tramite = 'TRANSFERENCIA'
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND c.ali_num = 0
                         AND c.ali_lstope = 'U'
                         AND c.alc_alcance_id = b.alc_alcance_id
                         AND a.ctl_control_id = prm_codigocontrol
                         AND c.ali_tipo_etapa = 'NORMAL'
                UNION
                SELECT   a.amp_alcanceamp_id,
                         b.alc_tipo_tramite,
                            b.alc_gestion
                         || '-'
                         || TO_CHAR (b.alc_fecha, 'dd/mm/yyyy')
                         || '-'
                         || b.alc_proveedor
                         || '-'
                         || b.alc_tipo_documento
                             tramite,
                         b.alc_tipo_alcance,
                         b.alc_tipo_etapa,
                         c.ali_numero_item,
                         DECODE (c.ali_obs_valor, 'x', 'X', ''),
                         DECODE (c.ali_obs_origen, 'x', 'X', ''),
                         DECODE (c.ali_obs_partida, 'x', 'X', ''),
                         DECODE (c.ali_obs_otro, 'x', 'X', ''),
                         TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                         b.alc_alcance_id || '-' || c.ali_numero_item
                  FROM   fis_alcance_amp a, fis_alcance b, fis_alcance_item c
                 WHERE       a.alc_alcance_id = b.alc_alcance_id
                         AND a.amp_num = 0
                         AND a.amp_lstope = 'U'
                         AND b.alc_tipo_alcance = 'TRAMITE'
                         AND b.alc_tipo_tramite = 'OTROS'
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND c.ali_num = 0
                         AND c.ali_lstope = 'U'
                         AND c.alc_alcance_id = b.alc_alcance_id
                         AND a.ctl_control_id = prm_codigocontrol
                         AND c.ali_tipo_etapa = 'NORMAL'
                ORDER BY   2, 3;
        ELSE
            v_codigo := prm_codigocontrol;

            OPEN ct FOR
                SELECT   b.alc_alcance_id,
                         b.alc_tipo_tramite,
                            b.alc_gestion
                         || '/'
                         || b.alc_aduana
                         || '/'
                         || 'C-'
                         || b.alc_numero
                             tramite,
                         b.alc_tipo_alcance,
                         b.alc_tipo_etapa,
                         c.ali_numero_item,
                         DECODE (c.ali_obs_valor, 'x', 'X', ''),
                         DECODE (c.ali_obs_origen, 'x', 'X', ''),
                         DECODE (c.ali_obs_partida, 'x', 'X', ''),
                         DECODE (c.ali_obs_otro, 'x', 'X', ''),
                         TO_CHAR (g.sad_reg_date, 'dd/mm/yyyy'),
                         b.alc_alcance_id || '-' || c.ali_numero_item
                  FROM   fis_control a,
                         fis_alcance b,
                         fis_alcance_item c,
                         ops$asy.sad_gen g
                 WHERE       a.ctl_control_id = b.ctl_control_id
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U'
                         AND (b.alc_tipo_alcance = 'ITEM'
                              OR b.alc_tipo_alcance = 'DECLARACION')
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND c.ali_num = 0
                         AND c.ali_lstope = 'U'
                         AND c.alc_alcance_id = b.alc_alcance_id
                         AND b.alc_gestion = g.sad_reg_year
                         AND b.alc_aduana = g.key_cuo
                         AND g.sad_reg_serial = 'C'
                         AND b.alc_numero = g.sad_reg_nber
                         AND g.sad_num = 0
                         AND a.ctl_control_id = v_codigo
                         AND c.ali_tipo_etapa = 'NORMAL'
                UNION
                SELECT   b.alc_alcance_id,
                         b.alc_tipo_tramite,
                            b.alc_numero
                         || '-'
                         || b.alc_proveedor
                         || '-'
                         || pkg_general.devuelve_pais (b.alc_pais)
                             tramite,
                         b.alc_tipo_alcance,
                         b.alc_tipo_etapa,
                         c.ali_numero_item,
                         DECODE (c.ali_obs_valor, 'x', 'X', ''),
                         DECODE (c.ali_obs_origen, 'x', 'X', ''),
                         DECODE (c.ali_obs_partida, 'x', 'X', ''),
                         DECODE (c.ali_obs_otro, 'x', 'X', ''),
                         TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                         b.alc_alcance_id || '-' || c.ali_numero_item
                  FROM   fis_control a, fis_alcance b, fis_alcance_item c
                 WHERE       a.ctl_control_id = b.ctl_control_id
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U'
                         AND b.alc_tipo_alcance = 'TRAMITE'
                         AND b.alc_tipo_tramite = 'FACTURA'
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND c.ali_num = 0
                         AND c.ali_lstope = 'U'
                         AND c.alc_alcance_id = b.alc_alcance_id
                         AND a.ctl_control_id = v_codigo
                         AND c.ali_tipo_etapa = 'NORMAL'
                UNION
                SELECT   b.alc_alcance_id,
                         b.alc_tipo_tramite,
                            b.alc_gestion
                         || '/'
                         || b.alc_aduana
                         || '/'
                         || b.alc_numero
                             tramite,
                         b.alc_tipo_alcance,
                         b.alc_tipo_etapa,
                         c.ali_numero_item,
                         DECODE (c.ali_obs_valor, 'x', 'X', ''),
                         DECODE (c.ali_obs_origen, 'x', 'X', ''),
                         DECODE (c.ali_obs_partida, 'x', 'X', ''),
                         DECODE (c.ali_obs_otro, 'x', 'X', ''),
                         TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                         b.alc_alcance_id || '-' || c.ali_numero_item
                  FROM   fis_control a, fis_alcance b, fis_alcance_item c
                 WHERE       a.ctl_control_id = b.ctl_control_id
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U'
                         AND b.alc_tipo_alcance = 'MANIFIESTO'
                         AND b.alc_tipo_tramite = 'MIC'
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND c.ali_num = 0
                         AND c.ali_lstope = 'U'
                         AND c.alc_alcance_id = b.alc_alcance_id
                         AND a.ctl_control_id = v_codigo
                         AND c.ali_tipo_etapa = 'NORMAL'
                UNION
                SELECT   b.alc_alcance_id,
                         b.alc_tipo_tramite,
                         b.alc_gestion || '-' || b.alc_proveedor tramite,
                         b.alc_tipo_alcance,
                         b.alc_tipo_etapa,
                         c.ali_numero_item,
                         DECODE (c.ali_obs_valor, 'x', 'X', ''),
                         DECODE (c.ali_obs_origen, 'x', 'X', ''),
                         DECODE (c.ali_obs_partida, 'x', 'X', ''),
                         DECODE (c.ali_obs_otro, 'x', 'X', ''),
                         TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                         b.alc_alcance_id || '-' || c.ali_numero_item
                  FROM   fis_control a, fis_alcance b, fis_alcance_item c
                 WHERE       a.ctl_control_id = b.ctl_control_id
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U'
                         AND c.ali_num = 0
                         AND c.ali_lstope = 'U'
                         AND c.alc_alcance_id = b.alc_alcance_id
                         AND b.alc_tipo_alcance = 'TRAMITE'
                         AND b.alc_tipo_tramite = 'TRANSFERENCIA'
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND a.ctl_control_id = v_codigo
                         AND c.ali_tipo_etapa = 'NORMAL'
                UNION
                SELECT   b.alc_alcance_id,
                         b.alc_tipo_tramite,
                            b.alc_gestion
                         || '-'
                         || b.alc_proveedor
                         || '-'
                         || b.alc_tipo_documento
                             tramite,
                         b.alc_tipo_alcance,
                         b.alc_tipo_etapa,
                         c.ali_numero_item,
                         DECODE (c.ali_obs_valor, 'x', 'X', ''),
                         DECODE (c.ali_obs_origen, 'x', 'X', ''),
                         DECODE (c.ali_obs_partida, 'x', 'X', ''),
                         DECODE (c.ali_obs_otro, 'x', 'X', ''),
                         TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                         b.alc_alcance_id || '-' || c.ali_numero_item
                  FROM   fis_control a, fis_alcance b, fis_alcance_item c
                 WHERE       a.ctl_control_id = b.ctl_control_id
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U'
                         AND b.alc_tipo_alcance = 'TRAMITE'
                         AND b.alc_tipo_tramite = 'OTROS'
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND c.ali_num = 0
                         AND c.ali_lstope = 'U'
                         AND c.alc_alcance_id = b.alc_alcance_id
                         AND a.ctl_control_id = v_codigo
                         AND c.ali_tipo_etapa = 'NORMAL'
                ORDER BY   2, 3;
        END IF;


        RETURN res;
    END;

    FUNCTION devuelve_tramitesrepamp (prm_codigocontrol   IN     VARCHAR2,
                                      ct                     OUT cursortype)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_codigo        VARCHAR2 (20);
        v_tipocontrol   VARCHAR2 (30);
    BEGIN
        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigocontrol
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            SELECT   c.ctl_control_id
              INTO   v_codigo
              FROM   fis_control a, fis_control c
             WHERE       a.ctl_control_id = prm_codigocontrol
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND a.ctl_cod_gestion = c.ctl_cod_gestion
                     AND a.ctl_amp_control = c.ctl_cod_tipo
                     AND a.ctl_cod_gerencia = c.ctl_cod_gerencia
                     AND a.ctl_cod_numero = c.ctl_cod_numero
                     AND c.ctl_num = 0
                     AND c.ctl_lstope = 'U';
        ELSE
            v_codigo := prm_codigocontrol;
        END IF;

        OPEN ct FOR
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '/'
                     || b.alc_aduana
                     || '/'
                     || 'C-'
                     || b.alc_numero
                         tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (g.sad_reg_date, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item
              FROM   fis_control a,
                     fis_alcance b,
                     fis_alcance_item c,
                     ops$asy.sad_gen g
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND (b.alc_tipo_alcance = 'ITEM'
                          OR b.alc_tipo_alcance = 'DECLARACION')
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND b.alc_gestion = g.sad_reg_year
                     AND b.alc_aduana = g.key_cuo
                     AND g.sad_reg_serial = 'C'
                     AND b.alc_numero = g.sad_reg_nber
                     AND g.sad_num = 0
                     AND a.ctl_control_id = prm_codigocontrol
                     AND c.ali_tipo_etapa = 'AMPLIATORIA'
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_numero
                     || '-'
                     || b.alc_proveedor
                     || '-'
                     || pkg_general.devuelve_pais (b.alc_pais)
                         tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item
              FROM   fis_control a, fis_alcance b, fis_alcance_item c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'FACTURA'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND a.ctl_control_id = prm_codigocontrol
                     AND c.ali_tipo_etapa = 'AMPLIATORIA'
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '/'
                     || b.alc_aduana
                     || '/'
                     || b.alc_numero
                         tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item
              FROM   fis_control a, fis_alcance b, fis_alcance_item c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'MANIFIESTO'
                     AND b.alc_tipo_tramite = 'MIC'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND a.ctl_control_id = prm_codigocontrol
                     AND c.ali_tipo_etapa = 'AMPLIATORIA'
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                     b.alc_gestion || '-' || b.alc_proveedor tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item
              FROM   fis_control a, fis_alcance b, fis_alcance_item c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'TRANSFERENCIA'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = prm_codigocontrol
                     AND c.ali_tipo_etapa = 'AMPLIATORIA'
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '-'
                     || b.alc_proveedor
                     || '-'
                     || b.alc_tipo_documento
                         tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item
              FROM   fis_control a, fis_alcance b, fis_alcance_item c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'OTROS'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND a.ctl_control_id = prm_codigocontrol
                     AND c.ali_tipo_etapa = 'AMPLIATORIA'
            ORDER BY   2, 3;

        RETURN res;
    END;

    FUNCTION devuelve_tramitesrepampliacion (
        prm_codigocontrol   IN     VARCHAR2,
        ct                     OUT cursortype)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_codigo        VARCHAR2 (20);
        v_tipocontrol   VARCHAR2 (30);
    BEGIN
        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigocontrol
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            SELECT   c.ctl_control_id
              INTO   v_codigo
              FROM   fis_control a, fis_control c
             WHERE       a.ctl_control_id = prm_codigocontrol
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND a.ctl_cod_gestion = c.ctl_cod_gestion
                     AND a.ctl_amp_control = c.ctl_cod_tipo
                     AND a.ctl_cod_gerencia = c.ctl_cod_gerencia
                     AND a.ctl_cod_numero = c.ctl_cod_numero
                     AND c.ctl_num = 0
                     AND c.ctl_lstope = 'U';
        ELSE
            v_codigo := prm_codigocontrol;
        END IF;

        OPEN ct FOR
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '/'
                     || b.alc_aduana
                     || '/'
                     || 'C-'
                     || b.alc_numero
                         tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (g.sad_reg_date, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item,
                     c.ali_tipo_etapa
              FROM   fis_control a,
                     fis_alcance b,
                     fis_alcance_item c,
                     ops$asy.sad_gen g
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND (b.alc_tipo_alcance = 'ITEM'
                          OR b.alc_tipo_alcance = 'DECLARACION')
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND b.alc_gestion = g.sad_reg_year
                     AND b.alc_aduana = g.key_cuo
                     AND g.sad_reg_serial = 'C'
                     AND b.alc_numero = g.sad_reg_nber
                     AND g.sad_num = 0
                     AND a.ctl_control_id = prm_codigocontrol
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_numero
                     || '-'
                     || b.alc_proveedor
                     || '-'
                     || pkg_general.devuelve_pais (b.alc_pais)
                         tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item,
                     c.ali_tipo_etapa
              FROM   fis_control a, fis_alcance b, fis_alcance_item c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'FACTURA'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND a.ctl_control_id = prm_codigocontrol
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '/'
                     || b.alc_aduana
                     || '/'
                     || b.alc_numero
                         tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item,
                     c.ali_tipo_etapa
              FROM   fis_control a, fis_alcance b, fis_alcance_item c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'MANIFIESTO'
                     AND b.alc_tipo_tramite = 'MIC'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND a.ctl_control_id = prm_codigocontrol
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                     b.alc_gestion || '-' || b.alc_proveedor tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item,
                     c.ali_tipo_etapa
              FROM   fis_control a, fis_alcance b, fis_alcance_item c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'TRANSFERENCIA'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = prm_codigocontrol
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '-'
                     || b.alc_proveedor
                     || '-'
                     || b.alc_tipo_documento
                         tramite,
                     b.alc_tipo_alcance,
                     b.alc_tipo_etapa,
                     c.ali_numero_item,
                     DECODE (c.ali_obs_valor, 'x', 'X', ''),
                     DECODE (c.ali_obs_origen, 'x', 'X', ''),
                     DECODE (c.ali_obs_partida, 'x', 'X', ''),
                     DECODE (c.ali_obs_otro, 'x', 'X', ''),
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     b.alc_alcance_id || '-' || c.ali_numero_item,
                     c.ali_tipo_etapa
              FROM   fis_control a, fis_alcance b, fis_alcance_item c
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'OTROS'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = b.alc_alcance_id
                     AND a.ctl_control_id = prm_codigocontrol
            ORDER BY   2, 3;

        RETURN res;
    END;

    FUNCTION graba_duis_selec (prm_id              VARCHAR2,
                               prm_ids_concat      VARCHAR2,
                               prm_tipo_tramite    VARCHAR2,
                               prm_usuario         VARCHAR2,
                               prm_tipo_etapa      VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;
    BEGIN
        cad := prm_ids_concat;

        WHILE (LENGTH (cad) > 0)
        LOOP
            total := total + 1;
            val := TO_NUMBER (SUBSTR (cad, 0, INSTR (cad, ',') - 1));
            cad := SUBSTR (cad, INSTR (cad, ',') + 1, LENGTH (cad));
            v_key_year := SUBSTR (val, 1, 4);
            v_key_cou := SUBSTR (val, 5, 3);
            v_reg_nber := SUBSTR (val, 8, LENGTH (val) - 7);

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_alcance b
             WHERE       b.alc_gestion = v_key_year
                     AND b.alc_aduana = v_key_cou
                     AND b.alc_numero = v_reg_nber
                     AND b.alc_tipo_tramite = prm_tipo_tramite
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U';

            IF existe = 0
            THEN
                grabadas := grabadas + 1;
                v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                v_numero := numero_control_alc (v_gestion);

                INSERT INTO fis_alcance (alc_alcance_id,
                                         alc_tipo_alcance,
                                         alc_tipo_tramite,
                                         alc_gestion,
                                         alc_aduana,
                                         alc_numero,
                                         alc_num,
                                         alc_lstope,
                                         alc_usuario,
                                         alc_fecsys,
                                         ctl_control_id,
                                         alc_tipo_etapa)
                  VALUES   (v_gestion || TO_CHAR (v_numero),
                            'DECLARACION',
                            prm_tipo_tramite,
                            SUBSTR (val, 1, 4),
                            SUBSTR (val, 5, 3),
                            SUBSTR (val, 8, LENGTH (val) - 7),
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE,
                            prm_id,
                            prm_tipo_etapa);
            ELSE
                error_dui :=
                       error_dui
                    || v_key_year
                    || '/'
                    || v_key_cou
                    || '/C-'
                    || v_reg_nber
                    || ' - ';
            END IF;
        END LOOP;

        COMMIT;
        res := 'CORRECTOSe grabaron correctamente las declaraciones';

        IF LENGTH (error_dui) > 0
        THEN
            res :=
                res
                || ', Las siguientes declaraciones ya se encuentran registradas en otro control: '
                || error_dui;
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_duis_selec2 (prm_id                 VARCHAR2,
                                prm_ids_concat         VARCHAR2,
                                prm_tipo_tramite       VARCHAR2,
                                prm_usuario            VARCHAR2,
                                prm_tipo_etapa         VARCHAR2,
                                prm_numero_operador    VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        error_dui2   VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;

        operador     VARCHAR2 (15);
        declarante   VARCHAR2 (15);
    BEGIN
        cad := prm_ids_concat;

        WHILE (LENGTH (cad) > 0)
        LOOP
            total := total + 1;
            --val := TO_NUMBER (SUBSTR (cad, 0, INSTR (cad, ',') - 1));
            val := SUBSTR (cad, 0, INSTR (cad, ',') - 1);
            cad := SUBSTR (cad, INSTR (cad, ',') + 1, LENGTH (cad));

            operador := TO_NUMBER (SUBSTR (val, 0, INSTR (val, ':') - 1));
            val := SUBSTR (val, INSTR (val, ':') + 1, LENGTH (val));
            declarante := TO_NUMBER (SUBSTR (val, 0, INSTR (val, ':') - 1));
            val := SUBSTR (val, INSTR (val, ':') + 1, LENGTH (val));

            v_key_year := SUBSTR (val, 1, 4);
            v_key_cou := SUBSTR (val, 5, 3);
            v_reg_nber := SUBSTR (val, 8, LENGTH (val) - 7);

            IF prm_numero_operador = operador
               OR prm_numero_operador = declarante
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance b
                 WHERE       b.alc_gestion = v_key_year
                         AND b.alc_aduana = v_key_cou
                         AND b.alc_numero = v_reg_nber
                         AND b.alc_tipo_tramite = prm_tipo_tramite
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U';

                IF existe = 0
                THEN
                    grabadas := grabadas + 1;
                    v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                    v_numero := numero_control_alc (v_gestion);

                    INSERT INTO fis_alcance (alc_alcance_id,
                                             alc_tipo_alcance,
                                             alc_tipo_tramite,
                                             alc_gestion,
                                             alc_aduana,
                                             alc_numero,
                                             alc_num,
                                             alc_lstope,
                                             alc_usuario,
                                             alc_fecsys,
                                             ctl_control_id,
                                             alc_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                'DECLARACION',
                                prm_tipo_tramite,
                                SUBSTR (val, 1, 4),
                                SUBSTR (val, 5, 3),
                                SUBSTR (val, 8, LENGTH (val) - 7),
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_id,
                                prm_tipo_etapa);
                ELSE
                    error_dui :=
                           error_dui
                        || v_key_year
                        || '/'
                        || v_key_cou
                        || '/C-'
                        || v_reg_nber
                        || ' - ';
                END IF;
            ELSE
                error_dui2 :=
                       error_dui
                    || v_key_year
                    || '/'
                    || v_key_cou
                    || '/C-'
                    || v_reg_nber
                    || ' - ';
            END IF;
        END LOOP;

        COMMIT;
        res := 'CORRECTOSe grabaron correctamente las declaraciones';

        IF LENGTH (error_dui) > 0
        THEN
            res :=
                res
                || ', <br>Las siguientes declaraciones ya se encuentran registradas en otro Control: '
                || error_dui;
        END IF;

        IF LENGTH (error_dui2) > 0
        THEN
            res :=
                res
                || ', <br>Las siguientes declaraciones no corresponden al Operador: '
                || error_dui2;
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;


    FUNCTION graba_duis_selecitem (prm_id               VARCHAR2,
                                   prm_ids_concatval    VARCHAR2,
                                   prm_ids_concatpar    VARCHAR2,
                                   prm_ids_concatori    VARCHAR2,
                                   prm_ids_concatotr    VARCHAR2,
                                   prm_tipo_tramite     VARCHAR2,
                                   prm_usuario          VARCHAR2,
                                   prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        v_item       VARCHAR2 (10);
        v_codigo     NUMBER (18, 0);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;
    BEGIN
        IF LENGTH (prm_ids_concatval) > 3
        THEN
            cad := prm_ids_concatval;
            total := 0;

            WHILE (LENGTH (cad) > 0)
            LOOP
                total := total + 1;
                val := SUBSTR (cad, 0, INSTR (cad, ',') - 1);
                cad := SUBSTR (cad, INSTR (cad, ',') + 1, LENGTH (cad));

                v_item := SUBSTR (val, 0, INSTR (val, '-') - 1);
                v_key_year :=
                    SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 0, 4);
                v_key_cou := SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 5, 3)
;
                v_reg_nber := SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 8);

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance b
                 WHERE       b.alc_gestion = v_key_year
                         AND b.alc_aduana = v_key_cou
                         AND b.alc_numero = v_reg_nber
                         AND b.alc_tipo_tramite = prm_tipo_tramite
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U';

                IF existe = 0
                THEN
                    grabadas := grabadas + 1;
                    v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                    v_numero := numero_control_alc (v_gestion);

                    INSERT INTO fis_alcance (alc_alcance_id,
                                             alc_tipo_alcance,
                                             alc_tipo_tramite,
                                             alc_gestion,
                                             alc_aduana,
                                             alc_numero,
                                             alc_num,
                                             alc_lstope,
                                             alc_usuario,
                                             alc_fecsys,
                                             ctl_control_id,
                                             alc_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                'ITEM',
                                prm_tipo_tramite,
                                v_key_year,
                                v_key_cou,
                                v_reg_nber,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_id,
                                prm_tipo_etapa);

                    INSERT INTO fis_alcance_item (alc_alcance_id,
                                                  ali_numero_item,
                                                  ali_obs_valor,
                                                  ali_obs_partida,
                                                  ali_obs_origen,
                                                  ali_num,
                                                  ali_lstope,
                                                  ali_usuario,
                                                  ali_fecsys,
                                                  ali_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                v_item,
                                'x',
                                NULL,
                                NULL,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_tipo_etapa);
                ELSE
                    SELECT   b.alc_alcance_id
                      INTO   v_codigo
                      FROM   fis_alcance b
                     WHERE       b.alc_gestion = v_key_year
                             AND b.alc_aduana = v_key_cou
                             AND b.alc_numero = v_reg_nber
                             AND b.alc_tipo_tramite = prm_tipo_tramite
                             AND b.alc_num = 0
                             AND b.alc_lstope = 'U';

                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_alcance_item b
                     WHERE   b.alc_alcance_id = v_codigo
                             AND b.ali_numero_item = v_item;

                    IF existe = 0
                    THEN
                        INSERT INTO fis_alcance_item (alc_alcance_id,
                                                      ali_numero_item,
                                                      ali_obs_valor,
                                                      ali_obs_partida,
                                                      ali_obs_origen,
                                                      ali_num,
                                                      ali_lstope,
                                                      ali_usuario,
                                                      ali_fecsys,
                                                      ali_tipo_etapa)
                          VALUES   (v_codigo,
                                    v_item,
                                    'x',
                                    NULL,
                                    NULL,
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_tipo_etapa);
                    ELSE
                        UPDATE   fis_alcance_item
                           SET   ali_num = existe
                         WHERE       alc_alcance_id = v_codigo
                                 AND ali_numero_item = v_item
                                 AND ali_num = 0;

                        INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                        a.ali_numero_item,
                                                        a.ali_obs_valor,
                                                        a.ali_obs_partida,
                                                        a.ali_obs_origen,
                                                        a.ali_num,
                                                        a.ali_lstope,
                                                        a.ali_usuario,
                                                        a.ali_fecsys,
                                                        a.ali_obs_otro,
                                                        a.ali_tipo_etapa)
                            SELECT   alc_alcance_id,
                                     ali_numero_item,
                                     'x',
                                     ali_obs_partida,
                                     ali_obs_origen,
                                     0,
                                     'U',
                                     prm_usuario,
                                     SYSDATE,
                                     ali_obs_otro,
                                     ali_tipo_etapa
                              FROM   fis_alcance_item
                             WHERE       alc_alcance_id = v_codigo
                                     AND ali_numero_item = v_item
                                     AND ali_num = existe
                                     AND ROWNUM = 1;
                    END IF;
                END IF;

                COMMIT;
            END LOOP;
        END IF;

        IF LENGTH (prm_ids_concatpar) > 3
        THEN
            cad := prm_ids_concatpar;
            total := 0;

            WHILE (LENGTH (cad) > 0)
            LOOP
                total := total + 1;
                val := SUBSTR (cad, 0, INSTR (cad, ',') - 1);
                cad := SUBSTR (cad, INSTR (cad, ',') + 1, LENGTH (cad));
                v_item := SUBSTR (val, 0, INSTR (val, '-') - 1);
                v_key_year :=
                    SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 0, 4);
                v_key_cou := SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 5, 3)
;
                v_reg_nber := SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 8);

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance b
                 WHERE       b.alc_gestion = v_key_year
                         AND b.alc_aduana = v_key_cou
                         AND b.alc_numero = v_reg_nber
                         AND b.alc_tipo_tramite = prm_tipo_tramite
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U';

                IF existe = 0
                THEN
                    grabadas := grabadas + 1;
                    v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                    v_numero := numero_control_alc (v_gestion);

                    INSERT INTO fis_alcance (alc_alcance_id,
                                             alc_tipo_alcance,
                                             alc_tipo_tramite,
                                             alc_gestion,
                                             alc_aduana,
                                             alc_numero,
                                             alc_num,
                                             alc_lstope,
                                             alc_usuario,
                                             alc_fecsys,
                                             ctl_control_id,
                                             alc_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                'ITEM',
                                prm_tipo_tramite,
                                v_key_year,
                                v_key_cou,
                                v_reg_nber,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_id,
                                prm_tipo_etapa);

                    INSERT INTO fis_alcance_item (alc_alcance_id,
                                                  ali_numero_item,
                                                  ali_obs_valor,
                                                  ali_obs_partida,
                                                  ali_obs_origen,
                                                  ali_num,
                                                  ali_lstope,
                                                  ali_usuario,
                                                  ali_fecsys,
                                                  ali_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                v_item,
                                NULL,
                                'x',
                                NULL,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_tipo_etapa);
                ELSE
                    SELECT   b.alc_alcance_id
                      INTO   v_codigo
                      FROM   fis_alcance b
                     WHERE       b.alc_gestion = v_key_year
                             AND b.alc_aduana = v_key_cou
                             AND b.alc_numero = v_reg_nber
                             AND b.alc_tipo_tramite = prm_tipo_tramite
                             AND b.alc_num = 0
                             AND b.alc_lstope = 'U';

                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_alcance_item b
                     WHERE   b.alc_alcance_id = v_codigo
                             AND b.ali_numero_item = v_item;

                    IF existe = 0
                    THEN
                        INSERT INTO fis_alcance_item (alc_alcance_id,
                                                      ali_numero_item,
                                                      ali_obs_valor,
                                                      ali_obs_partida,
                                                      ali_obs_origen,
                                                      ali_num,
                                                      ali_lstope,
                                                      ali_usuario,
                                                      ali_fecsys,
                                                      ali_tipo_etapa)
                          VALUES   (v_codigo,
                                    v_item,
                                    NULL,
                                    'x',
                                    NULL,
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_tipo_etapa);
                    ELSE
                        UPDATE   fis_alcance_item
                           SET   ali_num = existe
                         WHERE       alc_alcance_id = v_codigo
                                 AND ali_numero_item = v_item
                                 AND ali_num = 0;

                        INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                        a.ali_numero_item,
                                                        a.ali_obs_valor,
                                                        a.ali_obs_partida,
                                                        a.ali_obs_origen,
                                                        a.ali_num,
                                                        a.ali_lstope,
                                                        a.ali_usuario,
                                                        a.ali_fecsys,
                                                        a.ali_obs_otro,
                                                        a.ali_tipo_etapa)
                            SELECT   alc_alcance_id,
                                     ali_numero_item,
                                     ali_obs_valor,
                                     'x',
                                     ali_obs_origen,
                                     0,
                                     'U',
                                     prm_usuario,
                                     SYSDATE,
                                     ali_obs_otro,
                                     ali_tipo_etapa
                              FROM   fis_alcance_item
                             WHERE       alc_alcance_id = v_codigo
                                     AND ali_numero_item = v_item
                                     AND ali_num = existe
                                     AND ROWNUM = 1;
                    END IF;
                END IF;

                COMMIT;
            END LOOP;
        END IF;

        IF LENGTH (prm_ids_concatori) > 3
        THEN
            cad := prm_ids_concatori;
            total := 0;

            WHILE (LENGTH (cad) > 0)
            LOOP
                total := total + 1;
                val := SUBSTR (cad, 0, INSTR (cad, ',') - 1);
                cad := SUBSTR (cad, INSTR (cad, ',') + 1, LENGTH (cad));
                v_item := SUBSTR (val, 0, INSTR (val, '-') - 1);
                v_key_year :=
                    SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 0, 4);
                v_key_cou := SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 5, 3)
;
                v_reg_nber := SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 8);

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance b
                 WHERE       b.alc_gestion = v_key_year
                         AND b.alc_aduana = v_key_cou
                         AND b.alc_numero = v_reg_nber
                         AND b.alc_tipo_tramite = prm_tipo_tramite
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U';

                IF existe = 0
                THEN
                    grabadas := grabadas + 1;
                    v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                    v_numero := numero_control_alc (v_gestion);

                    INSERT INTO fis_alcance (alc_alcance_id,
                                             alc_tipo_alcance,
                                             alc_tipo_tramite,
                                             alc_gestion,
                                             alc_aduana,
                                             alc_numero,
                                             alc_num,
                                             alc_lstope,
                                             alc_usuario,
                                             alc_fecsys,
                                             ctl_control_id,
                                             alc_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                'ITEM',
                                prm_tipo_tramite,
                                v_key_year,
                                v_key_cou,
                                v_reg_nber,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_id,
                                prm_tipo_etapa);

                    INSERT INTO fis_alcance_item (alc_alcance_id,
                                                  ali_numero_item,
                                                  ali_obs_valor,
                                                  ali_obs_partida,
                                                  ali_obs_origen,
                                                  ali_num,
                                                  ali_lstope,
                                                  ali_usuario,
                                                  ali_fecsys,
                                                  ali_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                v_item,
                                NULL,
                                NULL,
                                'x',
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_tipo_etapa);
                ELSE
                    SELECT   b.alc_alcance_id
                      INTO   v_codigo
                      FROM   fis_alcance b
                     WHERE       b.alc_gestion = v_key_year
                             AND b.alc_aduana = v_key_cou
                             AND b.alc_numero = v_reg_nber
                             AND b.alc_tipo_tramite = prm_tipo_tramite
                             AND b.alc_num = 0
                             AND b.alc_lstope = 'U';

                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_alcance_item b
                     WHERE   b.alc_alcance_id = v_codigo
                             AND b.ali_numero_item = v_item;

                    IF existe = 0
                    THEN
                        INSERT INTO fis_alcance_item (alc_alcance_id,
                                                      ali_numero_item,
                                                      ali_obs_valor,
                                                      ali_obs_partida,
                                                      ali_obs_origen,
                                                      ali_num,
                                                      ali_lstope,
                                                      ali_usuario,
                                                      ali_fecsys,
                                                      ali_tipo_etapa)
                          VALUES   (v_codigo,
                                    v_item,
                                    NULL,
                                    NULL,
                                    'x',
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_tipo_etapa);
                    ELSE
                        UPDATE   fis_alcance_item
                           SET   ali_num = existe
                         WHERE       alc_alcance_id = v_codigo
                                 AND ali_numero_item = v_item
                                 AND ali_num = 0;

                        INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                        a.ali_numero_item,
                                                        a.ali_obs_valor,
                                                        a.ali_obs_partida,
                                                        a.ali_obs_origen,
                                                        a.ali_num,
                                                        a.ali_lstope,
                                                        a.ali_usuario,
                                                        a.ali_fecsys,
                                                        a.ali_obs_otro,
                                                        a.ali_tipo_etapa)
                            SELECT   alc_alcance_id,
                                     ali_numero_item,
                                     ali_obs_valor,
                                     ali_obs_partida,
                                     'x',
                                     0,
                                     'U',
                                     prm_usuario,
                                     SYSDATE,
                                     ali_obs_otro,
                                     ali_tipo_etapa
                              FROM   fis_alcance_item
                             WHERE       alc_alcance_id = v_codigo
                                     AND ali_numero_item = v_item
                                     AND ali_num = existe
                                     AND ROWNUM = 1;
                    END IF;
                END IF;

                COMMIT;
            END LOOP;
        END IF;

        IF LENGTH (prm_ids_concatotr) > 3
        THEN
            cad := prm_ids_concatotr;
            total := 0;

            WHILE (LENGTH (cad) > 0)
            LOOP
                total := total + 1;
                val := SUBSTR (cad, 0, INSTR (cad, ',') - 1);
                cad := SUBSTR (cad, INSTR (cad, ',') + 1, LENGTH (cad));
                v_item := SUBSTR (val, 0, INSTR (val, '-') - 1);
                v_key_year :=
                    SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 0, 4);
                v_key_cou := SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 5, 3)
;
                v_reg_nber := SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 8);

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance b
                 WHERE       b.alc_gestion = v_key_year
                         AND b.alc_aduana = v_key_cou
                         AND b.alc_numero = v_reg_nber
                         AND b.alc_tipo_tramite = prm_tipo_tramite
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U';

                IF existe = 0
                THEN
                    grabadas := grabadas + 1;
                    v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                    v_numero := numero_control_alc (v_gestion);

                    INSERT INTO fis_alcance (alc_alcance_id,
                                             alc_tipo_alcance,
                                             alc_tipo_tramite,
                                             alc_gestion,
                                             alc_aduana,
                                             alc_numero,
                                             alc_num,
                                             alc_lstope,
                                             alc_usuario,
                                             alc_fecsys,
                                             ctl_control_id,
                                             alc_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                'ITEM',
                                prm_tipo_tramite,
                                v_key_year,
                                v_key_cou,
                                v_reg_nber,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_id,
                                prm_tipo_etapa);

                    INSERT INTO fis_alcance_item (alc_alcance_id,
                                                  ali_numero_item,
                                                  ali_obs_valor,
                                                  ali_obs_partida,
                                                  ali_obs_origen,
                                                  ali_num,
                                                  ali_lstope,
                                                  ali_usuario,
                                                  ali_fecsys,
                                                  ali_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                v_item,
                                NULL,
                                NULL,
                                'x',
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_tipo_etapa);
                ELSE
                    SELECT   b.alc_alcance_id
                      INTO   v_codigo
                      FROM   fis_alcance b
                     WHERE       b.alc_gestion = v_key_year
                             AND b.alc_aduana = v_key_cou
                             AND b.alc_numero = v_reg_nber
                             AND b.alc_tipo_tramite = prm_tipo_tramite
                             AND b.alc_num = 0
                             AND b.alc_lstope = 'U';

                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_alcance_item b
                     WHERE   b.alc_alcance_id = v_codigo
                             AND b.ali_numero_item = v_item;

                    IF existe = 0
                    THEN
                        INSERT INTO fis_alcance_item (alc_alcance_id,
                                                      ali_numero_item,
                                                      ali_obs_valor,
                                                      ali_obs_partida,
                                                      ali_obs_origen,
                                                      ali_num,
                                                      ali_lstope,
                                                      ali_usuario,
                                                      ali_fecsys,
                                                      ali_tipo_etapa)
                          VALUES   (v_codigo,
                                    v_item,
                                    NULL,
                                    NULL,
                                    'x',
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_tipo_etapa);
                    ELSE
                        UPDATE   fis_alcance_item
                           SET   ali_num = existe
                         WHERE       alc_alcance_id = v_codigo
                                 AND ali_numero_item = v_item
                                 AND ali_num = 0;

                        INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                        a.ali_numero_item,
                                                        a.ali_obs_valor,
                                                        a.ali_obs_partida,
                                                        a.ali_obs_origen,
                                                        a.ali_num,
                                                        a.ali_lstope,
                                                        a.ali_usuario,
                                                        a.ali_fecsys,
                                                        a.ali_obs_otro,
                                                        a.ali_tipo_etapa)
                            SELECT   alc_alcance_id,
                                     ali_numero_item,
                                     ali_obs_valor,
                                     ali_obs_partida,
                                     'x',
                                     0,
                                     'U',
                                     prm_usuario,
                                     SYSDATE,
                                     ali_obs_otro,
                                     ali_tipo_etapa
                              FROM   fis_alcance_item
                             WHERE       alc_alcance_id = v_codigo
                                     AND ali_numero_item = v_item
                                     AND ali_num = existe
                                     AND ROWNUM = 1;
                    END IF;
                END IF;

                COMMIT;
            END LOOP;
        END IF;

        COMMIT;
        res := 'CORRECTOSe grabaron correctamente las Declaraciones';

        IF LENGTH (error_dui) > 0
        THEN
            res :=
                res
                || ', Las siguientes declaraciones ya se encuentran registradas en otro Control: '
                || error_dui;
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_duis_selecitemval (prm_id               VARCHAR2,
                                      prm_ids_concatval    VARCHAR2,
                                      prm_tipo_tramite     VARCHAR2,
                                      prm_usuario          VARCHAR2,
                                      prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        v_item       VARCHAR2 (10);
        v_codigo     NUMBER (18, 0);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;
    BEGIN
        IF LENGTH (prm_ids_concatval) > 0
        THEN
            cad := prm_ids_concatval;
            total := 0;

            WHILE (LENGTH (cad) > 0)
            LOOP
                total := total + 1;
                val := SUBSTR (cad, 0, INSTR (cad, ',') - 1);
                cad := SUBSTR (cad, INSTR (cad, ',') + 1, LENGTH (cad));

                v_item := SUBSTR (val, 0, INSTR (val, '-') - 1);
                v_key_year :=
                    SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 0, 4);
                v_key_cou := SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 5, 3)
;
                v_reg_nber := SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 8);

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance b
                 WHERE       b.alc_gestion = v_key_year
                         AND b.alc_aduana = v_key_cou
                         AND b.alc_numero = v_reg_nber
                         AND b.alc_tipo_tramite = prm_tipo_tramite
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND b.ctl_control_id = prm_id;

                IF existe = 0
                THEN
                    grabadas := grabadas + 1;
                    v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                    v_numero := numero_control_alc (v_gestion);

                    INSERT INTO fis_alcance (alc_alcance_id,
                                             alc_tipo_alcance,
                                             alc_tipo_tramite,
                                             alc_gestion,
                                             alc_aduana,
                                             alc_numero,
                                             alc_num,
                                             alc_lstope,
                                             alc_usuario,
                                             alc_fecsys,
                                             ctl_control_id,
                                             alc_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                'ITEM',
                                prm_tipo_tramite,
                                v_key_year,
                                v_key_cou,
                                v_reg_nber,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_id,
                                prm_tipo_etapa);

                    INSERT INTO fis_alcance_item (alc_alcance_id,
                                                  ali_numero_item,
                                                  ali_obs_valor,
                                                  ali_obs_partida,
                                                  ali_obs_origen,
                                                  ali_num,
                                                  ali_lstope,
                                                  ali_usuario,
                                                  ali_fecsys,
                                                  ali_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                v_item,
                                'x',
                                NULL,
                                NULL,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_tipo_etapa);
                ELSE
                    SELECT   b.alc_alcance_id
                      INTO   v_codigo
                      FROM   fis_alcance b
                     WHERE       b.alc_gestion = v_key_year
                             AND b.alc_aduana = v_key_cou
                             AND b.alc_numero = v_reg_nber
                             AND b.alc_tipo_tramite = prm_tipo_tramite
                             AND b.alc_num = 0
                             AND b.alc_lstope = 'U'
                             AND b.ctl_control_id = prm_id;

                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_alcance_item b
                     WHERE   b.alc_alcance_id = v_codigo
                             AND b.ali_numero_item = v_item;

                    IF existe = 0
                    THEN
                        INSERT INTO fis_alcance_item (alc_alcance_id,
                                                      ali_numero_item,
                                                      ali_obs_valor,
                                                      ali_obs_partida,
                                                      ali_obs_origen,
                                                      ali_num,
                                                      ali_lstope,
                                                      ali_usuario,
                                                      ali_fecsys,
                                                      ali_tipo_etapa)
                          VALUES   (v_codigo,
                                    v_item,
                                    'x',
                                    NULL,
                                    NULL,
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_tipo_etapa);
                    ELSE
                        SELECT   b.ali_lstope
                          INTO   res
                          FROM   fis_alcance_item b
                         WHERE       b.alc_alcance_id = v_codigo
                                 AND b.ali_numero_item = v_item
                                 AND b.ali_num = 0;

                        IF res = 'U'
                        THEN
                            UPDATE   fis_alcance_item
                               SET   ali_num = existe
                             WHERE       alc_alcance_id = v_codigo
                                     AND ali_numero_item = v_item
                                     AND ali_num = 0;

                            INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                            a.ali_numero_item,
                                                            a.ali_obs_valor,
                                                            a.ali_obs_partida,
                                                            a.ali_obs_origen,
                                                            a.ali_num,
                                                            a.ali_lstope,
                                                            a.ali_usuario,
                                                            a.ali_fecsys,
                                                            a.ali_obs_otro,
                                                            a.ali_tipo_etapa)
                                SELECT   alc_alcance_id,
                                         ali_numero_item,
                                         'x',
                                         ali_obs_partida,
                                         ali_obs_origen,
                                         0,
                                         'U',
                                         prm_usuario,
                                         SYSDATE,
                                         ali_obs_otro,
                                         ali_tipo_etapa
                                  FROM   fis_alcance_item
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = existe
                                         AND ROWNUM = 1;
                        ELSE
                            UPDATE   fis_alcance_item
                               SET   ali_num = existe
                             WHERE       alc_alcance_id = v_codigo
                                     AND ali_numero_item = v_item
                                     AND ali_num = 0;

                            INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                            a.ali_numero_item,
                                                            a.ali_obs_valor,
                                                            a.ali_obs_partida,
                                                            a.ali_obs_origen,
                                                            a.ali_num,
                                                            a.ali_lstope,
                                                            a.ali_usuario,
                                                            a.ali_fecsys,
                                                            a.ali_obs_otro,
                                                            a.ali_tipo_etapa)
                                SELECT   alc_alcance_id,
                                         ali_numero_item,
                                         'x',
                                         NULL,
                                         NULL,
                                         0,
                                         'U',
                                         prm_usuario,
                                         SYSDATE,
                                         NULL,
                                         ali_tipo_etapa
                                  FROM   fis_alcance_item
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = existe
                                         AND ROWNUM = 1;
                        END IF;
                    END IF;
                END IF;
            END LOOP;
        END IF;

        COMMIT;
        res := 'CORRECTOSe grabaron correctamente las Declaraciones';

        IF LENGTH (error_dui) > 0
        THEN
            res :=
                res
                || ', Las siguientes declaraciones ya se encuentran registradas en otro Control: '
                || error_dui;
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_duis_selecitemotr (prm_id               VARCHAR2,
                                      prm_ids_concatotr    VARCHAR2,
                                      prm_tipo_tramite     VARCHAR2,
                                      prm_usuario          VARCHAR2,
                                      prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        v_item       VARCHAR2 (10);
        v_codigo     NUMBER (18, 0);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;
    BEGIN
        IF LENGTH (prm_ids_concatotr) > 0
        THEN
            cad := prm_ids_concatotr;
            total := 0;

            WHILE (LENGTH (cad) > 0)
            LOOP
                total := total + 1;
                val := SUBSTR (cad, 0, INSTR (cad, ',') - 1);
                cad := SUBSTR (cad, INSTR (cad, ',') + 1, LENGTH (cad));

                v_item := SUBSTR (val, 0, INSTR (val, '-') - 1);
                v_key_year :=
                    SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 0, 4);
                v_key_cou := SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 5, 3)
;
                v_reg_nber := SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 8);

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance b
                 WHERE       b.alc_gestion = v_key_year
                         AND b.alc_aduana = v_key_cou
                         AND b.alc_numero = v_reg_nber
                         AND b.alc_tipo_tramite = prm_tipo_tramite
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND b.ctl_control_id = prm_id;

                IF existe = 0
                THEN
                    grabadas := grabadas + 1;
                    v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                    v_numero := numero_control_alc (v_gestion);

                    INSERT INTO fis_alcance (alc_alcance_id,
                                             alc_tipo_alcance,
                                             alc_tipo_tramite,
                                             alc_gestion,
                                             alc_aduana,
                                             alc_numero,
                                             alc_num,
                                             alc_lstope,
                                             alc_usuario,
                                             alc_fecsys,
                                             ctl_control_id,
                                             alc_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                'ITEM',
                                prm_tipo_tramite,
                                v_key_year,
                                v_key_cou,
                                v_reg_nber,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_id,
                                prm_tipo_etapa);

                    INSERT INTO fis_alcance_item (alc_alcance_id,
                                                  ali_numero_item,
                                                  ali_obs_valor,
                                                  ali_obs_partida,
                                                  ali_obs_origen,
                                                  ali_num,
                                                  ali_lstope,
                                                  ali_usuario,
                                                  ali_fecsys,
                                                  ali_obs_otro,
                                                  ali_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                v_item,
                                NULL,
                                NULL,
                                NULL,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                'x',
                                prm_tipo_etapa);
                ELSE
                    SELECT   b.alc_alcance_id
                      INTO   v_codigo
                      FROM   fis_alcance b
                     WHERE       b.alc_gestion = v_key_year
                             AND b.alc_aduana = v_key_cou
                             AND b.alc_numero = v_reg_nber
                             AND b.alc_tipo_tramite = prm_tipo_tramite
                             AND b.alc_num = 0
                             AND b.alc_lstope = 'U'
                             AND b.ctl_control_id = prm_id;

                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_alcance_item b
                     WHERE   b.alc_alcance_id = v_codigo
                             AND b.ali_numero_item = v_item;

                    IF existe = 0
                    THEN
                        INSERT INTO fis_alcance_item (alc_alcance_id,
                                                      ali_numero_item,
                                                      ali_obs_valor,
                                                      ali_obs_partida,
                                                      ali_obs_origen,
                                                      ali_num,
                                                      ali_lstope,
                                                      ali_usuario,
                                                      ali_fecsys,
                                                      ali_obs_otro,
                                                      ali_tipo_etapa)
                          VALUES   (v_codigo,
                                    v_item,
                                    NULL,
                                    NULL,
                                    NULL,
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    'x',
                                    prm_tipo_etapa);
                    ELSE
                        SELECT   b.ali_lstope
                          INTO   res
                          FROM   fis_alcance_item b
                         WHERE       b.alc_alcance_id = v_codigo
                                 AND b.ali_numero_item = v_item
                                 AND b.ali_num = 0;

                        IF res = 'U'
                        THEN
                            UPDATE   fis_alcance_item
                               SET   ali_num = existe
                             WHERE       alc_alcance_id = v_codigo
                                     AND ali_numero_item = v_item
                                     AND ali_num = 0;

                            INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                            a.ali_numero_item,
                                                            a.ali_obs_valor,
                                                            a.ali_obs_partida,
                                                            a.ali_obs_origen,
                                                            a.ali_num,
                                                            a.ali_lstope,
                                                            a.ali_usuario,
                                                            a.ali_fecsys,
                                                            a.ali_obs_otro,
                                                            a.ali_tipo_etapa)
                                SELECT   alc_alcance_id,
                                         ali_numero_item,
                                         ali_obs_valor,
                                         ali_obs_partida,
                                         ali_obs_origen,
                                         0,
                                         'U',
                                         prm_usuario,
                                         SYSDATE,
                                         'x',
                                         ali_tipo_etapa
                                  FROM   fis_alcance_item
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = existe
                                         AND ROWNUM = 1;
                        ELSE
                            UPDATE   fis_alcance_item
                               SET   ali_num = existe
                             WHERE       alc_alcance_id = v_codigo
                                     AND ali_numero_item = v_item
                                     AND ali_num = 0;

                            INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                            a.ali_numero_item,
                                                            a.ali_obs_valor,
                                                            a.ali_obs_partida,
                                                            a.ali_obs_origen,
                                                            a.ali_num,
                                                            a.ali_lstope,
                                                            a.ali_usuario,
                                                            a.ali_fecsys,
                                                            a.ali_obs_otro,
                                                            a.ali_tipo_etapa)
                                SELECT   alc_alcance_id,
                                         ali_numero_item,
                                         NULL,
                                         NULL,
                                         NULL,
                                         0,
                                         'U',
                                         prm_usuario,
                                         SYSDATE,
                                         'x',
                                         ali_tipo_etapa
                                  FROM   fis_alcance_item
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = existe
                                         AND ROWNUM = 1;
                        END IF;
                    END IF;
                END IF;
            END LOOP;
        END IF;

        COMMIT;
        res := 'CORRECTOSe grabaron correctamente las Declaraciones';

        IF LENGTH (error_dui) > 0
        THEN
            res :=
                res
                || ', Las siguientes declaraciones ya se encuentran registradas en otro control: '
                || error_dui;
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_tramite_dec (prm_id              VARCHAR2,
                                prm_tipo_tramite    VARCHAR2,
                                prm_gestion         VARCHAR2,
                                prm_aduana          VARCHAR2,
                                prm_numero          VARCHAR2,
                                prm_usuario         VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        v_item       VARCHAR2 (10);
        v_codigo     NUMBER (18, 0);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_alcance b
         WHERE       b.alc_gestion = prm_gestion
                 AND b.alc_aduana = prm_aduana
                 AND b.alc_numero = prm_numero
                 AND b.alc_tipo_tramite = prm_tipo_tramite
                 AND b.alc_num = 0
                 AND b.alc_lstope = 'U'
                 AND b.ctl_control_id = prm_id;

        RETURN res;
    END;

    FUNCTION graba_tramite_factura (prm_id              VARCHAR2,
                                    prm_tipo_tramite    VARCHAR2,
                                    prm_numero          VARCHAR2,
                                    prm_fecha           VARCHAR2,
                                    prm_proveedor       VARCHAR2,
                                    prm_origen          VARCHAR2,
                                    prm_usuario         VARCHAR2,
                                    prm_tipo_etapa      VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        v_item       VARCHAR2 (10);
        v_codigo     NUMBER (18, 0);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;
    BEGIN
        IF TO_DATE (prm_fecha, 'dd/mm/yyyy') > TRUNC (SYSDATE)
        THEN
            RETURN 'La fecha no puede ser mayor a la actual';
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_alcance b
             WHERE       b.alc_numero = prm_numero
                     AND b.alc_fecha = TO_DATE (prm_fecha, 'dd/mm/yyyy')
                     AND b.alc_proveedor = prm_proveedor
                     AND b.alc_pais = prm_origen
                     AND b.alc_tipo_tramite = prm_tipo_tramite
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND b.ctl_control_id = prm_id;

            IF existe = 0
            THEN
                v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                v_numero := numero_control_alc (v_gestion);

                INSERT INTO fis_alcance (alc_alcance_id,
                                         alc_tipo_alcance,
                                         alc_tipo_tramite,
                                         alc_gestion,
                                         alc_numero,
                                         alc_fecha,
                                         alc_proveedor,
                                         alc_pais,
                                         alc_num,
                                         alc_lstope,
                                         alc_usuario,
                                         alc_fecsys,
                                         ctl_control_id,
                                         alc_tipo_etapa)
                  VALUES   (v_gestion || TO_CHAR (v_numero),
                            'TRAMITE',
                            prm_tipo_tramite,
                            TO_CHAR (SYSDATE, 'YYYY'),
                            prm_numero,
                            TO_DATE (prm_fecha, 'dd/mm/yyyy'),
                            prm_proveedor,
                            prm_origen,
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE,
                            prm_id,
                            prm_tipo_etapa);

                INSERT INTO fis_alcance_item (alc_alcance_id,
                                              ali_numero_item,
                                              ali_obs_valor,
                                              ali_obs_partida,
                                              ali_obs_origen,
                                              ali_num,
                                              ali_lstope,
                                              ali_usuario,
                                              ali_fecsys,
                                              ali_tipo_etapa)
                  VALUES   (v_gestion || TO_CHAR (v_numero),
                            1,
                            NULL,
                            NULL,
                            NULL,
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE,
                            prm_tipo_etapa);

                COMMIT;
                res :=
                    'CORRECTOSe grab&oacute; correctamente el tr&aacute;mite';
            ELSE
                res := 'Ya se encuentra registrado el tr&aacute;mite';
            END IF;

            RETURN res;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_tramite_transferencia (prm_id              VARCHAR2,
                                          prm_tipo_tramite    VARCHAR2,
                                          prm_gestion         VARCHAR2,
                                          prm_fecha           VARCHAR2,
                                          prm_proveedor       VARCHAR2,
                                          prm_usuario         VARCHAR2,
                                          prm_tipo_etapa      VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        v_item       VARCHAR2 (10);
        v_codigo     NUMBER (18, 0);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;
    BEGIN
        IF TO_DATE (prm_fecha, 'dd/mm/yyyy') > TRUNC (SYSDATE)
        THEN
            RETURN 'La fecha no puede ser mayor a la actual';
        ELSE
            IF prm_gestion > TO_CHAR (SYSDATE, 'YYYY')
            THEN
                RETURN 'La Gesti&oacute;n no puede ser mayor a la actual, y debe ser una gesti&oacute;n valida'
;
            END IF;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_alcance b
             WHERE       b.alc_fecha = TO_DATE (prm_fecha, 'dd/mm/yyyy')
                     AND b.alc_proveedor = prm_proveedor
                     AND b.alc_gestion = prm_gestion
                     AND b.alc_tipo_tramite = prm_tipo_tramite
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND b.ctl_control_id = prm_id;

            IF existe = 0
            THEN
                v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                v_numero := numero_control_alc (v_gestion);

                INSERT INTO fis_alcance (alc_alcance_id,
                                         alc_tipo_alcance,
                                         alc_tipo_tramite,
                                         alc_gestion,
                                         alc_numero,
                                         alc_fecha,
                                         alc_proveedor,
                                         alc_num,
                                         alc_lstope,
                                         alc_usuario,
                                         alc_fecsys,
                                         ctl_control_id,
                                         alc_tipo_etapa)
                  VALUES   (v_gestion || TO_CHAR (v_numero),
                            'TRAMITE',
                            prm_tipo_tramite,
                            prm_gestion,
                            0,
                            TO_DATE (prm_fecha, 'dd/mm/yyyy'),
                            prm_proveedor,
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE,
                            prm_id,
                            prm_tipo_etapa);

                INSERT INTO fis_alcance_item (alc_alcance_id,
                                              ali_numero_item,
                                              ali_obs_valor,
                                              ali_obs_partida,
                                              ali_obs_origen,
                                              ali_num,
                                              ali_lstope,
                                              ali_usuario,
                                              ali_fecsys,
                                              ali_tipo_etapa)
                  VALUES   (v_gestion || TO_CHAR (v_numero),
                            1,
                            NULL,
                            NULL,
                            NULL,
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE,
                            prm_tipo_etapa);

                COMMIT;
                res :=
                    'CORRECTOSe grab&oacute; correctamente el tr&aacute;mite';
            ELSE
                res := 'Ya se encuentra registrado el tr&aacute;mite';
            END IF;

            RETURN res;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_tramite_otro (prm_id                VARCHAR2,
                                 prm_tipo_tramite      VARCHAR2,
                                 prm_gestion           VARCHAR2,
                                 prm_fecha             VARCHAR2,
                                 prm_proveedor         VARCHAR2,
                                 prm_tipo_documento    VARCHAR2,
                                 prm_usuario           VARCHAR2,
                                 prm_tipo_etapa        VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        v_item       VARCHAR2 (10);
        v_codigo     NUMBER (18, 0);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;
    BEGIN
        IF TO_DATE (prm_fecha, 'dd/mm/yyyy') > TRUNC (SYSDATE)
        THEN
            RETURN 'La fecha no puede ser mayor a la actual';
        ELSE
            IF prm_gestion > TO_CHAR (SYSDATE, 'YYYY')
            THEN
                RETURN 'La Gesti&oacute;n no puede ser mayor a la actual, y debe ser una gesti&oacute;n valida'
;
            END IF;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_alcance b
             WHERE       b.alc_fecha = TO_DATE (prm_fecha, 'dd/mm/yyyy')
                     AND b.alc_proveedor = prm_proveedor
                     AND b.alc_gestion = prm_gestion
                     AND b.alc_tipo_tramite = prm_tipo_tramite
                     AND b.alc_tipo_documento = prm_tipo_documento
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND b.ctl_control_id = prm_id;

            IF existe = 0
            THEN
                v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                v_numero := numero_control_alc (v_gestion);

                INSERT INTO fis_alcance (alc_alcance_id,
                                         alc_tipo_alcance,
                                         alc_tipo_tramite,
                                         alc_gestion,
                                         alc_numero,
                                         alc_fecha,
                                         alc_proveedor,
                                         alc_tipo_documento,
                                         alc_num,
                                         alc_lstope,
                                         alc_usuario,
                                         alc_fecsys,
                                         ctl_control_id,
                                         alc_tipo_etapa)
                  VALUES   (v_gestion || TO_CHAR (v_numero),
                            'TRAMITE',
                            prm_tipo_tramite,
                            prm_gestion,
                            0,
                            TO_DATE (prm_fecha, 'dd/mm/yyyy'),
                            prm_proveedor,
                            prm_tipo_documento,
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE,
                            prm_id,
                            prm_tipo_etapa);

                INSERT INTO fis_alcance_item (alc_alcance_id,
                                              ali_numero_item,
                                              ali_obs_valor,
                                              ali_obs_partida,
                                              ali_obs_origen,
                                              ali_num,
                                              ali_lstope,
                                              ali_usuario,
                                              ali_fecsys,
                                              ali_tipo_etapa)
                  VALUES   (v_gestion || TO_CHAR (v_numero),
                            1,
                            NULL,
                            NULL,
                            NULL,
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE,
                            prm_tipo_etapa);

                COMMIT;
                res :=
                    'CORRECTOSe grab&oacute; correctamente el tr&aacute;mite';
            ELSE
                res := 'Ya se encuentra registrado el tr&aacute;mite';
            END IF;

            RETURN res;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION actualiza_alcance_tramite (prm_id         VARCHAR2,
                                        prm_item       VARCHAR2,
                                        prm_valor      VARCHAR2,
                                        prm_origen     VARCHAR2,
                                        prm_partida    VARCHAR2,
                                        prm_otro       VARCHAR2,
                                        prm_usuario    VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        v_item       VARCHAR2 (10);
        v_codigo     NUMBER (18, 0);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_alcance_item b
         WHERE       b.alc_alcance_id = prm_id
                 AND b.ali_numero_item = prm_item
                 AND b.ali_num = 0
                 AND b.ali_lstope = 'U';

        IF existe > 0
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_alcance_item b
             WHERE   b.alc_alcance_id = prm_id
                     AND b.ali_numero_item = prm_item;



            UPDATE   fis_alcance_item
               SET   ali_num = existe
             WHERE       alc_alcance_id = prm_id
                     AND ali_numero_item = prm_item
                     AND ali_num = 0;

            INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                            a.ali_numero_item,
                                            a.ali_obs_valor,
                                            a.ali_obs_partida,
                                            a.ali_obs_origen,
                                            a.ali_num,
                                            a.ali_lstope,
                                            a.ali_usuario,
                                            a.ali_fecsys,
                                            a.ali_obs_otro,
                                            a.ali_tipo_etapa)
                SELECT   alc_alcance_id,
                         ali_numero_item,
                         DECODE (prm_valor, 'on', 'x', ''),
                         DECODE (prm_partida, 'on', 'x', ''),
                         DECODE (prm_origen, 'on', 'x', ''),
                         0,
                         'U',
                         prm_usuario,
                         SYSDATE,
                         DECODE (prm_otro, 'on', 'x', ''),
                         ali_tipo_etapa
                  FROM   fis_alcance_item
                 WHERE       alc_alcance_id = prm_id
                         AND ali_numero_item = prm_item
                         AND ali_num = existe
                         AND ROWNUM = 1;

            res :=
                'CORRECTOSe actualizo&oacute; correctamente el tr&aacute;mite';
        ELSE
            res := 'El Tr&aacute;mite ya fue borrad&oacute; anteriormente';
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_duis_selecitempar (prm_id               VARCHAR2,
                                      prm_ids_concatval    VARCHAR2,
                                      prm_tipo_tramite     VARCHAR2,
                                      prm_usuario          VARCHAR2,
                                      prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        v_item       VARCHAR2 (10);
        v_codigo     NUMBER (18, 0);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;
    BEGIN
        IF LENGTH (prm_ids_concatval) > 0
        THEN
            cad := prm_ids_concatval;
            total := 0;

            WHILE (LENGTH (cad) > 0)
            LOOP
                total := total + 1;
                val := SUBSTR (cad, 0, INSTR (cad, ',') - 1);
                cad := SUBSTR (cad, INSTR (cad, ',') + 1, LENGTH (cad));

                v_item := SUBSTR (val, 0, INSTR (val, '-') - 1);
                v_key_year :=
                    SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 0, 4);
                v_key_cou := SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 5, 3);
                v_reg_nber := SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 8);

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance b
                 WHERE       b.alc_gestion = v_key_year
                         AND b.alc_aduana = v_key_cou
                         AND b.alc_numero = v_reg_nber
                         AND b.alc_tipo_tramite = prm_tipo_tramite
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND b.ctl_control_id = prm_id;

                IF existe = 0
                THEN
                    grabadas := grabadas + 1;
                    v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                    v_numero := numero_control_alc (v_gestion);

                    INSERT INTO fis_alcance (alc_alcance_id,
                                             alc_tipo_alcance,
                                             alc_tipo_tramite,
                                             alc_gestion,
                                             alc_aduana,
                                             alc_numero,
                                             alc_num,
                                             alc_lstope,
                                             alc_usuario,
                                             alc_fecsys,
                                             ctl_control_id,
                                             alc_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                'ITEM',
                                prm_tipo_tramite,
                                v_key_year,
                                v_key_cou,
                                v_reg_nber,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_id,
                                prm_tipo_etapa);

                    INSERT INTO fis_alcance_item (alc_alcance_id,
                                                  ali_numero_item,
                                                  ali_obs_valor,
                                                  ali_obs_partida,
                                                  ali_obs_origen,
                                                  ali_num,
                                                  ali_lstope,
                                                  ali_usuario,
                                                  ali_fecsys,
                                                  ali_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                v_item,
                                NULL,
                                'x',
                                NULL,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_tipo_etapa);
                ELSE
                    SELECT   b.alc_alcance_id
                      INTO   v_codigo
                      FROM   fis_alcance b
                     WHERE       b.alc_gestion = v_key_year
                             AND b.alc_aduana = v_key_cou
                             AND b.alc_numero = v_reg_nber
                             AND b.alc_tipo_tramite = prm_tipo_tramite
                             AND b.alc_num = 0
                             AND b.alc_lstope = 'U'
                             AND b.ctl_control_id = prm_id;

                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_alcance_item b
                     WHERE   b.alc_alcance_id = v_codigo
                             AND b.ali_numero_item = v_item;

                    IF existe = 0
                    THEN
                        INSERT INTO fis_alcance_item (alc_alcance_id,
                                                      ali_numero_item,
                                                      ali_obs_valor,
                                                      ali_obs_partida,
                                                      ali_obs_origen,
                                                      ali_num,
                                                      ali_lstope,
                                                      ali_usuario,
                                                      ali_fecsys,
                                                      ali_tipo_etapa)
                          VALUES   (v_codigo,
                                    v_item,
                                    NULL,
                                    'x',
                                    NULL,
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_tipo_etapa);
                    ELSE
                        SELECT   b.ali_lstope
                          INTO   res
                          FROM   fis_alcance_item b
                         WHERE       b.alc_alcance_id = v_codigo
                                 AND b.ali_numero_item = v_item
                                 AND b.ali_num = 0;

                        IF res = 'U'
                        THEN
                            UPDATE   fis_alcance_item
                               SET   ali_num = existe
                             WHERE       alc_alcance_id = v_codigo
                                     AND ali_numero_item = v_item
                                     AND ali_num = 0;

                            INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                            a.ali_numero_item,
                                                            a.ali_obs_valor,
                                                            a.ali_obs_partida,
                                                            a.ali_obs_origen,
                                                            a.ali_num,
                                                            a.ali_lstope,
                                                            a.ali_usuario,
                                                            a.ali_fecsys,
                                                            a.ali_obs_otro,
                                                            a.ali_tipo_etapa)
                                SELECT   alc_alcance_id,
                                         ali_numero_item,
                                         ali_obs_valor,
                                         'x',
                                         ali_obs_origen,
                                         0,
                                         'U',
                                         prm_usuario,
                                         SYSDATE,
                                         ali_obs_otro,
                                         ali_tipo_etapa
                                  FROM   fis_alcance_item
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = existe
                                         AND ROWNUM = 1;
                        ELSE
                            UPDATE   fis_alcance_item
                               SET   ali_num = existe
                             WHERE       alc_alcance_id = v_codigo
                                     AND ali_numero_item = v_item
                                     AND ali_num = 0;

                            INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                            a.ali_numero_item,
                                                            a.ali_obs_valor,
                                                            a.ali_obs_partida,
                                                            a.ali_obs_origen,
                                                            a.ali_num,
                                                            a.ali_lstope,
                                                            a.ali_usuario,
                                                            a.ali_fecsys,
                                                            a.ali_obs_otro,
                                                            a.ali_tipo_etapa)
                                SELECT   alc_alcance_id,
                                         ali_numero_item,
                                         NULL,
                                         'x',
                                         NULL,
                                         0,
                                         'U',
                                         prm_usuario,
                                         SYSDATE,
                                         NULL,
                                         ali_tipo_etapa
                                  FROM   fis_alcance_item
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = existe
                                         AND ROWNUM = 1;
                        END IF;
                    END IF;
                END IF;
            END LOOP;
        END IF;

        COMMIT;
        res := 'CORRECTOSe grabaron correctamente las Declaraciones';

        IF LENGTH (error_dui) > 0
        THEN
            res :=
                res
                || ', Las siguientes Declaraciones ya se encuentran registradas en otro Control: '
                || error_dui;
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_duis_selecitempori (prm_id               VARCHAR2,
                                       prm_ids_concatval    VARCHAR2,
                                       prm_tipo_tramite     VARCHAR2,
                                       prm_usuario          VARCHAR2,
                                       prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        v_item       VARCHAR2 (10);
        v_codigo     NUMBER (18, 0);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;
    BEGIN
        IF LENGTH (prm_ids_concatval) > 0
        THEN
            cad := prm_ids_concatval;
            total := 0;

            WHILE (LENGTH (cad) > 0)
            LOOP
                total := total + 1;
                val := SUBSTR (cad, 0, INSTR (cad, ',') - 1);
                cad := SUBSTR (cad, INSTR (cad, ',') + 1, LENGTH (cad));

                v_item := SUBSTR (val, 0, INSTR (val, '-') - 1);
                v_key_year :=
                    SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 0, 4);
                v_key_cou := SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 5, 3);
                v_reg_nber := SUBSTR (SUBSTR (val, INSTR (val, '-') + 1), 8);

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance b
                 WHERE       b.alc_gestion = v_key_year
                         AND b.alc_aduana = v_key_cou
                         AND b.alc_numero = v_reg_nber
                         AND b.alc_tipo_tramite = prm_tipo_tramite
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U'
                         AND b.ctl_control_id = prm_id;

                IF existe = 0
                THEN
                    grabadas := grabadas + 1;
                    v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                    v_numero := numero_control_alc (v_gestion);

                    INSERT INTO fis_alcance (alc_alcance_id,
                                             alc_tipo_alcance,
                                             alc_tipo_tramite,
                                             alc_gestion,
                                             alc_aduana,
                                             alc_numero,
                                             alc_num,
                                             alc_lstope,
                                             alc_usuario,
                                             alc_fecsys,
                                             ctl_control_id,
                                             alc_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                'ITEM',
                                prm_tipo_tramite,
                                v_key_year,
                                v_key_cou,
                                v_reg_nber,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_id,
                                prm_tipo_etapa);

                    INSERT INTO fis_alcance_item (alc_alcance_id,
                                                  ali_numero_item,
                                                  ali_obs_valor,
                                                  ali_obs_partida,
                                                  ali_obs_origen,
                                                  ali_num,
                                                  ali_lstope,
                                                  ali_usuario,
                                                  ali_fecsys,
                                                  ali_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                v_item,
                                NULL,
                                NULL,
                                'x',
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_tipo_etapa);
                ELSE
                    SELECT   b.alc_alcance_id
                      INTO   v_codigo
                      FROM   fis_alcance b
                     WHERE       b.alc_gestion = v_key_year
                             AND b.alc_aduana = v_key_cou
                             AND b.alc_numero = v_reg_nber
                             AND b.alc_tipo_tramite = prm_tipo_tramite
                             AND b.alc_num = 0
                             AND b.alc_lstope = 'U'
                             AND b.ctl_control_id = prm_id;

                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_alcance_item b
                     WHERE   b.alc_alcance_id = v_codigo
                             AND b.ali_numero_item = v_item;

                    IF existe = 0
                    THEN
                        INSERT INTO fis_alcance_item (alc_alcance_id,
                                                      ali_numero_item,
                                                      ali_obs_valor,
                                                      ali_obs_partida,
                                                      ali_obs_origen,
                                                      ali_num,
                                                      ali_lstope,
                                                      ali_usuario,
                                                      ali_fecsys,
                                                      ali_tipo_etapa)
                          VALUES   (v_codigo,
                                    v_item,
                                    NULL,
                                    NULL,
                                    'x',
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_tipo_etapa);
                    ELSE
                        SELECT   b.ali_lstope
                          INTO   res
                          FROM   fis_alcance_item b
                         WHERE       b.alc_alcance_id = v_codigo
                                 AND b.ali_numero_item = v_item
                                 AND b.ali_num = 0;

                        IF res = 'U'
                        THEN
                            UPDATE   fis_alcance_item
                               SET   ali_num = existe
                             WHERE       alc_alcance_id = v_codigo
                                     AND ali_numero_item = v_item
                                     AND ali_num = 0;

                            INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                            a.ali_numero_item,
                                                            a.ali_obs_valor,
                                                            a.ali_obs_partida,
                                                            a.ali_obs_origen,
                                                            a.ali_num,
                                                            a.ali_lstope,
                                                            a.ali_usuario,
                                                            a.ali_fecsys,
                                                            a.ali_obs_otro,
                                                            a.ali_tipo_etapa)
                                SELECT   alc_alcance_id,
                                         ali_numero_item,
                                         ali_obs_valor,
                                         ali_obs_partida,
                                         'x',
                                         0,
                                         'U',
                                         prm_usuario,
                                         SYSDATE,
                                         ali_obs_otro,
                                         ali_tipo_etapa
                                  FROM   fis_alcance_item
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = existe
                                         AND ROWNUM = 1;
                        ELSE
                            UPDATE   fis_alcance_item
                               SET   ali_num = existe
                             WHERE       alc_alcance_id = v_codigo
                                     AND ali_numero_item = v_item
                                     AND ali_num = 0;

                            INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                            a.ali_numero_item,
                                                            a.ali_obs_valor,
                                                            a.ali_obs_partida,
                                                            a.ali_obs_origen,
                                                            a.ali_num,
                                                            a.ali_lstope,
                                                            a.ali_usuario,
                                                            a.ali_fecsys,
                                                            a.ali_obs_otro,
                                                            a.ali_tipo_etapa)
                                SELECT   alc_alcance_id,
                                         ali_numero_item,
                                         NULL,
                                         NULL,
                                         'x',
                                         0,
                                         'U',
                                         prm_usuario,
                                         SYSDATE,
                                         NULL,
                                         ali_tipo_etapa
                                  FROM   fis_alcance_item
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = existe
                                         AND ROWNUM = 1;
                        END IF;
                    END IF;
                END IF;

                COMMIT;
            END LOOP;
        END IF;


        res := 'CORRECTOSe grabaron correctamente las Declaraciones';

        IF LENGTH (error_dui) > 0
        THEN
            res :=
                res
                || ', Las siguientes Declaraciones ya se encuentran registradas en otro Control: '
                || error_dui;
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;


    FUNCTION graba_duis_selecdecval (prm_id               VARCHAR2,
                                     prm_ids_concatval    VARCHAR2,
                                     prm_tipo_tramite     VARCHAR2,
                                     prm_usuario          VARCHAR2,
                                     prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        v_item       NUMBER (10);
        v_codigo     NUMBER (18, 0);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;
        totitem      NUMBER := 0;
    BEGIN
        IF LENGTH (prm_ids_concatval) > 0
        THEN
            cad := prm_ids_concatval;
            total := 0;

            WHILE (LENGTH (cad) > 0)
            LOOP
                total := total + 1;
                val := TO_NUMBER (SUBSTR (cad, 0, INSTR (cad, ',') - 1));
                cad := SUBSTR (cad, INSTR (cad, ',') + 1, LENGTH (cad));
                v_key_year := SUBSTR (val, 1, 4);
                v_key_cou := SUBSTR (val, 5, 3);
                v_reg_nber := SUBSTR (val, 8, LENGTH (val) - 7);

                SELECT   g.sad_itm_total
                  INTO   totitem
                  FROM   ops$asy.sad_gen g
                 WHERE       g.sad_reg_year = v_key_year
                         AND g.key_cuo = v_key_cou
                         AND g.sad_reg_nber = v_reg_nber
                         AND g.sad_num = 0;

                v_item := 1;

                WHILE (v_item <= totitem)
                LOOP
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_alcance b
                     WHERE       b.alc_gestion = v_key_year
                             AND b.alc_aduana = v_key_cou
                             AND b.alc_numero = v_reg_nber
                             AND b.alc_tipo_tramite = prm_tipo_tramite
                             AND b.alc_num = 0
                             AND b.alc_lstope = 'U'
                             AND b.ctl_control_id = prm_id;

                    IF existe = 0
                    THEN
                        grabadas := grabadas + 1;
                        v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                        v_numero := numero_control_alc (v_gestion);

                        INSERT INTO fis_alcance (alc_alcance_id,
                                                 alc_tipo_alcance,
                                                 alc_tipo_tramite,
                                                 alc_gestion,
                                                 alc_aduana,
                                                 alc_numero,
                                                 alc_num,
                                                 alc_lstope,
                                                 alc_usuario,
                                                 alc_fecsys,
                                                 ctl_control_id,
                                                 alc_tipo_etapa)
                          VALUES   (v_gestion || TO_CHAR (v_numero),
                                    'DECLARACION',
                                    prm_tipo_tramite,
                                    v_key_year,
                                    v_key_cou,
                                    v_reg_nber,
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_id,
                                    prm_tipo_etapa);

                        INSERT INTO fis_alcance_item (alc_alcance_id,
                                                      ali_numero_item,
                                                      ali_obs_valor,
                                                      ali_obs_partida,
                                                      ali_obs_origen,
                                                      ali_num,
                                                      ali_lstope,
                                                      ali_usuario,
                                                      ali_fecsys,
                                                      ali_tipo_etapa)
                          VALUES   (v_gestion || TO_CHAR (v_numero),
                                    v_item,
                                    'x',
                                    NULL,
                                    NULL,
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_tipo_etapa);
                    ELSE
                        SELECT   b.alc_alcance_id
                          INTO   v_codigo
                          FROM   fis_alcance b
                         WHERE       b.alc_gestion = v_key_year
                                 AND b.alc_aduana = v_key_cou
                                 AND b.alc_numero = v_reg_nber
                                 AND b.alc_tipo_tramite = prm_tipo_tramite
                                 AND b.alc_num = 0
                                 AND b.alc_lstope = 'U'
                                 AND b.ctl_control_id = prm_id;

                        SELECT   COUNT (1)
                          INTO   existe
                          FROM   fis_alcance_item b
                         WHERE   b.alc_alcance_id = v_codigo
                                 AND b.ali_numero_item = v_item;

                        IF existe = 0
                        THEN
                            INSERT INTO fis_alcance_item (alc_alcance_id,
                                                          ali_numero_item,
                                                          ali_obs_valor,
                                                          ali_obs_partida,
                                                          ali_obs_origen,
                                                          ali_num,
                                                          ali_lstope,
                                                          ali_usuario,
                                                          ali_fecsys,
                                                          ali_tipo_etapa)
                              VALUES   (v_codigo,
                                        v_item,
                                        'x',
                                        NULL,
                                        NULL,
                                        0,
                                        'U',
                                        prm_usuario,
                                        SYSDATE,
                                        prm_tipo_etapa);
                        ELSE
                            SELECT   b.ali_lstope
                              INTO   res
                              FROM   fis_alcance_item b
                             WHERE       b.alc_alcance_id = v_codigo
                                     AND b.ali_numero_item = v_item
                                     AND b.ali_num = 0;

                            IF res = 'U'
                            THEN
                                UPDATE   fis_alcance_item
                                   SET   ali_num = existe
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = 0;

                                INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                                a.ali_numero_item,
                                                                a.ali_obs_valor,
                                                                a.ali_obs_partida,
                                                                a.ali_obs_origen,
                                                                a.ali_num,
                                                                a.ali_lstope,
                                                                a.ali_usuario,
                                                                a.ali_fecsys,
                                                                a.ali_obs_otro,
                                                                a.ali_tipo_etapa)
                                    SELECT   alc_alcance_id,
                                             ali_numero_item,
                                             'x',
                                             ali_obs_partida,
                                             ali_obs_origen,
                                             0,
                                             'U',
                                             prm_usuario,
                                             SYSDATE,
                                             ali_obs_otro,
                                             ali_tipo_etapa
                                      FROM   fis_alcance_item
                                     WHERE       alc_alcance_id = v_codigo
                                             AND ali_numero_item = v_item
                                             AND ali_num = existe
                                             AND ROWNUM = 1;
                            ELSE
                                UPDATE   fis_alcance_item
                                   SET   ali_num = existe
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = 0;

                                INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                                a.ali_numero_item,
                                                                a.ali_obs_valor,
                                                                a.ali_obs_partida,
                                                                a.ali_obs_origen,
                                                                a.ali_num,
                                                                a.ali_lstope,
                                                                a.ali_usuario,
                                                                a.ali_fecsys,
                                                                a.ali_obs_otro,
                                                                a.ali_tipo_etapa)
                                    SELECT   alc_alcance_id,
                                             ali_numero_item,
                                             'x',
                                             NULL,
                                             NULL,
                                             0,
                                             'U',
                                             prm_usuario,
                                             SYSDATE,
                                             NULL,
                                             ali_tipo_etapa
                                      FROM   fis_alcance_item
                                     WHERE       alc_alcance_id = v_codigo
                                             AND ali_numero_item = v_item
                                             AND ali_num = existe
                                             AND ROWNUM = 1;
                            END IF;
                        END IF;
                    END IF;

                    v_item := v_item + 1;
                END LOOP;
            END LOOP;
        END IF;

        COMMIT;
        res := 'CORRECTOSe grabaron correctamente las Declaraciones';

        IF LENGTH (error_dui) > 0
        THEN
            res :=
                res
                || ', Las siguientes Declaraciones ya se encuentran registradas en otro Control: '
                || error_dui;
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_duis_selecdecamp (prm_id               VARCHAR2,
                                     prm_ids_concatval    VARCHAR2,
                                     prm_tipo_tramite     VARCHAR2,
                                     prm_usuario          VARCHAR2,
                                     prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        v_item       NUMBER (10);
        v_codigo     NUMBER (18, 0);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;
        totitem      NUMBER := 0;
    BEGIN
        IF LENGTH (prm_ids_concatval) > 0
        THEN
            cad := prm_ids_concatval;
            total := 0;

            WHILE (LENGTH (cad) > 0)
            LOOP
                total := total + 1;
                val := TO_NUMBER (SUBSTR (cad, 0, INSTR (cad, ',') - 1));
                cad := SUBSTR (cad, INSTR (cad, ',') + 1, LENGTH (cad));

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance_amp b
                 WHERE       b.alc_alcance_id = val
                         AND b.amp_num = 0
                         AND b.amp_lstope = 'U'
                         AND b.ctl_control_id = prm_id;

                IF existe = 0
                THEN
                    grabadas := grabadas + 1;
                    v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                    v_numero := numero_control_amp (v_gestion);



                    INSERT INTO fis_alcance_amp (amp_alcanceamp_id,
                                                 alc_alcance_id,
                                                 ctl_control_id,
                                                 amp_num,
                                                 amp_lstope,
                                                 amp_usuario,
                                                 amp_fecsys,
                                                 amp_tipo_etapa)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                val,
                                prm_id,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_tipo_etapa);
                END IF;
            END LOOP;
        END IF;

        COMMIT;
        res := 'CORRECTOSe grabaron correctamente las Declaraciones';

        IF LENGTH (error_dui) > 0
        THEN
            res :=
                res
                || ', Las siguientes Declaraciones ya se encuentran registradas en otro Control: '
                || error_dui;
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_duis_selecdecotr (prm_id               VARCHAR2,
                                     prm_ids_concatotr    VARCHAR2,
                                     prm_tipo_tramite     VARCHAR2,
                                     prm_usuario          VARCHAR2,
                                     prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        v_item       VARCHAR2 (10);
        v_codigo     NUMBER (18, 0);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;
        totitem      NUMBER := 0;
    BEGIN
        IF LENGTH (prm_ids_concatotr) > 0
        THEN
            cad := prm_ids_concatotr;
            total := 0;

            WHILE (LENGTH (cad) > 0)
            LOOP
                total := total + 1;
                val := TO_NUMBER (SUBSTR (cad, 0, INSTR (cad, ',') - 1));
                cad := SUBSTR (cad, INSTR (cad, ',') + 1, LENGTH (cad));
                v_key_year := SUBSTR (val, 1, 4);
                v_key_cou := SUBSTR (val, 5, 3);
                v_reg_nber := SUBSTR (val, 8, LENGTH (val) - 7);

                SELECT   g.sad_itm_total
                  INTO   totitem
                  FROM   ops$asy.sad_gen g
                 WHERE       g.sad_reg_year = v_key_year
                         AND g.key_cuo = v_key_cou
                         AND g.sad_reg_nber = v_reg_nber
                         AND g.sad_num = 0;

                v_item := 1;

                WHILE (v_item <= totitem)
                LOOP
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_alcance b
                     WHERE       b.alc_gestion = v_key_year
                             AND b.alc_aduana = v_key_cou
                             AND b.alc_numero = v_reg_nber
                             AND b.alc_tipo_tramite = prm_tipo_tramite
                             AND b.alc_num = 0
                             AND b.alc_lstope = 'U'
                             AND b.ctl_control_id = prm_id;

                    IF existe = 0
                    THEN
                        grabadas := grabadas + 1;
                        v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                        v_numero := numero_control_alc (v_gestion);

                        INSERT INTO fis_alcance (alc_alcance_id,
                                                 alc_tipo_alcance,
                                                 alc_tipo_tramite,
                                                 alc_gestion,
                                                 alc_aduana,
                                                 alc_numero,
                                                 alc_num,
                                                 alc_lstope,
                                                 alc_usuario,
                                                 alc_fecsys,
                                                 ctl_control_id,
                                                 alc_tipo_etapa)
                          VALUES   (v_gestion || TO_CHAR (v_numero),
                                    'DECLARACION',
                                    prm_tipo_tramite,
                                    v_key_year,
                                    v_key_cou,
                                    v_reg_nber,
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_id,
                                    prm_tipo_etapa);

                        INSERT INTO fis_alcance_item (alc_alcance_id,
                                                      ali_numero_item,
                                                      ali_obs_valor,
                                                      ali_obs_partida,
                                                      ali_obs_origen,
                                                      ali_num,
                                                      ali_lstope,
                                                      ali_usuario,
                                                      ali_fecsys,
                                                      ali_obs_otro,
                                                      ali_tipo_etapa)
                          VALUES   (v_gestion || TO_CHAR (v_numero),
                                    v_item,
                                    NULL,
                                    NULL,
                                    NULL,
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    'x',
                                    prm_tipo_etapa);
                    ELSE
                        SELECT   b.alc_alcance_id
                          INTO   v_codigo
                          FROM   fis_alcance b
                         WHERE       b.alc_gestion = v_key_year
                                 AND b.alc_aduana = v_key_cou
                                 AND b.alc_numero = v_reg_nber
                                 AND b.alc_tipo_tramite = prm_tipo_tramite
                                 AND b.alc_num = 0
                                 AND b.alc_lstope = 'U'
                                 AND b.ctl_control_id = prm_id;

                        SELECT   COUNT (1)
                          INTO   existe
                          FROM   fis_alcance_item b
                         WHERE   b.alc_alcance_id = v_codigo
                                 AND b.ali_numero_item = v_item;

                        IF existe = 0
                        THEN
                            INSERT INTO fis_alcance_item (alc_alcance_id,
                                                          ali_numero_item,
                                                          ali_obs_valor,
                                                          ali_obs_partida,
                                                          ali_obs_origen,
                                                          ali_num,
                                                          ali_lstope,
                                                          ali_usuario,
                                                          ali_fecsys,
                                                          ali_obs_otro,
                                                          ali_tipo_etapa)
                              VALUES   (v_codigo,
                                        v_item,
                                        NULL,
                                        NULL,
                                        NULL,
                                        0,
                                        'U',
                                        prm_usuario,
                                        SYSDATE,
                                        'x',
                                        prm_tipo_etapa);
                        ELSE
                            SELECT   b.ali_lstope
                              INTO   res
                              FROM   fis_alcance_item b
                             WHERE       b.alc_alcance_id = v_codigo
                                     AND b.ali_numero_item = v_item
                                     AND b.ali_num = 0;

                            IF res = 'U'
                            THEN
                                UPDATE   fis_alcance_item
                                   SET   ali_num = existe
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = 0;

                                INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                                a.ali_numero_item,
                                                                a.ali_obs_valor,
                                                                a.ali_obs_partida,
                                                                a.ali_obs_origen,
                                                                a.ali_num,
                                                                a.ali_lstope,
                                                                a.ali_usuario,
                                                                a.ali_fecsys,
                                                                a.ali_obs_otro,
                                                                ali_tipo_etapa)
                                    SELECT   alc_alcance_id,
                                             ali_numero_item,
                                             ali_obs_valor,
                                             ali_obs_partida,
                                             ali_obs_origen,
                                             0,
                                             'U',
                                             prm_usuario,
                                             SYSDATE,
                                             'x',
                                             prm_tipo_etapa
                                      FROM   fis_alcance_item
                                     WHERE       alc_alcance_id = v_codigo
                                             AND ali_numero_item = v_item
                                             AND ali_num = existe
                                             AND ROWNUM = 1;
                            ELSE
                                UPDATE   fis_alcance_item
                                   SET   ali_num = existe
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = 0;

                                INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                                a.ali_numero_item,
                                                                a.ali_obs_valor,
                                                                a.ali_obs_partida,
                                                                a.ali_obs_origen,
                                                                a.ali_num,
                                                                a.ali_lstope,
                                                                a.ali_usuario,
                                                                a.ali_fecsys,
                                                                a.ali_obs_otro,
                                                                ali_tipo_etapa)
                                    SELECT   alc_alcance_id,
                                             ali_numero_item,
                                             NULL,
                                             NULL,
                                             NULL,
                                             0,
                                             'U',
                                             prm_usuario,
                                             SYSDATE,
                                             'x',
                                             prm_tipo_etapa
                                      FROM   fis_alcance_item
                                     WHERE       alc_alcance_id = v_codigo
                                             AND ali_numero_item = v_item
                                             AND ali_num = existe
                                             AND ROWNUM = 1;
                            END IF;
                        END IF;
                    END IF;

                    v_item := v_item + 1;
                END LOOP;
            END LOOP;
        END IF;

        COMMIT;
        res := 'CORRECTOSe grabaron correctamente las Declaraciones';

        IF LENGTH (error_dui) > 0
        THEN
            res :=
                res
                || ', Las siguientes Declaraciones ya se encuentran registradas en otro Control: '
                || error_dui;
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_duis_selecdecpar (prm_id               VARCHAR2,
                                     prm_ids_concatval    VARCHAR2,
                                     prm_tipo_tramite     VARCHAR2,
                                     prm_usuario          VARCHAR2,
                                     prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        v_item       VARCHAR2 (10);
        v_codigo     NUMBER (18, 0);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;
        totitem      NUMBER := 0;
    BEGIN
        IF LENGTH (prm_ids_concatval) > 0
        THEN
            cad := prm_ids_concatval;
            total := 0;

            WHILE (LENGTH (cad) > 0)
            LOOP
                total := total + 1;
                val := TO_NUMBER (SUBSTR (cad, 0, INSTR (cad, ',') - 1));
                cad := SUBSTR (cad, INSTR (cad, ',') + 1, LENGTH (cad));
                v_key_year := SUBSTR (val, 1, 4);
                v_key_cou := SUBSTR (val, 5, 3);
                v_reg_nber := SUBSTR (val, 8, LENGTH (val) - 7);

                SELECT   g.sad_itm_total
                  INTO   totitem
                  FROM   ops$asy.sad_gen g
                 WHERE       g.sad_reg_year = v_key_year
                         AND g.key_cuo = v_key_cou
                         AND g.sad_reg_nber = v_reg_nber
                         AND g.sad_num = 0;

                v_item := 1;

                WHILE (v_item <= totitem)
                LOOP
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_alcance b
                     WHERE       b.alc_gestion = v_key_year
                             AND b.alc_aduana = v_key_cou
                             AND b.alc_numero = v_reg_nber
                             AND b.alc_tipo_tramite = prm_tipo_tramite
                             AND b.alc_num = 0
                             AND b.alc_lstope = 'U'
                             AND b.ctl_control_id = prm_id;

                    IF existe = 0
                    THEN
                        grabadas := grabadas + 1;
                        v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                        v_numero := numero_control_alc (v_gestion);

                        INSERT INTO fis_alcance (alc_alcance_id,
                                                 alc_tipo_alcance,
                                                 alc_tipo_tramite,
                                                 alc_gestion,
                                                 alc_aduana,
                                                 alc_numero,
                                                 alc_num,
                                                 alc_lstope,
                                                 alc_usuario,
                                                 alc_fecsys,
                                                 ctl_control_id,
                                                 alc_tipo_etapa)
                          VALUES   (v_gestion || TO_CHAR (v_numero),
                                    'DECLARACION',
                                    prm_tipo_tramite,
                                    v_key_year,
                                    v_key_cou,
                                    v_reg_nber,
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_id,
                                    prm_tipo_etapa);

                        INSERT INTO fis_alcance_item (alc_alcance_id,
                                                      ali_numero_item,
                                                      ali_obs_valor,
                                                      ali_obs_partida,
                                                      ali_obs_origen,
                                                      ali_num,
                                                      ali_lstope,
                                                      ali_usuario,
                                                      ali_fecsys,
                                                      ali_tipo_etapa)
                          VALUES   (v_gestion || TO_CHAR (v_numero),
                                    v_item,
                                    NULL,
                                    'x',
                                    NULL,
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_tipo_etapa);
                    ELSE
                        SELECT   b.alc_alcance_id
                          INTO   v_codigo
                          FROM   fis_alcance b
                         WHERE       b.alc_gestion = v_key_year
                                 AND b.alc_aduana = v_key_cou
                                 AND b.alc_numero = v_reg_nber
                                 AND b.alc_tipo_tramite = prm_tipo_tramite
                                 AND b.alc_num = 0
                                 AND b.alc_lstope = 'U'
                                 AND b.ctl_control_id = prm_id;

                        SELECT   COUNT (1)
                          INTO   existe
                          FROM   fis_alcance_item b
                         WHERE   b.alc_alcance_id = v_codigo
                                 AND b.ali_numero_item = v_item;

                        IF existe = 0
                        THEN
                            INSERT INTO fis_alcance_item (alc_alcance_id,
                                                          ali_numero_item,
                                                          ali_obs_valor,
                                                          ali_obs_partida,
                                                          ali_obs_origen,
                                                          ali_num,
                                                          ali_lstope,
                                                          ali_usuario,
                                                          ali_fecsys,
                                                          ali_tipo_etapa)
                              VALUES   (v_codigo,
                                        v_item,
                                        NULL,
                                        'x',
                                        NULL,
                                        0,
                                        'U',
                                        prm_usuario,
                                        SYSDATE,
                                        prm_tipo_etapa);
                        ELSE
                            SELECT   b.ali_lstope
                              INTO   res
                              FROM   fis_alcance_item b
                             WHERE       b.alc_alcance_id = v_codigo
                                     AND b.ali_numero_item = v_item
                                     AND b.ali_num = 0;

                            IF res = 'U'
                            THEN
                                UPDATE   fis_alcance_item
                                   SET   ali_num = existe
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = 0;

                                INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                                a.ali_numero_item,
                                                                a.ali_obs_valor,
                                                                a.ali_obs_partida,
                                                                a.ali_obs_origen,
                                                                a.ali_num,
                                                                a.ali_lstope,
                                                                a.ali_usuario,
                                                                a.ali_fecsys,
                                                                a.ali_obs_otro,
                                                                a.ali_tipo_etapa)
                                    SELECT   alc_alcance_id,
                                             ali_numero_item,
                                             ali_obs_valor,
                                             'x',
                                             ali_obs_origen,
                                             0,
                                             'U',
                                             prm_usuario,
                                             SYSDATE,
                                             ali_obs_otro,
                                             ali_tipo_etapa
                                      FROM   fis_alcance_item
                                     WHERE       alc_alcance_id = v_codigo
                                             AND ali_numero_item = v_item
                                             AND ali_num = existe
                                             AND ROWNUM = 1;
                            ELSE
                                UPDATE   fis_alcance_item
                                   SET   ali_num = existe
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = 0;

                                INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                                a.ali_numero_item,
                                                                a.ali_obs_valor,
                                                                a.ali_obs_partida,
                                                                a.ali_obs_origen,
                                                                a.ali_num,
                                                                a.ali_lstope,
                                                                a.ali_usuario,
                                                                a.ali_fecsys,
                                                                a.ali_obs_otro,
                                                                a.ali_tipo_etapa)
                                    SELECT   alc_alcance_id,
                                             ali_numero_item,
                                             NULL,
                                             'x',
                                             NULL,
                                             0,
                                             'U',
                                             prm_usuario,
                                             SYSDATE,
                                             NULL,
                                             ali_tipo_etapa
                                      FROM   fis_alcance_item
                                     WHERE       alc_alcance_id = v_codigo
                                             AND ali_numero_item = v_item
                                             AND ali_num = existe
                                             AND ROWNUM = 1;
                            END IF;
                        END IF;
                    END IF;

                    v_item := v_item + 1;
                END LOOP;
            END LOOP;
        END IF;

        COMMIT;
        res := 'CORRECTOSe grabaron correctamente las Declaraciones';

        IF LENGTH (error_dui) > 0
        THEN
            res :=
                res
                || ', Las siguientes Declaraciones ya se encuentran registradas en otro Control: '
                || error_dui;
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_duis_selecdecori (prm_id               VARCHAR2,
                                     prm_ids_concatval    VARCHAR2,
                                     prm_tipo_tramite     VARCHAR2,
                                     prm_usuario          VARCHAR2,
                                     prm_tipo_etapa       VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (300) := 0;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        val          VARCHAR2 (100);
        cad          VARCHAR2 (30000);
        v_key_year   VARCHAR2 (4);
        v_key_cou    VARCHAR2 (3);
        v_reg_nber   VARCHAR2 (10);
        v_item       NUMBER := 0;
        v_codigo     NUMBER (18, 0);
        existe       NUMBER;
        error_dui    VARCHAR2 (30000) := '';
        total        NUMBER := 0;
        grabadas     NUMBER := 0;
        totitem      NUMBER := 0;
    BEGIN
        IF LENGTH (prm_ids_concatval) > 0
        THEN
            cad := prm_ids_concatval;
            total := 0;

            WHILE (LENGTH (cad) > 0)
            LOOP
                total := total + 1;
                val := TO_NUMBER (SUBSTR (cad, 0, INSTR (cad, ',') - 1));
                cad := SUBSTR (cad, INSTR (cad, ',') + 1, LENGTH (cad));
                v_key_year := SUBSTR (val, 1, 4);
                v_key_cou := SUBSTR (val, 5, 3);
                v_reg_nber := SUBSTR (val, 8, LENGTH (val) - 7);

                SELECT   g.sad_itm_total
                  INTO   totitem
                  FROM   ops$asy.sad_gen g
                 WHERE       g.sad_reg_year = v_key_year
                         AND g.key_cuo = v_key_cou
                         AND g.sad_reg_nber = v_reg_nber
                         AND g.sad_num = 0;

                v_item := 1;

                WHILE (v_item <= totitem)
                LOOP
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_alcance b
                     WHERE       b.alc_gestion = v_key_year
                             AND b.alc_aduana = v_key_cou
                             AND b.alc_numero = v_reg_nber
                             AND b.alc_tipo_tramite = prm_tipo_tramite
                             AND b.alc_num = 0
                             AND b.alc_lstope = 'U'
                             AND b.ctl_control_id = prm_id;

                    IF existe = 0
                    THEN
                        grabadas := grabadas + 1;
                        v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                        v_numero := numero_control_alc (v_gestion);

                        INSERT INTO fis_alcance (alc_alcance_id,
                                                 alc_tipo_alcance,
                                                 alc_tipo_tramite,
                                                 alc_gestion,
                                                 alc_aduana,
                                                 alc_numero,
                                                 alc_num,
                                                 alc_lstope,
                                                 alc_usuario,
                                                 alc_fecsys,
                                                 ctl_control_id,
                                                 alc_tipo_etapa)
                          VALUES   (v_gestion || TO_CHAR (v_numero),
                                    'DECLARACION',
                                    prm_tipo_tramite,
                                    v_key_year,
                                    v_key_cou,
                                    v_reg_nber,
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_id,
                                    prm_tipo_etapa);

                        INSERT INTO fis_alcance_item (alc_alcance_id,
                                                      ali_numero_item,
                                                      ali_obs_valor,
                                                      ali_obs_partida,
                                                      ali_obs_origen,
                                                      ali_num,
                                                      ali_lstope,
                                                      ali_usuario,
                                                      ali_fecsys,
                                                      ali_tipo_etapa)
                          VALUES   (v_gestion || TO_CHAR (v_numero),
                                    v_item,
                                    NULL,
                                    NULL,
                                    'x',
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_tipo_etapa);
                    ELSE
                        SELECT   b.alc_alcance_id
                          INTO   v_codigo
                          FROM   fis_alcance b
                         WHERE       b.alc_gestion = v_key_year
                                 AND b.alc_aduana = v_key_cou
                                 AND b.alc_numero = v_reg_nber
                                 AND b.alc_tipo_tramite = prm_tipo_tramite
                                 AND b.alc_num = 0
                                 AND b.alc_lstope = 'U'
                                 AND b.ctl_control_id = prm_id;

                        SELECT   COUNT (1)
                          INTO   existe
                          FROM   fis_alcance_item b
                         WHERE   b.alc_alcance_id = v_codigo
                                 AND b.ali_numero_item = v_item;

                        IF existe = 0
                        THEN
                            INSERT INTO fis_alcance_item (alc_alcance_id,
                                                          ali_numero_item,
                                                          ali_obs_valor,
                                                          ali_obs_partida,
                                                          ali_obs_origen,
                                                          ali_num,
                                                          ali_lstope,
                                                          ali_usuario,
                                                          ali_fecsys,
                                                          ali_obs_otro,
                                                          ali_tipo_etapa)
                              VALUES   (v_codigo,
                                        v_item,
                                        NULL,
                                        NULL,
                                        'x',
                                        0,
                                        'U',
                                        prm_usuario,
                                        SYSDATE,
                                        NULL,
                                        prm_tipo_etapa);
                        ELSE
                            SELECT   b.ali_lstope
                              INTO   res
                              FROM   fis_alcance_item b
                             WHERE       b.alc_alcance_id = v_codigo
                                     AND b.ali_numero_item = v_item
                                     AND b.ali_num = 0;

                            IF res = 'U'
                            THEN
                                UPDATE   fis_alcance_item
                                   SET   ali_num = existe
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = 0;

                                INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                                a.ali_numero_item,
                                                                a.ali_obs_valor,
                                                                a.ali_obs_partida,
                                                                a.ali_obs_origen,
                                                                a.ali_num,
                                                                a.ali_lstope,
                                                                a.ali_usuario,
                                                                a.ali_fecsys,
                                                                a.ali_obs_otro,
                                                                ali_tipo_etapa)
                                    SELECT   alc_alcance_id,
                                             ali_numero_item,
                                             ali_obs_valor,
                                             ali_obs_partida,
                                             'x',
                                             0,
                                             'U',
                                             prm_usuario,
                                             SYSDATE,
                                             ali_obs_otro,
                                             ali_tipo_etapa
                                      FROM   fis_alcance_item
                                     WHERE       alc_alcance_id = v_codigo
                                             AND ali_numero_item = v_item
                                             AND ali_num = existe
                                             AND ROWNUM = 1;
                            ELSE
                                UPDATE   fis_alcance_item
                                   SET   ali_num = existe
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = 0;

                                INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                                a.ali_numero_item,
                                                                a.ali_obs_valor,
                                                                a.ali_obs_partida,
                                                                a.ali_obs_origen,
                                                                a.ali_num,
                                                                a.ali_lstope,
                                                                a.ali_usuario,
                                                                a.ali_fecsys,
                                                                a.ali_obs_otro,
                                                                ali_tipo_etapa)
                                    SELECT   alc_alcance_id,
                                             ali_numero_item,
                                             NULL,
                                             NULL,
                                             'x',
                                             0,
                                             'U',
                                             prm_usuario,
                                             SYSDATE,
                                             NULL,
                                             ali_tipo_etapa
                                      FROM   fis_alcance_item
                                     WHERE       alc_alcance_id = v_codigo
                                             AND ali_numero_item = v_item
                                             AND ali_num = existe
                                             AND ROWNUM = 1;
                            END IF;
                        END IF;
                    END IF;


                    v_item := v_item + 1;
                END LOOP;
            END LOOP;
        END IF;

        COMMIT;
        res := 'CORRECTOSe grabaron correctamente las Declaraciones';

        IF LENGTH (error_dui) > 0
        THEN
            res :=
                res
                || ', Las siguientes Declaraciones ya se encuentran registradas en otro Control: '
                || error_dui;
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION borra_tramite_selec (prm_id VARCHAR2, prm_usuario VARCHAR2)
        RETURN VARCHAR2
    IS
        res      VARCHAR2 (300) := 0;
        existe   NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_alcance b
         WHERE       b.alc_alcance_id = prm_id
                 AND b.alc_num = 0
                 AND b.alc_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'EL TRAMITE NO EXISTE';
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_alcance b
             WHERE   b.alc_alcance_id = prm_id;

            UPDATE   fis_alcance b
               SET   b.alc_num = existe
             WHERE   b.alc_alcance_id = prm_id AND b.alc_num = 0;

            INSERT INTO fis_alcance
                SELECT   a.alc_alcance_id,
                         a.alc_tipo_alcance,
                         a.alc_tipo_tramite,
                         a.alc_gestion,
                         a.alc_aduana,
                         a.alc_numero,
                         a.alc_fecha,
                         a.alc_proveedor,
                         a.alc_pais,
                         a.alc_tipo_documento,
                         0,
                         'D',
                         prm_usuario,
                         SYSDATE,
                         a.ctl_control_id,
                         a.alc_tipo_etapa
                  FROM   fis_alcance a
                 WHERE       a.alc_alcance_id = prm_id
                         AND a.alc_num = existe
                         AND ROWNUM = 1;

            COMMIT;
            RETURN 'CORRECTOEl tr&aacute;mite se borr&oacute; correctamente';
        END IF;
    END;

    FUNCTION borra_tramite_selecitem (prm_id VARCHAR2, prm_usuario VARCHAR2)
        RETURN VARCHAR2
    IS
        res        VARCHAR2 (300) := 0;
        existe     NUMBER;
        v_codigo   VARCHAR2 (30);
        v_item     VARCHAR2 (30);
    BEGIN
        SELECT   SUBSTR (prm_id, 0, INSTR (prm_id, '-') - 1),
                 SUBSTR (prm_id,
                         INSTR (prm_id, '-') + 1,
                         LENGTH (prm_id) - INSTR (prm_id, '-'))
          INTO   v_codigo, v_item
          FROM   DUAL;


        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_alcance_item b
         WHERE       b.alc_alcance_id = v_codigo
                 AND b.ali_numero_item = v_item
                 AND b.ali_num = 0
                 AND b.ali_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'El tr&aacute;mite no existe';
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_alcance_item b
             WHERE   b.alc_alcance_id = v_codigo
                     AND b.ali_numero_item = v_item;

            UPDATE   fis_alcance_item b
               SET   b.ali_num = existe
             WHERE       b.alc_alcance_id = v_codigo
                     AND b.ali_numero_item = v_item
                     AND b.ali_num = 0;

            INSERT INTO fis_alcance_item
                SELECT   a.alc_alcance_id,
                         a.ali_numero_item,
                         a.ali_obs_valor,
                         a.ali_obs_partida,
                         a.ali_obs_origen,
                         0,
                         'D',
                         prm_usuario,
                         SYSDATE,
                         a.ali_obs_otro,
                         a.ali_tipo_etapa
                  FROM   fis_alcance_item a
                 WHERE       a.alc_alcance_id = v_codigo
                         AND a.ali_numero_item = v_item
                         AND a.ali_num = existe
                         AND ROWNUM = 1;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_alcance_item b
             WHERE       b.alc_alcance_id = v_codigo
                     AND b.ali_num = 0
                     AND b.ali_lstope = 'U';

            IF existe = 0
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance b
                 WHERE   b.alc_alcance_id = v_codigo;

                UPDATE   fis_alcance b
                   SET   b.alc_num = existe
                 WHERE   b.alc_alcance_id = v_codigo AND b.alc_num = 0;

                INSERT INTO fis_alcance
                    SELECT   a.alc_alcance_id,
                             a.alc_tipo_alcance,
                             a.alc_tipo_tramite,
                             a.alc_gestion,
                             a.alc_aduana,
                             a.alc_numero,
                             a.alc_fecha,
                             a.alc_proveedor,
                             a.alc_pais,
                             a.alc_tipo_documento,
                             0,
                             'D',
                             prm_usuario,
                             SYSDATE,
                             a.ctl_control_id,
                             a.alc_tipo_etapa
                      FROM   fis_alcance a
                     WHERE       a.alc_alcance_id = v_codigo
                             AND a.alc_num = existe
                             AND ROWNUM = 1;
            END IF;

            COMMIT;
            RETURN 'CORRECTOEl tr&aacute;mite se borr&oacute; correctamente';
        END IF;
    END;

    FUNCTION borra_tramite_todo (prm_codigo VARCHAR2, prm_usuario VARCHAR2)
        RETURN VARCHAR2
    IS
        res        VARCHAR2 (300) := 0;
        existe     NUMBER;
        v_codigo   VARCHAR2 (30);
        v_item     VARCHAR2 (30);
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_alcance a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.alc_num = 0
                 AND a.alc_lstope = 'U'
                 AND a.alc_tipo_etapa = 'NORMAL';

        IF existe > 0
        THEN
            FOR i IN (SELECT   a.alc_alcance_id
                        FROM   fis_alcance a
                       WHERE       a.ctl_control_id = prm_codigo
                               AND a.alc_num = 0
                               AND a.alc_lstope = 'U'
                               AND a.alc_tipo_etapa = 'NORMAL')
            LOOP
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance b
                 WHERE   b.alc_alcance_id = i.alc_alcance_id;

                UPDATE   fis_alcance b
                   SET   b.alc_num = existe
                 WHERE   b.alc_alcance_id = i.alc_alcance_id
                         AND b.alc_num = 0;

                INSERT INTO fis_alcance
                    SELECT   a.alc_alcance_id,
                             a.alc_tipo_alcance,
                             a.alc_tipo_tramite,
                             a.alc_gestion,
                             a.alc_aduana,
                             a.alc_numero,
                             a.alc_fecha,
                             a.alc_proveedor,
                             a.alc_pais,
                             a.alc_tipo_documento,
                             0,
                             'D',
                             prm_usuario,
                             SYSDATE,
                             a.ctl_control_id,
                             a.alc_tipo_etapa
                      FROM   fis_alcance a
                     WHERE       a.alc_alcance_id = i.alc_alcance_id
                             AND a.alc_num = existe
                             AND ROWNUM = 1;
            END LOOP;

            COMMIT;
            RETURN 'CORRECTOSe borr&oacute; correctamente el alcance del control';
        ELSE
            RETURN 'El control no tiene alcance registrado';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION borra_tramite_todo_amp (prm_codigo     VARCHAR2,
                                     prm_usuario    VARCHAR2)
        RETURN VARCHAR2
    IS
        res        VARCHAR2 (300) := 0;
        existe     NUMBER;
        v_codigo   VARCHAR2 (30);
        v_item     VARCHAR2 (30);
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_alcance a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.alc_num = 0
                 AND a.alc_lstope = 'U'
                 AND a.alc_tipo_etapa = 'AMPLIATORIA';

        IF existe > 0
        THEN
            FOR i IN (SELECT   a.alc_alcance_id
                        FROM   fis_alcance a
                       WHERE       a.ctl_control_id = prm_codigo
                               AND a.alc_num = 0
                               AND a.alc_lstope = 'U'
                               AND a.alc_tipo_etapa = 'AMPLIATORIA')
            LOOP
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance b
                 WHERE   b.alc_alcance_id = i.alc_alcance_id;

                UPDATE   fis_alcance b
                   SET   b.alc_num = existe
                 WHERE   b.alc_alcance_id = i.alc_alcance_id
                         AND b.alc_num = 0;

                INSERT INTO fis_alcance
                    SELECT   a.alc_alcance_id,
                             a.alc_tipo_alcance,
                             a.alc_tipo_tramite,
                             a.alc_gestion,
                             a.alc_aduana,
                             a.alc_numero,
                             a.alc_fecha,
                             a.alc_proveedor,
                             a.alc_pais,
                             a.alc_tipo_documento,
                             0,
                             'D',
                             prm_usuario,
                             SYSDATE,
                             a.ctl_control_id,
                             a.alc_tipo_etapa
                      FROM   fis_alcance a
                     WHERE       a.alc_alcance_id = i.alc_alcance_id
                             AND a.alc_num = existe
                             AND ROWNUM = 1;
            END LOOP;

            COMMIT;
            RETURN 'CORRECTOSe borr&oacute; correctamente el alcance del control';
        ELSE
            RETURN 'El control no tiene alcance registrado';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;


    FUNCTION borra_tramite_selecamp (prm_id VARCHAR2, prm_usuario VARCHAR2)
        RETURN VARCHAR2
    IS
        res      VARCHAR2 (300) := 0;
        existe   NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_alcance_amp b
         WHERE       b.amp_alcanceamp_id = prm_id
                 AND b.amp_num = 0
                 AND b.amp_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'El tr&aacute;mite no existe';
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_alcance_amp b
             WHERE   b.amp_alcanceamp_id = prm_id;

            UPDATE   fis_alcance_amp b
               SET   b.amp_num = existe
             WHERE   b.amp_alcanceamp_id = prm_id AND b.amp_num = 0;

            INSERT INTO fis_alcance_amp
                SELECT   a.amp_alcanceamp_id,
                         a.alc_alcance_id,
                         a.ctl_control_id,
                         0,
                         'D',
                         prm_usuario,
                         SYSDATE,
                         amp_tipo_etapa
                  FROM   fis_alcance_amp a
                 WHERE       a.amp_alcanceamp_id = prm_id
                         AND a.amp_num = existe
                         AND ROWNUM = 1;

            COMMIT;
            RETURN 'CORRECTOEl tr&aacute;mite se borr&oacute; correctamente';
        END IF;
    END;

    FUNCTION verifica_registra_control (prm_codigo      VARCHAR2,
                                        prm_gerencia    VARCHAR2,
                                        prm_usuario     VARCHAR2)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_gestion       VARCHAR2 (4);
        v_numero        NUMBER;
        val             VARCHAR2 (100);
        cad             VARCHAR2 (30000);
        v_key_year      VARCHAR2 (4);
        v_key_cou       VARCHAR2 (3);
        v_reg_nber      VARCHAR2 (10);
        existe          NUMBER;
        error_dui       VARCHAR2 (30000) := '';
        total           NUMBER := 0;
        grabadas        NUMBER := 0;
        v_tipo          VARCHAR2 (15);
        v_tipocontrol   VARCHAR2 (30);
        v_gerusuario    VARCHAR2 (30);
        v_gercontrol    VARCHAR2 (30);
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'No existe el Control';
        END IF;

        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.est_num = 0
                 AND a.est_lstope = 'U'
                 AND est_estado = 'MEMORIZADO';

        IF existe = 0
        THEN
            RETURN 'El control no est&aacute; en estado Memorizado';
        END IF;

        res := pkg_general.verifica_usuariogerencia (prm_codigo, prm_usuario);

        IF NOT res = 'CORRECTO'
        THEN
            RETURN res;
        END IF;

        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'POSTERIOR' OR v_tipocontrol = 'DIFERIDO'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_alcance a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.alc_num = 0
                     AND a.alc_lstope = 'U';

            IF existe = 0
            THEN
                RETURN 'El control no tiene registrado alcance';
            END IF;
        END IF;

        RETURN 'CORRECTO';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION verifica_alcance_control (prm_codigo VARCHAR2)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_gestion       VARCHAR2 (4);
        v_numero        NUMBER;
        val             VARCHAR2 (100);
        cad             VARCHAR2 (30000);
        v_key_year      VARCHAR2 (4);
        v_key_cou       VARCHAR2 (3);
        v_reg_nber      VARCHAR2 (10);
        existe          NUMBER;
        error_dui       VARCHAR2 (30000) := '';
        total           NUMBER := 0;
        grabadas        NUMBER := 0;
        v_tipo          VARCHAR2 (10);
        v_tipocontrol   VARCHAR2 (30);
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'No existe el Control';
        END IF;

        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.est_num = 0
                 AND a.est_lstope = 'U'
                 AND est_estado = 'MEMORIZADO';

        IF existe = 0
        THEN
            RETURN 'El control no est&aacute; en estado Memorizado';
        END IF;

        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            RETURN 'No se puede registrar alcance de una Fiscalizaci&oacute;n Ampliatoria';
        END IF;

        RETURN 'CORRECTO';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION verifica_alcance_control2 (prm_codigo     VARCHAR2,
                                        prm_usuario    VARCHAR2)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_gestion       VARCHAR2 (4);
        v_numero        NUMBER;
        val             VARCHAR2 (100);
        cad             VARCHAR2 (30000);
        v_key_year      VARCHAR2 (4);
        v_key_cou       VARCHAR2 (3);
        v_reg_nber      VARCHAR2 (10);
        existe          NUMBER;
        error_dui       VARCHAR2 (30000) := '';
        total           NUMBER := 0;
        grabadas        NUMBER := 0;
        v_tipo          VARCHAR2 (10);
        v_tipocontrol   VARCHAR2 (30);
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'No existe el Control';
        END IF;

        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.est_num = 0
                 AND a.est_lstope = 'U'
                 AND est_estado = 'MEMORIZADO';

        IF existe = 0
        THEN
            RETURN 'El control no est&aacute; en estado Memorizado';
        END IF;

        res := pkg_general.verifica_usuariogerencia (prm_codigo, prm_usuario);

        IF NOT res = 'CORRECTO'
        THEN
            RETURN res;
        END IF;

        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            RETURN    'No se puede registrar alcance de una fiscalizaci'
                   || CHR (243)
                   || 'n ampliatoria';
        END IF;

        RETURN 'CORRECTO';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION verifica_ampliacion_control (prm_codigo     VARCHAR2,
                                          prm_usuario    VARCHAR2)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_gestion       VARCHAR2 (4);
        v_numero        NUMBER;
        val             VARCHAR2 (100);
        cad             VARCHAR2 (30000);
        v_key_year      VARCHAR2 (4);
        v_key_cou       VARCHAR2 (3);
        v_reg_nber      VARCHAR2 (10);
        existe          NUMBER;
        error_dui       VARCHAR2 (30000) := '';
        total           NUMBER := 0;
        grabadas        NUMBER := 0;
        v_tipo          VARCHAR2 (10);
        v_tipocontrol   VARCHAR2 (30);
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'No existe el Control';
        END IF;

        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.est_num = 0
                 AND a.est_lstope = 'U'
                 AND est_estado = 'REGISTRADO';

        IF existe = 0
        THEN
            RETURN 'El control no est&aacute; en estado Registrado';
        END IF;

        res := pkg_general.verifica_usuariogerencia (prm_codigo, prm_usuario);

        IF NOT res = 'CORRECTO'
        THEN
            RETURN res;
        END IF;

        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            RETURN 'No se puede registrar ampliaci&oacute;n de alcance de una Fiscalizaci&oacute;n Ampliatoria';
        END IF;

        RETURN 'CORRECTO';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION verifica_asigna_control (prm_codigo VARCHAR2)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_gestion       VARCHAR2 (4);
        v_numero        NUMBER;
        val             VARCHAR2 (100);
        cad             VARCHAR2 (30000);
        v_key_year      VARCHAR2 (4);
        v_key_cou       VARCHAR2 (3);
        v_reg_nber      VARCHAR2 (10);
        existe          NUMBER;
        error_dui       VARCHAR2 (30000) := '';
        total           NUMBER := 0;
        grabadas        NUMBER := 0;
        v_tipo          VARCHAR2 (10);
        v_tipocontrol   VARCHAR2 (30);
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'No existe el Control';
        END IF;

        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.est_num = 0
                 AND a.est_lstope = 'U'
                 AND est_estado = 'MEMORIZADO';

        IF existe = 0
        THEN
            RETURN 'El control no est&aacute; en estado Memorizado';
        END IF;


        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            RETURN 'No se puede registrar asignaci&oacute;n de una Fiscalizaci&oacute;n Ampliatoria';
        END IF;

        RETURN 'CORRECTO';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION verifica_asigna_control2 (prm_codigo     VARCHAR2,
                                       prm_usuario    VARCHAR2)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_gestion       VARCHAR2 (4);
        v_numero        NUMBER;
        val             VARCHAR2 (100);
        cad             VARCHAR2 (30000);
        v_key_year      VARCHAR2 (4);
        v_key_cou       VARCHAR2 (3);
        v_reg_nber      VARCHAR2 (10);
        existe          NUMBER;
        error_dui       VARCHAR2 (30000) := '';
        total           NUMBER := 0;
        grabadas        NUMBER := 0;
        v_tipo          VARCHAR2 (10);
        v_tipocontrol   VARCHAR2 (30);
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'No existe el Control';
        END IF;

        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.est_num = 0
                 AND a.est_lstope = 'U'
                 AND est_estado = 'MEMORIZADO';

        IF existe = 0
        THEN
            RETURN 'El control no est&aacute; en estado Memorizado';
        END IF;

        res := pkg_general.verifica_usuariogerencia (prm_codigo, prm_usuario);

        IF NOT res = 'CORRECTO'
        THEN
            RETURN res;
        END IF;


        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            RETURN 'No se puede registrar asignaci&oacute;n de una Fiscalizaci&oacute;n Ampliatoria';
        END IF;

        RETURN 'CORRECTO';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION verifica_acceso_control2 (prm_codigo     VARCHAR2,
                                       prm_usuario    VARCHAR2)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_gestion       VARCHAR2 (4);
        v_numero        NUMBER;
        val             VARCHAR2 (100);
        cad             VARCHAR2 (30000);
        v_key_year      VARCHAR2 (4);
        v_key_cou       VARCHAR2 (3);
        v_reg_nber      VARCHAR2 (10);
        existe          NUMBER;
        error_dui       VARCHAR2 (30000) := '';
        total           NUMBER := 0;
        grabadas        NUMBER := 0;
        v_tipo          VARCHAR2 (10);
        v_tipocontrol   VARCHAR2 (30);
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'No existe el Control';
        END IF;

        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.est_num = 0
                 AND a.est_lstope = 'U'
                 AND est_estado = 'REGISTRADO';

        IF existe = 0
        THEN
            RETURN 'El control no est&aacute; en estado Registrado';
        END IF;

        res := pkg_general.verifica_usuariogerencia (prm_codigo, prm_usuario);

        IF NOT res = 'CORRECTO'
        THEN
            RETURN res;
        END IF;


        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            RETURN 'No se puede registrar reasignaci&oacute;n de una Fiscalizaci&oacute;n Ampliatoria';
        END IF;

        RETURN 'CORRECTO';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION registra_controlant (prm_codigo      VARCHAR2,
                                  prm_gerencia    VARCHAR2,
                                  prm_usuario     VARCHAR2)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_gestion       VARCHAR2 (4);
        v_numero        NUMBER;
        v_numeroamp     VARCHAR2 (15);
        val             VARCHAR2 (100);
        cad             VARCHAR2 (30000);
        v_key_year      VARCHAR2 (4);
        v_key_cou       VARCHAR2 (3);
        v_reg_nber      VARCHAR2 (10);
        existe          NUMBER;
        error_dui       VARCHAR2 (30000) := '';
        total           NUMBER := 0;
        grabadas        NUMBER := 0;
        v_tipo          VARCHAR2 (20);
        v_tipocontrol   VARCHAR2 (30);
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'NO EXISTE EL CONTROL';
        END IF;

        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.est_num = 0
                 AND a.est_lstope = 'U'
                 AND est_estado = 'MEMORIZADO';

        IF existe = 0
        THEN
            RETURN 'El control no est&aacute; en estado Memorizado';
        END IF;

        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        --CONTROL DEL ALCANCE
        IF v_tipocontrol = 'POSTERIOR'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_alcance a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.alc_num = 0
                     AND a.alc_lstope = 'U';

            IF existe = 0
            THEN
                RETURN 'El control no tiene registrado alcance';
            END IF;
        END IF;

        IF v_tipocontrol = 'DIFERIDO'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_alcance a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.alc_num = 0
                     AND a.alc_lstope = 'U';

            IF existe = 0
            THEN
                RETURN 'El control no tiene registrado alcance';
            END IF;

            IF existe > 1
            THEN
                RETURN 'El control diferido no puede tener mas de una Declaraci&oacute;n registrada en el alcance';
            END IF;
        END IF;

        --CONTROL DEL LOS TIPOS PARA GENERAR EL REGISTRO
        IF v_tipocontrol = 'POSTERIOR' OR v_tipocontrol = 'DIFERIDO'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_estado a
             WHERE   a.ctl_control_id = prm_codigo;

            UPDATE   fis_estado
               SET   est_num = existe
             WHERE   ctl_control_id = prm_codigo AND est_num = 0;

            INSERT INTO fis_estado (ctl_control_id,
                                    est_estado,
                                    est_num,
                                    est_lstope,
                                    est_usuario,
                                    est_fecsys)
              VALUES   (prm_codigo,
                        'REGISTRADO',
                        0,
                        'U',
                        prm_usuario,
                        SYSDATE);

            SELECT   a.ctl_cod_tipo
              INTO   v_tipo
              FROM   fis_control a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U';

            v_gestion := TO_CHAR (SYSDATE, 'yyyy');
            v_numero := numero_control_gen (v_gestion, v_tipo, prm_gerencia);

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_control a
             WHERE   a.ctl_control_id = prm_codigo;

            UPDATE   fis_control
               SET   ctl_num = existe
             WHERE   ctl_control_id = prm_codigo AND ctl_num = 0;

            INSERT INTO fis_control
                SELECT   a.ctl_control_id,
                         v_gestion,
                         a.ctl_cod_tipo,
                         prm_gerencia,
                         v_numero,
                         a.ctl_tipo_documento,
                         a.ctl_nro_documento,
                         a.ctl_fecha_documento,
                         a.ctl_obs_documento,
                         a.ctl_riesgo_identificado,
                         a.ctl_tipo_doc_identidad,
                         a.ctl_nit,
                         a.ctl_razon_social,
                         a.ctl_ci,
                         a.ctl_ci_exp,
                         a.ctl_nombres,
                         a.ctl_appat,
                         a.ctl_apmat,
                         a.ctl_direccion,
                         a.ctl_actividad_principal,
                         a.ctl_amp_correlativo,
                         0,
                         'U',
                         prm_usuario,
                         SYSDATE,
                         a.ctl_tipo_operador,
                         a.ctl_tribtodos,
                         a.ctl_tribga,
                         a.ctl_tribiva,
                         a.ctl_tribice,
                         a.ctl_tribiehd,
                         a.ctl_tribicd,
                         a.ctl_tribnoaplica,
                         a.ctl_periodo,
                         a.ctl_riesgodelito,
                         a.ctl_riesgosubval,
                         a.ctl_riesgoclas,
                         a.ctl_riesgocontrab,
                         a.ctl_amp_control,
                         a.ctl_periodo_solicitar
                  FROM   fis_control a
                 WHERE       ctl_control_id = prm_codigo
                         AND ctl_num = existe
                         AND ROWNUM = 1;

            COMMIT;
            res :=
                   'CORRECTOSe registr&oacute; correctamente el Control '
                || v_gestion
                || '-'
                || v_tipo
                || '-'
                || prm_gerencia
                || '-'
                || v_numero;
            RETURN res;
        END IF;

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_estado a
             WHERE   a.ctl_control_id = prm_codigo;

            UPDATE   fis_estado
               SET   est_num = existe
             WHERE   ctl_control_id = prm_codigo AND est_num = 0;

            INSERT INTO fis_estado (ctl_control_id,
                                    est_estado,
                                    est_num,
                                    est_lstope,
                                    est_usuario,
                                    est_fecsys)
              VALUES   (prm_codigo,
                        'REGISTRADO',
                        0,
                        'U',
                        prm_usuario,
                        SYSDATE);

            SELECT   COUNT (1) + 1
              INTO   v_numero
              FROM   fis_control a, fis_control c
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.ctl_cod_gestion = c.ctl_cod_gestion
                     AND a.ctl_cod_tipo = c.ctl_cod_tipo
                     AND a.ctl_cod_gerencia = c.ctl_cod_gerencia
                     AND a.ctl_cod_numero = c.ctl_cod_numero
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND c.ctl_num = 0
                     AND c.ctl_lstope = 'U'
                     AND NOT c.ctl_amp_correlativo IS NULL;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_control a
             WHERE   a.ctl_control_id = prm_codigo;

            UPDATE   fis_control
               SET   ctl_num = existe
             WHERE   ctl_control_id = prm_codigo AND ctl_num = 0;

            INSERT INTO fis_control
                SELECT   a.ctl_control_id,
                         a.ctl_cod_gestion,
                         a.ctl_cod_tipo,
                         prm_gerencia,
                         a.ctl_cod_numero,
                         a.ctl_tipo_documento,
                         a.ctl_nro_documento,
                         a.ctl_fecha_documento,
                         a.ctl_obs_documento,
                         a.ctl_riesgo_identificado,
                         a.ctl_tipo_doc_identidad,
                         a.ctl_nit,
                         a.ctl_razon_social,
                         a.ctl_ci,
                         a.ctl_ci_exp,
                         a.ctl_nombres,
                         a.ctl_appat,
                         a.ctl_apmat,
                         a.ctl_direccion,
                         a.ctl_actividad_principal,
                         v_numero,
                         0,
                         'U',
                         prm_usuario,
                         SYSDATE,
                         a.ctl_tipo_operador,
                         a.ctl_tribtodos,
                         a.ctl_tribga,
                         a.ctl_tribiva,
                         a.ctl_tribice,
                         a.ctl_tribiehd,
                         a.ctl_tribicd,
                         a.ctl_tribnoaplica,
                         a.ctl_periodo,
                         a.ctl_riesgodelito,
                         a.ctl_riesgosubval,
                         a.ctl_riesgoclas,
                         a.ctl_riesgocontrab,
                         a.ctl_amp_control,
                         a.ctl_periodo_solicitar
                  FROM   fis_control a
                 WHERE       ctl_control_id = prm_codigo
                         AND ctl_num = existe
                         AND ROWNUM = 1;

            SELECT   ctl_cod_gestion,
                     ctl_cod_tipo,
                     ctl_cod_numero || '/' || ctl_amp_correlativo
              INTO   v_gestion, v_tipo, v_numeroamp
              FROM   fis_control a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U';

            COMMIT;
            res :=
                   'CORRECTOSe registr&oacute; correctamente el Control '
                || v_gestion
                || '-'
                || v_tipo
                || '-'
                || prm_gerencia
                || '-'
                || v_numeroamp;
            RETURN res;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;


    FUNCTION registra_control (prm_codigo                    VARCHAR2,
                               prm_gerencia                  VARCHAR2,
                               prm_usuario                   VARCHAR2,
                               prm_inn_1                     VARCHAR2,
                               prm_inn_2                     VARCHAR2,
                               prm_inn_3                     VARCHAR2,
                               prm_inn_4                     VARCHAR2,
                               prm_inn_5                     VARCHAR2,
                               prm_inn_6                     VARCHAR2,
                               prm_inn_7                     VARCHAR2,
                               prm_inn_8                     VARCHAR2,
                               prm_inn_9                     VARCHAR2,
                               prm_inn_10                    VARCHAR2,
                               prm_inn_11                    VARCHAR2,
                               prm_inn_12                    VARCHAR2,
                               prm_inn_13                    VARCHAR2,
                               prm_inn_14                    VARCHAR2,
                               prm_inn_15                    VARCHAR2,
                               prm_inn_16                    VARCHAR2,
                               prm_inn_17                    VARCHAR2,
                               prm_inn_18                    VARCHAR2,
                               prm_inn_19                    VARCHAR2,
                               prm_inn_20                    VARCHAR2,
                               prm_inn_21                    VARCHAR2,
                               prm_inn_plazo_conclusion      VARCHAR2,
                               prm_tribga                 IN VARCHAR2,
                               prm_tribiva                IN VARCHAR2,
                               prm_tribice                IN VARCHAR2,
                               prm_tribiehd               IN VARCHAR2,
                               prm_tribicd                IN VARCHAR2,
                               prm_tribnoaplica           IN VARCHAR2,
                               prm_peridodosolicitar      IN VARCHAR2,
                               prm_nrodocumento           IN VARCHAR2,
                               prm_fecdocumento           IN VARCHAR2,
                               prm_riesgodelito           IN VARCHAR2,
                               prm_riesgosubval           IN VARCHAR2,
                               prm_riesgoclas             IN VARCHAR2,
                               prm_riesgocontrab          IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_gestion       VARCHAR2 (4);
        v_numero        NUMBER;
        v_numeroinfo    NUMBER;
        v_numeroamp     VARCHAR2 (15);
        val             VARCHAR2 (100);
        cad             VARCHAR2 (30000);
        v_key_year      VARCHAR2 (4);
        v_key_cou       VARCHAR2 (3);
        v_reg_nber      VARCHAR2 (10);
        existe          NUMBER;
        error_dui       VARCHAR2 (30000) := '';
        total           NUMBER := 0;
        grabadas        NUMBER := 0;
        v_tipo          VARCHAR2 (30);
        v_tipocontrol   VARCHAR2 (30);
        v_codigofisca   VARCHAR2 (100);
    BEGIN
        IF     prm_tribga IS NULL
           AND prm_tribiva IS NULL
           AND prm_tribice IS NULL
           AND prm_tribiehd IS NULL
           AND prm_tribicd IS NULL
        THEN
            IF prm_tribnoaplica IS NULL
            THEN
                RETURN 'Si no desea seleccionar ning&uacute;n tributo a fiscalizar, debe marcar la casilla de no aplica';
            END IF;
        ELSE
            IF NOT prm_tribnoaplica IS NULL
            THEN
                RETURN 'Si seleccion&oacute; uno de los tributos a fiscalizar, no debe marcar la casilla de no aplica';
            END IF;
        END IF;


        IF     prm_inn_1 IS NULL
           AND prm_inn_2 IS NULL
           AND prm_inn_3 IS NULL
           AND prm_inn_4 IS NULL
           AND prm_inn_5 IS NULL
           AND prm_inn_6 IS NULL
           AND prm_inn_7 IS NULL
           AND prm_inn_8 IS NULL
           AND prm_inn_9 IS NULL
           AND prm_inn_10 IS NULL
           AND prm_inn_11 IS NULL
           AND prm_inn_12 IS NULL
           AND prm_inn_13 IS NULL
           AND prm_inn_14 IS NULL
           AND prm_inn_15 IS NULL
           AND prm_inn_16 IS NULL
           AND prm_inn_17 IS NULL
           AND prm_inn_18 IS NULL
           AND prm_inn_19 IS NULL
           AND prm_inn_20 IS NULL
           AND prm_inn_21 IS NULL
        THEN
            RETURN 'Debe seleccionar por lo menos un elemento para el documento de notificaci&oacute;n';
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_control a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U';

            IF existe = 0
            THEN
                RETURN 'No existe el control';
            END IF;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_estado a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.est_num = 0
                     AND a.est_lstope = 'U'
                     AND est_estado = 'MEMORIZADO';

            IF existe = 0
            THEN
                RETURN 'El control no est&aacute; en estado Memorizado';
            END IF;

            SELECT   ctl_cod_tipo
              INTO   v_tipocontrol
              FROM   fis_control a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U';

            --CONTROL DEL ALCANCE
            IF v_tipocontrol = 'POSTERIOR'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.alc_num = 0
                         AND a.alc_lstope = 'U';

                IF existe = 0
                THEN
                    RETURN 'El control no tiene registrado alcance';
                END IF;
            END IF;

            IF v_tipocontrol = 'DIFERIDO'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.alc_num = 0
                         AND a.alc_lstope = 'U';

                IF existe = 0
                THEN
                    RETURN 'El control no tiene registrado alcance';
                END IF;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.alc_num = 0
                         AND a.alc_lstope = 'U'
                         AND a.alc_tipo_tramite <> 'DUI';

                IF existe > 0
                THEN
                    RETURN 'El control diferido no puede tener otros tipos de tr&aacute;mites registrados en el alcance';
                END IF;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.alc_num = 0
                         AND a.alc_lstope = 'U'
                         AND a.alc_tipo_tramite = 'DUI';

                IF existe > 1
                THEN
                    RETURN 'El control diferido no puede tener m&aacute;s de una declaraci&oacute;n registrada en el alcance';
                END IF;
            END IF;

            IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
               OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance_amp a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.amp_num = 0
                         AND a.amp_lstope = 'U';

                IF existe = 0
                THEN
                    RETURN 'El control ampliatorio no tiene registrado alcance';
                END IF;
            END IF;

            --CONTROL DE LA ASIGNACION DE FISCALIZADORES
            IF v_tipocontrol = 'POSTERIOR' OR v_tipocontrol = 'DIFERIDO'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_fiscalizador a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.fis_cargo = 'FISCALIZADOR'
                         AND fis_num = 0
                         AND fis_lstope = 'U';

                IF existe = 0
                THEN
                    RETURN 'El control no tiene registrado fiscalizador';
                END IF;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_fiscalizador a
                 WHERE   a.ctl_control_id = prm_codigo
                         AND (a.fis_cargo = 'SUPERVISOR'
                              OR a.fis_cargo = 'JEFE')
                         AND fis_num = 0
                         AND fis_lstope = 'U';

                IF existe = 0
                THEN
                    RETURN 'El control no tiene registrado un Jefe o Supervisor';
                END IF;
            END IF;



            --CONTROL DEL LOS TIPOS PARA GENERAR EL REGISTRO
            IF v_tipocontrol = 'POSTERIOR' OR v_tipocontrol = 'DIFERIDO'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_estado a
                 WHERE   a.ctl_control_id = prm_codigo;

                UPDATE   fis_estado
                   SET   est_num = existe
                 WHERE   ctl_control_id = prm_codigo AND est_num = 0;

                INSERT INTO fis_estado (ctl_control_id,
                                        est_estado,
                                        est_num,
                                        est_lstope,
                                        est_usuario,
                                        est_fecsys)
                  VALUES   (prm_codigo,
                            'REGISTRADO',
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE);

                SELECT   a.ctl_cod_tipo
                  INTO   v_tipo
                  FROM   fis_control a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U';

                v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                v_numero :=
                    numero_control_gen (v_gestion, v_tipo, prm_gerencia);

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_control a
                 WHERE   a.ctl_control_id = prm_codigo;

                UPDATE   fis_control
                   SET   ctl_num = existe
                 WHERE   ctl_control_id = prm_codigo AND ctl_num = 0;

                INSERT INTO fis_control
                    SELECT   a.ctl_control_id,
                             v_gestion,
                             a.ctl_cod_tipo,
                             prm_gerencia,
                             v_numero,
                             a.ctl_tipo_documento,
                             prm_nrodocumento,
                             TO_DATE (prm_fecdocumento, 'dd/mm/yyyy'),
                             a.ctl_obs_documento,
                             a.ctl_riesgo_identificado,
                             a.ctl_tipo_doc_identidad,
                             a.ctl_nit,
                             a.ctl_razon_social,
                             a.ctl_ci,
                             a.ctl_ci_exp,
                             a.ctl_nombres,
                             a.ctl_appat,
                             a.ctl_apmat,
                             a.ctl_direccion,
                             a.ctl_actividad_principal,
                             a.ctl_amp_correlativo,
                             0,
                             'U',
                             prm_usuario,
                             SYSDATE,
                             a.ctl_tipo_operador,
                             a.ctl_tribtodos,
                             prm_tribga,
                             prm_tribiva,
                             prm_tribice,
                             prm_tribiehd,
                             prm_tribicd,
                             prm_tribnoaplica,
                             a.ctl_periodo,
                             prm_riesgodelito,
                             prm_riesgosubval,
                             prm_riesgoclas,
                             prm_riesgocontrab,
                             a.ctl_amp_control,
                             prm_peridodosolicitar
                      FROM   fis_control a
                     WHERE       ctl_control_id = prm_codigo
                             AND ctl_num = existe
                             AND ROWNUM = 1;

                v_numeroinfo :=
                    numero_control_gen (v_gestion, 'INF', prm_gerencia);

                INSERT INTO fis_info_notificacion a (a.inn_infnot_id,
                                                     a.inn_plazo_conclusion,
                                                     a.inn_1,
                                                     a.inn_2,
                                                     a.inn_3,
                                                     a.inn_4,
                                                     a.inn_5,
                                                     a.inn_6,
                                                     a.inn_7,
                                                     a.inn_8,
                                                     a.inn_9,
                                                     a.inn_10,
                                                     a.inn_11,
                                                     a.inn_12,
                                                     a.inn_13,
                                                     a.inn_14,
                                                     a.inn_15,
                                                     a.inn_16,
                                                     a.inn_17,
                                                     a.inn_18,
                                                     a.inn_19,
                                                     a.inn_20,
                                                     a.inn_21,
                                                     a.inn_num,
                                                     a.inn_lstope,
                                                     a.inn_usuario,
                                                     a.inn_fecsys,
                                                     a.ctl_control_id)
                  VALUES   (v_gestion || v_numeroinfo,
                            prm_inn_plazo_conclusion,
                            prm_inn_1,
                            prm_inn_2,
                            prm_inn_3,
                            prm_inn_4,
                            prm_inn_5,
                            prm_inn_6,
                            prm_inn_7,
                            prm_inn_8,
                            prm_inn_9,
                            prm_inn_10,
                            prm_inn_11,
                            prm_inn_12,
                            prm_inn_13,
                            prm_inn_14,
                            prm_inn_15,
                            prm_inn_16,
                            prm_inn_17,
                            prm_inn_18,
                            prm_inn_19,
                            prm_inn_20,
                            prm_inn_21,
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE,
                            prm_codigo);

                COMMIT;

                SELECT   a.ctl_cod_gestion
                         || DECODE (a.ctl_cod_tipo,
                                    'DIFERIDO', 'CD',
                                    'POSTERIOR', 'FP',
                                    'AMPLIATORIA DIFERIDO', 'CD',
                                    'AMPLIATORIA POSTERIOR', 'FP',
                                    '-')
                         || a.ctl_cod_gerencia
                         || DECODE (
                                a.ctl_amp_correlativo,
                                NULL,
                                '00',
                                DECODE (LENGTH (a.ctl_amp_correlativo),
                                        1, '0' || a.ctl_amp_correlativo,
                                        a.ctl_amp_correlativo))
                         || DECODE (LENGTH (a.ctl_cod_numero),
                                    1, '0000' || a.ctl_cod_numero,
                                    2, '000' || a.ctl_cod_numero,
                                    3, '00' || a.ctl_cod_numero,
                                    4, '0' || a.ctl_cod_numero,
                                    a.ctl_cod_numero)
                  INTO   v_codigofisca
                  FROM   fis_control a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U';

                INSERT INTO fis_acceso
                    SELECT   a.fis_fiscalizador_id,
                             a.fis_codigo_fiscalizador,
                             a.fis_cargo,
                             a.fis_num,
                             a.fis_lstope,
                             prm_usuario,
                             SYSDATE,
                             a.ctl_control_id
                      FROM   fis_fiscalizador a
                     WHERE       a.ctl_control_id = prm_codigo
                             AND a.fis_num = 0
                             AND a.fis_lstope = 'U';

                res :=
                    'CORRECTOSe registr&oacute; correctamente el Control '
                    || v_codigofisca;
                RETURN res;
            END IF;

            IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
               OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_estado a
                 WHERE   a.ctl_control_id = prm_codigo;

                UPDATE   fis_estado
                   SET   est_num = existe
                 WHERE   ctl_control_id = prm_codigo AND est_num = 0;

                INSERT INTO fis_estado (ctl_control_id,
                                        est_estado,
                                        est_num,
                                        est_lstope,
                                        est_usuario,
                                        est_fecsys)
                  VALUES   (prm_codigo,
                            'REGISTRADO',
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE);

                SELECT   COUNT (1) + 1
                  INTO   v_numero
                  FROM   fis_control a, fis_control c
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.ctl_cod_gestion = c.ctl_cod_gestion
                         AND a.ctl_cod_tipo = c.ctl_cod_tipo
                         AND a.ctl_cod_gerencia = c.ctl_cod_gerencia
                         AND a.ctl_cod_numero = c.ctl_cod_numero
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U'
                         AND c.ctl_num = 0
                         AND c.ctl_lstope = 'U'
                         AND NOT c.ctl_amp_correlativo IS NULL;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_control a
                 WHERE   a.ctl_control_id = prm_codigo;

                UPDATE   fis_control
                   SET   ctl_num = existe
                 WHERE   ctl_control_id = prm_codigo AND ctl_num = 0;

                INSERT INTO fis_control
                    SELECT   a.ctl_control_id,
                             a.ctl_cod_gestion,
                             a.ctl_cod_tipo,
                             prm_gerencia,
                             a.ctl_cod_numero,
                             a.ctl_tipo_documento,
                             prm_nrodocumento,
                             TO_DATE (prm_fecdocumento, 'dd/mm/yyyy'),
                             a.ctl_obs_documento,
                             a.ctl_riesgo_identificado,
                             a.ctl_tipo_doc_identidad,
                             a.ctl_nit,
                             a.ctl_razon_social,
                             a.ctl_ci,
                             a.ctl_ci_exp,
                             a.ctl_nombres,
                             a.ctl_appat,
                             a.ctl_apmat,
                             a.ctl_direccion,
                             a.ctl_actividad_principal,
                             v_numero,
                             0,
                             'U',
                             prm_usuario,
                             SYSDATE,
                             a.ctl_tipo_operador,
                             a.ctl_tribtodos,
                             prm_tribga,
                             prm_tribiva,
                             prm_tribice,
                             prm_tribiehd,
                             prm_tribicd,
                             prm_tribnoaplica,
                             a.ctl_periodo,
                             prm_riesgodelito,
                             prm_riesgosubval,
                             prm_riesgoclas,
                             prm_riesgocontrab,
                             a.ctl_amp_control,
                             prm_peridodosolicitar
                      FROM   fis_control a
                     WHERE       ctl_control_id = prm_codigo
                             AND ctl_num = existe
                             AND ROWNUM = 1;

                SELECT   ctl_cod_gestion,
                         ctl_cod_tipo,
                         ctl_cod_numero || '/' || ctl_amp_correlativo
                  INTO   v_gestion, v_tipo, v_numeroamp
                  FROM   fis_control a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U';

                v_numero :=
                    numero_control_gen (v_gestion, 'INF', prm_gerencia);

                INSERT INTO fis_info_notificacion a (a.inn_infnot_id,
                                                     a.inn_plazo_conclusion,
                                                     a.inn_1,
                                                     a.inn_2,
                                                     a.inn_3,
                                                     a.inn_4,
                                                     a.inn_5,
                                                     a.inn_6,
                                                     a.inn_7,
                                                     a.inn_8,
                                                     a.inn_9,
                                                     a.inn_10,
                                                     a.inn_11,
                                                     a.inn_12,
                                                     a.inn_13,
                                                     a.inn_14,
                                                     a.inn_15,
                                                     a.inn_16,
                                                     a.inn_17,
                                                     a.inn_18,
                                                     a.inn_19,
                                                     a.inn_20,
                                                     a.inn_21,
                                                     a.inn_num,
                                                     a.inn_lstope,
                                                     a.inn_usuario,
                                                     a.inn_fecsys,
                                                     a.ctl_control_id)
                  VALUES   (v_gestion || v_numero,
                            prm_inn_plazo_conclusion,
                            prm_inn_1,
                            prm_inn_2,
                            prm_inn_3,
                            prm_inn_4,
                            prm_inn_5,
                            prm_inn_6,
                            prm_inn_7,
                            prm_inn_8,
                            prm_inn_9,
                            prm_inn_10,
                            prm_inn_11,
                            prm_inn_12,
                            prm_inn_13,
                            prm_inn_14,
                            prm_inn_15,
                            prm_inn_16,
                            prm_inn_17,
                            prm_inn_18,
                            prm_inn_19,
                            prm_inn_20,
                            prm_inn_21,
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE,
                            prm_codigo);

                COMMIT;

                SELECT   a.ctl_cod_gestion
                         || DECODE (a.ctl_cod_tipo,
                                    'DIFERIDO', 'CD',
                                    'POSTERIOR', 'FP',
                                    'AMPLIATORIA DIFERIDO', 'CD',
                                    'AMPLIATORIA POSTERIOR', 'FP',
                                    '-')
                         || a.ctl_cod_gerencia
                         || DECODE (
                                a.ctl_amp_correlativo,
                                NULL,
                                '00',
                                DECODE (LENGTH (a.ctl_amp_correlativo),
                                        1, '0' || a.ctl_amp_correlativo,
                                        a.ctl_amp_correlativo))
                         || DECODE (LENGTH (a.ctl_cod_numero),
                                    1, '0000' || a.ctl_cod_numero,
                                    2, '000' || a.ctl_cod_numero,
                                    3, '00' || a.ctl_cod_numero,
                                    4, '0' || a.ctl_cod_numero,
                                    a.ctl_cod_numero)
                  INTO   v_codigofisca
                  FROM   fis_control a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U';


                res :=
                    'CORRECTOSe registr&oacute; correctamente el Control '
                    || v_codigofisca;
                RETURN res;
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_asignacion (prm_id         VARCHAR2,
                               prm_usufis     VARCHAR2,
                               prm_cargo      VARCHAR2,
                               prm_usuario    VARCHAR2)
        RETURN VARCHAR2
    IS
        res         VARCHAR2 (300) := 0;
        existe      NUMBER;
        v_gestion   VARCHAR2 (4);
        v_numero    NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_fiscalizador a
         WHERE       a.fis_codigo_fiscalizador = prm_usufis
                 AND a.ctl_control_id = prm_id
                 AND a.fis_num = 0
                 AND a.fis_lstope = 'U';

        IF existe = 0
        THEN
            IF NOT prm_cargo = 'FISCALIZADOR'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_fiscalizador a
                 WHERE       a.ctl_control_id = prm_id
                         AND a.fis_num = 0
                         AND a.fis_lstope = 'U'
                         AND a.fis_cargo = prm_cargo;

                IF existe = 1
                THEN
                    RETURN 'Solo se puede registrar un funcionario como '
                           || prm_cargo;
                ELSE
                    v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                    v_numero := numero_control_asig (v_gestion);

                    INSERT INTO fis_fiscalizador (fis_fiscalizador_id,
                                                  fis_codigo_fiscalizador,
                                                  fis_cargo,
                                                  fis_num,
                                                  fis_lstope,
                                                  fis_usuario,
                                                  fis_fecsys,
                                                  ctl_control_id)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                prm_usufis,
                                prm_cargo,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_id);

                    COMMIT;
                    RETURN 'CORRECTOSe asign&oacute;  correctamente al fiscalizador '
                           || UPPER (prm_usufis);
                END IF;
            ELSE
                v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                v_numero := numero_control_asig (v_gestion);

                INSERT INTO fis_fiscalizador (fis_fiscalizador_id,
                                              fis_codigo_fiscalizador,
                                              fis_cargo,
                                              fis_num,
                                              fis_lstope,
                                              fis_usuario,
                                              fis_fecsys,
                                              ctl_control_id)
                  VALUES   (v_gestion || TO_CHAR (v_numero),
                            prm_usufis,
                            prm_cargo,
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE,
                            prm_id);

                COMMIT;
                RETURN 'CORRECTOSe asign&oacute;  correctamente al fiscalizador '
                       || UPPER (prm_usufis);
            END IF;
        ELSE
            RETURN 'El fiscalizador ya se encuentra asignado al Control';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION borra_asignacion (prm_id VARCHAR2, prm_usuario VARCHAR2)
        RETURN VARCHAR2
    IS
        res      VARCHAR2 (300) := 0;
        existe   NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_fiscalizador b
         WHERE       b.fis_fiscalizador_id = prm_id
                 AND b.fis_num = 0
                 AND b.fis_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'El Fiscalizador no existe';
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_fiscalizador b
             WHERE   b.fis_fiscalizador_id = prm_id;

            UPDATE   fis_fiscalizador b
               SET   b.fis_num = existe
             WHERE   b.fis_fiscalizador_id = prm_id AND b.fis_num = 0;

            INSERT INTO fis_fiscalizador
                SELECT   a.fis_fiscalizador_id,
                         a.fis_codigo_fiscalizador,
                         a.fis_cargo,
                         0,
                         'D',
                         prm_usuario,
                         SYSDATE,
                         a.ctl_control_id
                  FROM   fis_fiscalizador a
                 WHERE       a.fis_fiscalizador_id = prm_id
                         AND a.fis_num = existe
                         AND ROWNUM = 1;

            RETURN 'CORRECTOEl Fiscalizador se borr&oacute; correctamente';
        END IF;
    END;

    FUNCTION graba_acceso (prm_id         VARCHAR2,
                           prm_usufis     VARCHAR2,
                           prm_cargo      VARCHAR2,
                           prm_usuario    VARCHAR2)
        RETURN VARCHAR2
    IS
        res         VARCHAR2 (300) := 0;
        existe      NUMBER;
        v_gestion   VARCHAR2 (4);
        v_numero    NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_acceso a
         WHERE       a.fis_codigo_fiscalizador = prm_usufis
                 AND a.ctl_control_id = prm_id
                 AND a.fis_num = 0
                 AND a.fis_lstope = 'U';

        IF existe = 0
        THEN
            IF prm_cargo = 'JEFE' OR prm_cargo = 'SUPERVISOR'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_acceso a
                 WHERE       a.ctl_control_id = prm_id
                         AND a.fis_num = 0
                         AND a.fis_lstope = 'U'
                         AND a.fis_cargo = prm_cargo;

                IF existe = 1
                THEN
                    RETURN 'Solo se puede registrar un funcionario como '
                           || prm_cargo;
                ELSE
                    v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                    v_numero := numero_control_asig (v_gestion);

                    INSERT INTO fis_acceso (fis_acceso_id,
                                            fis_codigo_fiscalizador,
                                            fis_cargo,
                                            fis_num,
                                            fis_lstope,
                                            fis_usuario,
                                            fis_fecsys,
                                            ctl_control_id)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                prm_usufis,
                                prm_cargo,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_id);

                    COMMIT;
                    RETURN 'CORRECTOSe asign&oacute;  correctamente al fiscalizador '
                           || UPPER (prm_usufis);
                END IF;
            ELSE
                v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                v_numero := numero_control_asig (v_gestion);

                INSERT INTO fis_acceso (fis_acceso_id,
                                        fis_codigo_fiscalizador,
                                        fis_cargo,
                                        fis_num,
                                        fis_lstope,
                                        fis_usuario,
                                        fis_fecsys,
                                        ctl_control_id)
                  VALUES   (v_gestion || TO_CHAR (v_numero),
                            prm_usufis,
                            prm_cargo,
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE,
                            prm_id);

                COMMIT;
                RETURN 'CORRECTOSe asign&oacute;  correctamente al fiscalizador '
                       || UPPER (prm_usufis);
            END IF;
        ELSE
            RETURN 'El fiscalizador ya se encuentra asignado al Control';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION borra_acceso (prm_id VARCHAR2, prm_usuario VARCHAR2)
        RETURN VARCHAR2
    IS
        res      VARCHAR2 (300) := 0;
        existe   NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_acceso b
         WHERE       b.fis_acceso_id = prm_id
                 AND b.fis_num = 0
                 AND b.fis_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'El asignaci&oacute;n no existe';
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_acceso a, fis_notificacion b
             WHERE       a.fis_acceso_id = prm_id
                     AND a.fis_cargo = 'FISCALIZADOR'
                     AND a.fis_num = 0
                     AND a.fis_lstope = 'U'
                     AND a.fis_codigo_fiscalizador = b.not_usuario
                     AND b.not_num = 0
                     AND b.not_lstope = 'U'
                     AND a.ctl_control_id = b.ctl_control_id;

            IF existe > 0
            THEN
                RETURN 'El Funcionario realiz&oacute; la operacion de Notificaci&oacute;n, no se puede eliminar la asignaci&oacute;n';
            END IF;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_acceso a, fis_conclusion b
             WHERE       a.fis_acceso_id = prm_id
                     AND a.fis_cargo = 'FISCALIZADOR'
                     AND a.fis_num = 0
                     AND a.fis_lstope = 'U'
                     AND a.fis_codigo_fiscalizador = b.con_usuario
                     AND b.con_num = 0
                     AND b.con_lstope = 'U'
                     AND a.ctl_control_id = b.ctl_control_id;

            IF existe > 0
            THEN
                RETURN 'El Funcionario realiz&oacute; la operacion de Concluci&oacute;n, no se puede eliminar la asignaci&oacute;n';
            END IF;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_acceso b
             WHERE   b.fis_acceso_id = prm_id;

            UPDATE   fis_acceso b
               SET   b.fis_num = existe
             WHERE   b.fis_acceso_id = prm_id AND b.fis_num = 0;

            INSERT INTO fis_acceso
                SELECT   a.fis_acceso_id,
                         a.fis_codigo_fiscalizador,
                         a.fis_cargo,
                         0,
                         'D',
                         prm_usuario,
                         SYSDATE,
                         a.ctl_control_id
                  FROM   fis_acceso a
                 WHERE       a.fis_acceso_id = prm_id
                         AND a.fis_num = existe
                         AND ROWNUM = 1;

            RETURN 'CORRECTOLa asignaci&oacute;n se borr&oacute; correctamente';
        END IF;
    END;

    FUNCTION verifica_anulacion_control (prm_codigo      VARCHAR2,
                                         prm_gerencia    VARCHAR2,
                                         prm_usuario     VARCHAR2)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_gestion       VARCHAR2 (4);
        v_numero        NUMBER;
        val             VARCHAR2 (100);
        cad             VARCHAR2 (30000);
        v_key_year      VARCHAR2 (4);
        v_key_cou       VARCHAR2 (3);
        v_reg_nber      VARCHAR2 (10);
        existe          NUMBER;
        error_dui       VARCHAR2 (30000) := '';
        total           NUMBER := 0;
        grabadas        NUMBER := 0;
        v_tipo          VARCHAR2 (15);
        v_tipocontrol   VARCHAR2 (30);
        v_gerusuario    VARCHAR2 (30);
        v_gercontrol    VARCHAR2 (30);
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'No existe el Control';
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_estado a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.est_num = 0
                     AND a.est_lstope = 'U'
                     AND est_estado = 'ANULADO';

            IF existe > 0
            THEN
                RETURN 'El control ya se encuentra Anulado';
            ELSE
                res :=
                    pkg_general.verifica_usuariogerencia (prm_codigo,
                                                          prm_usuario);

                IF NOT res = 'CORRECTO'
                THEN
                    RETURN res;
                ELSE
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_estado a
                     WHERE       a.ctl_control_id = prm_codigo
                             AND a.est_num = 0
                             AND a.est_lstope = 'U'
                             AND est_estado = 'MEMORIZADO';

                    IF existe > 0
                    THEN
                        RETURN 'CORRECTO';
                    ELSE
                        SELECT   COUNT (1)
                          INTO   existe
                          FROM   fis_estado a
                         WHERE       a.ctl_control_id = prm_codigo
                                 AND a.est_num = 0
                                 AND a.est_lstope = 'U'
                                 AND est_estado = 'REGISTRADO';

                        IF existe > 0
                        THEN
                            SELECT   COUNT (1)
                              INTO   existe
                              FROM   fis_notificacion a
                             WHERE       a.ctl_control_id = prm_codigo
                                     AND a.not_num = 0
                                     AND a.not_lstope = 'U';

                            IF existe = 0
                            THEN
                                SELECT   ctl_cod_tipo
                                  INTO   v_tipocontrol
                                  FROM   fis_control a
                                 WHERE       a.ctl_control_id = prm_codigo
                                         AND a.ctl_num = 0
                                         AND a.ctl_lstope = 'U';

                                IF v_tipocontrol = 'POSTERIOR'
                                   OR v_tipocontrol = 'DIFERIDO'
                                THEN
                                    SELECT   COUNT (1)
                                      INTO   existe
                                      FROM   fis_control a, fis_control b
                                     WHERE   a.ctl_control_id = prm_codigo
                                             AND a.ctl_num = 0
                                             AND a.ctl_lstope = 'U'
                                             AND a.ctl_cod_gestion =
                                                    b.ctl_cod_gestion
                                             AND a.ctl_cod_tipo =
                                                    b.ctl_amp_control
                                             AND a.ctl_cod_gerencia =
                                                    b.ctl_cod_gerencia
                                             AND a.ctl_cod_numero =
                                                    b.ctl_cod_numero
                                             AND b.ctl_num = 0
                                             AND b.ctl_lstope = 'U';

                                    IF existe > 0
                                    THEN
                                        RETURN 'El control tiene fiscalizaciones ampliatorias registradas';
                                    ELSE
                                        RETURN 'CORRECTO';
                                    END IF;
                                ELSE
                                    RETURN 'CORRECTO';
                                END IF;
                            ELSE
                                RETURN 'No se puede Anular, porque el control ya fue notificado';
                            END IF;
                        ELSE
                            RETURN 'Debe estar en estado MEMORIZADO o REGISTRADO, para poder anular';
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION verifica_registro_recibos (prm_codigo      VARCHAR2,
                                        prm_gerencia    VARCHAR2,
                                        prm_usuario     VARCHAR2)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_gestion       VARCHAR2 (4);
        v_numero        NUMBER;
        val             VARCHAR2 (100);
        cad             VARCHAR2 (30000);
        v_key_year      VARCHAR2 (4);
        v_key_cou       VARCHAR2 (3);
        v_reg_nber      VARCHAR2 (10);
        existe          NUMBER;
        error_dui       VARCHAR2 (30000) := '';
        total           NUMBER := 0;
        grabadas        NUMBER := 0;
        v_tipo          VARCHAR2 (15);
        v_tipocontrol   VARCHAR2 (30);
        v_gerusuario    VARCHAR2 (30);
        v_gercontrol    VARCHAR2 (30);
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'No existe el Control';
        ELSE
            res :=
                pkg_general.verifica_usuariogerencia (prm_codigo,
                                                      prm_usuario);

            IF NOT res = 'CORRECTO'
            THEN
                RETURN res;
            ELSE
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_notificacion a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.not_num = 0
                         AND a.not_lstope = 'U';

                IF existe > 0
                THEN
                    RETURN 'CORRECTO';
                ELSE
                    RETURN 'No se puede registrar recibos de pago porque el control no fue notificado';
                END IF;
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;


    FUNCTION anula_control (prm_codigo           VARCHAR2,
                            prm_gerencia         VARCHAR2,
                            prm_usuario          VARCHAR2,
                            prm_justificacion    VARCHAR2)
        RETURN VARCHAR2
    IS
        res         VARCHAR2 (300) := 0;
        existe      NUMBER;
        v_gestion   VARCHAR2 (4);
        v_numero    NUMBER;
        v_fecreg    DATE;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_anulacion a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.anu_num = 0
                 AND a.anu_lstope = 'U';

        IF existe = 0
        THEN
            FOR i
            IN (SELECT   a.alc_alcance_id
                  FROM   fis_alcance a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.alc_num = 0
                         AND a.alc_lstope = 'U')
            LOOP
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance b
                 WHERE   b.alc_alcance_id = i.alc_alcance_id;

                UPDATE   fis_alcance b
                   SET   b.alc_num = existe
                 WHERE   b.alc_alcance_id = i.alc_alcance_id
                         AND b.alc_num = 0;

                INSERT INTO fis_alcance
                    SELECT   a.alc_alcance_id,
                             a.alc_tipo_alcance,
                             a.alc_tipo_tramite,
                             a.alc_gestion,
                             a.alc_aduana,
                             a.alc_numero,
                             a.alc_fecha,
                             a.alc_proveedor,
                             a.alc_pais,
                             a.alc_tipo_documento,
                             0,
                             'D',
                             prm_usuario,
                             SYSDATE,
                             a.ctl_control_id,
                             a.alc_tipo_etapa
                      FROM   fis_alcance a
                     WHERE       a.alc_alcance_id = i.alc_alcance_id
                             AND a.alc_num = existe
                             AND ROWNUM = 1;
            END LOOP;



            INSERT INTO fis_anulacion (ctl_control_id,
                                       anu_justificacion,
                                       anu_num,
                                       anu_lstope,
                                       anu_usuario,
                                       anu_fecsys)
              VALUES   (prm_codigo,
                        prm_justificacion,
                        0,
                        'U',
                        prm_usuario,
                        SYSDATE);

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_estado a
             WHERE   a.ctl_control_id = prm_codigo;

            UPDATE   fis_estado
               SET   est_num = existe
             WHERE   ctl_control_id = prm_codigo AND est_num = 0;

            INSERT INTO fis_estado (ctl_control_id,
                                    est_estado,
                                    est_num,
                                    est_lstope,
                                    est_usuario,
                                    est_fecsys)
              VALUES   (prm_codigo,
                        'ANULADO',
                        0,
                        'D',
                        prm_usuario,
                        SYSDATE);


            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_control a
             WHERE   a.ctl_control_id = prm_codigo;

            UPDATE   fis_control
               SET   ctl_num = existe
             WHERE   ctl_control_id = prm_codigo AND ctl_num = 0;

            INSERT INTO fis_control
                SELECT   a.ctl_control_id,
                         a.ctl_cod_gestion,
                         a.ctl_cod_tipo,
                         a.ctl_cod_gerencia,
                         a.ctl_cod_numero,
                         a.ctl_tipo_documento,
                         a.ctl_nro_documento,
                         a.ctl_fecha_documento,
                         a.ctl_obs_documento,
                         a.ctl_riesgo_identificado,
                         a.ctl_tipo_doc_identidad,
                         a.ctl_nit,
                         a.ctl_razon_social,
                         a.ctl_ci,
                         a.ctl_ci_exp,
                         a.ctl_nombres,
                         a.ctl_appat,
                         a.ctl_apmat,
                         a.ctl_direccion,
                         a.ctl_actividad_principal,
                         a.ctl_amp_correlativo,
                         0,
                         'D',
                         prm_usuario,
                         SYSDATE,
                         a.ctl_tipo_operador,
                         a.ctl_tribtodos,
                         a.ctl_tribga,
                         a.ctl_tribiva,
                         a.ctl_tribice,
                         a.ctl_tribiehd,
                         a.ctl_tribicd,
                         a.ctl_tribnoaplica,
                         a.ctl_periodo,
                         a.ctl_riesgodelito,
                         a.ctl_riesgosubval,
                         a.ctl_riesgoclas,
                         a.ctl_riesgocontrab,
                         a.ctl_amp_control,
                         a.ctl_periodo_solicitar
                  FROM   fis_control a
                 WHERE       ctl_control_id = prm_codigo
                         AND ctl_num = existe
                         AND ROWNUM = 1;



            COMMIT;
            RETURN 'CORRECTOSe anul&oacute; correctamente el control';
        ELSE
            /*
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_anulacion a
             WHERE   a.ctl_control_id = prm_id;

            UPDATE   fis_anulacion
               SET   anu_num = existe
             WHERE   ctl_control_id = prm_id AND anu_num = 0;

            INSERT INTO fis_anulacion (ctl_control_id,
                                       anu_justificacion,
                                       anu_num,
                                       anu_lstope,
                                       anu_usuario,
                                       anu_fecsys)
              VALUES   (prm_id,
                        prm_justificacion,
                        0,
                        'U',
                        prm_usuario,
                        SYSDATE);

            RETURN 'CORRECTOSe anulo corectamente el control';*/
            RETURN 'El control ya se encuentra anulado';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION devuelve_dif_duis1 (prm_fecini   IN     VARCHAR2,
                                 prm_fecfin   IN     VARCHAR2,
                                 prm_aduana   IN     VARCHAR2,
                                 prm_reg      IN     VARCHAR2,
                                 ct              OUT cursortype)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (300) := 0;
    BEGIN
        IF prm_aduana = '%'
        THEN
            OPEN ct FOR
                  SELECT   *
                    FROM   (SELECT   DISTINCT
                                        gen.key_year
                                     || '/'
                                     || gen.key_cuo
                                     || '/'
                                     || gen.sad_reg_serial
                                     || '-'
                                     || gen.sad_reg_nber
                                         tramite,
                                     gen.key_year,
                                     gen.key_cuo,
                                     gen.sad_reg_nber,
                                     TO_CHAR (gen.sad_reg_date, 'dd/mm/yyyy')
                                         fecha_registro,
                                     TO_CHAR (gen.sad_asmt_date, 'dd/mm/yyyy')
                                         fecha_valid,
                                     DECODE (gen.sad_consignee,
                                             NULL, cns.sad_con_zip,
                                             gen.sad_consignee)
                                         nro_doc,
                                     DECODE (gen.sad_consignee,
                                             NULL, cns.sad_con_nam,
                                             cmp.cmp_nam)
                                         importador,
                                     --5
                                     gen.key_dec doc_dec,
                                     de.dec_nam nombre_dec,
                                     cty.cty_dsc origen,
                                        gen.key_year
                                     || gen.key_cuo
                                     || gen.sad_reg_nber
                                         dui,
                                     existe_tramite (gen.key_year,
                                                     gen.key_cuo,
                                                     gen.sad_reg_nber,
                                                     'DUI'),              --13
                                     verifica_alcance_dec ('DUI',
                                                           gen.key_year,
                                                           gen.key_cuo,
                                                           gen.sad_reg_nber), --14 vertifitem
                                     '-' partida,
                                     ex.sad_exp_zip || ':' || ex.sad_exp_nam
                                         proveedor,                       --15
                                     DECODE (spy1.sad_clr,
                                             0,
                                             'VERDE',
                                             1,
                                             'AZUL',
                                             2,
                                             'AMARILLO',
                                             3,
                                             'ROJO')
                                         canal,                           --16
                                     devuelve_ficha_inf (gen.sad_reg_year,
                                                         gen.key_cuo,
                                                         gen.sad_reg_nber)
                                         ficha,
                                     devuelve_fecha_levante (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.key_dec,
                                                             gen.key_nber)
                                         fecha_levante,
                                     devuelve_fecha_pase (gen.key_year,
                                                          gen.key_cuo,
                                                          gen.key_dec,
                                                          gen.key_nber)
                                         fecha_pase,
                                     gen.sad_itm_total items,
                                     gen.sad_typ_dec || gen.sad_typ_proc patron
                              FROM   ops$asy.sad_gen gen,
                                     ops$asy.sad_itm itm,
                                     ops$asy.sad_occ_cns cns,
                                     ops$asy.uncmptab cmp,
                                     ops$asy.undectab de,
                                     ops$asy.unctytab cty,
                                     ops$asy.sad_occ_exp ex,
                                     ops$asy.sad_spy spy1
                             WHERE       gen.sad_flw = 1
                                     AND gen.sad_asmt_serial IS NOT NULL
                                     AND gen.lst_ope = 'U'
                                     AND gen.sad_num = '0'
                                     AND gen.key_year = itm.key_year
                                     AND gen.key_cuo = itm.key_cuo
                                     AND gen.key_dec = itm.key_dec
                                     AND gen.key_nber = itm.key_nber
                                     AND itm.sad_num = '0'
                                     AND gen.key_dec = de.dec_cod
                                     AND gen.key_year = cns.key_year(+)
                                     AND gen.key_cuo = cns.key_cuo(+)
                                     AND gen.key_dec = cns.key_dec(+)
                                     AND gen.key_nber = cns.key_nber(+)
                                     AND gen.sad_num = cns.sad_num(+)
                                     AND cns.sad_num(+) = '0'
                                     AND gen.key_year = ex.key_year(+)
                                     AND gen.key_cuo = ex.key_cuo(+)
                                     AND gen.key_dec = ex.key_dec(+)
                                     AND gen.key_nber = ex.key_nber(+)
                                     AND gen.sad_num = ex.sad_num(+)
                                     AND ex.sad_num(+) = '0'
                                     AND gen.key_year = spy1.key_year(+)
                                     AND gen.key_cuo = spy1.key_cuo(+)
                                     AND gen.key_dec = spy1.key_dec(+)
                                     AND gen.key_nber = spy1.key_nber(+)
                                     AND spy1.spy_sta(+) = '10'
                                     AND spy1.spy_act(+) = '24'
                                     AND itm.saditm_cty_origcod = cty.cty_cod
                                     AND cty.lst_ope = 'U'
                                     AND gen.sad_consignee = cmp.cmp_cod(+)
                                     AND cmp.lst_ope(+) = 'U'
                                     AND gen.key_dec IS NOT NULL
                                     AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                      prm_fecini,
                                                                      'DD/MM/YYYY')
                                                              AND  TO_DATE (
                                                                       prm_fecfin,
                                                                       'DD/MM/YYYY')
                                     AND itm.itm_nber = 1
                            UNION
                            SELECT   DISTINCT
                                        gen.key_year
                                     || '/'
                                     || gen.key_cuo
                                     || '/'
                                     || gen.sad_reg_serial
                                     || '-'
                                     || gen.sad_reg_nber
                                         tramite,
                                     gen.key_year,
                                     gen.key_cuo,
                                     gen.sad_reg_nber,
                                     TO_CHAR (gen.sad_reg_date, 'dd/mm/yyyy')
                                         fecha_registro,
                                     TO_CHAR (gen.sad_asmt_date, 'dd/mm/yyyy')
                                         fecha_valid,
                                     DECODE (gen.sad_consignee,
                                             NULL, cns.sad_con_zip,
                                             gen.sad_consignee)
                                         nro_doc,
                                     DECODE (gen.sad_consignee,
                                             NULL, cns.sad_con_nam,
                                             cmp.cmp_nam)
                                         importador,
                                     gen.key_dec doc_dec,
                                     deo.sad_dec_nam nombre_dec,
                                     cty.cty_dsc origen,
                                        gen.key_year
                                     || gen.key_cuo
                                     || gen.sad_reg_nber
                                         dui,
                                     existe_tramite (gen.key_year,
                                                     gen.key_cuo,
                                                     gen.sad_reg_nber,
                                                     'DUI'),
                                     verifica_alcance_dec ('DUI',
                                                           gen.key_year,
                                                           gen.key_cuo,
                                                           gen.sad_reg_nber),
                                     '-' partida,
                                     ex.sad_exp_zip || ':' || ex.sad_exp_nam
                                         proveedor,
                                     DECODE (spy1.sad_clr,
                                             0,
                                             'VERDE',
                                             1,
                                             'AZUL',
                                             2,
                                             'AMARILLO',
                                             3,
                                             'ROJO')
                                         canal,                           --16
                                     devuelve_ficha_inf (gen.sad_reg_year,
                                                         gen.key_cuo,
                                                         gen.sad_reg_nber)
                                         ficha,
                                     devuelve_fecha_levante (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.key_dec,
                                                             gen.key_nber)
                                         fecha_levante,
                                     devuelve_fecha_pase (gen.key_year,
                                                          gen.key_cuo,
                                                          gen.key_dec,
                                                          gen.key_nber)
                                         fecha_pase,
                                     gen.sad_itm_total items,
                                     gen.sad_typ_dec || gen.sad_typ_proc patron
                              FROM   ops$asy.sad_gen gen,
                                     ops$asy.sad_itm itm,
                                     ops$asy.sad_occ_cns cns,
                                     ops$asy.uncmptab cmp,
                                     ops$asy.sad_occ_dec deo,
                                     ops$asy.unctytab cty,
                                     ops$asy.sad_occ_exp ex,
                                     ops$asy.sad_spy spy1
                             WHERE       gen.sad_flw = 1
                                     AND gen.sad_asmt_serial IS NOT NULL
                                     AND gen.lst_ope = 'U'
                                     AND gen.sad_num = '0'
                                     AND gen.key_year = itm.key_year
                                     AND gen.key_cuo = itm.key_cuo
                                     AND itm.key_dec IS NULL
                                     AND gen.key_nber = itm.key_nber
                                     AND itm.sad_num = '0'
                                     AND gen.key_year = deo.key_year
                                     AND gen.key_cuo = deo.key_cuo
                                     AND deo.key_dec IS NULL
                                     AND gen.key_nber = deo.key_nber
                                     AND gen.sad_num = deo.sad_num
                                     AND gen.key_year = cns.key_year(+)
                                     AND gen.key_cuo = cns.key_cuo(+)
                                     AND cns.key_dec(+) IS NULL
                                     AND gen.key_nber = cns.key_nber(+)
                                     AND gen.sad_num = cns.sad_num(+)
                                     AND cns.sad_num(+) = '0'
                                     AND gen.key_year = ex.key_year(+)
                                     AND gen.key_cuo = ex.key_cuo(+)
                                     AND ex.key_dec(+) IS NULL
                                     AND gen.key_nber = ex.key_nber(+)
                                     AND gen.sad_num = ex.sad_num(+)
                                     AND ex.sad_num(+) = '0'
                                     AND gen.key_year = spy1.key_year(+)
                                     AND gen.key_cuo = spy1.key_cuo(+)
                                     AND spy1.key_dec(+) IS NULL
                                     AND gen.key_nber = spy1.key_nber(+)
                                     AND spy1.spy_sta(+) = '10'
                                     AND spy1.spy_act(+) = '24'
                                     AND itm.saditm_cty_origcod = cty.cty_cod
                                     AND cty.lst_ope = 'U'
                                     AND gen.sad_consignee = cmp.cmp_cod(+)
                                     AND cmp.lst_ope(+) = 'U'
                                     AND gen.key_dec IS NULL
                                     AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                      prm_fecini,
                                                                      'DD/MM/YYYY')
                                                              AND  TO_DATE (
                                                                       prm_fecfin,
                                                                       'DD/MM/YYYY')
                                     AND itm.itm_nber = 1) tbl
                ORDER BY   2, 3, 4;
        ELSE
            OPEN ct FOR
                  SELECT   *
                    FROM   (SELECT   DISTINCT
                                        gen.key_year
                                     || '/'
                                     || gen.key_cuo
                                     || '/'
                                     || gen.sad_reg_serial
                                     || '-'
                                     || gen.sad_reg_nber
                                         tramite,
                                     gen.key_year,
                                     gen.key_cuo,
                                     gen.sad_reg_nber,
                                     TO_CHAR (gen.sad_reg_date, 'dd/mm/yyyy')
                                         fecha_registro,
                                     TO_CHAR (gen.sad_asmt_date, 'dd/mm/yyyy')
                                         fecha_valid,
                                     DECODE (gen.sad_consignee,
                                             NULL, cns.sad_con_zip,
                                             gen.sad_consignee)
                                         nro_doc,
                                     DECODE (gen.sad_consignee,
                                             NULL, cns.sad_con_nam,
                                             cmp.cmp_nam)
                                         importador,
                                     --5
                                     gen.key_dec doc_dec,
                                     de.dec_nam nombre_dec,
                                     cty.cty_dsc origen,
                                        gen.key_year
                                     || gen.key_cuo
                                     || gen.sad_reg_nber
                                         dui,
                                     existe_tramite (gen.key_year,
                                                     gen.key_cuo,
                                                     gen.sad_reg_nber,
                                                     'DUI'),
                                     verifica_alcance_dec ('DUI',
                                                           gen.key_year,
                                                           gen.key_cuo,
                                                           gen.sad_reg_nber),
                                     '-' partida,
                                     ex.sad_exp_zip || ':' || ex.sad_exp_nam
                                         proveedor,
                                     DECODE (spy1.sad_clr,
                                             0,
                                             'VERDE',
                                             1,
                                             'AZUL',
                                             2,
                                             'AMARILLO',
                                             3,
                                             'ROJO')
                                         canal,                           --16
                                     devuelve_ficha_inf (gen.sad_reg_year,
                                                         gen.key_cuo,
                                                         gen.sad_reg_nber)
                                         ficha,
                                     devuelve_fecha_levante (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.key_dec,
                                                             gen.key_nber)
                                         fecha_levante,
                                     devuelve_fecha_pase (gen.key_year,
                                                          gen.key_cuo,
                                                          gen.key_dec,
                                                          gen.key_nber)
                                         fecha_pase,
                                     gen.sad_itm_total items,
                                     gen.sad_typ_dec || gen.sad_typ_proc patron
                              FROM   ops$asy.sad_gen gen,
                                     ops$asy.sad_itm itm,
                                     ops$asy.sad_occ_cns cns,
                                     ops$asy.uncmptab cmp,
                                     ops$asy.undectab de,
                                     ops$asy.unctytab cty,
                                     ops$asy.sad_occ_exp ex,
                                     ops$asy.sad_spy spy1
                             WHERE       gen.sad_flw = 1
                                     AND gen.sad_asmt_serial IS NOT NULL
                                     AND gen.lst_ope = 'U'
                                     AND gen.sad_num = '0'
                                     AND gen.key_year = itm.key_year
                                     AND gen.key_cuo = itm.key_cuo
                                     AND gen.key_dec = itm.key_dec
                                     AND gen.key_nber = itm.key_nber
                                     AND itm.sad_num = '0'
                                     AND gen.key_dec = de.dec_cod
                                     AND gen.key_year = cns.key_year(+)
                                     AND gen.key_cuo = cns.key_cuo(+)
                                     AND gen.key_dec = cns.key_dec(+)
                                     AND gen.key_nber = cns.key_nber(+)
                                     AND gen.sad_num = cns.sad_num(+)
                                     AND cns.sad_num(+) = '0'
                                     AND gen.key_year = ex.key_year(+)
                                     AND gen.key_cuo = ex.key_cuo(+)
                                     AND gen.key_dec = ex.key_dec(+)
                                     AND gen.key_nber = ex.key_nber(+)
                                     AND gen.sad_num = ex.sad_num(+)
                                     AND ex.sad_num(+) = '0'
                                     AND gen.key_year = spy1.key_year(+)
                                     AND gen.key_cuo = spy1.key_cuo(+)
                                     AND gen.key_dec = spy1.key_dec(+)
                                     AND gen.key_nber = spy1.key_nber(+)
                                     AND spy1.spy_sta(+) = '10'
                                     AND spy1.spy_act(+) = '24'
                                     AND itm.saditm_cty_origcod = cty.cty_cod
                                     AND cty.lst_ope = 'U'
                                     AND gen.sad_consignee = cmp.cmp_cod(+)
                                     AND cmp.lst_ope(+) = 'U'
                                     AND gen.key_dec IS NOT NULL
                                     AND gen.key_cuo = prm_aduana
                                     AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                      prm_fecini,
                                                                      'DD/MM/YYYY')
                                                              AND  TO_DATE (
                                                                       prm_fecfin,
                                                                       'DD/MM/YYYY')
                                     AND itm.itm_nber = 1
                            UNION
                            SELECT   DISTINCT
                                        gen.key_year
                                     || '/'
                                     || gen.key_cuo
                                     || '/'
                                     || gen.sad_reg_serial
                                     || '-'
                                     || gen.sad_reg_nber
                                         tramite,
                                     gen.key_year,
                                     gen.key_cuo,
                                     gen.sad_reg_nber,
                                     TO_CHAR (gen.sad_reg_date, 'dd/mm/yyyy')
                                         fecha_registro,
                                     TO_CHAR (gen.sad_asmt_date, 'dd/mm/yyyy')
                                         fecha_valid,
                                     DECODE (gen.sad_consignee,
                                             NULL, cns.sad_con_zip,
                                             gen.sad_consignee)
                                         nro_doc,
                                     DECODE (gen.sad_consignee,
                                             NULL, cns.sad_con_nam,
                                             cmp.cmp_nam)
                                         importador,
                                     gen.key_dec doc_dec,
                                     deo.sad_dec_nam nombre_dec,
                                     cty.cty_dsc origen,
                                        gen.key_year
                                     || gen.key_cuo
                                     || gen.sad_reg_nber
                                         dui,
                                     existe_tramite (gen.key_year,
                                                     gen.key_cuo,
                                                     gen.sad_reg_nber,
                                                     'DUI'),
                                     verifica_alcance_dec ('DUI',
                                                           gen.key_year,
                                                           gen.key_cuo,
                                                           gen.sad_reg_nber),
                                     '-' partida,
                                     ex.sad_exp_zip || ':' || ex.sad_exp_nam
                                         proveedor,
                                     DECODE (spy1.sad_clr,
                                             0,
                                             'VERDE',
                                             1,
                                             'AZUL',
                                             2,
                                             'AMARILLO',
                                             3,
                                             'ROJO')
                                         canal,                           --16
                                     devuelve_ficha_inf (gen.sad_reg_year,
                                                         gen.key_cuo,
                                                         gen.sad_reg_nber)
                                         ficha,
                                     devuelve_fecha_levante (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.key_dec,
                                                             gen.key_nber)
                                         fecha_levante,
                                     devuelve_fecha_pase (gen.key_year,
                                                          gen.key_cuo,
                                                          gen.key_dec,
                                                          gen.key_nber)
                                         fecha_pase,
                                     gen.sad_itm_total items,
                                     gen.sad_typ_dec || gen.sad_typ_proc patron
                              FROM   ops$asy.sad_gen gen,
                                     ops$asy.sad_itm itm,
                                     ops$asy.sad_occ_cns cns,
                                     ops$asy.uncmptab cmp,
                                     ops$asy.sad_occ_dec deo,
                                     ops$asy.unctytab cty,
                                     ops$asy.sad_occ_exp ex,
                                     ops$asy.sad_spy spy1
                             WHERE       gen.sad_flw = 1
                                     AND gen.sad_asmt_serial IS NOT NULL
                                     AND gen.lst_ope = 'U'
                                     AND gen.sad_num = '0'
                                     AND gen.key_year = itm.key_year
                                     AND gen.key_cuo = itm.key_cuo
                                     AND itm.key_dec IS NULL
                                     AND gen.key_nber = itm.key_nber
                                     AND itm.sad_num = '0'
                                     AND gen.key_year = deo.key_year
                                     AND gen.key_cuo = deo.key_cuo
                                     AND deo.key_dec IS NULL
                                     AND gen.key_nber = deo.key_nber
                                     AND gen.sad_num = deo.sad_num
                                     AND gen.key_year = cns.key_year(+)
                                     AND gen.key_cuo = cns.key_cuo(+)
                                     AND cns.key_dec(+) IS NULL
                                     AND gen.key_nber = cns.key_nber(+)
                                     AND gen.sad_num = cns.sad_num(+)
                                     AND cns.sad_num(+) = '0'
                                     AND gen.key_year = ex.key_year(+)
                                     AND gen.key_cuo = ex.key_cuo(+)
                                     AND ex.key_dec(+) IS NULL
                                     AND gen.key_nber = ex.key_nber(+)
                                     AND gen.sad_num = ex.sad_num(+)
                                     AND ex.sad_num(+) = '0'
                                     AND gen.key_year = spy1.key_year(+)
                                     AND gen.key_cuo = spy1.key_cuo(+)
                                     AND spy1.key_dec(+) IS NULL
                                     AND gen.key_nber = spy1.key_nber(+)
                                     AND spy1.spy_sta(+) = '10'
                                     AND spy1.spy_act(+) = '24'
                                     AND itm.saditm_cty_origcod = cty.cty_cod
                                     AND cty.lst_ope = 'U'
                                     AND gen.sad_consignee = cmp.cmp_cod(+)
                                     AND cmp.lst_ope(+) = 'U'
                                     AND gen.key_dec IS NULL
                                     AND gen.key_cuo = prm_aduana
                                     AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                      prm_fecini,
                                                                      'DD/MM/YYYY')
                                                              AND  TO_DATE (
                                                                       prm_fecfin,
                                                                       'DD/MM/YYYY')
                                     AND itm.itm_nber = 1) tbl
                ORDER BY   2, 3, 4;
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION devuelve_dif_duis2 (prm_fecini       IN     VARCHAR2,
                                 prm_fecfin       IN     VARCHAR2,
                                 prm_aduana       IN     VARCHAR2,
                                 prm_importador   IN     VARCHAR2,
                                 prm_reg          IN     VARCHAR2,
                                 ct                  OUT cursortype)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (300) := 0;
    BEGIN
        IF prm_aduana = '%'
        THEN
            OPEN ct FOR
                  SELECT   *
                    FROM   (SELECT   DISTINCT
                                        gen.key_year
                                     || '/'
                                     || gen.key_cuo
                                     || '/'
                                     || gen.sad_reg_serial
                                     || '-'
                                     || gen.sad_reg_nber
                                         tramite,
                                     gen.key_year,
                                     gen.key_cuo,
                                     gen.sad_reg_nber,
                                     TO_CHAR (gen.sad_reg_date, 'dd/mm/yyyy')
                                         fecha_registro,
                                     TO_CHAR (gen.sad_asmt_date, 'dd/mm/yyyy')
                                         fecha_valid,
                                     DECODE (gen.sad_consignee,
                                             NULL, cns.sad_con_zip,
                                             gen.sad_consignee)
                                         nro_doc,
                                     DECODE (gen.sad_consignee,
                                             NULL, cns.sad_con_nam,
                                             cmp.cmp_nam)
                                         importador,
                                     --5
                                     gen.key_dec doc_dec,
                                     de.dec_nam nombre_dec,
                                     cty.cty_dsc origen,
                                        gen.key_year
                                     || gen.key_cuo
                                     || gen.sad_reg_nber
                                         dui,
                                     existe_tramite (gen.key_year,
                                                     gen.key_cuo,
                                                     gen.sad_reg_nber,
                                                     'DUI'),              --13
                                     verifica_alcance_dec ('DUI',
                                                           gen.key_year,
                                                           gen.key_cuo,
                                                           gen.sad_reg_nber), --14 vertifitem
                                     '-' partida,
                                     ex.sad_exp_zip || ':' || ex.sad_exp_nam
                                         proveedor,                       --15
                                     DECODE (spy1.sad_clr,
                                             0,
                                             'VERDE',
                                             1,
                                             'AZUL',
                                             2,
                                             'AMARILLO',
                                             3,
                                             'ROJO')
                                         canal,                           --16
                                     devuelve_ficha_inf (gen.sad_reg_year,
                                                         gen.key_cuo,
                                                         gen.sad_reg_nber)
                                         ficha,
                                     devuelve_fecha_levante (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.key_dec,
                                                             gen.key_nber)
                                         fecha_levante,
                                     devuelve_fecha_pase (gen.key_year,
                                                          gen.key_cuo,
                                                          gen.key_dec,
                                                          gen.key_nber)
                                         fecha_pase,
                                     gen.sad_itm_total items,
                                     gen.sad_typ_dec || gen.sad_typ_proc patron
                              FROM   ops$asy.sad_gen gen,
                                     ops$asy.sad_itm itm,
                                     ops$asy.sad_occ_cns cns,
                                     ops$asy.uncmptab cmp,
                                     ops$asy.undectab de,
                                     ops$asy.unctytab cty,
                                     ops$asy.sad_occ_exp ex,
                                     ops$asy.sad_spy spy1
                             WHERE       gen.sad_flw = 1
                                     AND gen.sad_asmt_serial IS NOT NULL
                                     AND gen.lst_ope = 'U'
                                     AND gen.sad_num = '0'
                                     AND gen.key_year = itm.key_year
                                     AND gen.key_cuo = itm.key_cuo
                                     AND gen.key_dec = itm.key_dec
                                     AND gen.key_nber = itm.key_nber
                                     AND itm.sad_num = '0'
                                     AND gen.key_dec = de.dec_cod
                                     AND gen.key_year = cns.key_year(+)
                                     AND gen.key_cuo = cns.key_cuo(+)
                                     AND gen.key_dec = cns.key_dec(+)
                                     AND gen.key_nber = cns.key_nber(+)
                                     AND gen.sad_num = cns.sad_num(+)
                                     AND cns.sad_num(+) = '0'
                                     AND gen.key_year = ex.key_year(+)
                                     AND gen.key_cuo = ex.key_cuo(+)
                                     AND gen.key_dec = ex.key_dec(+)
                                     AND gen.key_nber = ex.key_nber(+)
                                     AND gen.sad_num = ex.sad_num(+)
                                     AND ex.sad_num(+) = '0'
                                     AND gen.key_year = spy1.key_year(+)
                                     AND gen.key_cuo = spy1.key_cuo(+)
                                     AND gen.key_dec = spy1.key_dec(+)
                                     AND gen.key_nber = spy1.key_nber(+)
                                     AND spy1.spy_sta(+) = '10'
                                     AND spy1.spy_act(+) = '24'
                                     AND itm.saditm_cty_origcod = cty.cty_cod
                                     AND cty.lst_ope = 'U'
                                     AND gen.sad_consignee = cmp.cmp_cod(+)
                                     AND cmp.lst_ope(+) = 'U'
                                     AND gen.key_dec IS NOT NULL
                                     AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                      prm_fecini,
                                                                      'DD/MM/YYYY')
                                                              AND  TO_DATE (
                                                                       prm_fecfin,
                                                                       'DD/MM/YYYY')
                                     AND (gen.sad_consignee LIKE prm_importador
                                          OR cns.sad_con_zip LIKE
                                                '%' || prm_importador || '%')
                                     AND itm.itm_nber = 1
                            UNION
                            SELECT   DISTINCT
                                        gen.key_year
                                     || '/'
                                     || gen.key_cuo
                                     || '/'
                                     || gen.sad_reg_serial
                                     || '-'
                                     || gen.sad_reg_nber
                                         tramite,
                                     gen.key_year,
                                     gen.key_cuo,
                                     gen.sad_reg_nber,
                                     TO_CHAR (gen.sad_reg_date, 'dd/mm/yyyy')
                                         fecha_registro,
                                     TO_CHAR (gen.sad_asmt_date, 'dd/mm/yyyy')
                                         fecha_valid,
                                     DECODE (gen.sad_consignee,
                                             NULL, cns.sad_con_zip,
                                             gen.sad_consignee)
                                         nro_doc,
                                     DECODE (gen.sad_consignee,
                                             NULL, cns.sad_con_nam,
                                             cmp.cmp_nam)
                                         importador,
                                     gen.key_dec doc_dec,
                                     deo.sad_dec_nam nombre_dec,
                                     cty.cty_dsc origen,
                                        gen.key_year
                                     || gen.key_cuo
                                     || gen.sad_reg_nber
                                         dui,
                                     existe_tramite (gen.key_year,
                                                     gen.key_cuo,
                                                     gen.sad_reg_nber,
                                                     'DUI'),
                                     verifica_alcance_dec ('DUI',
                                                           gen.key_year,
                                                           gen.key_cuo,
                                                           gen.sad_reg_nber),
                                     '-' partida,
                                     ex.sad_exp_zip || ':' || ex.sad_exp_nam
                                         proveedor,
                                     DECODE (spy1.sad_clr,
                                             0,
                                             'VERDE',
                                             1,
                                             'AZUL',
                                             2,
                                             'AMARILLO',
                                             3,
                                             'ROJO')
                                         canal,                           --16
                                     devuelve_ficha_inf (gen.sad_reg_year,
                                                         gen.key_cuo,
                                                         gen.sad_reg_nber)
                                         ficha,
                                     devuelve_fecha_levante (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.key_dec,
                                                             gen.key_nber)
                                         fecha_levante,
                                     devuelve_fecha_pase (gen.key_year,
                                                          gen.key_cuo,
                                                          gen.key_dec,
                                                          gen.key_nber)
                                         fecha_pase,
                                     gen.sad_itm_total items,
                                     gen.sad_typ_dec || gen.sad_typ_proc patron
                              FROM   ops$asy.sad_gen gen,
                                     ops$asy.sad_itm itm,
                                     ops$asy.sad_occ_cns cns,
                                     ops$asy.uncmptab cmp,
                                     ops$asy.sad_occ_dec deo,
                                     ops$asy.unctytab cty,
                                     ops$asy.sad_occ_exp ex,
                                     ops$asy.sad_spy spy1
                             WHERE       gen.sad_flw = 1
                                     AND gen.sad_asmt_serial IS NOT NULL
                                     AND gen.lst_ope = 'U'
                                     AND gen.sad_num = '0'
                                     AND gen.key_year = itm.key_year
                                     AND gen.key_cuo = itm.key_cuo
                                     AND itm.key_dec IS NULL
                                     AND gen.key_nber = itm.key_nber
                                     AND itm.sad_num = '0'
                                     AND gen.key_year = deo.key_year
                                     AND gen.key_cuo = deo.key_cuo
                                     AND deo.key_dec IS NULL
                                     AND gen.key_nber = deo.key_nber
                                     AND gen.sad_num = deo.sad_num
                                     AND gen.key_year = cns.key_year(+)
                                     AND gen.key_cuo = cns.key_cuo(+)
                                     AND cns.key_dec(+) IS NULL
                                     AND gen.key_nber = cns.key_nber(+)
                                     AND gen.sad_num = cns.sad_num(+)
                                     AND cns.sad_num(+) = '0'
                                     AND gen.key_year = ex.key_year(+)
                                     AND gen.key_cuo = ex.key_cuo(+)
                                     AND ex.key_dec(+) IS NULL
                                     AND gen.key_nber = ex.key_nber(+)
                                     AND gen.sad_num = ex.sad_num(+)
                                     AND ex.sad_num(+) = '0'
                                     AND gen.key_year = spy1.key_year(+)
                                     AND gen.key_cuo = spy1.key_cuo(+)
                                     AND spy1.key_dec(+) IS NULL
                                     AND gen.key_nber = spy1.key_nber(+)
                                     AND spy1.spy_sta(+) = '10'
                                     AND spy1.spy_act(+) = '24'
                                     AND itm.saditm_cty_origcod = cty.cty_cod
                                     AND cty.lst_ope = 'U'
                                     AND gen.sad_consignee = cmp.cmp_cod(+)
                                     AND cmp.lst_ope(+) = 'U'
                                     AND gen.key_dec IS NULL
                                     AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                      prm_fecini,
                                                                      'DD/MM/YYYY')
                                                              AND  TO_DATE (
                                                                       prm_fecfin,
                                                                       'DD/MM/YYYY')
                                     AND (gen.sad_consignee LIKE prm_importador
                                          OR cns.sad_con_zip LIKE
                                                '%' || prm_importador || '%')
                                     AND itm.itm_nber = 1) tbl
                ORDER BY   2, 3, 4;
        ELSE
            OPEN ct FOR
                  SELECT   *
                    FROM   (SELECT   DISTINCT
                                        gen.key_year
                                     || '/'
                                     || gen.key_cuo
                                     || '/'
                                     || gen.sad_reg_serial
                                     || '-'
                                     || gen.sad_reg_nber
                                         tramite,
                                     gen.key_year,
                                     gen.key_cuo,
                                     gen.sad_reg_nber,
                                     TO_CHAR (gen.sad_reg_date, 'dd/mm/yyyy')
                                         fecha_registro,
                                     TO_CHAR (gen.sad_asmt_date, 'dd/mm/yyyy')
                                         fecha_valid,
                                     DECODE (gen.sad_consignee,
                                             NULL, cns.sad_con_zip,
                                             gen.sad_consignee)
                                         nro_doc,
                                     DECODE (gen.sad_consignee,
                                             NULL, cns.sad_con_nam,
                                             cmp.cmp_nam)
                                         importador,
                                     --5
                                     gen.key_dec doc_dec,
                                     de.dec_nam nombre_dec,
                                     cty.cty_dsc origen,
                                        gen.key_year
                                     || gen.key_cuo
                                     || gen.sad_reg_nber
                                         dui,
                                     existe_tramite (gen.key_year,
                                                     gen.key_cuo,
                                                     gen.sad_reg_nber,
                                                     'DUI'),
                                     verifica_alcance_dec ('DUI',
                                                           gen.key_year,
                                                           gen.key_cuo,
                                                           gen.sad_reg_nber),
                                     '-' partida,
                                     ex.sad_exp_zip || ':' || ex.sad_exp_nam
                                         proveedor,
                                     DECODE (spy1.sad_clr,
                                             0,
                                             'VERDE',
                                             1,
                                             'AZUL',
                                             2,
                                             'AMARILLO',
                                             3,
                                             'ROJO')
                                         canal,                           --16
                                     devuelve_ficha_inf (gen.sad_reg_year,
                                                         gen.key_cuo,
                                                         gen.sad_reg_nber)
                                         ficha,
                                     devuelve_fecha_levante (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.key_dec,
                                                             gen.key_nber)
                                         fecha_levante,
                                     devuelve_fecha_pase (gen.key_year,
                                                          gen.key_cuo,
                                                          gen.key_dec,
                                                          gen.key_nber)
                                         fecha_pase,
                                     gen.sad_itm_total items,
                                     gen.sad_typ_dec || gen.sad_typ_proc patron
                              FROM   ops$asy.sad_gen gen,
                                     ops$asy.sad_itm itm,
                                     ops$asy.sad_occ_cns cns,
                                     ops$asy.uncmptab cmp,
                                     ops$asy.undectab de,
                                     ops$asy.unctytab cty,
                                     ops$asy.sad_occ_exp ex,
                                     ops$asy.sad_spy spy1
                             WHERE       gen.sad_flw = 1
                                     AND gen.sad_asmt_serial IS NOT NULL
                                     AND gen.lst_ope = 'U'
                                     AND gen.sad_num = '0'
                                     AND gen.key_year = itm.key_year
                                     AND gen.key_cuo = itm.key_cuo
                                     AND gen.key_dec = itm.key_dec
                                     AND gen.key_nber = itm.key_nber
                                     AND itm.sad_num = '0'
                                     AND gen.key_dec = de.dec_cod
                                     AND gen.key_year = cns.key_year(+)
                                     AND gen.key_cuo = cns.key_cuo(+)
                                     AND gen.key_dec = cns.key_dec(+)
                                     AND gen.key_nber = cns.key_nber(+)
                                     AND gen.sad_num = cns.sad_num(+)
                                     AND cns.sad_num(+) = '0'
                                     AND gen.key_year = ex.key_year(+)
                                     AND gen.key_cuo = ex.key_cuo(+)
                                     AND gen.key_dec = ex.key_dec(+)
                                     AND gen.key_nber = ex.key_nber(+)
                                     AND gen.sad_num = ex.sad_num(+)
                                     AND ex.sad_num(+) = '0'
                                     AND gen.key_year = spy1.key_year(+)
                                     AND gen.key_cuo = spy1.key_cuo(+)
                                     AND gen.key_dec = spy1.key_dec(+)
                                     AND gen.key_nber = spy1.key_nber(+)
                                     AND spy1.spy_sta(+) = '10'
                                     AND spy1.spy_act(+) = '24'
                                     AND itm.saditm_cty_origcod = cty.cty_cod
                                     AND cty.lst_ope = 'U'
                                     AND gen.sad_consignee = cmp.cmp_cod(+)
                                     AND cmp.lst_ope(+) = 'U'
                                     AND gen.key_dec IS NOT NULL
                                     AND gen.key_cuo = prm_aduana
                                     AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                      prm_fecini,
                                                                      'DD/MM/YYYY')
                                                              AND  TO_DATE (
                                                                       prm_fecfin,
                                                                       'DD/MM/YYYY')
                                     AND (gen.sad_consignee LIKE prm_importador
                                          OR cns.sad_con_zip LIKE
                                                '%' || prm_importador || '%')
                                     AND itm.itm_nber = 1
                            UNION
                            SELECT   DISTINCT
                                        gen.key_year
                                     || '/'
                                     || gen.key_cuo
                                     || '/'
                                     || gen.sad_reg_serial
                                     || '-'
                                     || gen.sad_reg_nber
                                         tramite,
                                     gen.key_year,
                                     gen.key_cuo,
                                     gen.sad_reg_nber,
                                     TO_CHAR (gen.sad_reg_date, 'dd/mm/yyyy')
                                         fecha_registro,
                                     TO_CHAR (gen.sad_asmt_date, 'dd/mm/yyyy')
                                         fecha_valid,
                                     DECODE (gen.sad_consignee,
                                             NULL, cns.sad_con_zip,
                                             gen.sad_consignee)
                                         nro_doc,
                                     DECODE (gen.sad_consignee,
                                             NULL, cns.sad_con_nam,
                                             cmp.cmp_nam)
                                         importador,
                                     gen.key_dec doc_dec,
                                     deo.sad_dec_nam nombre_dec,
                                     cty.cty_dsc origen,
                                        gen.key_year
                                     || gen.key_cuo
                                     || gen.sad_reg_nber
                                         dui,
                                     existe_tramite (gen.key_year,
                                                     gen.key_cuo,
                                                     gen.sad_reg_nber,
                                                     'DUI'),
                                     verifica_alcance_dec ('DUI',
                                                           gen.key_year,
                                                           gen.key_cuo,
                                                           gen.sad_reg_nber),
                                     '-' partida,
                                     ex.sad_exp_zip || ':' || ex.sad_exp_nam
                                         proveedor,
                                     DECODE (spy1.sad_clr,
                                             0,
                                             'VERDE',
                                             1,
                                             'AZUL',
                                             2,
                                             'AMARILLO',
                                             3,
                                             'ROJO')
                                         canal,                           --16
                                     devuelve_ficha_inf (gen.sad_reg_year,
                                                         gen.key_cuo,
                                                         gen.sad_reg_nber)
                                         ficha,
                                     devuelve_fecha_levante (gen.key_year,
                                                             gen.key_cuo,
                                                             gen.key_dec,
                                                             gen.key_nber)
                                         fecha_levante,
                                     devuelve_fecha_pase (gen.key_year,
                                                          gen.key_cuo,
                                                          gen.key_dec,
                                                          gen.key_nber)
                                         fecha_pase,
                                     gen.sad_itm_total items,
                                     gen.sad_typ_dec || gen.sad_typ_proc patron
                              FROM   ops$asy.sad_gen gen,
                                     ops$asy.sad_itm itm,
                                     ops$asy.sad_occ_cns cns,
                                     ops$asy.uncmptab cmp,
                                     ops$asy.sad_occ_dec deo,
                                     ops$asy.unctytab cty,
                                     ops$asy.sad_occ_exp ex,
                                     ops$asy.sad_spy spy1
                             WHERE       gen.sad_flw = 1
                                     AND gen.sad_asmt_serial IS NOT NULL
                                     AND gen.lst_ope = 'U'
                                     AND gen.sad_num = '0'
                                     AND gen.key_year = itm.key_year
                                     AND gen.key_cuo = itm.key_cuo
                                     AND itm.key_dec IS NULL
                                     AND gen.key_nber = itm.key_nber
                                     AND itm.sad_num = '0'
                                     AND gen.key_year = deo.key_year
                                     AND gen.key_cuo = deo.key_cuo
                                     AND deo.key_dec IS NULL
                                     AND gen.key_nber = deo.key_nber
                                     AND gen.sad_num = deo.sad_num
                                     AND gen.key_year = cns.key_year(+)
                                     AND gen.key_cuo = cns.key_cuo(+)
                                     AND cns.key_dec(+) IS NULL
                                     AND gen.key_nber = cns.key_nber(+)
                                     AND gen.sad_num = cns.sad_num(+)
                                     AND cns.sad_num(+) = '0'
                                     AND gen.key_year = ex.key_year(+)
                                     AND gen.key_cuo = ex.key_cuo(+)
                                     AND ex.key_dec(+) IS NULL
                                     AND gen.key_nber = ex.key_nber(+)
                                     AND gen.sad_num = ex.sad_num(+)
                                     AND ex.sad_num(+) = '0'
                                     AND gen.key_year = spy1.key_year(+)
                                     AND gen.key_cuo = spy1.key_cuo(+)
                                     AND spy1.key_dec(+) IS NULL
                                     AND gen.key_nber = spy1.key_nber(+)
                                     AND spy1.spy_sta(+) = '10'
                                     AND spy1.spy_act(+) = '24'
                                     AND itm.saditm_cty_origcod = cty.cty_cod
                                     AND cty.lst_ope = 'U'
                                     AND gen.sad_consignee = cmp.cmp_cod(+)
                                     AND cmp.lst_ope(+) = 'U'
                                     AND gen.key_dec IS NULL
                                     AND gen.key_cuo = prm_aduana
                                     AND gen.sad_reg_date BETWEEN TO_DATE (
                                                                      prm_fecini,
                                                                      'DD/MM/YYYY')
                                                              AND  TO_DATE (
                                                                       prm_fecfin,
                                                                       'DD/MM/YYYY')
                                     AND (gen.sad_consignee LIKE prm_importador
                                          OR cns.sad_con_zip LIKE
                                                '%' || prm_importador || '%')
                                     AND itm.itm_nber = 1) tbl
                ORDER BY   2, 3, 4;
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION devuelve_dif_duis3 (prm_gestion   IN     VARCHAR2,
                                 prm_aduana    IN     VARCHAR2,
                                 prm_numero    IN     VARCHAR2,
                                 prm_reg       IN     VARCHAR2,
                                 ct               OUT cursortype)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (300) := 0;
    BEGIN
        OPEN ct FOR
              SELECT   *
                FROM   (SELECT   DISTINCT
                                    gen.key_year
                                 || '/'
                                 || gen.key_cuo
                                 || '/'
                                 || gen.sad_reg_serial
                                 || '-'
                                 || gen.sad_reg_nber
                                     tramite,
                                 gen.key_year,
                                 gen.key_cuo,
                                 gen.sad_reg_nber,
                                 TO_CHAR (gen.sad_reg_date, 'dd/mm/yyyy')
                                     fecha_registro,
                                 TO_CHAR (gen.sad_asmt_date, 'dd/mm/yyyy')
                                     fecha_valid,
                                 DECODE (gen.sad_consignee,
                                         NULL, cns.sad_con_zip,
                                         gen.sad_consignee)
                                     nro_doc,
                                 DECODE (gen.sad_consignee,
                                         NULL, cns.sad_con_nam,
                                         cmp.cmp_nam)
                                     importador,
                                 --5
                                 gen.key_dec doc_dec,
                                 de.dec_nam nombre_dec,
                                 cty.cty_dsc origen,
                                    gen.key_year
                                 || gen.key_cuo
                                 || gen.sad_reg_nber
                                     dui,
                                 existe_tramite (gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber,
                                                 'DUI'),                  --13
                                 verifica_alcance_dec ('DUI',
                                                       gen.key_year,
                                                       gen.key_cuo,
                                                       gen.sad_reg_nber), --14 vertifitem
                                 '-' partida,
                                 ex.sad_exp_zip || ':' || ex.sad_exp_nam
                                     proveedor,                           --15
                                 DECODE (spy1.sad_clr,
                                         0,
                                         'VERDE',
                                         1,
                                         'AZUL',
                                         2,
                                         'AMARILLO',
                                         3,
                                         'ROJO')
                                     canal,                               --16
                                 devuelve_ficha_inf (gen.sad_reg_year,
                                                     gen.key_cuo,
                                                     gen.sad_reg_nber)
                                     ficha,
                                 devuelve_fecha_levante (gen.key_year,
                                                         gen.key_cuo,
                                                         gen.key_dec,
                                                         gen.key_nber)
                                     fecha_levante,
                                 devuelve_fecha_pase (gen.key_year,
                                                      gen.key_cuo,
                                                      gen.key_dec,
                                                      gen.key_nber)
                                     fecha_pase,
                                 gen.sad_itm_total items,
                                 gen.sad_typ_dec || gen.sad_typ_proc patron
                          FROM   ops$asy.sad_gen gen,
                                 ops$asy.sad_itm itm,
                                 ops$asy.sad_occ_cns cns,
                                 ops$asy.uncmptab cmp,
                                 ops$asy.undectab de,
                                 ops$asy.unctytab cty,
                                 ops$asy.sad_occ_exp ex,
                                 ops$asy.sad_spy spy1
                         WHERE       gen.sad_flw = 1
                                 AND gen.sad_asmt_serial IS NOT NULL
                                 AND gen.lst_ope = 'U'
                                 AND gen.sad_num = '0'
                                 AND gen.key_year = itm.key_year
                                 AND gen.key_cuo = itm.key_cuo
                                 AND gen.key_dec = itm.key_dec
                                 AND gen.key_nber = itm.key_nber
                                 AND itm.sad_num = '0'
                                 AND gen.key_dec = de.dec_cod
                                 AND gen.key_year = cns.key_year(+)
                                 AND gen.key_cuo = cns.key_cuo(+)
                                 AND gen.key_dec = cns.key_dec(+)
                                 AND gen.key_nber = cns.key_nber(+)
                                 AND gen.sad_num = cns.sad_num(+)
                                 AND cns.sad_num(+) = '0'
                                 AND gen.key_year = ex.key_year(+)
                                 AND gen.key_cuo = ex.key_cuo(+)
                                 AND gen.key_dec = ex.key_dec(+)
                                 AND gen.key_nber = ex.key_nber(+)
                                 AND gen.sad_num = ex.sad_num(+)
                                 AND ex.sad_num(+) = '0'
                                 AND gen.key_year = spy1.key_year(+)
                                 AND gen.key_cuo = spy1.key_cuo(+)
                                 AND gen.key_dec = spy1.key_dec(+)
                                 AND gen.key_nber = spy1.key_nber(+)
                                 AND spy1.spy_sta(+) = '10'
                                 AND spy1.spy_act(+) = '24'
                                 AND itm.saditm_cty_origcod = cty.cty_cod
                                 AND cty.lst_ope = 'U'
                                 AND gen.sad_consignee = cmp.cmp_cod(+)
                                 AND cmp.lst_ope(+) = 'U'
                                 AND gen.key_dec IS NOT NULL
                                 AND gen.sad_reg_year = prm_gestion
                                 AND gen.key_cuo = prm_aduana
                                 AND gen.sad_reg_serial = 'C'
                                 AND gen.sad_reg_nber = prm_numero
                                 AND itm.itm_nber = 1
                        UNION
                        SELECT   DISTINCT
                                    gen.key_year
                                 || '/'
                                 || gen.key_cuo
                                 || '/'
                                 || gen.sad_reg_serial
                                 || '-'
                                 || gen.sad_reg_nber
                                     tramite,
                                 gen.key_year,
                                 gen.key_cuo,
                                 gen.sad_reg_nber,
                                 TO_CHAR (gen.sad_reg_date, 'dd/mm/yyyy')
                                     fecha_registro,
                                 TO_CHAR (gen.sad_asmt_date, 'dd/mm/yyyy')
                                     fecha_valid,
                                 DECODE (gen.sad_consignee,
                                         NULL, cns.sad_con_zip,
                                         gen.sad_consignee)
                                     nro_doc,
                                 DECODE (gen.sad_consignee,
                                         NULL, cns.sad_con_nam,
                                         cmp.cmp_nam)
                                     importador,
                                 gen.key_dec doc_dec,
                                 deo.sad_dec_nam nombre_dec,
                                 cty.cty_dsc origen,
                                    gen.key_year
                                 || gen.key_cuo
                                 || gen.sad_reg_nber
                                     dui,
                                 existe_tramite (gen.key_year,
                                                 gen.key_cuo,
                                                 gen.sad_reg_nber,
                                                 'DUI'),
                                 verifica_alcance_dec ('DUI',
                                                       gen.key_year,
                                                       gen.key_cuo,
                                                       gen.sad_reg_nber),
                                 '-' partida,
                                 ex.sad_exp_zip || ':' || ex.sad_exp_nam
                                     proveedor,
                                 DECODE (spy1.sad_clr,
                                         0,
                                         'VERDE',
                                         1,
                                         'AZUL',
                                         2,
                                         'AMARILLO',
                                         3,
                                         'ROJO')
                                     canal,                               --16
                                 devuelve_ficha_inf (gen.sad_reg_year,
                                                     gen.key_cuo,
                                                     gen.sad_reg_nber)
                                     ficha,
                                 devuelve_fecha_levante (gen.key_year,
                                                         gen.key_cuo,
                                                         gen.key_dec,
                                                         gen.key_nber)
                                     fecha_levante,
                                 devuelve_fecha_pase (gen.key_year,
                                                      gen.key_cuo,
                                                      gen.key_dec,
                                                      gen.key_nber)
                                     fecha_pase,
                                 gen.sad_itm_total items,
                                 gen.sad_typ_dec || gen.sad_typ_proc patron
                          FROM   ops$asy.sad_gen gen,
                                 ops$asy.sad_itm itm,
                                 ops$asy.sad_occ_cns cns,
                                 ops$asy.uncmptab cmp,
                                 ops$asy.sad_occ_dec deo,
                                 ops$asy.unctytab cty,
                                 ops$asy.sad_occ_exp ex,
                                 ops$asy.sad_spy spy1
                         WHERE       gen.sad_flw = 1
                                 AND gen.sad_asmt_serial IS NOT NULL
                                 AND gen.lst_ope = 'U'
                                 AND gen.sad_num = '0'
                                 AND gen.key_year = itm.key_year
                                 AND gen.key_cuo = itm.key_cuo
                                 AND itm.key_dec IS NULL
                                 AND gen.key_nber = itm.key_nber
                                 AND itm.sad_num = '0'
                                 AND gen.key_year = deo.key_year
                                 AND gen.key_cuo = deo.key_cuo
                                 AND deo.key_dec IS NULL
                                 AND gen.key_nber = deo.key_nber
                                 AND gen.sad_num = deo.sad_num
                                 AND gen.key_year = cns.key_year(+)
                                 AND gen.key_cuo = cns.key_cuo(+)
                                 AND cns.key_dec(+) IS NULL
                                 AND gen.key_nber = cns.key_nber(+)
                                 AND gen.sad_num = cns.sad_num(+)
                                 AND cns.sad_num(+) = '0'
                                 AND gen.key_year = ex.key_year(+)
                                 AND gen.key_cuo = ex.key_cuo(+)
                                 AND ex.key_dec(+) IS NULL
                                 AND gen.key_nber = ex.key_nber(+)
                                 AND gen.sad_num = ex.sad_num(+)
                                 AND ex.sad_num(+) = '0'
                                 AND gen.key_year = spy1.key_year(+)
                                 AND gen.key_cuo = spy1.key_cuo(+)
                                 AND spy1.key_dec(+) IS NULL
                                 AND gen.key_nber = spy1.key_nber(+)
                                 AND spy1.spy_sta(+) = '10'
                                 AND spy1.spy_act(+) = '24'
                                 AND itm.saditm_cty_origcod = cty.cty_cod
                                 AND cty.lst_ope = 'U'
                                 AND gen.sad_consignee = cmp.cmp_cod(+)
                                 AND cmp.lst_ope(+) = 'U'
                                 AND gen.key_dec IS NULL
                                 AND gen.sad_reg_year = prm_gestion
                                 AND gen.key_cuo = prm_aduana
                                 AND gen.sad_reg_serial = 'C'
                                 AND gen.sad_reg_nber = prm_numero
                                 AND itm.itm_nber = 1) tbl
            ORDER BY   2, 3, 4;


        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION devuelve_ficha_inf (prm_gestion   IN VARCHAR2,
                                 prm_aduana    IN VARCHAR2,
                                 prm_numero    IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res    VARCHAR2 (50);
        cont   NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   cont
          FROM   mira.mir_control b, mira.mir_diligencia1 f
         WHERE       b.con_key_year = SUBSTR (f.id, 1, 4)
                 AND b.con_key_cuo = SUBSTR (f.id, 5, 3)
                 AND b.con_reg_nber = SUBSTR (f.id, 8, INSTR (f.id, '-') - 8)
                 AND b.con_fuente = SUBSTR (f.id, INSTR (f.id, '-') + 1)
                 AND f.dil1_num = 0
                 AND b.con_num = 0
                 AND b.con_lst_ope = 'U'
                 AND con_key_year = prm_gestion
                 AND con_key_cuo = prm_aduana
                 AND con_reg_nber = prm_numero
                 AND ROWNUM = 1;

        IF cont > 0
        THEN
            SELECT   f.id
              INTO   res
              FROM   mira.mir_control b, mira.mir_diligencia1 f
             WHERE   b.con_key_year = SUBSTR (f.id, 1, 4)
                     AND b.con_key_cuo = SUBSTR (f.id, 5, 3)
                     AND b.con_reg_nber =
                            SUBSTR (f.id, 8, INSTR (f.id, '-') - 8)
                     AND b.con_fuente = SUBSTR (f.id, INSTR (f.id, '-') + 1)
                     AND f.dil1_num = 0
                     AND b.con_num = 0
                     AND b.con_lst_ope = 'U'
                     AND con_key_year = prm_gestion
                     AND con_key_cuo = prm_aduana
                     AND con_reg_nber = prm_numero
                     AND ROWNUM = 1;
        ELSE
            res := '-';
        END IF;

        RETURN res;
    END;

    FUNCTION devuelve_fecha_levante (prm_key_year   IN VARCHAR2,
                                     prm_key_cuo    IN VARCHAR2,
                                     prm_key_dec    IN VARCHAR2,
                                     prm_key_nber   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res    VARCHAR2 (50) := '';
        cont   NUMBER (8) := 0;
    BEGIN
        SELECT   TO_CHAR (n.upd_dat, 'dd/mm/yyyy') || ' ' || n.upd_hor
                     AS fecha_levante
          INTO   res
          FROM   ops$asy.sad_spy n
         WHERE       n.key_year = prm_key_year
                 AND n.key_cuo = prm_key_cuo
                 AND NVL (n.key_dec, '-') = NVL (prm_key_dec, '-')
                 AND n.key_nber = prm_key_nber
                 AND ( (n.spy_sta = '6' AND n.spy_act = '9' AND n.sad_clr = 0)
                      OR (n.spy_sta = '10' AND n.spy_act = '24'));

        IF res = ''
        THEN
            res := '-';
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN '-';
    END devuelve_fecha_levante;


    FUNCTION devuelve_fecha_pase (prm_key_year   IN VARCHAR2,
                                  prm_key_cuo    IN VARCHAR2,
                                  prm_key_dec    IN VARCHAR2,
                                  prm_key_nber   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res    VARCHAR2 (50) := '';
        cont   NUMBER (8) := 0;
    BEGIN
        SELECT   TO_CHAR (n.upd_dat, 'dd/mm/yyyy') || ' ' || n.upd_hor
                     AS fecha_levante
          INTO   res
          FROM   ops$asy.sad_spy n
         WHERE       n.key_year = prm_key_year
                 AND n.key_cuo = prm_key_cuo
                 AND NVL (n.key_dec, '-') = NVL (prm_key_dec, '-')
                 AND n.key_nber = prm_key_nber
                 AND n.spy_sta = '10'
                 AND n.spy_act = '25';

        IF res = ''
        THEN
            res := '-';
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN '-';
    END devuelve_fecha_pase;

    FUNCTION devuelve_items (prm_gestion   IN VARCHAR2,
                             prm_aduana    IN VARCHAR2,
                             prm_numero    IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res    VARCHAR2 (50);
        cont   NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   cont
          FROM   mira.mir_control b, mira.mir_diligencia1 f
         WHERE       b.con_key_year = SUBSTR (f.id, 1, 4)
                 AND b.con_key_cuo = SUBSTR (f.id, 5, 3)
                 AND b.con_reg_nber = SUBSTR (f.id, 8, INSTR (f.id, '-') - 8)
                 AND b.con_fuente = SUBSTR (f.id, INSTR (f.id, '-') + 1)
                 AND f.dil1_num = 0
                 AND b.con_num = 0
                 AND b.con_lst_ope = 'U'
                 AND con_key_year = prm_gestion
                 AND con_key_cuo = prm_aduana
                 AND con_reg_nber = prm_numero
                 AND ROWNUM = 1;

        RETURN res;
    END;

    FUNCTION devuelve_datos_importador (prm_importador   IN     VARCHAR2,
                                        prm_razon           OUT VARCHAR2,
                                        prm_direccion       OUT VARCHAR2,
                                        prm_actividad       OUT VARCHAR2,
                                        prm_tipo            OUT VARCHAR2,
                                        prm_nombre          OUT VARCHAR2,
                                        prm_appat           OUT VARCHAR2,
                                        prm_apmat           OUT VARCHAR2)
        RETURN VARCHAR2
    IS
        res      VARCHAR2 (50) := 'OK';
        cont     NUMBER;
        existe   NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   ops$asy.bo_oce_opecab a
         WHERE       a.ope_numerodoc = prm_importador
                 AND ope_num = 0
                 AND ROWNUM = 1;

        IF (existe > 0)
        THEN
            SELECT   a.ope_razonsocial,
                        a.ope_direccion
                     || ', N'
                     || CHR (186)
                     || ' '
                     || a.ope_nrodireccion
                     || ', ZONA '
                     || a.ope_zona
                     || ', '
                     || a.ope_ciudad,
                     UPPER (
                         pkg_general.fn_devuelve_actividad (a.ope_numerodoc)),
                     a.ope_tipodoc,
                     a.ope_nombre,
                     a.ope_paterno,
                     a.ope_materno
              INTO   prm_razon,
                     prm_direccion,
                     prm_actividad,
                     prm_tipo,
                     prm_nombre,
                     prm_appat,
                     prm_apmat
              FROM   ops$asy.bo_oce_opecab a
             WHERE       a.ope_numerodoc = prm_importador
                     AND ope_num = 0
                     AND ROWNUM = 1;
        END IF;

        RETURN res;
    END;

    FUNCTION graba_recibo (prm_id         VARCHAR2,
                           prm_gestion    VARCHAR2,
                           prm_aduana     VARCHAR2,
                           prm_numero     VARCHAR2,
                           prm_tipo       VARCHAR2,
                           prm_fecha      VARCHAR2,
                           prm_importe    VARCHAR2,
                           prm_usuario    VARCHAR2)
        RETURN VARCHAR2
    IS
        res                    VARCHAR2 (300) := 0;
        v_gestion              VARCHAR2 (4);
        v_numero               NUMBER;
        val                    VARCHAR2 (100);
        cad                    VARCHAR2 (30000);
        v_key_year             VARCHAR2 (4);
        v_key_cou              VARCHAR2 (3);
        v_reg_nber             VARCHAR2 (10);
        v_item                 VARCHAR2 (10);
        v_codigo               NUMBER (18, 0);
        existe                 NUMBER;
        error_dui              VARCHAR2 (30000) := '';
        total                  NUMBER := 0;
        grabadas               NUMBER := 0;
        v_fecha_recibo         DATE;
        v_fecha_notificacion   DATE;
        v_val_recibo           NUMBER (18);
        v_val_registro         NUMBER (18);
    BEGIN
        IF TO_DATE (prm_fecha, 'dd/mm/yyyy') > TRUNC (SYSDATE)
        THEN
            RETURN 'La fecha no puede ser mayor a la actual';
        ELSE
            IF prm_gestion > TO_CHAR (SYSDATE, 'YYYY')
            THEN
                RETURN 'La Gesti&oacute;n no puede ser mayor a la actual, y debe ser una gesti&oacute;n valida';
            END IF;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_recibos
             WHERE       rec_gestion = prm_gestion
                     AND rec_aduana = prm_aduana
                     AND rec_numero = prm_numero
                     AND rec_tipo = prm_tipo
                     AND rec_num = 0
                     AND rec_lstope = 'U';

            IF existe = 0
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   ops$asy.bo_sad_payment a
                 WHERE       TO_CHAR (a.sad_rcpt_date, 'yyyy') = prm_gestion
                         AND a.key_cuo = prm_aduana
                         AND a.sad_rcpt_nber = prm_numero;

                IF existe = 0
                THEN
                    RETURN 'EL recibo no existe';
                ELSE
                    SELECT   sad_rcpt_date
                      INTO   v_fecha_recibo
                      FROM   ops$asy.bo_sad_payment a
                     WHERE   TO_CHAR (a.sad_rcpt_date, 'yyyy') = prm_gestion
                             AND a.key_cuo = prm_aduana
                             AND a.sad_rcpt_nber = prm_numero
                             AND ROWNUM = 1;

                    SELECT   a.not_fecha_notificacion
                      INTO   v_fecha_notificacion
                      FROM   fis_notificacion a
                     WHERE       a.ctl_control_id = prm_id
                             AND a.not_num = 0
                             AND a.not_lstope = 'U';

                    IF v_fecha_recibo < v_fecha_notificacion
                    THEN
                        RETURN 'EL recibo no puede ser registrado, porque la fecha de pago no puede ser inferior a la fecha de notificaci&oacute;n';
                    ELSE
                        SELECT   NVL (SUM (rec_importe), 0) + prm_importe
                          INTO   v_val_registro
                          FROM   fis_recibos a
                         WHERE       rec_gestion = prm_gestion
                                 AND rec_aduana = prm_aduana
                                 AND rec_numero = prm_numero
                                 AND rec_lstope = 'U'
                                 AND rec_num = 0;

                        SELECT   SUM (a.sad_pco_amount)
                          INTO   v_val_recibo
                          FROM   ops$asy.bo_sad_payment a
                         WHERE   sad_rcpt_nber = prm_numero
                                 AND TO_CHAR (sad_rcpt_date, 'yyyy') =
                                        prm_gestion
                                 AND key_cuo = prm_aduana;

                        IF v_val_registro > v_val_recibo
                        THEN
                            RETURN 'La suma de los montos registrados es mayor al valor del recibo';
                        ELSE

                        IF prm_importe <= 0
                        THEN
                            RETURN 'El importe debe ser mayor a 0';
                        ELSE
                            v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                            v_numero := numero_control_rec (v_gestion);

                            INSERT INTO fis_recibos (rec_recibos_id,
                                                     rec_gestion,
                                                     rec_aduana,
                                                     rec_numero,
                                                     rec_tipo,
                                                     rec_fecha,
                                                     rec_importe,
                                                     rec_num,
                                                     rec_lstope,
                                                     rec_usuario,
                                                     rec_fecsys,
                                                     ctl_control_id)
                              VALUES   (v_gestion || TO_CHAR (v_numero),
                                        prm_gestion,
                                        prm_aduana,
                                        prm_numero,
                                        prm_tipo,
                                        TO_DATE (prm_fecha, 'dd/mm/yyyy'),
                                        prm_importe,
                                        0,
                                        'U',
                                        prm_usuario,
                                        SYSDATE,
                                        prm_id);

                            COMMIT;
                            res :=
                                'CORRECTOSe grab&oacute; correctamente el recibo';
                                 END IF;
                        END IF;
                    END IF;
                END IF;
            ELSE
                res :=
                    'Ya se encuentra registrado el recibo con el mismo tipo de pago';
            END IF;

            RETURN res;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION devuelve_recibos (prm_codigocontrol   IN     VARCHAR2,
                               ct                     OUT cursortype)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_codigo        VARCHAR2 (20);
        v_tipocontrol   VARCHAR2 (30);
    BEGIN
        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigocontrol
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'DIFERIDO' OR v_tipocontrol = 'POSTERIOR'
        THEN
            OPEN ct FOR
                  SELECT   a.rec_recibos_id,
                           a.rec_gestion,
                           a.rec_aduana,
                           a.rec_numero,
                           a.rec_tipo,
                           TO_CHAR (a.rec_fecha, 'dd/mm/yyyy'),
                           a.rec_importe,
                           a.rec_num,
                           a.rec_lstope,
                           a.rec_usuario,
                           a.rec_fecsys,
                           a.ctl_control_id
                    FROM   fis_recibos a
                   WHERE       a.rec_num = 0
                           AND a.rec_lstope = 'U'
                           AND a.ctl_control_id = prm_codigocontrol
                ORDER BY   2,
                           3,
                           4,
                           5;

            RETURN 'CORRECTO';
        ELSE
            RETURN 'No se puede registrar recibos de una Fiscalizaci&oacute;n Ampliatoria';
        END IF;
    END;

    FUNCTION borra_recibo (prm_id VARCHAR2, prm_usuario VARCHAR2)
        RETURN VARCHAR2
    IS
        res      VARCHAR2 (300) := 0;
        existe   NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_recibos b
         WHERE       b.rec_recibos_id = prm_id
                 AND b.rec_num = 0
                 AND b.rec_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'EL RECIBO NO EXISTE';
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_recibos b
             WHERE   b.rec_recibos_id = prm_id;

            UPDATE   fis_recibos b
               SET   b.rec_num = existe
             WHERE   b.rec_recibos_id = prm_id AND b.rec_num = 0;

            INSERT INTO fis_recibos
                SELECT   a.rec_recibos_id,
                         a.rec_gestion,
                         a.rec_aduana,
                         a.rec_numero,
                         a.rec_tipo,
                         a.rec_fecha,
                         a.rec_importe,
                         0,
                         'D',
                         prm_usuario,
                         SYSDATE,
                         a.ctl_control_id
                  FROM   fis_recibos a
                 WHERE       a.rec_recibos_id = prm_id
                         AND a.rec_num = existe
                         AND ROWNUM = 1;

            COMMIT;
            RETURN 'CORRECTOEl recibo se borr&oacute; correctamente';
        END IF;
    END;
END;
/


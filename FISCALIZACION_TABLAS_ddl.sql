CREATE TABLE app_ser
    (app_gestion                    VARCHAR2(4 BYTE),
    app_tipo                       VARCHAR2(15 BYTE),
    app_gerencia                   VARCHAR2(5 BYTE),
    app_numero                     NUMBER)
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE UNIQUE INDEX app_ser_idx ON app_ser
  (
    app_gestion                     ASC,
    app_tipo                        ASC,
    app_gerencia                    ASC
  )
NOPARALLEL
LOGGING
/


CREATE TABLE ciudad_dep
    (dep_id                         VARCHAR2(10 BYTE),
    dep_des                        VARCHAR2(50 BYTE),
    ciu_id                         NUMBER(10,0),
    ciu_des                        VARCHAR2(50 BYTE),
    lst_ope                        VARCHAR2(1 BYTE))
  NOPARALLEL
  LOGGING
/

CREATE TABLE fis_acceso
    (fis_acceso_id                  NUMBER(18,0) NOT NULL,
    fis_codigo_fiscalizador        VARCHAR2(30 BYTE),
    fis_cargo                      VARCHAR2(50 BYTE),
    fis_num                        NUMBER(10,0),
    fis_lstope                     VARCHAR2(1 BYTE),
    fis_usuario                    VARCHAR2(30 BYTE),
    fis_fecsys                     DATE,
    ctl_control_id                 NUMBER(18,0))
  NOPARALLEL
  LOGGING
/

CREATE TABLE fis_alcance
    (alc_alcance_id                 NUMBER(18,0),
    alc_tipo_alcance               VARCHAR2(30 BYTE) NOT NULL,
    alc_tipo_tramite               VARCHAR2(30 BYTE) NOT NULL,
    alc_gestion                    VARCHAR2(4 BYTE) NOT NULL,
    alc_aduana                     VARCHAR2(3 BYTE),
    alc_numero                     NUMBER(20,0) NOT NULL,
    alc_fecha                      DATE,
    alc_proveedor                  VARCHAR2(50 BYTE),
    alc_pais                       VARCHAR2(10 BYTE),
    alc_tipo_documento             VARCHAR2(30 BYTE),
    alc_num                        NUMBER(10,0),
    alc_lstope                     VARCHAR2(1 BYTE) NOT NULL,
    alc_usuario                    VARCHAR2(30 BYTE),
    alc_fecsys                     DATE,
    ctl_control_id                 NUMBER(18,0),
    alc_tipo_etapa                 VARCHAR2(30 BYTE))
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE INDEX fis_alcance_idxn ON fis_alcance
  (
    ctl_control_id                  ASC,
    alc_alcance_id                  ASC,
    alc_num                         ASC,
    alc_lstope                      ASC
  )
NOPARALLEL
LOGGING
/

CREATE UNIQUE INDEX fis_alcance_idx ON fis_alcance
  (
    ctl_control_id                  ASC,
    alc_tipo_tramite                ASC,
    alc_gestion                     ASC,
    alc_aduana                      ASC,
    alc_numero                      ASC,
    alc_num                         ASC,
    alc_lstope                      ASC,
    alc_alcance_id                  ASC
  )
NOPARALLEL
LOGGING
/


ALTER TABLE fis_alcance
ADD CONSTRAINT fis_alcance_pk UNIQUE (alc_alcance_id, alc_tipo_alcance, 
  alc_tipo_tramite, alc_gestion, alc_num, ctl_control_id)
USING INDEX
/

CREATE TABLE fis_alcance_amp
    (amp_alcanceamp_id              NUMBER(18,0) NOT NULL,
    alc_alcance_id                 NUMBER(18,0) NOT NULL,
    ctl_control_id                 NUMBER(18,0),
    amp_num                        NUMBER(10,0),
    amp_lstope                     VARCHAR2(1 BYTE) NOT NULL,
    amp_usuario                    VARCHAR2(30 BYTE),
    amp_fecsys                     DATE,
    amp_tipo_etapa                 VARCHAR2(30 BYTE))
  NOPARALLEL
  LOGGING
/

CREATE UNIQUE INDEX fis_alcance_amp_idx ON fis_alcance_amp
  (
    amp_alcanceamp_id               ASC,
    ctl_control_id                  ASC,
    alc_alcance_id                  ASC,
    amp_num                         ASC
  )
NOPARALLEL
LOGGING
/


CREATE TABLE fis_alcance_item
    (alc_alcance_id                 NUMBER(18,0) NOT NULL,
    ali_numero_item                NUMBER(10,0) NOT NULL,
    ali_obs_valor                  VARCHAR2(5 BYTE),
    ali_obs_partida                VARCHAR2(5 BYTE),
    ali_obs_origen                 VARCHAR2(5 BYTE),
    ali_num                        NUMBER(10,0) ,
    ali_lstope                     VARCHAR2(1 BYTE) NOT NULL,
    ali_usuario                    VARCHAR2(30 BYTE),
    ali_fecsys                     DATE,
    ali_obs_otro                   VARCHAR2(5 BYTE),
    ali_tipo_etapa                 VARCHAR2(30 BYTE))
  NOPARALLEL
  LOGGING
  MONITORING
/

ALTER TABLE fis_alcance_item
ADD CONSTRAINT fis_alcance_item_pk PRIMARY KEY (alc_alcance_id, ali_numero_item, 
  ali_num)
USING INDEX
/

CREATE TABLE fis_anulacion
    (ctl_control_id                 NUMBER(18,0),
    anu_justificacion              VARCHAR2(300 BYTE),
    anu_num                        NUMBER(10,0),
    anu_lstope                     VARCHAR2(1 BYTE),
    anu_usuario                    VARCHAR2(30 BYTE),
    anu_fecsys                     DATE)
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE TABLE fis_con_actainter
    (ctl_control_id                 NUMBER(18,0) NOT NULL,
    cai_acta_interv                VARCHAR2(30 BYTE),
    cai_fecha_acta_interv          DATE,
    cai_tipo_ilicito               VARCHAR2(30 BYTE),
    cai_ci_remision                VARCHAR2(30 BYTE),
    cai_fecha_ci_remision          DATE,
    cai_fecha_pres_descargos       DATE,
    cai_inf_descargo               VARCHAR2(30 BYTE),
    cai_fecha_inf_descargo         DATE,
    cai_numero_rfs                 VARCHAR2(30 BYTE),
    cai_fecha_rfs                  DATE,
    cai_numero_rs                  VARCHAR2(30 BYTE),
    cai_fecha_rs                   DATE,
    cai_num                        NUMBER(10,0),
    cai_lstope                     VARCHAR2(1 BYTE),
    cai_usuario                    VARCHAR2(30 BYTE),
    cai_fecsys                     DATE,
    cai_numero_informe             VARCHAR2(30 BYTE),
    cai_fecha_informe              DATE,
    cai_gerencia_legal             VARCHAR2(50 BYTE),
    cai_fecha_not_ai               DATE,
    cai_tipo_not_ai                VARCHAR2(50 BYTE),
    cai_resultado_des              VARCHAR2(50 BYTE),
    cai_tipo_resolucion            VARCHAR2(50 BYTE))
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE TABLE fis_con_autoinicial
    (ctl_control_id                 NUMBER(18,0) NOT NULL,
    cas_numero_aisc                VARCHAR2(30 BYTE),
    cas_fecha_notificacion         DATE,
    cas_fecha_pres_descargos       DATE,
    cas_inf_descargo               VARCHAR2(30 BYTE),
    cas_fecha_inf_descargo         DATE,
    cas_numero_rfs                 VARCHAR2(30 BYTE),
    cas_fecha_rfs                  DATE,
    cas_ci_remision_gr             VARCHAR2(30 BYTE),
    cas_fecha_ci                   DATE,
    cas_numero_rs                  VARCHAR2(30 BYTE),
    cas_fecha_rs                   DATE,
    cas_num                        NUMBER(10,0),
    cas_lstope                     VARCHAR2(1 BYTE),
    cas_usuario                    VARCHAR2(30 BYTE),
    cas_fecsys                     DATE,
    cas_numero_informe             VARCHAR2(30 BYTE),
    cas_fecha_informe              DATE,
    cas_gerencia_legal             VARCHAR2(50 BYTE))
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE TABLE fis_con_resadmin
    (ctl_control_id                 NUMBER(18,0) NOT NULL,
    cra_fecha_pago_cuini           DATE,
    cra_monto_pago_cuoini          NUMBER(18,0),
    cra_numero_ra                  VARCHAR2(30 BYTE),
    cra_fecha_ra                   DATE,
    cra_ci_remision_set            VARCHAR2(30 BYTE),
    cra_fecha_remision_set         DATE,
    cra_saldo_por_cobrar           NUMBER(18,0),
    cra_num                        NUMBER(10,0),
    cra_lstope                     VARCHAR2(1 BYTE),
    cra_usuario                    VARCHAR2(30 BYTE),
    cra_fecsys                     DATE,
    cra_numero_informe             VARCHAR2(30 BYTE),
    cra_fecha_informe              DATE,
    cra_rup_gestion                VARCHAR2(4 BYTE),
    cra_rup_aduana                 VARCHAR2(4 BYTE),
    cra_rup_numero                 VARCHAR2(10 BYTE),
    cra_gerencia_legal             VARCHAR2(50 BYTE))
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE TABLE fis_con_resdeter
    (ctl_control_id                 NUMBER(18,0) NOT NULL,
    crd_rd_final                   VARCHAR2(30 BYTE),
    crd_fecha_not_rd_final         DATE,
    crd_num                        NUMBER(10,0),
    crd_lstope                     VARCHAR2(1 BYTE),
    crd_usuario                    VARCHAR2(30 BYTE),
    crd_fecsys                     DATE,
    crd_numero_informe             VARCHAR2(30 BYTE),
    crd_fecha_informe              DATE)
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE TABLE fis_con_viscargo
    (ctl_control_id                 NUMBER(18,0) NOT NULL,
    cvc_tipo_notificacion          VARCHAR2(30 BYTE),
    cvc_fecha_notificacion         DATE,
    cvc_fecha_presentacion         DATE,
    cvc_inf_descargo               VARCHAR2(30 BYTE),
    cvc_fecha_descargo             DATE,
    cvc_rd_final                   VARCHAR2(30 BYTE),
    cvc_fecha_not_rd_final         DATE,
    cvc_ci_remision                VARCHAR2(30 BYTE),
    cvc_fecha_ci_remision          DATE,
    cvc_numero_rd                  VARCHAR2(30 BYTE),
    cvc_fecha_rd                   DATE,
    cvc_num                        NUMBER(10,0),
    cvc_lstope                     VARCHAR2(1 BYTE),
    cvc_usuario                    VARCHAR2(30 BYTE),
    cvc_fecsys                     DATE,
    cvc_numero_informe             VARCHAR2(30 BYTE),
    cvc_fecha_informe              DATE,
    cvc_numero_vc                  VARCHAR2(30 BYTE),
    cvc_fecha_vc                   DATE,
    cvc_tipo_rd                    VARCHAR2(100 BYTE),
    cvc_gerencia_legal             VARCHAR2(50 BYTE))
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE TABLE fis_conclusion
    (ctl_control_id                 NUMBER(18,0) NOT NULL,
    con_tipo_doc_con               VARCHAR2(100 BYTE),
    con_num_doc_con                VARCHAR2(100 BYTE),
    con_fecha_doc_con              DATE,
    con_num                        NUMBER(10,0),
    con_lstope                     VARCHAR2(1 BYTE),
    con_usuario                    VARCHAR2(30 BYTE),
    con_fecsys                     DATE)
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE UNIQUE INDEX fis_conclusion_idx ON fis_conclusion
  (
    ctl_control_id                  ASC,
    con_num                         ASC,
    con_lstope                      ASC
  )
NOPARALLEL
LOGGING
/


CREATE TABLE fis_control
    (ctl_control_id                 NUMBER(18,0) NOT NULL,
    ctl_cod_gestion                VARCHAR2(4 BYTE),
    ctl_cod_tipo                   VARCHAR2(50 BYTE),
    ctl_cod_gerencia               VARCHAR2(10 BYTE),
    ctl_cod_numero                 NUMBER(10,0),
    ctl_tipo_documento             VARCHAR2(50 BYTE),
    ctl_nro_documento              VARCHAR2(100 BYTE),
    ctl_fecha_documento            DATE,
    ctl_obs_documento              VARCHAR2(500 BYTE),
    ctl_riesgo_identificado        VARCHAR2(30 BYTE),
    ctl_tipo_doc_identidad         VARCHAR2(10 BYTE),
    ctl_nit                        NUMBER(18,0),
    ctl_razon_social               VARCHAR2(100 BYTE),
    ctl_ci                         VARCHAR2(30 BYTE),
    ctl_ci_exp                     VARCHAR2(5 BYTE),
    ctl_nombres                    VARCHAR2(30 BYTE),
    ctl_appat                      VARCHAR2(30 BYTE),
    ctl_apmat                      VARCHAR2(30 BYTE),
    ctl_direccion                  VARCHAR2(300 BYTE),
    ctl_actividad_principal        VARCHAR2(300 BYTE),
    ctl_amp_correlativo            NUMBER(5,0),
    ctl_num                        NUMBER(5,0) NOT NULL,
    ctl_lstope                     VARCHAR2(1 BYTE),
    ctl_usuario                    VARCHAR2(30 BYTE),
    ctl_fecsys                     DATE,
    ctl_tipo_operador              VARCHAR2(30 BYTE),
    ctl_tribtodos                  VARCHAR2(10 BYTE),
    ctl_tribga                     VARCHAR2(10 BYTE),
    ctl_tribiva                    VARCHAR2(10 BYTE),
    ctl_tribice                    VARCHAR2(10 BYTE),
    ctl_tribiehd                   VARCHAR2(10 BYTE),
    ctl_tribicd                    VARCHAR2(10 BYTE),
    ctl_tribnoaplica               VARCHAR2(10 BYTE),
    ctl_periodo                    VARCHAR2(30 BYTE),
    ctl_riesgodelito               VARCHAR2(10 BYTE),
    ctl_riesgosubval               VARCHAR2(10 BYTE),
    ctl_riesgoclas                 VARCHAR2(10 BYTE),
    ctl_riesgocontrab              VARCHAR2(10 BYTE),
    ctl_amp_control                VARCHAR2(15 BYTE),
    ctl_periodo_solicitar          VARCHAR2(30 BYTE))
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE UNIQUE INDEX fis_control_idx ON fis_control
  (
    ctl_control_id                  ASC,
    ctl_cod_tipo                    ASC,
    ctl_cod_gerencia                ASC,
    ctl_num                         ASC,
    ctl_lstope                      ASC
  )
NOPARALLEL
LOGGING
/


CREATE TABLE fis_estado
    (ctl_control_id                 NUMBER(18,0) NOT NULL,
    est_estado                     VARCHAR2(30 BYTE),
    est_num                        NUMBER(10,0),
    est_lstope                     VARCHAR2(1 BYTE),
    est_usuario                    VARCHAR2(30 BYTE),
    est_fecsys                     DATE)
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE UNIQUE INDEX fis_estado_idx ON fis_estado
  (
    ctl_control_id                  ASC,
    est_estado                      ASC,
    est_num                         ASC,
    est_lstope                      ASC,
    est_fecsys                      ASC
  )
NOPARALLEL
LOGGING
/


CREATE TABLE fis_fap
    (sad_reg_year                   VARCHAR2(4 BYTE),
    key_cuo                        VARCHAR2(5 BYTE),
    sad_reg_serial                 VARCHAR2(1 BYTE),
    sad_reg_nber                   NUMBER,
    fap_nro_control                VARCHAR2(50 BYTE),
    fap_num                        NUMBER,
    fap_tramite                    VARCHAR2(30 BYTE),
    fap_estado                     VARCHAR2(50 BYTE))
  NOPARALLEL
  LOGGING
/

CREATE UNIQUE INDEX fis_fap_idx ON fis_fap
  (
    sad_reg_year                    ASC,
    key_cuo                         ASC,
    sad_reg_serial                  ASC,
    sad_reg_nber                    ASC,
    fap_num                         ASC,
    fap_tramite                     ASC
  )
NOPARALLEL
LOGGING
/


CREATE TABLE fis_fap_backup
    (sad_reg_year                   VARCHAR2(4 BYTE),
    key_cuo                        VARCHAR2(5 BYTE),
    sad_reg_serial                 VARCHAR2(1 BYTE),
    sad_reg_nber                   NUMBER,
    fap_nro_control                VARCHAR2(50 BYTE),
    fap_num                        NUMBER,
    fap_tramite                    VARCHAR2(30 BYTE),
    fap_estado                     VARCHAR2(50 BYTE))
  NOPARALLEL
  LOGGING
/

CREATE TABLE fis_fap2
    (sad_reg_year                   VARCHAR2(4 BYTE),
    key_cuo                        VARCHAR2(5 BYTE),
    sad_reg_serial                 VARCHAR2(1 BYTE),
    sad_reg_nber                   NUMBER,
    fap_nro_control                VARCHAR2(50 BYTE),
    fap_num                        NUMBER,
    fap_tramite                    VARCHAR2(30 BYTE),
    fap_estado                     VARCHAR2(50 BYTE))
  NOPARALLEL
  LOGGING
/

CREATE UNIQUE INDEX fis_fap2_idx ON fis_fap2
  (
    sad_reg_year                    ASC,
    key_cuo                         ASC,
    sad_reg_serial                  ASC,
    sad_reg_nber                    ASC,
    fap_num                         ASC,
    fap_tramite                     ASC
  )
NOPARALLEL
LOGGING
/


CREATE TABLE fis_fiscalizador
    (fis_fiscalizador_id            NUMBER(18,0) NOT NULL,
    fis_codigo_fiscalizador        VARCHAR2(30 BYTE),
    fis_cargo                      VARCHAR2(50 BYTE),
    fis_num                        NUMBER(10,0),
    fis_lstope                     VARCHAR2(1 BYTE),
    fis_usuario                    VARCHAR2(30 BYTE),
    fis_fecsys                     DATE,
    ctl_control_id                 NUMBER(18,0))
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE TABLE fis_gerencia
    (ger_id                         NUMBER,
    ger_codigo                     VARCHAR2(10 BYTE),
    ger_descripcion                VARCHAR2(50 BYTE),
    reg_cod                        VARCHAR2(2 BYTE),
    reg_lstope                     VARCHAR2(2 BYTE))
  NOPARALLEL
  LOGGING
/

CREATE UNIQUE INDEX fis_gerencia_idx ON fis_gerencia
  (
    ger_codigo                      ASC,
    reg_lstope                      ASC
  )
NOPARALLEL
LOGGING
/


CREATE TABLE fis_info_notificacion
    (inn_infnot_id                  NUMBER(18,0) NOT NULL,
    inn_plazo_conclusion           NUMBER(10,0),
    inn_1                          VARCHAR2(5 BYTE),
    inn_2                          VARCHAR2(5 BYTE),
    inn_3                          VARCHAR2(5 BYTE),
    inn_4                          VARCHAR2(5 BYTE),
    inn_5                          VARCHAR2(5 BYTE),
    inn_6                          VARCHAR2(5 BYTE),
    inn_7                          VARCHAR2(5 BYTE),
    inn_8                          VARCHAR2(5 BYTE),
    inn_9                          VARCHAR2(5 BYTE),
    inn_10                         VARCHAR2(5 BYTE),
    inn_11                         VARCHAR2(5 BYTE),
    inn_12                         VARCHAR2(500 BYTE),
    inn_13                         VARCHAR2(500 BYTE),
    inn_14                         VARCHAR2(500 BYTE),
    inn_15                         VARCHAR2(500 BYTE),
    inn_16                         VARCHAR2(500 BYTE),
    inn_17                         VARCHAR2(500 BYTE),
    inn_18                         VARCHAR2(500 BYTE),
    inn_19                         VARCHAR2(500 BYTE),
    inn_20                         VARCHAR2(500 BYTE),
    inn_21                         VARCHAR2(500 BYTE),
    inn_num                        NUMBER(10,0),
    inn_lstope                     VARCHAR2(1 BYTE),
    inn_usuario                    VARCHAR2(30 BYTE),
    inn_fecsys                     DATE,
    ctl_control_id                 NUMBER(18,0))
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE UNIQUE INDEX fis_info_notificacion_idx ON fis_info_notificacion
  (
    ctl_control_id                  ASC,
    inn_num                         ASC,
    inn_lstope                      ASC
  )
NOPARALLEL
LOGGING
/


CREATE TABLE fis_not_conclusion
    (ctl_control_id                 NUMBER(18,0) NOT NULL,
    ndc_fecha_notificacion         DATE,
    ndc_tipo_notificacion          VARCHAR2(30 BYTE),
    ndc_num                        NUMBER(10,0),
    ndc_lstope                     VARCHAR2(1 BYTE),
    ndc_usuario                    VARCHAR2(30 BYTE),
    ndc_fecsys                     DATE)
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE TABLE fis_notificacion
    (ctl_control_id                 NUMBER(18,0),
    not_fecha_notificacion         DATE,
    not_tipo_notificacion          VARCHAR2(30 BYTE),
    not_obs_notificacion           VARCHAR2(100 BYTE),
    not_num                        NUMBER(10,0),
    not_lstope                     VARCHAR2(1 BYTE),
    not_usuario                    VARCHAR2(30 BYTE),
    not_fecsys                     DATE)
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE UNIQUE INDEX fis_notificacion_idx ON fis_notificacion
  (
    ctl_control_id                  ASC,
    not_num                         ASC,
    not_lstope                      ASC
  )
NOPARALLEL
LOGGING
/


CREATE TABLE fis_recibos
    (rec_recibos_id                 NUMBER(18,0),
    rec_gestion                    VARCHAR2(10 BYTE),
    rec_aduana                     VARCHAR2(10 BYTE),
    rec_numero                     NUMBER(18,0),
    rec_tipo                       VARCHAR2(100 BYTE),
    rec_fecha                      DATE,
    rec_importe                    NUMBER(18,2),
    rec_num                        NUMBER(10,0),
    rec_lstope                     VARCHAR2(1 BYTE),
    rec_usuario                    VARCHAR2(30 BYTE),
    rec_fecsys                     DATE,
    ctl_control_id                 NUMBER(18,0))
  NOPARALLEL
  LOGGING
/

CREATE TABLE fis_resultados
    (res_dui                        VARCHAR2(30 BYTE) NOT NULL,
    res_numero_item                NUMBER(10,0),
    res_partida                    VARCHAR2(30 BYTE),
    res_fob_usd                    NUMBER(18,2),
    res_flete_usd                  NUMBER(18,2),
    res_seguro_usd                 NUMBER(18,2),
    res_otros_usd                  NUMBER(18,2),
    res_cif_usd                    NUMBER(18,2),
    res_cif_bob                    NUMBER(18,2),
    res_contrav                    NUMBER(18,0),
    res_ilicito                    VARCHAR2(100 BYTE),
    res_observacion                VARCHAR2(200 BYTE),
    res_num                        NUMBER(10,0),
    res_lstope                     VARCHAR2(1 BYTE),
    res_usuario                    VARCHAR2(30 BYTE),
    res_fecsys                     DATE,
    key_year                       VARCHAR2(4 BYTE),
    key_cuo                        VARCHAR2(5 BYTE),
    key_dec                        VARCHAR2(17 BYTE),
    key_nber                       VARCHAR2(13 BYTE),
    res_contravorden               NUMBER(18,0),
    alc_alcance_id                 NUMBER(18,0))
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE INDEX fis_resultados_idxn ON fis_resultados
  (
    alc_alcance_id                  ASC,
    res_num                         ASC,
    res_lstope                      ASC
  )
NOPARALLEL
LOGGING
/


CREATE TABLE fis_resultados_tramite
    (alc_alcance_id                 NUMBER(18,0),
    ret_mercancia                  VARCHAR2(100 BYTE),
    ret_fob_usd                    NUMBER(18,2),
    ret_flete_usd                  NUMBER(18,2),
    ret_seguro_usd                 NUMBER(18,2),
    ret_otros_usd                  NUMBER(18,2),
    ret_cif_usd                    NUMBER(18,2),
    ret_cif_bob                    NUMBER(18,2),
    ret_cif_ufv                    NUMBER(18,2),
    ret_num                        NUMBER(10,0),
    ret_lstope                     VARCHAR2(1 BYTE),
    ret_usuario                    VARCHAR2(30 BYTE),
    ret_fecsys                     DATE,
    ret_ilicito                    VARCHAR2(100 BYTE),
    ret_contravorden               NUMBER(18,0))
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE INDEX fis_resultado_tram_idxn ON fis_resultados_tramite
  (
    alc_alcance_id                  ASC,
    ret_num                         ASC,
    ret_lstope                      ASC
  )
NOPARALLEL
LOGGING
/



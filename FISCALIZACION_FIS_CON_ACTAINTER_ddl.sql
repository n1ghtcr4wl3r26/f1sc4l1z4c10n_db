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
    cai_tipo_resolucion            VARCHAR2(50 BYTE),
    cai_nombre_archivo             VARCHAR2(100 BYTE),
    cai_ubicacion_archivo          VARCHAR2(100 BYTE))
  NOPARALLEL
  LOGGING
  MONITORING
/


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
    cas_gerencia_legal             VARCHAR2(50 BYTE),
    cas_nombre_archivo             VARCHAR2(100 BYTE),
    cas_ubicacion_archivo          VARCHAR2(100 BYTE))
  NOPARALLEL
  LOGGING
  MONITORING
/


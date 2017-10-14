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
    cvc_gerencia_legal             VARCHAR2(50 BYTE),
    cvc_nombre_archivo             VARCHAR2(100 BYTE),
    cvc_ubicacion_archivo          VARCHAR2(100 BYTE))
  NOPARALLEL
  LOGGING
  MONITORING
/


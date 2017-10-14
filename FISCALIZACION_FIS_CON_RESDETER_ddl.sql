CREATE TABLE fis_con_resdeter
    (ctl_control_id                 NUMBER(18,0) NOT NULL,
    crd_rd_final                   VARCHAR2(30 BYTE),
    crd_fecha_not_rd_final         DATE,
    crd_num                        NUMBER(10,0),
    crd_lstope                     VARCHAR2(1 BYTE),
    crd_usuario                    VARCHAR2(30 BYTE),
    crd_fecsys                     DATE,
    crd_numero_informe             VARCHAR2(30 BYTE),
    crd_fecha_informe              DATE,
    crd_nombre_archivo             VARCHAR2(100 BYTE),
    crd_ubicacion_archivo          VARCHAR2(100 BYTE))
  NOPARALLEL
  LOGGING
  MONITORING
/


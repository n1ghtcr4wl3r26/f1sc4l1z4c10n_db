CREATE TABLE fis_presentacion
    (ctl_control_id                 NUMBER(18,0),
    pre_fecha_presentacion         DATE,
    pre_obs_presentacion           VARCHAR2(100 BYTE),
    pre_num                        NUMBER(10,0),
    pre_lstope                     VARCHAR2(1 BYTE),
    pre_usuario                    VARCHAR2(30 BYTE),
    pre_fecsys                     DATE)
  NOPARALLEL
  LOGGING
/


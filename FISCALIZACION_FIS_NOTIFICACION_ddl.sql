CREATE TABLE fis_notificacion
    (ctl_control_id                 NUMBER(18,0),
    not_fecha_notificacion         DATE,
    not_tipo_notificacion          VARCHAR2(30 BYTE),
    not_obs_notificacion           VARCHAR2(100 BYTE),
    not_num                        NUMBER(10,0),
    not_lstope                     VARCHAR2(1 BYTE),
    not_usuario                    VARCHAR2(30 BYTE),
    not_fecsys                     DATE,
    not_esapoderado                VARCHAR2(5 BYTE),
    not_ci                         VARCHAR2(30 BYTE),
    not_ci_exp                     VARCHAR2(5 BYTE),
    not_nombres                    VARCHAR2(30 BYTE),
    not_appat                      VARCHAR2(30 BYTE),
    not_apmat                      VARCHAR2(30 BYTE))
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



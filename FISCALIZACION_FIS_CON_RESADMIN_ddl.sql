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
    cra_gerencia_legal             VARCHAR2(50 BYTE),
    cra_nombre_archivo             VARCHAR2(100 BYTE),
    cra_ubicacion_archivo          VARCHAR2(100 BYTE))
  NOPARALLEL
  LOGGING
  MONITORING
/


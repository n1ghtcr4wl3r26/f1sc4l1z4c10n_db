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
  TABLESPACE  appdat
  NOPARALLEL
  LOGGING
  MONITORING
/


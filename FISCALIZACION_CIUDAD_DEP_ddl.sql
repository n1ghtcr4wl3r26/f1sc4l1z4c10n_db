CREATE TABLE ciudad_dep
    (dep_id                         VARCHAR2(10 BYTE),
    dep_des                        VARCHAR2(50 BYTE),
    ciu_id                         NUMBER(10,0),
    ciu_des                        VARCHAR2(50 BYTE),
    lst_ope                        VARCHAR2(1 BYTE))
  NOPARALLEL
  LOGGING
/


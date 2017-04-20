CREATE OR REPLACE 
PACKAGE pkg_conclusion
/* Formatted on 27-mar.-2017 16:04:24 (QP5 v5.126) */
IS
    TYPE cursortype IS REF CURSOR;


    FUNCTION devuelve_con_autoinicial (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION graba_con_autoinicial (prm_id                      VARCHAR2,
                                    prm_numero_aisc             VARCHAR2,
                                    prm_fecha_notificacion      VARCHAR2,
                                    prm_fecha_pres_descargos    VARCHAR2,
                                    prm_inf_descargo            VARCHAR2,
                                    prm_fecha_inf_descargo      VARCHAR2,
                                    prm_numero_rfs              VARCHAR2,
                                    prm_fecha_rfs               VARCHAR2,
                                    prm_ci_remision_gr          VARCHAR2,
                                    prm_fecha_ci                VARCHAR2,
                                    prm_numero_rs               VARCHAR2,
                                    prm_fecha_rs                VARCHAR2,
                                    prm_usuario                 VARCHAR2,
                                    prm_numero_informe          VARCHAR2,
                                    prm_fecha_informe           VARCHAR2,
                                    prm_gerencia_legal          VARCHAR2,
                                    prm_tipo_grabado            VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_con_resadmin (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION graba_con_resadmin (prm_id                    VARCHAR2,
                                 prm_fecha_pago_cuini      VARCHAR2,
                                 prm_monto_pago_cuoini     VARCHAR2,
                                 prm_numero_ra             VARCHAR2,
                                 prm_fecha_ra              VARCHAR2,
                                 prm_ci_remision_set       VARCHAR2,
                                 prm_fecha_remision_set    VARCHAR2,
                                 prm_saldo_por_cobrar      VARCHAR2,
                                 prm_usuario               VARCHAR2,
                                 prm_numero_informe        VARCHAR2,
                                 prm_fecha_informe         VARCHAR2,
                                 prm_rup_gestion           VARCHAR2,
                                 prm_rup_aduana            VARCHAR2,
                                 prm_rup_numero            VARCHAR2,
                                 prm_gerencia_legal        VARCHAR2,
                                 prm_tipo_grabado          VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_con_viscargo (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION graba_con_viscargo (prm_id                    VARCHAR2,
                                 prm_tipo_notificacion     VARCHAR2,
                                 prm_fecha_notificacion    VARCHAR2,
                                 prm_fecha_presentacion    VARCHAR2,
                                 prm_inf_descargo          VARCHAR2,
                                 prm_fecha_descargo        VARCHAR2,
                                 prm_rd_final              VARCHAR2,
                                 prm_fecha_not_rd_final    VARCHAR2,
                                 prm_ci_remision           VARCHAR2,
                                 prm_fecha_ci_remision     VARCHAR2,
                                 prm_numero_rd             VARCHAR2,
                                 prm_fecha_rd              VARCHAR2,
                                 prm_usuario               VARCHAR2,
                                 prm_numero_informe        VARCHAR2,
                                 prm_fecha_informe         VARCHAR2,
                                 prm_numero_vc             VARCHAR2,
                                 prm_fecha_vc              VARCHAR2,
                                 prm_tipo_rd               VARCHAR2,
                                 prm_gerencia_legal        VARCHAR2,
                                 prm_tipo_grabado          VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_con_resdeter (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION graba_con_resdeter (prm_id                    VARCHAR2,
                                 prm_rd_final              VARCHAR2,
                                 prm_fecha_not_rd_final    VARCHAR2,
                                 prm_usuario               VARCHAR2,
                                 prm_numero_informe        VARCHAR2,
                                 prm_fecha_informe         VARCHAR2,
                                 prm_tipo_grabado          VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_con_actainter (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION graba_con_actainter (prm_id                      VARCHAR2,
                                  prm_acta_interv             VARCHAR2,
                                  prm_fecha_acta_interv       VARCHAR2,
                                  prm_tipo_ilicito            VARCHAR2,
                                  prm_ci_remision             VARCHAR2,
                                  prm_fecha_ci_remision       VARCHAR2,
                                  prm_fecha_pres_descargos    VARCHAR2,
                                  prm_inf_descargo            VARCHAR2,
                                  prm_fecha_inf_descargo      VARCHAR2,
                                  prm_numero_rfs              VARCHAR2,
                                  prm_fecha_rfs               VARCHAR2,
                                  prm_numero_rs               VARCHAR2,
                                  prm_fecha_rs                VARCHAR2,
                                  prm_usuario                 VARCHAR2,
                                  prm_numero_informe          VARCHAR2,
                                  prm_fecha_informe           VARCHAR2,
                                  prm_gerencia_legal          VARCHAR2,
                                  prm_fecha_not_ai            VARCHAR2,
                                  prm_tipo_not_ai             VARCHAR2,
                                  prm_resultado_des           VARCHAR2,
                                  prm_tipo_resolucion         VARCHAR2,
                                  prm_tipo_grabado            VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_paneles (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION graba_conclusionfis (prm_codigo    IN VARCHAR2,
                                  prm_usuario   IN VARCHAR2)
        RETURN VARCHAR2;
END;
/

CREATE OR REPLACE 
PACKAGE BODY pkg_conclusion
/* Formatted on 30-mar.-2017 13:58:07 (QP5 v5.126) */
IS
    FUNCTION devuelve_con_autoinicial (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT   a.ctl_control_id,
                     a.cas_numero_aisc,
                     TO_CHAR (a.cas_fecha_notificacion, 'dd/mm/yyyy'),
                     TO_CHAR (a.cas_fecha_pres_descargos, 'dd/mm/yyyy'),
                     a.cas_inf_descargo,
                     TO_CHAR (a.cas_fecha_inf_descargo, 'dd/mm/yyyy'),
                     a.cas_numero_rfs,
                     TO_CHAR (a.cas_fecha_rfs, 'dd/mm/yyyy'),
                     cas_ci_remision_gr,
                     TO_CHAR (cas_fecha_ci, 'dd/mm/yyyy'),
                     cas_numero_rs,
                     TO_CHAR (cas_fecha_rs, 'dd/mm/yyyy'),
                     a.cas_num,
                     a.cas_lstope,
                     a.cas_usuario,
                     TO_CHAR (a.cas_fecsys, 'dd/mm/yyyy'),
                     a.cas_numero_informe,
                     TO_CHAR (a.cas_fecha_informe, 'dd/mm/yyyy'),
                     a.cas_gerencia_legal
              FROM   fis_con_autoinicial a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.cas_num = 0
                     AND a.cas_lstope = 'U';

        RETURN ct;
    END;

    FUNCTION graba_con_autoinicial (prm_id                      VARCHAR2,
                                    prm_numero_aisc             VARCHAR2,
                                    prm_fecha_notificacion      VARCHAR2,
                                    prm_fecha_pres_descargos    VARCHAR2,
                                    prm_inf_descargo            VARCHAR2,
                                    prm_fecha_inf_descargo      VARCHAR2,
                                    prm_numero_rfs              VARCHAR2,
                                    prm_fecha_rfs               VARCHAR2,
                                    prm_ci_remision_gr          VARCHAR2,
                                    prm_fecha_ci                VARCHAR2,
                                    prm_numero_rs               VARCHAR2,
                                    prm_fecha_rs                VARCHAR2,
                                    prm_usuario                 VARCHAR2,
                                    prm_numero_informe          VARCHAR2,
                                    prm_fecha_informe           VARCHAR2,
                                    prm_gerencia_legal          VARCHAR2,
                                    prm_tipo_grabado            VARCHAR2)
        RETURN VARCHAR2
    IS
        res           VARCHAR2 (300) := 0;
        existe        NUMBER;
        v_gestion     VARCHAR2 (4);
        v_numero      NUMBER;
        estado        VARCHAR2 (30);
        doc_con       VARCHAR2 (100) := '';
        doc_con_num   VARCHAR2 (30) := '';
        doc_con_fec   VARCHAR2 (30) := '';
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_conclusion a
         WHERE       a.ctl_control_id = prm_id
                 AND a.con_num = 0
                 AND a.con_lstope = 'U';

        IF existe = 1
        THEN
            SELECT   a.con_tipo_doc_con
              INTO   doc_con
              FROM   fis_conclusion a
             WHERE       a.ctl_control_id = prm_id
                     AND a.con_num = 0
                     AND a.con_lstope = 'U';

            IF doc_con = 'AUTO INICIAL DE SUMARIO CONTRAVENCIONAL'
            THEN
                SELECT   a.cas_numero_aisc,
                         TO_CHAR (a.cas_fecha_notificacion, 'dd/mm/yyyy')
                  INTO   doc_con_num, doc_con_fec
                  FROM   fis_con_autoinicial a
                 WHERE       a.cas_num = 0
                         AND a.cas_lstope = 'U'
                         AND a.ctl_control_id = prm_id;

                IF NOT (prm_numero_aisc = doc_con_num
                        AND prm_fecha_notificacion = doc_con_fec)
                THEN
                    RETURN 'NO SE PUEDE MODIFICAR EL N&Uacute;MERO O LA FECHA DEL AUTO INICIAL, PORQUE YA FUE REGISTRADO COMO DOCUMENTO DE CONCLUSI&Oacute;N.';
                END IF;
            END IF;
        END IF;

        SELECT   est_estado
          INTO   estado
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_id
                 AND a.est_num = 0
                 AND a.est_lstope = 'U';

        IF estado = 'REGISTRADO'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_con_autoinicial a
             WHERE       NOT a.ctl_control_id = prm_id
                     AND a.cas_numero_informe = prm_numero_informe
                     AND NOT prm_numero_informe IS NULL
                     AND a.cas_num = 0
                     AND a.cas_lstope = 'U';

            IF existe > 0
            THEN
                RETURN    'El n&uacute;mero de informe '
                       || prm_numero_informe
                       || ' se encuentra duplicado en otra orden';
            ELSE
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_con_autoinicial a
                 WHERE       NOT a.ctl_control_id = prm_id
                         AND a.cas_numero_aisc = prm_numero_aisc
                         AND NOT prm_numero_aisc IS NULL
                         AND a.cas_num = 0
                         AND a.cas_lstope = 'U';

                IF existe > 0
                THEN
                    RETURN 'El n&uacute;mero de Auto INICIAL DE SUMARIO CONTRAVENCIONAL '
                           || prm_numero_aisc
                           || ' se encuentra duplicado en otra orden';
                ELSE
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_con_autoinicial a
                     WHERE       a.ctl_control_id = prm_id
                             AND a.cas_num = 0
                             AND a.cas_lstope = 'U';

                    IF existe = 0
                    THEN
                        INSERT INTO fis_con_autoinicial (ctl_control_id,
                                                         cas_numero_aisc,
                                                         cas_fecha_notificacion,
                                                         cas_fecha_pres_descargos,
                                                         cas_inf_descargo,
                                                         cas_fecha_inf_descargo,
                                                         cas_numero_rfs,
                                                         cas_fecha_rfs,
                                                         cas_ci_remision_gr,
                                                         cas_fecha_ci,
                                                         cas_num,
                                                         cas_lstope,
                                                         cas_usuario,
                                                         cas_fecsys,
                                                         cas_numero_informe,
                                                         cas_fecha_informe,
                                                         cas_gerencia_legal)
                          VALUES   (prm_id,
                                    prm_numero_aisc,
                                    TO_DATE (prm_fecha_notificacion,
                                             'dd/mm/yyyy'),
                                    TO_DATE (prm_fecha_pres_descargos,
                                             'dd/mm/yyyy'),
                                    prm_inf_descargo,
                                    TO_DATE (prm_fecha_inf_descargo,
                                             'dd/mm/yyyy'),
                                    prm_numero_rfs,
                                    TO_DATE (prm_fecha_rfs, 'dd/mm/yyyy'),
                                    prm_ci_remision_gr,
                                    TO_DATE (prm_fecha_ci, 'dd/mm/yyyy'),
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_numero_informe,
                                    TO_DATE (prm_fecha_informe, 'dd/mm/yyyy'),
                                    prm_gerencia_legal);

                        IF prm_tipo_grabado = 'CONCLUIR'
                        THEN
                            SELECT   COUNT (1)
                              INTO   existe
                              FROM   fis_conclusion a
                             WHERE       a.ctl_control_id = prm_id
                                     AND a.con_num = 0
                                     AND a.con_lstope = 'U';

                            IF existe = 0
                            THEN
                                INSERT INTO fis_conclusion
                                  VALUES   (prm_id,
                                            'AUTO INICIAL DE SUMARIO CONTRAVENCIONAL',
                                            prm_numero_aisc,
                                            TO_DATE (prm_fecha_notificacion,
                                                     'dd/mm/yyyy'),
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE);
                            END IF;
                        END IF;

                        COMMIT;
                        RETURN 'CORRECTOSE REGISTRO CORRECTAMENTE EL AUTO INICIAL DE SUMARIO CONTRAVENCIONAL'
;
                    ELSE
                        SELECT   COUNT (1)
                          INTO   existe
                          FROM   fis_con_autoinicial a
                         WHERE   a.ctl_control_id = prm_id;

                        UPDATE   fis_con_autoinicial
                           SET   cas_num = existe
                         WHERE   ctl_control_id = prm_id AND cas_num = 0;

                        INSERT INTO fis_con_autoinicial (ctl_control_id,
                                                         cas_numero_aisc,
                                                         cas_fecha_notificacion,
                                                         cas_fecha_pres_descargos,
                                                         cas_inf_descargo,
                                                         cas_fecha_inf_descargo,
                                                         cas_numero_rfs,
                                                         cas_fecha_rfs,
                                                         cas_ci_remision_gr,
                                                         cas_fecha_ci,
                                                         cas_num,
                                                         cas_lstope,
                                                         cas_usuario,
                                                         cas_fecsys,
                                                         cas_numero_informe,
                                                         cas_fecha_informe,
                                                         cas_gerencia_legal)
                          VALUES   (prm_id,
                                    prm_numero_aisc,
                                    TO_DATE (prm_fecha_notificacion,
                                             'dd/mm/yyyy'),
                                    TO_DATE (prm_fecha_pres_descargos,
                                             'dd/mm/yyyy'),
                                    prm_inf_descargo,
                                    TO_DATE (prm_fecha_inf_descargo,
                                             'dd/mm/yyyy'),
                                    prm_numero_rfs,
                                    TO_DATE (prm_fecha_rfs, 'dd/mm/yyyy'),
                                    prm_ci_remision_gr,
                                    TO_DATE (prm_fecha_ci, 'dd/mm/yyyy'),
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_numero_informe,
                                    TO_DATE (prm_fecha_informe, 'dd/mm/yyyy'),
                                    prm_gerencia_legal);

                        IF prm_tipo_grabado = 'CONCLUIR'
                        THEN
                            SELECT   COUNT (1)
                              INTO   existe
                              FROM   fis_conclusion a
                             WHERE       a.ctl_control_id = prm_id
                                     AND a.con_num = 0
                                     AND a.con_lstope = 'U';

                            IF existe = 0
                            THEN
                                INSERT INTO fis_conclusion
                                  VALUES   (prm_id,
                                            'AUTO INICIAL DE SUMARIO CONTRAVENCIONAL',
                                            prm_numero_aisc,
                                            TO_DATE (prm_fecha_notificacion,
                                                     'dd/mm/yyyy'),
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE);
                            END IF;
                        END IF;

                        RETURN 'CORRECTOSE MODIFICO CORRECTAMENTE EL AUTO INICIAL DE SUMARIO CONTRAVENCIONAL'
;
                    END IF;
                END IF;
            END IF;
        END IF;

        IF estado = 'CONCLUIDO'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_con_autoinicial a
             WHERE       a.ctl_control_id = prm_id
                     AND a.cas_num = 0
                     AND a.cas_lstope = 'U';

            IF existe = 0
            THEN
                RETURN 'NO TIENE REGISTRO DE AUTO INICIAL DE SUMARIO CONTRAVENCIONAL';
            ELSE
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_con_autoinicial a
                 WHERE   a.ctl_control_id = prm_id;

                UPDATE   fis_con_autoinicial
                   SET   cas_num = existe
                 WHERE   ctl_control_id = prm_id AND cas_num = 0;

                INSERT INTO fis_con_autoinicial (ctl_control_id,
                                                 cas_numero_aisc,
                                                 cas_fecha_notificacion,
                                                 cas_fecha_pres_descargos,
                                                 cas_inf_descargo,
                                                 cas_fecha_inf_descargo,
                                                 cas_numero_rfs,
                                                 cas_fecha_rfs,
                                                 cas_ci_remision_gr,
                                                 cas_fecha_ci,
                                                 cas_numero_rs,
                                                 cas_fecha_rs,
                                                 cas_num,
                                                 cas_lstope,
                                                 cas_usuario,
                                                 cas_fecsys,
                                                 cas_numero_informe,
                                                 cas_fecha_informe,
                                                 cas_gerencia_legal)
                    SELECT   prm_id,
                             a.cas_numero_aisc,
                             a.cas_fecha_notificacion,
                             a.cas_fecha_pres_descargos,
                             a.cas_inf_descargo,
                             a.cas_fecha_inf_descargo,
                             a.cas_numero_rfs,
                             a.cas_fecha_rfs,
                             a.cas_ci_remision_gr,
                             a.cas_fecha_ci,
                             prm_numero_rs,
                             TO_DATE (prm_fecha_rs, 'dd/mm/yyyy'),
                             0,
                             'U',
                             prm_usuario,
                             SYSDATE,
                             a.cas_numero_informe,
                             a.cas_fecha_informe,
                             a.cas_gerencia_legal
                      FROM   fis_con_autoinicial a
                      WHERE  ctl_control_id = prm_id AND cas_num = existe;


                RETURN 'CORRECTOSE MODIFIC&Oacute; CORRECTAMENTE EL AUTO INICIAL DE SUMARIO CONTRAVENCIONAL'
;
            END IF;
        ELSE
            RETURN 'LA FISCALIZACI&Oacute;N NO SE ENCUENTRA EN EL ESTADO CORRECTO';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;



    FUNCTION devuelve_con_resadmin (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT   a.ctl_control_id,
                     TO_CHAR (a.cra_fecha_pago_cuini, 'dd/mm/yyyy'),
                     a.cra_monto_pago_cuoini,
                     a.cra_numero_ra,
                     TO_CHAR (a.cra_fecha_ra, 'dd/mm/yyyy'),
                     a.cra_ci_remision_set,
                     TO_CHAR (a.cra_fecha_remision_set, 'dd/mm/yyyy'),
                     a.cra_saldo_por_cobrar,
                     a.cra_num,
                     a.cra_lstope,
                     a.cra_usuario,
                     TO_CHAR (a.cra_fecsys, 'dd/mm/yyyy'),
                     a.cra_numero_informe,
                     TO_CHAR (a.cra_fecha_informe, 'dd/mm/yyyy'),
                     a.cra_rup_gestion,
                     a.cra_rup_aduana,
                     a.cra_rup_numero,
                     a.cra_gerencia_legal
              FROM   fis_con_resadmin a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.cra_num = 0
                     AND a.cra_lstope = 'U';

        RETURN ct;
    END;

    FUNCTION graba_con_resadmin (prm_id                    VARCHAR2,
                                 prm_fecha_pago_cuini      VARCHAR2,
                                 prm_monto_pago_cuoini     VARCHAR2,
                                 prm_numero_ra             VARCHAR2,
                                 prm_fecha_ra              VARCHAR2,
                                 prm_ci_remision_set       VARCHAR2,
                                 prm_fecha_remision_set    VARCHAR2,
                                 prm_saldo_por_cobrar      VARCHAR2,
                                 prm_usuario               VARCHAR2,
                                 prm_numero_informe        VARCHAR2,
                                 prm_fecha_informe         VARCHAR2,
                                 prm_rup_gestion           VARCHAR2,
                                 prm_rup_aduana            VARCHAR2,
                                 prm_rup_numero            VARCHAR2,
                                 prm_gerencia_legal        VARCHAR2,
                                 prm_tipo_grabado          VARCHAR2)
        RETURN VARCHAR2
    IS
        res           VARCHAR2 (300) := 0;
        existe        NUMBER;
        v_gestion     VARCHAR2 (4);
        v_numero      NUMBER;
        estado        VARCHAR2 (30);
        doc_con       VARCHAR2 (100) := '';
        doc_con_num   VARCHAR2 (30) := '';
        doc_con_fec   VARCHAR2 (30) := '';
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_conclusion a
         WHERE       a.ctl_control_id = prm_id
                 AND a.con_num = 0
                 AND a.con_lstope = 'U';

        IF existe = 1
        THEN
            SELECT   a.con_tipo_doc_con
              INTO   doc_con
              FROM   fis_conclusion a
             WHERE       a.ctl_control_id = prm_id
                     AND a.con_num = 0
                     AND a.con_lstope = 'U';

            IF doc_con =
                   'RESOLUCION ADMINISTRATIVA Y DETERMINATIVA DE FACILIDADES DE PAGO'
            THEN
                SELECT   a.cra_numero_ra,
                         TO_CHAR (a.cra_fecha_ra, 'dd/mm/yyyy')
                  INTO   doc_con_num, doc_con_fec
                  FROM   fis_con_resadmin a
                 WHERE       a.cra_num = 0
                         AND a.cra_lstope = 'U'
                         AND a.ctl_control_id = prm_id;

                IF NOT (prm_numero_ra = doc_con_num
                        AND prm_fecha_ra = doc_con_fec)
                THEN
                    RETURN 'NO SE PUEDE MODIFICAR EL N&Uacute;MERO O LA FECHA DE LA RESOLUCI&Oacute;N ADMINISTRATIVA, PORQUE YA FUE REGISTRADA COMO DOCUMENTO DE CONCLUSI&Oacute;N.';
                END IF;
            END IF;
        END IF;

        SELECT   est_estado
          INTO   estado
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_id
                 AND a.est_num = 0
                 AND a.est_lstope = 'U';

        IF estado = 'REGISTRADO'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_con_resadmin a
             WHERE       NOT a.ctl_control_id = prm_id
                     AND a.cra_numero_informe = prm_numero_informe
                     AND NOT prm_numero_informe IS NULL
                     AND a.cra_num = 0
                     AND a.cra_lstope = 'U';

            IF existe > 0
            THEN
                RETURN    'El n&uacute;mero de informe '
                       || prm_numero_informe
                       || ' se encuentra duplicado en otra orden';
            ELSE
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_con_resadmin a
                 WHERE       NOT a.ctl_control_id = prm_id
                         AND a.cra_numero_ra = prm_numero_ra
                         AND NOT prm_numero_ra IS NULL
                         AND a.cra_num = 0
                         AND a.cra_lstope = 'U';

                IF existe > 0
                THEN
                    RETURN 'El n&uacute;mero de Resoluci&oacute;n Administrativa '
                           || prm_numero_ra
                           || ' se encuentra duplicado en otra orden';
                ELSE
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_con_resadmin a
                     WHERE       a.ctl_control_id = prm_id
                             AND a.cra_num = 0
                             AND a.cra_lstope = 'U';

                    IF existe = 0
                    THEN
                        INSERT INTO fis_con_resadmin (ctl_control_id,
                                                      cra_fecha_pago_cuini,
                                                      cra_monto_pago_cuoini,
                                                      cra_numero_ra,
                                                      cra_fecha_ra,
                                                      cra_ci_remision_set,
                                                      cra_fecha_remision_set,
                                                      cra_saldo_por_cobrar,
                                                      cra_num,
                                                      cra_lstope,
                                                      cra_usuario,
                                                      cra_fecsys,
                                                      cra_numero_informe,
                                                      cra_fecha_informe,
                                                      cra_rup_gestion,
                                                      cra_rup_aduana,
                                                      cra_rup_numero,
                                                      cra_gerencia_legal)
                          VALUES   (prm_id,
                                    TO_DATE (prm_fecha_pago_cuini,
                                             'dd/mm/yyyy'),
                                    prm_monto_pago_cuoini,
                                    prm_numero_ra,
                                    TO_DATE (prm_fecha_ra, 'dd/mm/yyyy'),
                                    prm_ci_remision_set,
                                    TO_DATE (prm_fecha_remision_set,
                                             'dd/mm/yyyy'),
                                    prm_saldo_por_cobrar,
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_numero_informe,
                                    TO_DATE (prm_fecha_informe, 'dd/mm/yyyy'),
                                    prm_rup_gestion,
                                    prm_rup_aduana,
                                    prm_rup_numero,
                                    prm_gerencia_legal);

                        IF prm_tipo_grabado = 'CONCLUIR'
                        THEN
                            SELECT   COUNT (1)
                              INTO   existe
                              FROM   fis_conclusion a
                             WHERE       a.ctl_control_id = prm_id
                                     AND a.con_num = 0
                                     AND a.con_lstope = 'U';

                            IF existe = 0
                            THEN
                                INSERT INTO fis_conclusion
                                  VALUES   (prm_id,
                                            'RESOLUCION ADMINISTRATIVA Y DETERMINATIVA DE FACILIDADES DE PAGO',
                                            prm_numero_ra,
                                            TO_DATE (prm_fecha_ra,
                                                     'dd/mm/yyyy'),
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE);
                            END IF;
                        END IF;

                        COMMIT;
                        RETURN 'CORRECTOSE REGISTR&Oacute; CORRECTAMENTE LA RESOLUCI&Oacute;N ADMINISTRATIVA';
                    ELSE
                        SELECT   COUNT (1)
                          INTO   existe
                          FROM   fis_con_resadmin a
                         WHERE   a.ctl_control_id = prm_id;

                        UPDATE   fis_con_resadmin
                           SET   cra_num = existe
                         WHERE   ctl_control_id = prm_id AND cra_num = 0;

                        INSERT INTO fis_con_resadmin (ctl_control_id,
                                                      cra_fecha_pago_cuini,
                                                      cra_monto_pago_cuoini,
                                                      cra_numero_ra,
                                                      cra_fecha_ra,
                                                      cra_ci_remision_set,
                                                      cra_fecha_remision_set,
                                                      cra_saldo_por_cobrar,
                                                      cra_num,
                                                      cra_lstope,
                                                      cra_usuario,
                                                      cra_fecsys,
                                                      cra_numero_informe,
                                                      cra_fecha_informe,
                                                      cra_rup_gestion,
                                                      cra_rup_aduana,
                                                      cra_rup_numero,
                                                      cra_gerencia_legal)
                          VALUES   (prm_id,
                                    TO_DATE (prm_fecha_pago_cuini,
                                             'dd/mm/yyyy'),
                                    prm_monto_pago_cuoini,
                                    prm_numero_ra,
                                    TO_DATE (prm_fecha_ra, 'dd/mm/yyyy'),
                                    prm_ci_remision_set,
                                    TO_DATE (prm_fecha_remision_set,
                                             'dd/mm/yyyy'),
                                    prm_saldo_por_cobrar,
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_numero_informe,
                                    TO_DATE (prm_fecha_informe, 'dd/mm/yyyy'),
                                    prm_rup_gestion,
                                    prm_rup_aduana,
                                    prm_rup_numero,
                                    prm_gerencia_legal);

                        IF prm_tipo_grabado = 'CONCLUIR'
                        THEN
                            SELECT   COUNT (1)
                              INTO   existe
                              FROM   fis_conclusion a
                             WHERE       a.ctl_control_id = prm_id
                                     AND a.con_num = 0
                                     AND a.con_lstope = 'U';

                            IF existe = 0
                            THEN
                                INSERT INTO fis_conclusion
                                  VALUES   (prm_id,
                                            'RESOLUCION ADMINISTRATIVA Y DETERMINATIVA DE FACILIDADES DE PAGO',
                                            prm_numero_ra,
                                            TO_DATE (prm_fecha_ra,
                                                     'dd/mm/yyyy'),
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE);
                            END IF;
                        END IF;

                        RETURN 'CORRECTOSE MODIFIC&Oacute; CORRECTAMENTE LA RESOLUCI&Oacute;N ADMINISTRATIVA';
                    END IF;
                END IF;
            END IF;
        ELSE
            RETURN 'LA FISCALIZACI&Oacute;N NO SE ENCUENTRA EN EL ESTADO CORRECTO';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;



    FUNCTION devuelve_con_viscargo (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT   a.ctl_control_id,
                     a.cvc_tipo_notificacion,
                     TO_CHAR (a.cvc_fecha_notificacion, 'dd/mm/yyyy'),
                     TO_CHAR (a.cvc_fecha_presentacion, 'dd/mm/yyyy'),
                     a.cvc_inf_descargo,
                     TO_CHAR (a.cvc_fecha_descargo, 'dd/mm/yyyy'),
                     a.cvc_rd_final,
                     TO_CHAR (a.cvc_fecha_not_rd_final, 'dd/mm/yyyy'),
                     a.cvc_ci_remision,
                     TO_CHAR (a.cvc_fecha_ci_remision, 'dd/mm/yyyy'),
                     a.cvc_numero_rd,
                     TO_CHAR (a.cvc_fecha_rd, 'dd/mm/yyyy'),
                     a.cvc_num,
                     a.cvc_lstope,
                     a.cvc_usuario,
                     TO_CHAR (a.cvc_fecsys, 'dd/mm/yyyy'),
                     cvc_numero_informe,
                     TO_CHAR (cvc_fecha_informe, 'dd/mm/yyyy'),
                     cvc_numero_vc,
                     TO_CHAR (cvc_fecha_vc, 'dd/mm/yyyy'),
                     a.cvc_tipo_rd,
                     a.cvc_gerencia_legal
              FROM   fis_con_viscargo a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.cvc_num = 0
                     AND a.cvc_lstope = 'U';

        RETURN ct;
    END;

    FUNCTION graba_con_viscargo (prm_id                    VARCHAR2,
                                 prm_tipo_notificacion     VARCHAR2,
                                 prm_fecha_notificacion    VARCHAR2,
                                 prm_fecha_presentacion    VARCHAR2,
                                 prm_inf_descargo          VARCHAR2,
                                 prm_fecha_descargo        VARCHAR2,
                                 prm_rd_final              VARCHAR2,
                                 prm_fecha_not_rd_final    VARCHAR2,
                                 prm_ci_remision           VARCHAR2,
                                 prm_fecha_ci_remision     VARCHAR2,
                                 prm_numero_rd             VARCHAR2,
                                 prm_fecha_rd              VARCHAR2,
                                 prm_usuario               VARCHAR2,
                                 prm_numero_informe        VARCHAR2,
                                 prm_fecha_informe         VARCHAR2,
                                 prm_numero_vc             VARCHAR2,
                                 prm_fecha_vc              VARCHAR2,
                                 prm_tipo_rd               VARCHAR2,
                                 prm_gerencia_legal        VARCHAR2,
                                 prm_tipo_grabado          VARCHAR2)
        RETURN VARCHAR2
    IS
        res           VARCHAR2 (300) := 0;
        existe        NUMBER;
        v_gestion     VARCHAR2 (4);
        v_numero      NUMBER;
        estado        VARCHAR2 (30) := '';
        doc_con       VARCHAR2 (100) := '';
        doc_con_num   VARCHAR2 (30) := '';
        doc_con_fec   VARCHAR2 (30) := '';
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_conclusion a
         WHERE       a.ctl_control_id = prm_id
                 AND a.con_num = 0
                 AND a.con_lstope = 'U';

        IF existe = 1
        THEN
            SELECT   a.con_tipo_doc_con
              INTO   doc_con
              FROM   fis_conclusion a
             WHERE       a.ctl_control_id = prm_id
                     AND a.con_num = 0
                     AND a.con_lstope = 'U';

            IF doc_con = 'VISTA DE CARGO'
            THEN
                SELECT   a.cvc_numero_vc,
                         TO_CHAR (a.cvc_fecha_vc, 'dd/mm/yyyy')
                  INTO   doc_con_num, doc_con_fec
                  FROM   fis_con_viscargo a
                 WHERE       a.cvc_num = 0
                         AND a.cvc_lstope = 'U'
                         AND a.ctl_control_id = prm_id;

                IF NOT (prm_numero_vc = doc_con_num
                        AND prm_fecha_vc = doc_con_fec)
                THEN
                    RETURN 'NO SE PUEDE MODIFICAR EL NUMERO O LA FECHA DE LA VISTA DE CARGO, PORQUE YA FUE REGISTRADA COMO DOCUMENTO DE CONCLUSION.';
                END IF;
            END IF;
        END IF;


        SELECT   est_estado
          INTO   estado
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_id
                 AND a.est_num = 0
                 AND a.est_lstope = 'U';

        IF estado = 'REGISTRADO'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_con_viscargo a
             WHERE       NOT a.ctl_control_id = prm_id
                     AND a.cvc_numero_informe = prm_numero_informe
                     AND NOT prm_numero_informe IS NULL
                     AND a.cvc_num = 0
                     AND a.cvc_lstope = 'U';

            IF existe > 0
            THEN
                RETURN    'El n&uacute;mero de informe '
                       || prm_numero_informe
                       || ' se encuentra duplicado en otra orden';
            ELSE
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_con_viscargo a
                 WHERE       NOT a.ctl_control_id = prm_id
                         AND a.cvc_numero_vc = prm_numero_vc
                         AND NOT prm_numero_vc IS NULL
                         AND a.cvc_num = 0
                         AND a.cvc_lstope = 'U';

                IF existe > 0
                THEN
                    RETURN    'EL NUMERO DE VISTA DE CARGO '
                           || prm_numero_vc
                           || ' se encuentra duplicado en otra orden';
                ELSE
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_con_viscargo a
                     WHERE       a.ctl_control_id = prm_id
                             AND a.cvc_num = 0
                             AND a.cvc_lstope = 'U';

                    IF existe = 0
                    THEN
                        INSERT INTO fis_con_viscargo (ctl_control_id,
                                                      cvc_tipo_notificacion,
                                                      cvc_fecha_notificacion,
                                                      cvc_fecha_presentacion,
                                                      cvc_inf_descargo,
                                                      cvc_fecha_descargo,
                                                      cvc_rd_final,
                                                      cvc_fecha_not_rd_final,
                                                      cvc_ci_remision,
                                                      cvc_fecha_ci_remision,
                                                      cvc_numero_rd,
                                                      cvc_fecha_rd,
                                                      cvc_num,
                                                      cvc_lstope,
                                                      cvc_usuario,
                                                      cvc_fecsys,
                                                      cvc_numero_informe,
                                                      cvc_fecha_informe,
                                                      cvc_numero_vc,
                                                      cvc_fecha_vc,
                                                      cvc_tipo_rd,
                                                      cvc_gerencia_legal)
                          VALUES   (prm_id,
                                    prm_tipo_notificacion,
                                    TO_DATE (prm_fecha_notificacion,
                                             'dd/mm/yyyy'),
                                    TO_DATE (prm_fecha_presentacion,
                                             'dd/mm/yyyy'),
                                    prm_inf_descargo,
                                    TO_DATE (prm_fecha_descargo,
                                             'dd/mm/yyyy'),
                                    prm_rd_final,
                                    TO_DATE (prm_fecha_not_rd_final,
                                             'dd/mm/yyyy'),
                                    prm_ci_remision,
                                    TO_DATE (prm_fecha_ci_remision,
                                             'dd/mm/yyyy'),
                                    prm_numero_rd,
                                    TO_DATE (prm_fecha_rd, 'dd/mm/yyyy'),
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_numero_informe,
                                    TO_DATE (prm_fecha_informe, 'dd/mm/yyyy'),
                                    prm_numero_vc,
                                    TO_DATE (prm_fecha_vc, 'dd/mm/yyyy'),
                                    prm_tipo_rd,
                                    prm_gerencia_legal);

                        IF prm_tipo_grabado = 'CONCLUIR'
                        THEN
                            SELECT   COUNT (1)
                              INTO   existe
                              FROM   fis_conclusion a
                             WHERE       a.ctl_control_id = prm_id
                                     AND a.con_num = 0
                                     AND a.con_lstope = 'U';

                            IF existe = 0
                            THEN
                                INSERT INTO fis_conclusion
                                  VALUES   (prm_id,
                                            'VISTA DE CARGO',
                                            prm_numero_vc,
                                            TO_DATE (prm_fecha_vc,
                                                     'dd/mm/yyyy'),
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE);
                            END IF;
                        END IF;

                        COMMIT;
                        RETURN 'CORRECTOSE REGISTR&Oacute; CORRECTAMENTE LA VISTA DE CARGO';
                    ELSE
                        SELECT   COUNT (1)
                          INTO   existe
                          FROM   fis_con_viscargo a
                         WHERE   a.ctl_control_id = prm_id;

                        UPDATE   fis_con_viscargo
                           SET   cvc_num = existe
                         WHERE   ctl_control_id = prm_id AND cvc_num = 0;

                        INSERT INTO fis_con_viscargo (ctl_control_id,
                                                      cvc_tipo_notificacion,
                                                      cvc_fecha_notificacion,
                                                      cvc_fecha_presentacion,
                                                      cvc_inf_descargo,
                                                      cvc_fecha_descargo,
                                                      cvc_rd_final,
                                                      cvc_fecha_not_rd_final,
                                                      cvc_ci_remision,
                                                      cvc_fecha_ci_remision,
                                                      cvc_numero_rd,
                                                      cvc_fecha_rd,
                                                      cvc_num,
                                                      cvc_lstope,
                                                      cvc_usuario,
                                                      cvc_fecsys,
                                                      cvc_numero_informe,
                                                      cvc_fecha_informe,
                                                      cvc_numero_vc,
                                                      cvc_fecha_vc,
                                                      cvc_tipo_rd,
                                                      cvc_gerencia_legal)
                          VALUES   (prm_id,
                                    prm_tipo_notificacion,
                                    TO_DATE (prm_fecha_notificacion,
                                             'dd/mm/yyyy'),
                                    TO_DATE (prm_fecha_presentacion,
                                             'dd/mm/yyyy'),
                                    prm_inf_descargo,
                                    TO_DATE (prm_fecha_descargo,
                                             'dd/mm/yyyy'),
                                    prm_rd_final,
                                    TO_DATE (prm_fecha_not_rd_final,
                                             'dd/mm/yyyy'),
                                    prm_ci_remision,
                                    TO_DATE (prm_fecha_ci_remision,
                                             'dd/mm/yyyy'),
                                    prm_numero_rd,
                                    TO_DATE (prm_fecha_rd, 'dd/mm/yyyy'),
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_numero_informe,
                                    TO_DATE (prm_fecha_informe, 'dd/mm/yyyy'),
                                    prm_numero_vc,
                                    TO_DATE (prm_fecha_vc, 'dd/mm/yyyy'),
                                    prm_tipo_rd,
                                    prm_gerencia_legal);

                        IF prm_tipo_grabado = 'CONCLUIR'
                        THEN
                            SELECT   COUNT (1)
                              INTO   existe
                              FROM   fis_conclusion a
                             WHERE       a.ctl_control_id = prm_id
                                     AND a.con_num = 0
                                     AND a.con_lstope = 'U';

                            IF existe = 0
                            THEN
                                INSERT INTO fis_conclusion
                                  VALUES   (prm_id,
                                            'VISTA DE CARGO',
                                            prm_numero_vc,
                                            TO_DATE (prm_fecha_vc,
                                                     'dd/mm/yyyy'),
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE);
                            END IF;
                        END IF;

                        RETURN 'CORRECTOSE MODIFICO CORRECTAMENTE LA VISTA DE CARGO';
                    END IF;
                END IF;
            END IF;
        END IF;

        IF estado = 'CONCLUIDO'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_con_viscargo a
             WHERE       a.ctl_control_id = prm_id
                     AND a.cvc_num = 0
                     AND a.cvc_lstope = 'U';

            IF existe = 0
            THEN
                RETURN 'NO TIENE REGISTR&Oacute; DE VISTA DE CARGO';
            ELSE
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_con_viscargo a
                 WHERE   a.ctl_control_id = prm_id;

                UPDATE   fis_con_viscargo
                   SET   cvc_num = existe
                 WHERE   ctl_control_id = prm_id AND cvc_num = 0;



                INSERT INTO fis_con_viscargo (ctl_control_id,
                                              cvc_tipo_notificacion,
                                              cvc_fecha_notificacion,
                                              cvc_fecha_presentacion,
                                              cvc_inf_descargo,
                                              cvc_fecha_descargo,
                                              cvc_rd_final,
                                              cvc_fecha_not_rd_final,
                                              cvc_ci_remision,
                                              cvc_fecha_ci_remision,
                                              cvc_numero_rd,
                                              cvc_fecha_rd,
                                              cvc_num,
                                              cvc_lstope,
                                              cvc_usuario,
                                              cvc_fecsys,
                                              cvc_numero_informe,
                                              cvc_fecha_informe,
                                              cvc_numero_vc,
                                              cvc_fecha_vc,
                                              cvc_tipo_rd,
                                              cvc_gerencia_legal)
                    SELECT   prm_id,
                             a.cvc_tipo_notificacion,
                             a.cvc_fecha_notificacion,
                             a.cvc_fecha_presentacion,
                             a.cvc_inf_descargo,
                             a.cvc_fecha_descargo,
                             a.cvc_rd_final,
                             a.cvc_fecha_not_rd_final,
                             a.cvc_ci_remision,
                             a.cvc_fecha_ci_remision,
                             prm_numero_rd,
                             TO_DATE (prm_fecha_rd, 'dd/mm/yyyy'),
                             0,
                             'U',
                             prm_usuario,
                             SYSDATE,
                             a.cvc_numero_informe,
                             a.cvc_fecha_informe,
                             a.cvc_numero_vc,
                             a.cvc_fecha_vc,
                             prm_tipo_rd,
                             a.cvc_gerencia_legal
                      FROM   fis_con_viscargo a
                     WHERE       ctl_control_id = prm_id
                             AND cvc_num = existe
                             AND ROWNUM = 1;

                RETURN 'CORRECTOSE REGISTR&Oacute; CORRECTAMENTE LA VISTA DE CARGO';
            END IF;
        ELSE
            RETURN 'LA FISCALIZACI&Oacute;N NO SE ENCUENTRA EN EL ESTADO CORRECTO';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;



    FUNCTION devuelve_con_resdeter (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT   ctl_control_id,
                     crd_rd_final,
                     TO_CHAR (a.crd_fecha_not_rd_final, 'dd/mm/yyyy'),
                     crd_num,
                     crd_lstope,
                     crd_usuario,
                     TO_CHAR (a.crd_fecsys, 'dd/mm/yyyy'),
                     crd_numero_informe,
                     TO_CHAR (crd_fecha_informe, 'dd/mm/yyyy')
              FROM   fis_con_resdeter a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.crd_num = 0
                     AND a.crd_lstope = 'U';

        RETURN ct;
    END;

    FUNCTION graba_con_resdeter (prm_id                    VARCHAR2,
                                 prm_rd_final              VARCHAR2,
                                 prm_fecha_not_rd_final    VARCHAR2,
                                 prm_usuario               VARCHAR2,
                                 prm_numero_informe        VARCHAR2,
                                 prm_fecha_informe         VARCHAR2,
                                 prm_tipo_grabado          VARCHAR2)
        RETURN VARCHAR2
    IS
        res           VARCHAR2 (300) := 0;
        existe        NUMBER;
        v_gestion     VARCHAR2 (4);
        v_numero      NUMBER;
        estado        VARCHAR2 (30);
        doc_con       VARCHAR2 (100) := '';
        doc_con_num   VARCHAR2 (30) := '';
        doc_con_fec   VARCHAR2 (30) := '';
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_conclusion a
         WHERE       a.ctl_control_id = prm_id
                 AND a.con_num = 0
                 AND a.con_lstope = 'U';

        IF existe = 1
        THEN
            SELECT   a.con_tipo_doc_con
              INTO   doc_con
              FROM   fis_conclusion a
             WHERE       a.ctl_control_id = prm_id
                     AND a.con_num = 0
                     AND a.con_lstope = 'U';

            IF doc_con =
                   'RESOLUCION DETERMINATIVA FINAL Y SIN VISTA DE CARGO'
            THEN
                SELECT   a.crd_rd_final,
                         TO_CHAR (a.crd_fecha_not_rd_final, 'dd/mm/yyyy')
                  INTO   doc_con_num, doc_con_fec
                  FROM   fis_con_resdeter a
                 WHERE       a.crd_num = 0
                         AND a.crd_lstope = 'U'
                         AND a.ctl_control_id = prm_id;

                IF NOT (prm_rd_final = doc_con_num
                        AND prm_fecha_not_rd_final = doc_con_fec)
                THEN
                    RETURN 'NO SE PUEDE MODIFICAR EL NUMERO O LA FECHA DE LA RESOLUCI&Oacute;N DETERMINATIVA, PORQUE YA FUE REGISTRADA COMO DOCUMENTO DE CONCLUSI&Oacute;N.';
                END IF;
            END IF;
        END IF;

        SELECT   est_estado
          INTO   estado
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_id
                 AND a.est_num = 0
                 AND a.est_lstope = 'U';

        IF estado = 'REGISTRADO'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_con_resdeter a
             WHERE       NOT a.ctl_control_id = prm_id
                     AND a.crd_numero_informe = prm_numero_informe
                     AND NOT prm_numero_informe IS NULL
                     AND a.crd_num = 0
                     AND a.crd_lstope = 'U';

            IF existe > 0
            THEN
                RETURN    'El n&uacute;mero de informe '
                       || prm_numero_informe
                       || ' se encuentra duplicado en otra orden';
            ELSE
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_con_resdeter a
                 WHERE       NOT a.ctl_control_id = prm_id
                         AND a.crd_rd_final = prm_rd_final
                         AND NOT prm_rd_final IS NULL
                         AND a.crd_num = 0
                         AND a.crd_lstope = 'U';

                IF existe > 0
                THEN
                    RETURN 'El n&uacute;mero de Resoluci&oacute;n Determinativa Final '
                           || prm_rd_final
                           || ' se encuentra duplicado en otra orden';
                ELSE
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_con_resdeter a
                     WHERE       a.ctl_control_id = prm_id
                             AND a.crd_num = 0
                             AND a.crd_lstope = 'U';

                    IF existe = 0
                    THEN
                        INSERT INTO fis_con_resdeter (ctl_control_id,
                                                      crd_rd_final,
                                                      crd_fecha_not_rd_final,
                                                      crd_num,
                                                      crd_lstope,
                                                      crd_usuario,
                                                      crd_fecsys,
                                                      crd_numero_informe,
                                                      crd_fecha_informe)
                          VALUES   (prm_id,
                                    prm_rd_final,
                                    TO_DATE (prm_fecha_not_rd_final,
                                             'dd/mm/yyyy'),
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_numero_informe,
                                    TO_DATE (prm_fecha_informe, 'dd/mm/yyyy'));

                        IF prm_tipo_grabado = 'CONCLUIR'
                        THEN
                            SELECT   COUNT (1)
                              INTO   existe
                              FROM   fis_conclusion a
                             WHERE       a.ctl_control_id = prm_id
                                     AND a.con_num = 0
                                     AND a.con_lstope = 'U';

                            IF existe = 0
                            THEN
                                INSERT INTO fis_conclusion
                                  VALUES   (prm_id,
                                            'RESOLUCION DETERMINATIVA FINAL Y SIN VISTA DE CARGO',
                                            prm_rd_final,
                                            TO_DATE (prm_fecha_not_rd_final,
                                                     'dd/mm/yyyy'),
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE);
                            END IF;
                        END IF;

                        COMMIT;
                        RETURN 'CORRECTOSE REGISTR&Oacute; CORRECTAMENTE LA RESOLUCI&Oacute;N DETERMINATIVA FINAL Y SIN VISTA DE CARGO';
                    ELSE
                        SELECT   COUNT (1)
                          INTO   existe
                          FROM   fis_con_resdeter a
                         WHERE   a.ctl_control_id = prm_id;

                        UPDATE   fis_con_resdeter
                           SET   crd_num = existe
                         WHERE   ctl_control_id = prm_id AND crd_num = 0;

                        INSERT INTO fis_con_resdeter (ctl_control_id,
                                                      crd_rd_final,
                                                      crd_fecha_not_rd_final,
                                                      crd_num,
                                                      crd_lstope,
                                                      crd_usuario,
                                                      crd_fecsys,
                                                      crd_numero_informe,
                                                      crd_fecha_informe)
                          VALUES   (prm_id,
                                    prm_rd_final,
                                    TO_DATE (prm_fecha_not_rd_final,
                                             'dd/mm/yyyy'),
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_numero_informe,
                                    TO_DATE (prm_fecha_informe, 'dd/mm/yyyy'));

                        IF prm_tipo_grabado = 'CONCLUIR'
                        THEN
                            SELECT   COUNT (1)
                              INTO   existe
                              FROM   fis_conclusion a
                             WHERE       a.ctl_control_id = prm_id
                                     AND a.con_num = 0
                                     AND a.con_lstope = 'U';

                            IF existe = 0
                            THEN
                                INSERT INTO fis_conclusion
                                  VALUES   (prm_id,
                                            'RESOLUCION DETERMINATIVA FINAL Y SIN VISTA DE CARGO',
                                            prm_rd_final,
                                            TO_DATE (prm_fecha_not_rd_final,
                                                     'dd/mm/yyyy'),
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE);
                            END IF;
                        END IF;

                        RETURN 'CORRECTOSE MODIFIC&Oacute; CORRECTAMENTE LA RESOLUCI&Oacute;N DETERMINATIVA FINAL Y SIN VISTA DE CARGO';
                    END IF;
                END IF;
            END IF;
        ELSE
            RETURN 'LA FISCALIZACI&Oacute;N NO SE ENCUENTRA EN EL ESTADO CORRECTO';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;



    FUNCTION devuelve_con_actainter (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT   ctl_control_id,
                     cai_acta_interv,
                     TO_CHAR (a.cai_fecha_acta_interv, 'dd/mm/yyyy'),
                     cai_tipo_ilicito,
                     cai_ci_remision,
                     TO_CHAR (a.cai_fecha_ci_remision, 'dd/mm/yyyy'),
                     TO_CHAR (a.cai_fecha_pres_descargos, 'dd/mm/yyyy'),
                     cai_inf_descargo,
                     TO_CHAR (a.cai_fecha_inf_descargo, 'dd/mm/yyyy'),
                     cai_numero_rfs,
                     TO_CHAR (a.cai_fecha_rfs, 'dd/mm/yyyy'),
                     cai_numero_rs,
                     TO_CHAR (a.cai_fecha_rs, 'dd/mm/yyyy'),
                     cai_num,
                     cai_lstope,
                     cai_usuario,
                     TO_CHAR (a.cai_fecsys, 'dd/mm/yyyy'),
                     cai_numero_informe,
                     TO_CHAR (cai_fecha_informe, 'dd/mm/yyyy'),
                     cai_gerencia_legal,
                     TO_CHAR (a.cai_fecha_not_ai, 'dd/mm/yyyy'),
                     cai_tipo_not_ai,
                     cai_resultado_des,
                     cai_tipo_resolucion
              FROM   fis_con_actainter a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.cai_num = 0
                     AND a.cai_lstope = 'U';

        RETURN ct;
    END;

    FUNCTION graba_con_actainter (prm_id                      VARCHAR2,
                                  prm_acta_interv             VARCHAR2,
                                  prm_fecha_acta_interv       VARCHAR2,
                                  prm_tipo_ilicito            VARCHAR2,
                                  prm_ci_remision             VARCHAR2,
                                  prm_fecha_ci_remision       VARCHAR2,
                                  prm_fecha_pres_descargos    VARCHAR2,
                                  prm_inf_descargo            VARCHAR2,
                                  prm_fecha_inf_descargo      VARCHAR2,
                                  prm_numero_rfs              VARCHAR2,
                                  prm_fecha_rfs               VARCHAR2,
                                  prm_numero_rs               VARCHAR2,
                                  prm_fecha_rs                VARCHAR2,
                                  prm_usuario                 VARCHAR2,
                                  prm_numero_informe          VARCHAR2,
                                  prm_fecha_informe           VARCHAR2,
                                  prm_gerencia_legal          VARCHAR2,
                                  prm_fecha_not_ai            VARCHAR2,
                                  prm_tipo_not_ai             VARCHAR2,
                                  prm_resultado_des           VARCHAR2,
                                  prm_tipo_resolucion         VARCHAR2,
                                  prm_tipo_grabado            VARCHAR2)
        RETURN VARCHAR2
    IS
        res           VARCHAR2 (300) := 0;
        existe        NUMBER;
        v_gestion     VARCHAR2 (4);
        v_numero      NUMBER;
        estado        VARCHAR2 (30);
        doc_con       VARCHAR2 (100) := '';
        doc_con_num   VARCHAR2 (30) := '';
        doc_con_fec   VARCHAR2 (30) := '';
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_conclusion a
         WHERE       a.ctl_control_id = prm_id
                 AND a.con_num = 0
                 AND a.con_lstope = 'U';

        IF existe = 1
        THEN
            SELECT   a.con_tipo_doc_con
              INTO   doc_con
              FROM   fis_conclusion a
             WHERE       a.ctl_control_id = prm_id
                     AND a.con_num = 0
                     AND a.con_lstope = 'U';

            IF doc_con = 'ACTA DE INTERVENCION'
            THEN
                SELECT   a.cai_acta_interv,
                         TO_CHAR (a.cai_fecha_acta_interv, 'dd/mm/yyyy')
                  INTO   doc_con_num, doc_con_fec
                  FROM   fis_con_actainter a
                 WHERE       a.cai_num = 0
                         AND a.cai_lstope = 'U'
                         AND a.ctl_control_id = prm_id;

                IF NOT (prm_acta_interv = doc_con_num
                        AND prm_fecha_acta_interv = doc_con_fec)
                THEN
                    RETURN 'NO SE PUEDE MODIFICAR EL NUMERO O LA FECHA DEL ACTA DE INTERVENCION, PORQUE YA FUE REGISTRADA COMO DOCUMENTO DE CONCLUSION.';
                END IF;
            END IF;
        END IF;


        SELECT   est_estado
          INTO   estado
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_id
                 AND a.est_num = 0
                 AND a.est_lstope = 'U';

        IF estado = 'REGISTRADO'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_con_actainter a
             WHERE       NOT a.ctl_control_id = prm_id
                     AND a.cai_numero_informe = prm_numero_informe
                     AND NOT prm_numero_informe IS NULL
                     AND a.cai_num = 0
                     AND a.cai_lstope = 'U';

            IF existe > 0
            THEN
                RETURN    'El n&uacute;mero de informe '
                       || prm_numero_informe
                       || ' se encuentra duplicado en otra orden';
            ELSE
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_con_actainter a
                 WHERE       NOT a.ctl_control_id = prm_id
                         AND a.cai_acta_interv = prm_acta_interv
                         AND NOT prm_acta_interv IS NULL
                         AND a.cai_num = 0
                         AND a.cai_lstope = 'U';

                IF existe > 0
                THEN
                    RETURN 'El n&uacute;mero de Acta de Intervenci&oacute;n '
                           || prm_acta_interv
                           || ' se encuentra duplicado en otra orden';
                ELSE
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_con_actainter a
                     WHERE       a.ctl_control_id = prm_id
                             AND a.cai_num = 0
                             AND a.cai_lstope = 'U';

                    IF existe = 0
                    THEN
                        INSERT INTO fis_con_actainter (ctl_control_id,
                                                       cai_acta_interv,
                                                       cai_fecha_acta_interv,
                                                       cai_tipo_ilicito,
                                                       cai_ci_remision,
                                                       cai_fecha_ci_remision,
                                                       cai_fecha_pres_descargos,
                                                       cai_inf_descargo,
                                                       cai_fecha_inf_descargo,
                                                       cai_numero_rfs,
                                                       cai_fecha_rfs,
                                                       cai_numero_rs,
                                                       cai_fecha_rs,
                                                       cai_num,
                                                       cai_lstope,
                                                       cai_usuario,
                                                       cai_fecsys,
                                                       cai_numero_informe,
                                                       cai_fecha_informe,
                                                       cai_gerencia_legal,
                                                       cai_fecha_not_ai,
                                                       cai_tipo_not_ai,
                                                       cai_resultado_des,
                                                       cai_tipo_resolucion)
                          VALUES   (prm_id,
                                    prm_acta_interv,
                                    TO_DATE (prm_fecha_acta_interv,
                                             'dd/mm/yyyy'),
                                    prm_tipo_ilicito,
                                    prm_ci_remision,
                                    TO_DATE (prm_fecha_ci_remision,
                                             'dd/mm/yyyy'),
                                    TO_DATE (prm_fecha_pres_descargos,
                                             'dd/mm/yyyy'),
                                    prm_inf_descargo,
                                    TO_DATE (prm_fecha_inf_descargo,
                                             'dd/mm/yyyy'),
                                    prm_numero_rfs,
                                    TO_DATE (prm_fecha_rfs, 'dd/mm/yyyy'),
                                    prm_numero_rs,
                                    TO_DATE (prm_fecha_rs, 'dd/mm/yyyy'),
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_numero_informe,
                                    TO_DATE (prm_fecha_informe, 'dd/mm/yyyy'),
                                    prm_gerencia_legal,
                                    TO_DATE (prm_fecha_not_ai, 'dd/mm/yyyy'),
                                    prm_tipo_not_ai,
                                    prm_resultado_des,
                                    prm_tipo_resolucion);

                        IF prm_tipo_grabado = 'CONCLUIR'
                        THEN
                            SELECT   COUNT (1)
                              INTO   existe
                              FROM   fis_conclusion a
                             WHERE       a.ctl_control_id = prm_id
                                     AND a.con_num = 0
                                     AND a.con_lstope = 'U';

                            IF existe = 0
                            THEN
                                INSERT INTO fis_conclusion
                                  VALUES   (prm_id,
                                            'ACTA DE INTERVENCION',
                                            prm_acta_interv,
                                            TO_DATE (prm_fecha_acta_interv,
                                                     'dd/mm/yyyy'),
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE);
                            END IF;
                        END IF;

                        COMMIT;
                        RETURN 'CORRECTOSE REGISTR&Oacute; CORRECTAMENTE LA ACTA DE INTERVENCION';
                    ELSE
                        SELECT   COUNT (1)
                          INTO   existe
                          FROM   fis_con_actainter a
                         WHERE   a.ctl_control_id = prm_id;

                        UPDATE   fis_con_actainter
                           SET   cai_num = existe
                         WHERE   ctl_control_id = prm_id AND cai_num = 0;

                        INSERT INTO fis_con_actainter (ctl_control_id,
                                                       cai_acta_interv,
                                                       cai_fecha_acta_interv,
                                                       cai_tipo_ilicito,
                                                       cai_ci_remision,
                                                       cai_fecha_ci_remision,
                                                       cai_fecha_pres_descargos,
                                                       cai_inf_descargo,
                                                       cai_fecha_inf_descargo,
                                                       cai_numero_rfs,
                                                       cai_fecha_rfs,
                                                       cai_numero_rs,
                                                       cai_fecha_rs,
                                                       cai_num,
                                                       cai_lstope,
                                                       cai_usuario,
                                                       cai_fecsys,
                                                       cai_numero_informe,
                                                       cai_fecha_informe,
                                                       cai_gerencia_legal,
                                                       cai_fecha_not_ai,
                                                       cai_tipo_not_ai,
                                                       cai_resultado_des,
                                                       cai_tipo_resolucion)
                          VALUES   (prm_id,
                                    prm_acta_interv,
                                    TO_DATE (prm_fecha_acta_interv,
                                             'dd/mm/yyyy'),
                                    prm_tipo_ilicito,
                                    prm_ci_remision,
                                    TO_DATE (prm_fecha_ci_remision,
                                             'dd/mm/yyyy'),
                                    TO_DATE (prm_fecha_pres_descargos,
                                             'dd/mm/yyyy'),
                                    prm_inf_descargo,
                                    TO_DATE (prm_fecha_inf_descargo,
                                             'dd/mm/yyyy'),
                                    prm_numero_rfs,
                                    TO_DATE (prm_fecha_rfs, 'dd/mm/yyyy'),
                                    prm_numero_rs,
                                    TO_DATE (prm_fecha_rs, 'dd/mm/yyyy'),
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_numero_informe,
                                    TO_DATE (prm_fecha_informe, 'dd/mm/yyyy'),
                                    prm_gerencia_legal,
                                    TO_DATE (prm_fecha_not_ai, 'dd/mm/yyyy'),
                                    prm_tipo_not_ai,
                                    prm_resultado_des,
                                    prm_tipo_resolucion);

                        IF prm_tipo_grabado = 'CONCLUIR'
                        THEN
                            SELECT   COUNT (1)
                              INTO   existe
                              FROM   fis_conclusion a
                             WHERE       a.ctl_control_id = prm_id
                                     AND a.con_num = 0
                                     AND a.con_lstope = 'U';

                            IF existe = 0
                            THEN
                                INSERT INTO fis_conclusion
                                  VALUES   (prm_id,
                                            'ACTA DE INTERVENCION',
                                            prm_acta_interv,
                                            TO_DATE (prm_fecha_acta_interv,
                                                     'dd/mm/yyyy'),
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE);
                            END IF;
                        END IF;

                        RETURN 'CORRECTOSE MODIFICO CORRECTAMENTE LA ACTA DE INTERVENCION';
                    END IF;
                END IF;
            END IF;
        END IF;

        IF estado = 'CONCLUIDO'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_con_actainter a
             WHERE       a.ctl_control_id = prm_id
                     AND a.cai_num = 0
                     AND a.cai_lstope = 'U';

            IF existe = 0
            THEN
                RETURN 'NO TIENE REGISTR&Oacute; DE ACTA DE INTERVENCION';
            ELSE
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_con_actainter a
                 WHERE   a.ctl_control_id = prm_id;

                UPDATE   fis_con_actainter
                   SET   cai_num = existe
                 WHERE   ctl_control_id = prm_id AND cai_num = 0;

                INSERT INTO fis_con_actainter (ctl_control_id,
                                               cai_acta_interv,
                                               cai_fecha_acta_interv,
                                               cai_tipo_ilicito,
                                               cai_ci_remision,
                                               cai_fecha_ci_remision,
                                               cai_fecha_pres_descargos,
                                               cai_inf_descargo,
                                               cai_fecha_inf_descargo,
                                               cai_numero_rfs,
                                               cai_fecha_rfs,
                                               cai_numero_rs,
                                               cai_fecha_rs,
                                               cai_num,
                                               cai_lstope,
                                               cai_usuario,
                                               cai_fecsys,
                                               cai_numero_informe,
                                               cai_fecha_informe,
                                               cai_gerencia_legal,
                                               cai_fecha_not_ai,
                                               cai_tipo_not_ai,
                                               cai_resultado_des,
                                               cai_tipo_resolucion)
                    SELECT   prm_id,
                             a.cai_acta_interv,
                             a.cai_fecha_acta_interv,
                             a.cai_tipo_ilicito,
                             a.cai_ci_remision,
                             a.cai_fecha_ci_remision,
                             TO_DATE (prm_fecha_pres_descargos, 'dd/mm/yyyy'),
                             prm_inf_descargo,
                             TO_DATE (prm_fecha_inf_descargo, 'dd/mm/yyyy'),
                             prm_numero_rfs,
                             TO_DATE (prm_fecha_rfs, 'dd/mm/yyyy'),
                             prm_numero_rs,
                             TO_DATE (prm_fecha_rs, 'dd/mm/yyyy'),
                             0,
                             'U',
                             prm_usuario,
                             SYSDATE,
                             a.cai_numero_informe,
                             a.cai_fecha_informe,
                             a.cai_gerencia_legal,
                             a.cai_fecha_not_ai,
                             a.cai_tipo_not_ai,
                             prm_resultado_des,
                             prm_tipo_resolucion
                      FROM   fis_con_actainter a
                     WHERE       ctl_control_id = prm_id
                             AND cai_num = existe
                             AND ROWNUM = 1;

                RETURN 'CORRECTOSE REGISTR&Oacute; CORRECTAMENTE LA ACTA DE INTERVENCION';
            END IF;
        ELSE
            RETURN 'LA FISCALIZACI&Oacute;N NO SE ENCUENTRA EN EL ESTADO CORRECTO';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION devuelve_paneles (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct       cursortype;
        panel1   NUMBER;
        panel2   NUMBER;
        panel3   NUMBER;
        panel4   NUMBER;
        panel5   NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   panel1
          FROM   fis_con_viscargo a
         WHERE       a.cvc_num = 0
                 AND a.cvc_lstope = 'U'
                 AND a.ctl_control_id = prm_codigo;

        SELECT   COUNT (1)
          INTO   panel2
          FROM   fis_con_resdeter a
         WHERE       a.crd_num = 0
                 AND a.crd_lstope = 'U'
                 AND a.ctl_control_id = prm_codigo;

        SELECT   COUNT (1)
          INTO   panel3
          FROM   fis_con_actainter a
         WHERE       a.cai_num = 0
                 AND a.cai_lstope = 'U'
                 AND a.ctl_control_id = prm_codigo;

        SELECT   COUNT (1)
          INTO   panel4
          FROM   fis_con_resadmin a
         WHERE       a.cra_num = 0
                 AND a.cra_lstope = 'U'
                 AND a.ctl_control_id = prm_codigo;

        SELECT   COUNT (1)
          INTO   panel5
          FROM   fis_con_autoinicial a
         WHERE       a.cas_num = 0
                 AND a.cas_lstope = 'U'
                 AND a.ctl_control_id = prm_codigo;



        OPEN ct FOR
            SELECT   panel1,
                     panel2,
                     panel3,
                     panel4,
                     panel5
              FROM   DUAL;

        RETURN ct;
    END;

    FUNCTION graba_conclusionfis (prm_codigo    IN VARCHAR2,
                                  prm_usuario   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        existe   NUMBER;
        cont     NUMBER := 0;
        estado   VARCHAR2 (30);
    BEGIN
        SELECT   est_estado
          INTO   estado
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.est_num = 0
                 AND a.est_lstope = 'U';

        IF estado = 'REGISTRADO'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_estado a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.est_num = 0
                     AND a.est_lstope = 'U'
                     AND est_estado = 'REGISTRADO';

            IF existe = 0
            THEN
                RETURN 'EL CONTROL NO ESTA EN ESTADO REGISTRADO';
            END IF;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_con_viscargo a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.cvc_num = 0
                     AND a.cvc_lstope = 'U';

            IF existe > 0
            THEN
                cont := cont + 1;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_con_viscargo a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.cvc_num = 0
                         AND a.cvc_lstope = 'U'
                         AND NOT a.cvc_tipo_notificacion IS NULL
                         AND NOT a.cvc_fecha_notificacion IS NULL
                         AND NOT a.cvc_fecha_presentacion IS NULL
                         AND NOT a.cvc_inf_descargo IS NULL
                         AND NOT a.cvc_fecha_descargo IS NULL
                         AND NOT a.cvc_ci_remision IS NULL
                         AND NOT a.cvc_fecha_ci_remision IS NULL
                         AND NOT a.cvc_numero_informe IS NULL
                         AND NOT a.cvc_fecha_informe IS NULL
                         AND NOT a.cvc_numero_vc IS NULL
                         AND NOT a.cvc_fecha_vc IS NULL
                         AND NOT a.cvc_gerencia_legal IS NULL;

                IF existe = 0
                THEN
                    RETURN 'DEBE COMPLETAR EL LLENADO DE LA INFORMACI&Oacute;N DE LA VISTA DE CARGO REGISTRADA';
                END IF;
            END IF;


            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_con_resdeter a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.crd_num = 0
                     AND a.crd_lstope = 'U';

            IF existe > 0
            THEN
                cont := cont + 1;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_con_resdeter a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.crd_num = 0
                         AND a.crd_lstope = 'U'
                         AND NOT a.crd_rd_final IS NULL
                         AND NOT a.crd_fecha_not_rd_final IS NULL
                         AND NOT a.crd_numero_informe IS NULL
                         AND NOT a.crd_fecha_informe IS NULL;

                IF existe = 0
                THEN
                    RETURN 'DEBE COMPLETAR EL LLENADO DE LA INFORMACI&Oacute;N DE LA RESOLUCI&Oacute;N DETERMINATIVA FINAL SIN VISTA DE CARGO REGISTRADA';
                END IF;
            END IF;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_con_actainter a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.cai_num = 0
                     AND a.cai_lstope = 'U';

            IF existe > 0
            THEN
                cont := cont + 1;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_con_actainter a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.cai_num = 0
                         AND a.cai_lstope = 'U'
                         AND NOT a.cai_acta_interv IS NULL
                         AND NOT a.cai_fecha_acta_interv IS NULL
                         AND NOT a.cai_tipo_ilicito = '-'
                         AND NOT a.cai_ci_remision IS NULL
                         AND NOT a.cai_fecha_ci_remision IS NULL
                         AND NOT cai_numero_informe IS NULL
                         AND NOT cai_fecha_informe IS NULL
                         AND NOT cai_gerencia_legal IS NULL
                         AND NOT cai_fecha_not_ai IS NULL
                         AND NOT cai_tipo_not_ai IS NULL;

                /*AND NOT a.cai_fecha_pres_descargos IS NULL
                AND NOT a.cai_inf_descargo IS NULL
                AND NOT a.cai_fecha_inf_descargo IS NULL
                AND NOT a.cai_numero_rfs IS NULL
                AND NOT a.cai_fecha_rfs IS NULL
                AND NOT a.cai_numero_rs IS NULL
                AND NOT a.cai_fecha_rs IS NULL;*/

                IF existe = 0
                THEN
                    RETURN 'DEBE COMPLETAR EL LLENADO DE LA INFORMACI&Oacute;N DEL ACTA DE INTERVENCI&Oacute;N REGISTRADA';
                END IF;
            END IF;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_con_resadmin a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.cra_num = 0
                     AND a.cra_lstope = 'U';

            IF existe > 0
            THEN
                cont := cont + 1;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_con_resadmin a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.cra_num = 0
                         AND a.cra_lstope = 'U'
                         AND NOT a.cra_fecha_pago_cuini IS NULL
                         AND NOT a.cra_monto_pago_cuoini IS NULL
                         AND NOT a.cra_numero_ra IS NULL
                         AND NOT a.cra_fecha_ra IS NULL
                         AND NOT a.cra_ci_remision_set IS NULL
                         AND NOT a.cra_fecha_remision_set IS NULL
                         AND NOT a.cra_saldo_por_cobrar IS NULL
                         AND NOT a.cra_numero_informe IS NULL
                         AND NOT a.cra_fecha_informe IS NULL
                         AND NOT a.cra_rup_gestion IS NULL
                         AND NOT a.cra_rup_aduana IS NULL
                         AND NOT a.cra_rup_numero IS NULL
                         AND NOT a.cra_gerencia_legal IS NULL;

                IF existe = 0
                THEN
                    RETURN 'DEBE COMPLETAR EL LLENADO DE LA INFORMACI&Oacute;N DE LA RESOLUCI&Oacute;N ADMINISTRATIVA Y DETERMINATIVA DE FACILIDADES DE PAGO REGISTRADA';
                END IF;
            END IF;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_con_autoinicial a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.cas_num = 0
                     AND a.cas_lstope = 'U';

            IF existe > 0
            THEN
                cont := cont + 1;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_con_autoinicial a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.cas_num = 0
                         AND a.cas_lstope = 'U'
                         AND NOT a.cas_numero_aisc IS NULL
                         AND NOT a.cas_fecha_notificacion IS NULL
                         AND NOT a.cas_fecha_pres_descargos IS NULL
                         AND NOT a.cas_inf_descargo IS NULL
                         AND NOT a.cas_fecha_inf_descargo IS NULL
                         AND NOT a.cas_numero_rfs IS NULL
                         AND NOT a.cas_fecha_rfs IS NULL
                         AND NOT a.cas_ci_remision_gr IS NULL
                         AND NOT a.cas_fecha_ci IS NULL
                         AND NOT a.cas_numero_informe IS NULL
                         AND NOT a.cas_fecha_informe IS NULL
                         AND NOT a.cas_gerencia_legal IS NULL;

                IF existe = 0
                THEN
                    RETURN 'DEBE COMPLETAR EL LLENADO DE LA INFORMACI&Oacute;N DEL AUTO INICIAL DE SUMARIO CONTRAVENCIONAL REGISTRADO';
                END IF;
            END IF;

            IF cont = 0
            THEN
                RETURN 'DEBE LLENAR POR LO MENOS UNO DE LOS DOCUMENTOS DE CONCLUSION';
            END IF;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_estado a
             WHERE   a.ctl_control_id = prm_codigo;

            UPDATE   fis_estado
               SET   est_num = existe
             WHERE   ctl_control_id = prm_codigo AND est_num = 0;

            INSERT INTO fis_estado (ctl_control_id,
                                    est_estado,
                                    est_num,
                                    est_lstope,
                                    est_usuario,
                                    est_fecsys)
              VALUES   (prm_codigo,
                        'CONCLUIDO',
                        0,
                        'U',
                        prm_usuario,
                        SYSDATE);

            RETURN 'CORRECTOSE REGISTR&Oacute; CORRECTAMENTE LA CONCLUSI&Oacute;N DE LA FISCALIZACI&Oacute;N';
        ELSE
            IF estado = 'CONCLUIDO'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_con_viscargo a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.cvc_num = 0
                         AND a.cvc_lstope = 'U';

                IF existe > 0
                THEN
                    cont := cont + 1;

                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_con_viscargo a
                     WHERE       a.ctl_control_id = prm_codigo
                             AND a.cvc_num = 0
                             AND a.cvc_lstope = 'U'
                             AND NOT a.cvc_numero_rd IS NULL
                             AND NOT a.cvc_fecha_rd IS NULL
                             AND NOT a.cvc_tipo_rd IS NULL;

                    IF existe = 0
                    THEN
                        RETURN 'DEBE COMPLETAR EL LLENADO DE LA INFORMACI&Oacute;N DE LA VISTA DE CARGO REGISTRADA';
                    END IF;
                END IF;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_con_actainter a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.cai_num = 0
                         AND a.cai_lstope = 'U';

                IF existe > 0
                THEN
                    cont := cont + 1;

                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_con_actainter a
                     WHERE       a.ctl_control_id = prm_codigo
                             AND a.cai_num = 0
                             AND a.cai_lstope = 'U'
                             AND NOT a.cai_fecha_pres_descargos IS NULL
                             AND NOT a.cai_inf_descargo IS NULL
                             AND NOT a.cai_fecha_inf_descargo IS NULL
                             AND NOT a.cai_resultado_des IS NULL
                             AND NOT a.cai_tipo_resolucion IS NULL
                             AND NOT a.cai_numero_rs IS NULL
                             AND NOT a.cai_fecha_rs IS NULL;

                    IF existe = 0
                    THEN
                        RETURN 'DEBE COMPLETAR EL LLENADO DE LA INFORMACI&Oacute;N DEL ACTA DE INTERVENCI&Oacute;N REGISTRADA';
                    END IF;
                END IF;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_con_autoinicial a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.cas_num = 0
                         AND a.cas_lstope = 'U';

                IF existe > 0
                THEN
                    cont := cont + 1;

                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_con_autoinicial a
                     WHERE       a.ctl_control_id = prm_codigo
                             AND a.cas_num = 0
                             AND a.cas_lstope = 'U'
                             AND NOT a.cas_numero_rs IS NULL
                             AND NOT a.cas_fecha_rs IS NULL;

                    IF existe = 0
                    THEN
                        RETURN 'DEBE COMPLETAR EL LLENADO DE LA INFORMACI&Oacute;N DEL AUTO INICIAL DE SUMARIO CONTRAVENCIONAL REGISTRADO';
                    END IF;
                END IF;

                IF cont = 0
                THEN
                    RETURN 'DEBE LLENAR POR LO MENOS UNO DE LOS DOCUMENTOS DE CONCLUSI&Oacute;N';
                END IF;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_estado a
                 WHERE   a.ctl_control_id = prm_codigo;

                UPDATE   fis_estado
                   SET   est_num = existe
                 WHERE   ctl_control_id = prm_codigo AND est_num = 0;

                INSERT INTO fis_estado (ctl_control_id,
                                        est_estado,
                                        est_num,
                                        est_lstope,
                                        est_usuario,
                                        est_fecsys)
                  VALUES   (prm_codigo,
                            'CONCLUIDO-LEGAL',
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE);

                RETURN 'CORRECTOSE REGISTR&Oacute; CORRECTAMENTE LA CONCLUSI&Oacute;N DE LA FISCALIZACI&Oacute;N POR LA UNIDAD LEGAL';
            ELSE
                RETURN 'LA FISCALIZACI&Oacute;N NO SE ENCUENTRA EN EL ESTADO CORRECTO';
            END IF;
        END IF;
    END;
END;
/


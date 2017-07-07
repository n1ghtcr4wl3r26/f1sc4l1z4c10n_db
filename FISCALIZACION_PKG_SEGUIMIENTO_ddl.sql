CREATE OR REPLACE 
PACKAGE pkg_seguimiento
/* Formatted on 24-nov.-2016 12:08:08 (QP5 v5.126) */
IS
    TYPE cursortype IS REF CURSOR;

    FUNCTION devuelve_fecha
        RETURN VARCHAR2;

    FUNCTION graba_notificacion (prm_id          VARCHAR2,
                                 prm_usuario     VARCHAR2,
                                 prm_fechanot    VARCHAR2,
                                 prm_tiponot     VARCHAR2,
                                 prm_obs         VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_resultados (prm_dui        VARCHAR2,
                               prm_item       VARCHAR2,
                               prm_partida    VARCHAR2,
                               prm_fob        VARCHAR2,
                               prm_flete      VARCHAR2,
                               prm_seguro     VARCHAR2,
                               prm_otros      VARCHAR2,
                               prm_cifusd     VARCHAR2,
                               prm_cifbob     VARCHAR2,
                               prm_contrav    VARCHAR2,
                               prm_ilicito    VARCHAR2,
                               prm_obs        VARCHAR2,
                               prm_usuario    VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_resultados2 (prm_dui        VARCHAR2,
                                prm_item       VARCHAR2,
                                prm_partida    VARCHAR2,
                                prm_fob        NUMBER,
                                prm_flete      NUMBER,
                                prm_seguro     NUMBER,
                                prm_otros      NUMBER,
                                prm_cifusd     NUMBER,
                                prm_cifbob     NUMBER,
                                prm_contrav    NUMBER,
                                prm_ilicito    VARCHAR2,
                                prm_obs        VARCHAR2,
                                prm_usuario    VARCHAR2,
                                prm_codigo     VARCHAR2,
                                prm_contravorden    NUMBER,
                                prm_idalcance       VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_resultadostram (prm_codigo       VARCHAR2,
                                   prm_idalcance    VARCHAR2,
                                   prm_mercancia    VARCHAR2,
                                   prm_fob          NUMBER,
                                   prm_flete        NUMBER,
                                   prm_seguro       NUMBER,
                                   prm_otros        NUMBER,
                                   prm_cifusd       NUMBER,
                                   prm_cifbob       NUMBER,
                                   prm_cifufv       NUMBER,
                                   prm_usuario      VARCHAR2,
                                   prm_ilicito      VARCHAR2,
                                   prm_contravorden NUMBER)
        RETURN VARCHAR2;

    FUNCTION graba_not_conclusion (prm_id          VARCHAR2,
                                   prm_usuario     VARCHAR2,
                                   prm_fechanot    VARCHAR2,
                                   prm_tiponot     VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_conclusion (prm_id                VARCHAR2,
                               prm_usuario           VARCHAR2,
                               prm_numero_informe    VARCHAR2,
                               prm_fecha_informe     VARCHAR2,
                               prm_tipo_doc_con      VARCHAR2,
                               prm_num_doc_con       VARCHAR2,
                               prm_fecha_doc_con     VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_hoja_trabajo (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION devuelve_hoja_trabajo_tramite (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION devuelve_hoja_trabajo_liq (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION devuelve_hoja_trabajoxls2 (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION devuelve_hoja_trabajoxls_cab (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION devuelve_hoja_trabajoxls (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION devuelve_notificacion (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION devuelve_not_conclusion (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION devuelve_conclusion (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION verifica_ampliacion_control (prm_codigo VARCHAR2)
        RETURN VARCHAR2;
END;
/

CREATE OR REPLACE 
PACKAGE BODY pkg_seguimiento
/* Formatted on 7-jul.-2017 14:48:37 (QP5 v5.126) */
IS
    FUNCTION devuelve_fecha
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (50);
    BEGIN
        SELECT   TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') INTO res FROM DUAL;

        RETURN res;
    END;

    FUNCTION graba_notificacion (prm_id          VARCHAR2,
                                 prm_usuario     VARCHAR2,
                                 prm_fechanot    VARCHAR2,
                                 prm_tiponot     VARCHAR2,
                                 prm_obs         VARCHAR2)
        RETURN VARCHAR2
    IS
        res         VARCHAR2 (300) := 0;
        existe      NUMBER;
        v_gestion   VARCHAR2 (4);
        v_numero    NUMBER;
        v_fecreg    DATE;
    BEGIN
        IF TO_DATE (prm_fechanot, 'dd/mm/yyyy') > TRUNC (SYSDATE)
        THEN
            RETURN 'La fecha de notificaci&oacute;n no puede ser mayor a la actual';
        ELSE
            v_fecreg :=
                TO_DATE (pkg_general.devuelve_fecha_registro (prm_id),
                         'dd/mm/yyyy');

            IF v_fecreg > TO_DATE (prm_fechanot, 'dd/mm/yyyy')
            THEN
                RETURN 'La fecha de notificaci&oacute;n no puede ser menor a la fecha de registro '
                       || TO_CHAR (v_fecreg, 'dd/mm/yyyy');
            ELSE
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_notificacion a
                 WHERE       a.ctl_control_id = prm_id
                         AND a.not_num = 0
                         AND a.not_lstope = 'U';

                IF existe = 0
                THEN
                    INSERT INTO fis_notificacion (ctl_control_id,
                                                  not_fecha_notificacion,
                                                  not_tipo_notificacion,
                                                  not_obs_notificacion,
                                                  not_num,
                                                  not_lstope,
                                                  not_usuario,
                                                  not_fecsys)
                      VALUES   (prm_id,
                                TO_DATE (prm_fechanot, 'dd/mm/yyyy'),
                                prm_tiponot,
                                prm_obs,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE);

                    COMMIT;
                    RETURN 'CORRECTOSe registr&oacute; correctamente la notificaci&oacute;n';
                ELSE
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_notificacion a
                     WHERE   a.ctl_control_id = prm_id;

                    UPDATE   fis_notificacion
                       SET   not_num = existe
                     WHERE   ctl_control_id = prm_id AND not_num = 0;

                    INSERT INTO fis_notificacion (ctl_control_id,
                                                  not_fecha_notificacion,
                                                  not_tipo_notificacion,
                                                  not_obs_notificacion,
                                                  not_num,
                                                  not_lstope,
                                                  not_usuario,
                                                  not_fecsys)
                      VALUES   (prm_id,
                                TO_DATE (prm_fechanot, 'dd/mm/yyyy'),
                                prm_tiponot,
                                prm_obs,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE);

                    RETURN 'CORRECTOSe modific&oacute; correctamente la notificaci&oacute;n';
                END IF;
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;


    FUNCTION graba_resultados (prm_dui        VARCHAR2,
                               prm_item       VARCHAR2,
                               prm_partida    VARCHAR2,
                               prm_fob        VARCHAR2,
                               prm_flete      VARCHAR2,
                               prm_seguro     VARCHAR2,
                               prm_otros      VARCHAR2,
                               prm_cifusd     VARCHAR2,
                               prm_cifbob     VARCHAR2,
                               prm_contrav    VARCHAR2,
                               prm_ilicito    VARCHAR2,
                               prm_obs        VARCHAR2,
                               prm_usuario    VARCHAR2)
        RETURN VARCHAR2
    IS
        res         VARCHAR2 (300) := 0;
        existe      NUMBER;
        v_gestion   VARCHAR2 (4);
        v_numero    VARCHAR2 (10);
    BEGIN
        v_numero := prm_item;

        SELECT   DECODE (INSTR (v_numero, '.'),
                         0, v_numero,
                         SUBSTR (v_numero, 0, INSTR (v_numero, '.') - 1))
          INTO   v_numero
          FROM   DUAL;

        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_resultados a
         WHERE       a.res_dui = prm_dui
                 AND a.res_numero_item = v_numero
                 AND a.res_num = 0
                 AND a.res_lstope = 'U';

        IF existe = 0
        THEN
            INSERT INTO fis_resultados (res_dui,
                                        res_numero_item,
                                        res_partida,
                                        res_fob_usd,
                                        res_flete_usd,
                                        res_seguro_usd,
                                        res_otros_usd,
                                        res_cif_usd,
                                        res_cif_bob,
                                        res_contrav,
                                        res_ilicito,
                                        res_observacion,
                                        res_num,
                                        res_lstope,
                                        res_usuario,
                                        res_fecsys)
              VALUES   (prm_dui,
                        v_numero,
                        NVL (prm_partida, '-'),
                        NVL (prm_fob, '0'),
                        NVL (prm_flete, '0'),
                        NVL (prm_seguro, '0'),
                        NVL (prm_otros, '0'),
                        NVL (prm_cifusd, '0'),
                        NVL (prm_cifbob, '0'),
                        prm_contrav,
                        prm_ilicito,
                        prm_obs,
                        0,
                        'U',
                        prm_usuario,
                        SYSDATE);

            COMMIT;
            RETURN 'CORRECTO';
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_resultados a
             WHERE   a.res_dui = prm_dui AND a.res_numero_item = v_numero;

            UPDATE   fis_resultados
               SET   res_num = existe
             WHERE       res_dui = prm_dui
                     AND res_numero_item = v_numero
                     AND res_num = 0;

            INSERT INTO fis_resultados (res_dui,
                                        res_numero_item,
                                        res_partida,
                                        res_fob_usd,
                                        res_flete_usd,
                                        res_seguro_usd,
                                        res_otros_usd,
                                        res_cif_usd,
                                        res_cif_bob,
                                        res_contrav,
                                        res_ilicito,
                                        res_observacion,
                                        res_num,
                                        res_lstope,
                                        res_usuario,
                                        res_fecsys)
              VALUES   (prm_dui,
                        v_numero,
                        NVL (prm_partida, '-'),
                        NVL (prm_fob, '0'),
                        NVL (prm_flete, '0'),
                        NVL (prm_seguro, '0'),
                        NVL (prm_otros, '0'),
                        NVL (prm_cifusd, '0'),
                        NVL (prm_cifbob, '0'),
                        prm_contrav,
                        prm_ilicito,
                        prm_obs,
                        0,
                        'U',
                        prm_usuario,
                        SYSDATE);

            RETURN 'CORRECTO';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_resultadostram (prm_codigo          VARCHAR2,
                                   prm_idalcance       VARCHAR2,
                                   prm_mercancia       VARCHAR2,
                                   prm_fob             NUMBER,
                                   prm_flete           NUMBER,
                                   prm_seguro          NUMBER,
                                   prm_otros           NUMBER,
                                   prm_cifusd          NUMBER,
                                   prm_cifbob          NUMBER,
                                   prm_cifufv          NUMBER,
                                   prm_usuario         VARCHAR2,
                                   prm_ilicito         VARCHAR2,
                                   prm_contravorden    NUMBER)
        RETURN VARCHAR2
    IS
        res         VARCHAR2 (300) := 0;
        existe      NUMBER;
        v_gestion   VARCHAR2 (4);
        v_numero    VARCHAR2 (10);

        v_alcance   NUMBER (18);
        v_tipo      VARCHAR2 (30);
    BEGIN
        IF    prm_fob < -1
           OR prm_flete < -1
           OR prm_seguro < -1
           OR prm_otros < -1
           OR prm_cifusd < -1
           OR prm_cifbob < -1
           OR prm_cifufv < -1
           OR prm_contravorden < -1
        THEN
            RETURN 'no puede tener valores negativos';
        END IF;

        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_alcance a
         WHERE       a.alc_num = 0
                 AND a.alc_lstope = 'U'
                 AND a.alc_alcance_id = prm_idalcance;

        IF existe = 0
        THEN
            RETURN 'no existe el tr&aacute;mite';
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_alcance a
             WHERE       a.alc_num = 0
                     AND a.alc_lstope = 'U'
                     AND a.alc_alcance_id = prm_idalcance
                     AND a.ctl_control_id = prm_codigo;

            IF existe = 0
            THEN
                RETURN 'no se encuentra registrada en el control';
            ELSE
                /*
                IF     NOT prm_ilicito IS NULL
                   AND NOT prm_ilicito = 'CONTRABANDO CONTRAVENCIONAL'
                   AND NOT prm_ilicito = 'CONTRABANDO DELITO'
                   AND NOT prm_ilicito = 'OTROS DELITOS'
                THEN
                    RETURN 'en el campo il&iacute;cito solo se deben colocar los siguientes valores "CONTRABANDO CONTRAVENCIONAL", "CONTRABANDO DELITO", "OTROS DELITOS" o se debe dejar vac&iacute;o';
                ELSE
                */
                IF     NOT prm_ilicito IS NULL
                   AND NOT prm_ilicito = 'CA DUI'
                   AND NOT prm_ilicito = 'CAO'
                   AND NOT prm_ilicito = 'OP'
                   AND NOT prm_ilicito = 'CC'
                   AND NOT prm_ilicito = 'CD'
                   AND NOT prm_ilicito = 'DF'
                   AND NOT prm_ilicito = 'OD'
                   AND NOT prm_ilicito = 'S/O'
                THEN
                    RETURN 'en el campo il&iacute;cito solo se deben colocar los siguientes valores "CA DUI" (Contravenci&oacute;n Aduanera relacionada con la DUI), "CAO" (Contravenci&oacute;n Aduanera relacionada con la Orden), "OP" (Omision de Pago), "CC" (Contrabando Contravencional), "CD" (Contrabando Delito), "DF" (Defraudaci&oacute;n), "OD" (Otros Delitos), "S/O" (Sin Observaci&oacute;n) o se debe dejar vac&iacute;o';
                ELSE
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_resultados_tramite a
                     WHERE       a.alc_alcance_id = prm_idalcance
                             AND a.ret_num = 0
                             AND a.ret_lstope = 'U';

                    IF existe = 0
                    THEN
                        INSERT INTO fis_resultados_tramite a (a.alc_alcance_id,
                                                              a.ret_mercancia,
                                                              a.ret_fob_usd,
                                                              a.ret_flete_usd,
                                                              a.ret_seguro_usd,
                                                              a.ret_otros_usd,
                                                              a.ret_cif_usd,
                                                              a.ret_cif_bob,
                                                              a.ret_cif_ufv,
                                                              a.ret_num,
                                                              a.ret_lstope,
                                                              a.ret_usuario,
                                                              a.ret_fecsys,
                                                              a.ret_ilicito,
                                                              a.ret_contravorden)
                          VALUES   (prm_idalcance,
                                    prm_mercancia,
                                    DECODE (prm_fob, '-1', NULL, prm_fob),
                                    DECODE (prm_flete, '-1', NULL, prm_flete),
                                    DECODE (prm_seguro,
                                            '-1', NULL,
                                            prm_seguro),
                                    DECODE (prm_otros, '-1', NULL, prm_otros),
                                    DECODE (prm_cifusd,
                                            '-1', NULL,
                                            prm_cifusd),
                                    DECODE (prm_cifbob,
                                            '-1', NULL,
                                            prm_cifbob),
                                    DECODE (prm_cifufv,
                                            '-1', NULL,
                                            prm_cifufv),
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_ilicito,
                                    DECODE (prm_contravorden,
                                            '-1', NULL,
                                            prm_contravorden));

                        COMMIT;
                        RETURN 'CORRECTO';
                    ELSE
                        SELECT   COUNT (1)
                          INTO   existe
                          FROM   fis_resultados_tramite a
                         WHERE   alc_alcance_id = prm_idalcance;

                        UPDATE   fis_resultados_tramite
                           SET   ret_num = existe
                         WHERE   alc_alcance_id = prm_idalcance
                                 AND ret_num = 0;

                        INSERT INTO fis_resultados_tramite a (a.alc_alcance_id,
                                                              a.ret_mercancia,
                                                              a.ret_fob_usd,
                                                              a.ret_flete_usd,
                                                              a.ret_seguro_usd,
                                                              a.ret_otros_usd,
                                                              a.ret_cif_usd,
                                                              a.ret_cif_bob,
                                                              a.ret_cif_ufv,
                                                              a.ret_num,
                                                              a.ret_lstope,
                                                              a.ret_usuario,
                                                              a.ret_fecsys,
                                                              a.ret_ilicito,
                                                              a.ret_contravorden)
                          VALUES   (prm_idalcance,
                                    prm_mercancia,
                                    DECODE (prm_fob, '-1', NULL, prm_fob),
                                    DECODE (prm_flete, '-1', NULL, prm_flete),
                                    DECODE (prm_seguro,
                                            '-1', NULL,
                                            prm_seguro),
                                    DECODE (prm_otros, '-1', NULL, prm_otros),
                                    DECODE (prm_cifusd,
                                            '-1', NULL,
                                            prm_cifusd),
                                    DECODE (prm_cifbob,
                                            '-1', NULL,
                                            prm_cifbob),
                                    DECODE (prm_cifufv,
                                            '-1', NULL,
                                            prm_cifufv),
                                    0,
                                    'U',
                                    prm_usuario,
                                    SYSDATE,
                                    prm_ilicito,
                                    prm_contravorden);

                        RETURN 'CORRECTO';
                    END IF;
                END IF;
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;



    FUNCTION graba_resultados2 (prm_dui             VARCHAR2,
                                prm_item            VARCHAR2,
                                prm_partida         VARCHAR2,
                                prm_fob             NUMBER,
                                prm_flete           NUMBER,
                                prm_seguro          NUMBER,
                                prm_otros           NUMBER,
                                prm_cifusd          NUMBER,
                                prm_cifbob          NUMBER,
                                prm_contrav         NUMBER,
                                prm_ilicito         VARCHAR2,
                                prm_obs             VARCHAR2,
                                prm_usuario         VARCHAR2,
                                prm_codigo          VARCHAR2,
                                prm_contravorden    NUMBER,
                                prm_idalcance       VARCHAR2)
        RETURN VARCHAR2
    IS
        res            VARCHAR2 (300) := 0;
        existe         NUMBER;
        v_gestion      VARCHAR2 (4);
        v_numero       VARCHAR2 (10);

        v_reg_year     VARCHAR2 (4);
        v_key_cuo      VARCHAR2 (3);
        v_reg_serial   VARCHAR (12);

        v_key_year     VARCHAR2 (4);
        v_key_dec      VARCHAR2 (17);
        v_key_nber     VARCHAR2 (13);

        v_alcance      NUMBER (18);
        v_tipo         VARCHAR2 (30);
        v_obs          VARCHAR2 (30);
    BEGIN
        IF NOT prm_obs IS NULL
        THEN
            v_obs := SUBSTR (prm_obs, 0, 30);

            SELECT   DECODE (INSTR (v_obs, '.0'),
                             0, v_obs,
                             REPLACE (v_obs, '.0'))
              INTO   v_obs
              FROM   DUAL;
        END IF;

        IF    prm_fob < -1
           OR prm_flete < -1
           OR prm_seguro < -1
           OR prm_otros < -1
           OR prm_cifusd < -1
           OR prm_cifbob < -1
           OR prm_contrav < -1
           OR prm_contravorden < -1
        THEN
            RETURN 'no puede tener valores negativos';
        END IF;

        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_alcance a
         WHERE       a.alc_num = 0
                 AND a.alc_lstope = 'U'
                 AND a.alc_alcance_id = prm_idalcance;

        IF existe = 0
        THEN
            RETURN 'no existe el tr&aacute;mite';
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_alcance a
             WHERE       a.alc_num = 0
                     AND a.alc_lstope = 'U'
                     AND a.alc_alcance_id = prm_idalcance
                     AND a.ctl_control_id = prm_codigo;

            IF existe = 0
            THEN
                RETURN 'no se encuentra registrada en el control';
            ELSE
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance_item a
                 WHERE       a.alc_alcance_id = prm_idalcance
                         AND a.ali_numero_item = prm_item
                         AND a.ali_num = 0
                         AND a.ali_lstope = 'U';

                IF existe = 0
                THEN
                    RETURN 'no se encuentra registrado el &iacute;tem en el control';
                ELSE
                    IF     NOT prm_ilicito IS NULL
                       AND NOT prm_ilicito = 'CA DUI'
                       AND NOT prm_ilicito = 'CAO'
                       AND NOT prm_ilicito = 'OP'
                       AND NOT prm_ilicito = 'CC'
                       AND NOT prm_ilicito = 'CD'
                       AND NOT prm_ilicito = 'DF'
                       AND NOT prm_ilicito = 'OD'
                       AND NOT prm_ilicito = 'S/O'
                    THEN
                        RETURN 'en el campo il&iacute;cito solo se deben colocar los siguientes valores "CA DUI" (Contravenci&oacute;n Aduanera relacionada con la DUI), "CAO" (Contravenci&oacute;n Aduanera relacionada con la Orden), "OP" (Omision de Pago), "CC" (Contrabando Contravencional), "CD" (Contrabando Delito), "DF" (Defraudaci&oacute;n), "OD" (Otros Delitos), "S/O" (Sin Observaci&oacute;n) o se debe dejar vac&iacute;o';
                    ELSE
                        IF     NOT v_obs IS NULL
                           AND NOT v_obs = '1'
                           AND NOT v_obs = '2'
                           AND NOT v_obs = '3'
                           AND NOT v_obs = '4'
                           AND NOT v_obs = '5'
                        THEN
                            RETURN 'en el campo observaci&oacute;n il&iacute;cito solo se deben colocar los siguientes valores "1" (Subvaluaci&oacute;n), "2" (Incorrecta Clasificaci&oacute;n Arancelaria), "3" (Desgravaci&oacute;n Arancelaria), "4" (Observaci&oacute;n a las Certificaciones y Autorizaciones), "5" (Otros) o se debe dejar vac&iacute;o';
                        ELSE
                            v_numero := prm_item;

                            SELECT   DECODE (
                                         INSTR (v_numero, '.'),
                                         0,
                                         v_numero,
                                         SUBSTR (v_numero,
                                                 0,
                                                 INSTR (v_numero, '.') - 1))
                              INTO   v_numero
                              FROM   DUAL;

                            SELECT   SUBSTR (prm_dui, 0, 4),
                                     SUBSTR (prm_dui, 6, 3),
                                     SUBSTR (prm_dui,
                                             12,
                                             LENGTH (prm_dui) - 11)
                              INTO   v_reg_year, v_key_cuo, v_reg_serial
                              FROM   DUAL;

                            SELECT   COUNT (1)
                              INTO   existe
                              FROM   ops$asy.sad_gen a
                             WHERE       a.sad_reg_year = v_reg_year
                                     AND a.key_cuo = v_key_cuo
                                     AND a.sad_reg_serial = 'C'
                                     AND a.sad_reg_nber = v_reg_serial
                                     AND a.sad_num = 0;

                            IF existe = 0
                            THEN
                                RETURN 'no existe la declaraci&oacute;n';
                            ELSE
                                SELECT   a.key_year,
                                         a.key_cuo,
                                         a.key_dec,
                                         a.key_nber
                                  INTO   v_key_year,
                                         v_key_cuo,
                                         v_key_dec,
                                         v_key_nber
                                  FROM   ops$asy.sad_gen a
                                 WHERE       a.sad_reg_year = v_reg_year
                                         AND a.key_cuo = v_key_cuo
                                         AND a.sad_reg_serial = 'C'
                                         AND a.sad_reg_nber = v_reg_serial
                                         AND a.sad_num = 0;


                                SELECT   COUNT (1)
                                  INTO   existe
                                  FROM   ops$asy.sad_itm a
                                 WHERE   a.key_year = v_key_year
                                         AND a.key_cuo = v_key_cuo
                                         AND NVL (a.key_dec, 0) =
                                                NVL (v_key_dec, 0)
                                         AND a.key_nber = v_key_nber
                                         AND a.itm_nber = v_numero;


                                IF existe = 0
                                THEN
                                    RETURN 'no existe el n&uacute;mero de item '
                                           || v_numero
                                           || ' en la declaraci&oacute;n';
                                ELSE
                                    SELECT   COUNT (1)
                                      INTO   existe
                                      FROM   fis_alcance a
                                     WHERE       alc_tipo_tramite = 'DUI'
                                             AND alc_gestion = v_reg_year
                                             AND alc_aduana = v_key_cuo
                                             AND alc_numero = v_reg_serial
                                             AND alc_num = 0
                                             AND alc_lstope = 'U'
                                             AND ctl_control_id = prm_codigo;

                                    IF existe = 0
                                    THEN
                                        RETURN 'no se encuentra registrada en el control '
                                               || v_reg_year
                                               || '/'
                                               || v_key_cuo
                                               || '/C-'
                                               || v_reg_serial
                                               || ' - '
                                               || prm_codigo;
                                    ELSE
                                        SELECT   alc_alcance_id,
                                                 alc_tipo_alcance
                                          INTO   v_alcance, v_tipo
                                          FROM   fis_alcance a
                                         WHERE       alc_tipo_tramite = 'DUI'
                                                 AND alc_gestion = v_reg_year
                                                 AND alc_aduana = v_key_cuo
                                                 AND alc_numero =
                                                        v_reg_serial
                                                 AND alc_num = 0
                                                 AND alc_lstope = 'U'
                                                 AND ctl_control_id =
                                                        prm_codigo;

                                        IF (v_tipo = 'ITEM')
                                        THEN
                                            SELECT   COUNT (1)
                                              INTO   existe
                                              FROM   fis_alcance_item a
                                             WHERE   a.alc_alcance_id =
                                                         v_alcance
                                                     AND ali_num = 0
                                                     AND ali_lstope = 'U'
                                                     AND ali_numero_item =
                                                            v_numero;

                                            IF existe = 0
                                            THEN
                                                RETURN 'el numero de item '
                                                       || v_numero
                                                       || ', no fue registrado dentro del alcance de este control.';
                                            ELSE
                                                SELECT   COUNT (1)
                                                  INTO   existe
                                                  FROM   fis_resultados a
                                                 WHERE   a.alc_alcance_id =
                                                             prm_idalcance
                                                         AND a.res_numero_item =
                                                                v_numero
                                                         AND a.res_num = 0
                                                         AND a.res_lstope =
                                                                'U';

                                                IF existe = 0
                                                THEN
                                                    INSERT INTO fis_resultados (res_dui,
                                                                                res_numero_item,
                                                                                res_partida,
                                                                                res_fob_usd,
                                                                                res_flete_usd,
                                                                                res_seguro_usd,
                                                                                res_otros_usd,
                                                                                res_cif_usd,
                                                                                res_cif_bob,
                                                                                res_contrav,
                                                                                res_ilicito,
                                                                                res_observacion,
                                                                                res_num,
                                                                                res_lstope,
                                                                                res_usuario,
                                                                                res_fecsys,
                                                                                key_year,
                                                                                key_cuo,
                                                                                key_dec,
                                                                                key_nber,
                                                                                res_contravorden,
                                                                                alc_alcance_id)
                                                      VALUES   (prm_dui,
                                                                v_numero,
                                                                DECODE (
                                                                    prm_partida,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_partida),
                                                                DECODE (
                                                                    prm_fob,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_fob),
                                                                DECODE (
                                                                    prm_flete,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_flete),
                                                                DECODE (
                                                                    prm_seguro,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_seguro),
                                                                DECODE (
                                                                    prm_otros,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_otros),
                                                                DECODE (
                                                                    prm_cifusd,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_cifusd),
                                                                DECODE (
                                                                    prm_cifbob,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_cifbob),
                                                                DECODE (
                                                                    prm_contrav,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_contrav),
                                                                prm_ilicito,
                                                                v_obs,
                                                                0,
                                                                'U',
                                                                prm_usuario,
                                                                SYSDATE,
                                                                v_key_year,
                                                                v_key_cuo,
                                                                v_key_dec,
                                                                v_key_nber,
                                                                DECODE (
                                                                    prm_contravorden,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_contravorden),
                                                                prm_idalcance);

                                                    COMMIT;
                                                    RETURN 'CORRECTO';
                                                ELSE
                                                    SELECT   COUNT (1)
                                                      INTO   existe
                                                      FROM   fis_resultados a
                                                     WHERE   a.alc_alcance_id =
                                                                 prm_idalcance
                                                             AND a.res_numero_item =
                                                                    v_numero;

                                                    UPDATE   fis_resultados
                                                       SET   res_num = existe
                                                     WHERE   alc_alcance_id =
                                                                 prm_idalcance
                                                             AND res_numero_item =
                                                                    v_numero
                                                             AND res_num = 0;

                                                    INSERT INTO fis_resultados (res_dui,
                                                                                res_numero_item,
                                                                                res_partida,
                                                                                res_fob_usd,
                                                                                res_flete_usd,
                                                                                res_seguro_usd,
                                                                                res_otros_usd,
                                                                                res_cif_usd,
                                                                                res_cif_bob,
                                                                                res_contrav,
                                                                                res_ilicito,
                                                                                res_observacion,
                                                                                res_num,
                                                                                res_lstope,
                                                                                res_usuario,
                                                                                res_fecsys,
                                                                                key_year,
                                                                                key_cuo,
                                                                                key_dec,
                                                                                key_nber,
                                                                                res_contravorden,
                                                                                alc_alcance_id)
                                                      VALUES   (prm_dui,
                                                                v_numero,
                                                                DECODE (
                                                                    prm_partida,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_partida),
                                                                DECODE (
                                                                    prm_fob,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_fob),
                                                                DECODE (
                                                                    prm_flete,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_flete),
                                                                DECODE (
                                                                    prm_seguro,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_seguro),
                                                                DECODE (
                                                                    prm_otros,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_otros),
                                                                DECODE (
                                                                    prm_cifusd,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_cifusd),
                                                                DECODE (
                                                                    prm_cifbob,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_cifbob),
                                                                DECODE (
                                                                    prm_contrav,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_contrav),
                                                                prm_ilicito,
                                                                v_obs,
                                                                0,
                                                                'U',
                                                                prm_usuario,
                                                                SYSDATE,
                                                                v_key_year,
                                                                v_key_cuo,
                                                                v_key_dec,
                                                                v_key_nber,
                                                                DECODE (
                                                                    prm_contravorden,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_contravorden),
                                                                prm_idalcance);

                                                    RETURN 'CORRECTO';
                                                END IF;
                                            END IF;
                                        ELSE
                                            SELECT   COUNT (1)
                                              INTO   existe
                                              FROM   fis_resultados a
                                             WHERE   a.alc_alcance_id =
                                                         prm_idalcance
                                                     AND a.res_numero_item =
                                                            v_numero
                                                     AND a.res_num = 0
                                                     AND a.res_lstope = 'U';

                                            IF existe = 0
                                            THEN
                                                INSERT INTO fis_resultados (res_dui,
                                                                            res_numero_item,
                                                                            res_partida,
                                                                            res_fob_usd,
                                                                            res_flete_usd,
                                                                            res_seguro_usd,
                                                                            res_otros_usd,
                                                                            res_cif_usd,
                                                                            res_cif_bob,
                                                                            res_contrav,
                                                                            res_ilicito,
                                                                            res_observacion,
                                                                            res_num,
                                                                            res_lstope,
                                                                            res_usuario,
                                                                            res_fecsys,
                                                                            key_year,
                                                                            key_cuo,
                                                                            key_dec,
                                                                            key_nber,
                                                                            res_contravorden,
                                                                            alc_alcance_id)
                                                  VALUES   (prm_dui,
                                                            v_numero,
                                                            DECODE (
                                                                prm_partida,
                                                                '-1',
                                                                NULL,
                                                                prm_partida),
                                                            DECODE (prm_fob,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_fob),
                                                            DECODE (
                                                                prm_flete,
                                                                '-1',
                                                                NULL,
                                                                prm_flete),
                                                            DECODE (
                                                                prm_seguro,
                                                                '-1',
                                                                NULL,
                                                                prm_seguro),
                                                            DECODE (
                                                                prm_otros,
                                                                '-1',
                                                                NULL,
                                                                prm_otros),
                                                            DECODE (
                                                                prm_cifusd,
                                                                '-1',
                                                                NULL,
                                                                prm_cifusd),
                                                            DECODE (
                                                                prm_cifbob,
                                                                '-1',
                                                                NULL,
                                                                prm_cifbob),
                                                            DECODE (
                                                                prm_contrav,
                                                                '-1',
                                                                NULL,
                                                                prm_contrav),
                                                            prm_ilicito,
                                                            v_obs,
                                                            0,
                                                            'U',
                                                            prm_usuario,
                                                            SYSDATE,
                                                            v_key_year,
                                                            v_key_cuo,
                                                            v_key_dec,
                                                            v_key_nber,
                                                            DECODE (
                                                                prm_contravorden,
                                                                '-1',
                                                                NULL,
                                                                prm_contravorden),
                                                            prm_idalcance);

                                                COMMIT;
                                                RETURN 'CORRECTO';
                                            ELSE
                                                SELECT   COUNT (1)
                                                  INTO   existe
                                                  FROM   fis_resultados a
                                                 WHERE   a.alc_alcance_id =
                                                             prm_idalcance
                                                         AND a.res_numero_item =
                                                                v_numero;

                                                UPDATE   fis_resultados
                                                   SET   res_num = existe
                                                 WHERE   alc_alcance_id =
                                                             prm_idalcance
                                                         AND res_numero_item =
                                                                v_numero
                                                         AND res_num = 0;

                                                INSERT INTO fis_resultados (res_dui,
                                                                            res_numero_item,
                                                                            res_partida,
                                                                            res_fob_usd,
                                                                            res_flete_usd,
                                                                            res_seguro_usd,
                                                                            res_otros_usd,
                                                                            res_cif_usd,
                                                                            res_cif_bob,
                                                                            res_contrav,
                                                                            res_ilicito,
                                                                            res_observacion,
                                                                            res_num,
                                                                            res_lstope,
                                                                            res_usuario,
                                                                            res_fecsys,
                                                                            key_year,
                                                                            key_cuo,
                                                                            key_dec,
                                                                            key_nber,
                                                                            res_contravorden,
                                                                            alc_alcance_id)
                                                  VALUES   (prm_dui,
                                                            v_numero,
                                                            DECODE (
                                                                prm_partida,
                                                                '-1',
                                                                NULL,
                                                                prm_partida),
                                                            DECODE (prm_fob,
                                                                    '-1',
                                                                    NULL,
                                                                    prm_fob),
                                                            DECODE (
                                                                prm_flete,
                                                                '-1',
                                                                NULL,
                                                                prm_flete),
                                                            DECODE (
                                                                prm_seguro,
                                                                '-1',
                                                                NULL,
                                                                prm_seguro),
                                                            DECODE (
                                                                prm_otros,
                                                                '-1',
                                                                NULL,
                                                                prm_otros),
                                                            DECODE (
                                                                prm_cifusd,
                                                                '-1',
                                                                NULL,
                                                                prm_cifusd),
                                                            DECODE (
                                                                prm_cifbob,
                                                                '-1',
                                                                NULL,
                                                                prm_cifbob),
                                                            DECODE (
                                                                prm_contrav,
                                                                '-1',
                                                                NULL,
                                                                prm_contrav),
                                                            prm_ilicito,
                                                            v_obs,
                                                            0,
                                                            'U',
                                                            prm_usuario,
                                                            SYSDATE,
                                                            v_key_year,
                                                            v_key_cuo,
                                                            v_key_dec,
                                                            v_key_nber,
                                                            DECODE (
                                                                prm_contravorden,
                                                                '-1',
                                                                NULL,
                                                                prm_contravorden),
                                                            prm_idalcance);

                                                RETURN 'CORRECTO';
                                            END IF;
                                        END IF;
                                    END IF;
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;


    FUNCTION graba_not_conclusion (prm_id          VARCHAR2,
                                   prm_usuario     VARCHAR2,
                                   prm_fechanot    VARCHAR2,
                                   prm_tiponot     VARCHAR2)
        RETURN VARCHAR2
    IS
        res         VARCHAR2 (300) := 0;
        existe      NUMBER;
        v_gestion   VARCHAR2 (4);
        v_numero    NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_not_conclusion a
         WHERE       a.ctl_control_id = prm_id
                 AND a.ndc_num = 0
                 AND a.ndc_lstope = 'U';

        IF existe = 0
        THEN
            INSERT INTO fis_not_conclusion (ctl_control_id,
                                            ndc_fecha_notificacion,
                                            ndc_tipo_notificacion,
                                            ndc_num,
                                            ndc_lstope,
                                            ndc_usuario,
                                            ndc_fecsys)
              VALUES   (prm_id,
                        TO_DATE (prm_fechanot, 'dd/mm/yyyy'),
                        prm_tiponot,
                        0,
                        'U',
                        prm_usuario,
                        SYSDATE);

            COMMIT;
            RETURN 'CORRECTOSe registr&oacute; correctamente la notificaci&oacute;n';
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_not_conclusion a
             WHERE   a.ctl_control_id = prm_id;

            UPDATE   fis_not_conclusion
               SET   ndc_num = existe
             WHERE   ctl_control_id = prm_id AND ndc_num = 0;

            INSERT INTO fis_not_conclusion (ctl_control_id,
                                            ndc_fecha_notificacion,
                                            ndc_tipo_notificacion,
                                            ndc_num,
                                            ndc_lstope,
                                            ndc_usuario,
                                            ndc_fecsys)
              VALUES   (prm_id,
                        TO_DATE (prm_fechanot, 'dd/mm/yyyy'),
                        prm_tiponot,
                        0,
                        'U',
                        prm_usuario,
                        SYSDATE);

            RETURN 'CORRECTOSe modific&oacute; correctamente la notificaci&oacute;n';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION graba_conclusion (prm_id                VARCHAR2,
                               prm_usuario           VARCHAR2,
                               prm_numero_informe    VARCHAR2,
                               prm_fecha_informe     VARCHAR2,
                               prm_tipo_doc_con      VARCHAR2,
                               prm_num_doc_con       VARCHAR2,
                               prm_fecha_doc_con     VARCHAR2)
        RETURN VARCHAR2
    IS
        res         VARCHAR2 (300) := 0;
        existe      NUMBER;
        v_gestion   VARCHAR2 (4);
        v_numero    NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_conclusion a
         WHERE       a.ctl_control_id = prm_id
                 AND a.con_num = 0
                 AND a.con_lstope = 'U';

        IF existe = 0
        THEN
            INSERT INTO fis_conclusion (ctl_control_id,
                                        con_tipo_doc_con,
                                        con_num_doc_con,
                                        con_fecha_doc_con,
                                        con_num,
                                        con_lstope,
                                        con_usuario,
                                        con_fecsys)
              VALUES   (prm_id,
                        prm_tipo_doc_con,
                        prm_num_doc_con,
                        TO_DATE (prm_fecha_doc_con, 'dd/mm/yyyy'),
                        0,
                        'U',
                        prm_usuario,
                        SYSDATE);

            COMMIT;
            RETURN 'CORRECTOSe registr&oacute; correctamente la conclusi&oacute;n';
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_conclusion a
             WHERE   a.ctl_control_id = prm_id;

            UPDATE   fis_conclusion
               SET   con_num = existe
             WHERE   ctl_control_id = prm_id AND con_num = 0;

            INSERT INTO fis_conclusion (ctl_control_id,
                                        con_tipo_doc_con,
                                        con_num_doc_con,
                                        con_fecha_doc_con,
                                        con_num,
                                        con_lstope,
                                        con_usuario,
                                        con_fecsys)
              VALUES   (prm_id,
                        prm_tipo_doc_con,
                        prm_num_doc_con,
                        TO_DATE (prm_fecha_doc_con, 'dd/mm/yyyy'),
                        0,
                        'U',
                        prm_usuario,
                        SYSDATE);

            RETURN 'CORRECTOSe modific&oacute; correctamente la conclusi&oacute;n';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION devuelve_hoja_trabajo (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT   i.itm_nber,
                     saditm_hs_cod || saditm_hsprec_cod decpartida,
                     r.res_partida detpartida,
                     g.sad_reg_year,
                     g.key_cuo,
                     g.sad_reg_serial,
                     g.sad_reg_nber,
                     TO_CHAR (sad_reg_date, 'dd/mm/yyyy') fecval,
                     '' fecvcto,
                     v.sad_iitminv_valc decfob,
                     DECODE (
                         v.sad_iitminv_cur,
                         'USD',
                         v.sad_iitmefr_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmefr_valn / v.sad_iitminv_rat,
                             2))
                         decflete,
                     DECODE (
                         v.sad_iitmins_cur,
                         'USD',
                         v.sad_iitmins_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmins_valn / v.sad_iitminv_rat,
                             2))
                         decseguro,
                     DECODE (
                         v.sad_iitmotc_cur,
                         'USD',
                         v.sad_iitmotc_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmotc_valn / v.sad_iitminv_rat,
                             2))
                         decotros,
                     pkg_general.roundsidunea (
                         v.sad_iitmcif_valn / v.sad_iitminv_rat,
                         2)
                         deccifusd,
                     v.sad_iitminv_rat dectc,
                     v.sad_iitmcif_valn deccifbob,
                     ga.saditm_tax_amount ga,
                     iva.saditm_tax_amount iva,
                     r.res_fob_usd detfob,
                     r.res_flete_usd detflete,
                     r.res_seguro_usd detseguro,
                     r.res_otros_usd detotros,
                     '' detcifusd,
                     '' detcifbob,
                     r.res_contrav contravencion,
                     r.res_ilicito ilicito,
                     r.res_observacion observacion,
                     f.alc_tipo_alcance,
                     r.res_contravorden,
                     c.alc_alcance_id
              FROM   fis_alcance f,
                     ops$asy.sad_gen g,
                     ops$asy.sad_itm i,
                     ops$asy.sad_itm_vim v,
                     ops$asy.sad_tax ga,
                     ops$asy.sad_tax iva,
                     fis_alcance_item c,
                     fis_resultados r
             WHERE       i.key_year = g.key_year
                     AND i.key_cuo = g.key_cuo
                     AND i.key_dec = g.key_dec
                     AND i.key_nber = g.key_nber
                     AND i.sad_num = g.sad_num
                     AND i.key_year = v.key_year
                     AND i.key_cuo = v.key_cuo
                     AND i.key_dec = v.key_dec
                     AND i.key_nber = v.key_nber
                     AND i.itm_nber = v.itm_nber
                     AND i.sad_num = v.sad_num
                     AND r.res_numero_item(+) = c.ali_numero_item
                     AND r.res_num(+) = 0
                     AND r.res_lstope(+) = 'U'
                     AND r.alc_alcance_id(+) = c.alc_alcance_id
                     AND i.key_year = ga.key_year
                     AND i.key_cuo = ga.key_cuo
                     AND i.key_dec = ga.key_dec
                     AND i.key_nber = ga.key_nber
                     AND i.itm_nber = ga.itm_nber
                     AND i.sad_num = ga.sad_num
                     AND ga.saditm_tax_code = 'GA'
                     AND i.key_year = iva.key_year
                     AND i.key_cuo = iva.key_cuo
                     AND i.key_dec = iva.key_dec
                     AND i.key_nber = iva.key_nber
                     AND i.itm_nber = iva.itm_nber
                     AND i.sad_num = iva.sad_num
                     AND iva.saditm_tax_code = 'IVA'
                     AND g.key_dec IS NOT NULL
                     AND g.sad_num = 0
                     AND g.lst_ope = 'U'
                     AND g.sad_reg_year = f.alc_gestion
                     AND g.key_cuo = f.alc_aduana
                     AND g.sad_reg_serial = 'C'
                     AND g.sad_reg_nber = f.alc_numero
                     AND c.ali_numero_item = i.itm_nber
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = f.alc_alcance_id
                     AND (f.alc_tipo_alcance = 'ITEM'
                          OR f.alc_tipo_alcance = 'DECLARACION')
                     AND f.alc_tipo_tramite = 'DUI'
                     AND f.alc_num = 0
                     AND f.alc_lstope = 'U'
                     AND f.ctl_control_id = prm_codigo
            UNION
            SELECT   i.itm_nber,
                     saditm_hs_cod || saditm_hsprec_cod decpartida,
                     r.res_partida detpartida,
                     g.sad_reg_year,
                     g.key_cuo,
                     g.sad_reg_serial,
                     g.sad_reg_nber,
                     TO_CHAR (sad_reg_date, 'dd/mm/yyyy') fecval,
                     '' fecvcto,
                     v.sad_iitminv_valc decfob,
                     DECODE (
                         v.sad_iitminv_cur,
                         'USD',
                         v.sad_iitmefr_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmefr_valn / v.sad_iitminv_rat,
                             2))
                         decflete,
                     DECODE (
                         v.sad_iitmins_cur,
                         'USD',
                         v.sad_iitmins_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmins_valn / v.sad_iitminv_rat,
                             2))
                         decseguro,
                     DECODE (
                         v.sad_iitmotc_cur,
                         'USD',
                         v.sad_iitmotc_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmotc_valn / v.sad_iitminv_rat,
                             2))
                         decotros,
                     pkg_general.roundsidunea (
                         v.sad_iitmcif_valn / v.sad_iitminv_rat,
                         2)
                         deccifusd,
                     v.sad_iitminv_rat dectc,
                     v.sad_iitmcif_valn deccifbob,
                     ga.saditm_tax_amount ga,
                     iva.saditm_tax_amount iva,
                     r.res_fob_usd detfob,
                     r.res_flete_usd detflete,
                     r.res_seguro_usd detseguro,
                     r.res_otros_usd detotros,
                     '' detcifusd,
                     '' detcifbob,
                     r.res_contrav contravencion,
                     r.res_ilicito ilicito,
                     r.res_observacion observacion,
                     f.alc_tipo_alcance,
                     r.res_contravorden,
                     c.alc_alcance_id
              FROM   fis_alcance f,
                     ops$asy.sad_gen g,
                     ops$asy.sad_itm i,
                     ops$asy.sad_itm_vim v,
                     ops$asy.sad_tax ga,
                     ops$asy.sad_tax iva,
                     fis_alcance_item c,
                     fis_resultados r
             WHERE       i.key_year = g.key_year
                     AND i.key_cuo = g.key_cuo
                     AND i.key_dec IS NULL
                     AND g.key_dec IS NULL
                     AND i.key_nber = g.key_nber
                     AND i.sad_num = g.sad_num
                     AND i.key_year = v.key_year
                     AND i.key_cuo = v.key_cuo
                     AND v.key_dec IS NULL
                     AND i.key_nber = v.key_nber
                     AND i.itm_nber = v.itm_nber
                     AND i.sad_num = v.sad_num
                     AND r.res_numero_item(+) = c.ali_numero_item
                     AND r.res_num(+) = 0
                     AND r.res_lstope(+) = 'U'
                     AND r.alc_alcance_id(+) = c.alc_alcance_id
                     AND i.key_year = ga.key_year
                     AND i.key_cuo = ga.key_cuo
                     AND ga.key_dec IS NULL
                     AND i.key_nber = ga.key_nber
                     AND i.itm_nber = ga.itm_nber
                     AND i.sad_num = ga.sad_num
                     AND ga.saditm_tax_code = 'GA'
                     AND i.key_year = iva.key_year
                     AND i.key_cuo = iva.key_cuo
                     AND iva.key_dec IS NULL
                     AND i.key_nber = iva.key_nber
                     AND i.itm_nber = iva.itm_nber
                     AND i.sad_num = iva.sad_num
                     AND iva.saditm_tax_code = 'IVA'
                     AND g.sad_num = 0
                     AND g.lst_ope = 'U'
                     AND g.sad_reg_year = f.alc_gestion
                     AND g.key_cuo = f.alc_aduana
                     AND g.sad_reg_serial = 'C'
                     AND g.sad_reg_nber = f.alc_numero
                     AND c.ali_numero_item = i.itm_nber
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = f.alc_alcance_id
                     AND (f.alc_tipo_alcance = 'ITEM'
                          OR f.alc_tipo_alcance = 'DECLARACION')
                     AND f.alc_tipo_tramite = 'DUI'
                     AND f.alc_num = 0
                     AND f.alc_lstope = 'U'
                     AND f.ctl_control_id = prm_codigo
            ORDER BY   4,
                       5,
                       7,
                       1;

        RETURN ct;
    END;


    FUNCTION devuelve_hoja_trabajo_liq (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT   i.itm_nber,
                     saditm_hs_cod || saditm_hsprec_cod decpartida,
                     '' detpartida,
                     g.sad_reg_year,
                     g.key_cuo,
                     g.sad_reg_serial,
                     g.sad_reg_nber,
                     TO_CHAR (sad_reg_date, 'dd/mm/yyyy') fecval,
                     '' fecvcto,
                     v.sad_iitminv_valc decfob,
                     DECODE (
                         v.sad_iitminv_cur,
                         'USD',
                         v.sad_iitmefr_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmefr_valn / v.sad_iitminv_rat,
                             2))
                         decflete,
                     DECODE (
                         v.sad_iitmins_cur,
                         'USD',
                         v.sad_iitmins_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmins_valn / v.sad_iitminv_rat,
                             2))
                         decseguro,
                     DECODE (
                         v.sad_iitmotc_cur,
                         'USD',
                         v.sad_iitmotc_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmotc_valn / v.sad_iitminv_rat,
                             2))
                         decotros,
                     pkg_general.roundsidunea (
                         v.sad_iitmcif_valn / v.sad_iitminv_rat,
                         2)
                         deccifusd,
                     v.sad_iitminv_rat dectc,
                     v.sad_iitmcif_valn deccifbob,
                     ga.saditm_tax_amount ga,
                     iva.saditm_tax_amount iva,
                     '' detfob,
                     '' detflete,
                     '' detseguro,
                     '' detotros,
                     '' detcifusd,
                     '' detcifbob,
                     '' contravencion,
                     '' ilicito,
                     '' observacion,
                     f.alc_tipo_alcance
              FROM   fis_alcance f,
                     ops$asy.sad_gen g,
                     ops$asy.sad_itm i,
                     ops$asy.sad_itm_vim v,
                     ops$asy.sad_tax ga,
                     ops$asy.sad_tax iva
             WHERE       i.key_year = g.key_year
                     AND i.key_cuo = g.key_cuo
                     AND i.key_dec = g.key_dec
                     AND g.key_dec IS NOT NULL
                     AND i.key_nber = g.key_nber
                     AND i.sad_num = g.sad_num
                     AND i.key_year = v.key_year
                     AND i.key_cuo = v.key_cuo
                     AND i.key_dec = v.key_dec
                     AND i.key_nber = v.key_nber
                     AND i.itm_nber = v.itm_nber
                     AND i.sad_num = v.sad_num
                     AND i.key_year = ga.key_year
                     AND i.key_cuo = ga.key_cuo
                     AND i.key_dec = ga.key_dec
                     AND i.key_nber = ga.key_nber
                     AND i.itm_nber = ga.itm_nber
                     AND i.sad_num = ga.sad_num
                     AND ga.saditm_tax_code = 'GA'
                     AND i.key_year = iva.key_year
                     AND i.key_cuo = iva.key_cuo
                     AND i.key_dec = iva.key_dec
                     AND i.key_nber = iva.key_nber
                     AND i.itm_nber = iva.itm_nber
                     AND i.sad_num = iva.sad_num
                     AND iva.saditm_tax_code = 'IVA'
                     AND g.sad_num = 0
                     AND g.lst_ope = 'U'
                     AND g.sad_reg_year = f.alc_gestion
                     AND g.key_cuo = f.alc_aduana
                     AND g.sad_reg_serial = 'C'
                     AND g.sad_reg_nber = f.alc_numero
                     AND f.alc_tipo_alcance = 'DECLARACION'
                     AND f.alc_tipo_tramite = 'DUI'
                     AND f.alc_num = 0
                     AND f.alc_lstope = 'U'
                     AND f.ctl_control_id = prm_codigo
            UNION
            SELECT   i.itm_nber,
                     saditm_hs_cod || saditm_hsprec_cod decpartida,
                     '' detpartida,
                     g.sad_reg_year,
                     g.key_cuo,
                     g.sad_reg_serial,
                     g.sad_reg_nber,
                     TO_CHAR (sad_reg_date, 'dd/mm/yyyy') fecval,
                     '' fecvcto,
                     v.sad_iitminv_valc decfob,
                     DECODE (
                         v.sad_iitminv_cur,
                         'USD',
                         v.sad_iitmefr_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmefr_valn / v.sad_iitminv_rat,
                             2))
                         decflete,
                     DECODE (
                         v.sad_iitmins_cur,
                         'USD',
                         v.sad_iitmins_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmins_valn / v.sad_iitminv_rat,
                             2))
                         decseguro,
                     DECODE (
                         v.sad_iitmotc_cur,
                         'USD',
                         v.sad_iitmotc_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmotc_valn / v.sad_iitminv_rat,
                             2))
                         decotros,
                     pkg_general.roundsidunea (
                         v.sad_iitmcif_valn / v.sad_iitminv_rat,
                         2)
                         deccifusd,
                     v.sad_iitminv_rat dectc,
                     v.sad_iitmcif_valn deccifbob,
                     ga.saditm_tax_amount ga,
                     iva.saditm_tax_amount iva,
                     '' detfob,
                     '' detflete,
                     '' detseguro,
                     '' detotros,
                     '' detcifusd,
                     '' detcifbob,
                     '' contravencion,
                     '' ilicito,
                     '' observacion,
                     f.alc_tipo_alcance
              FROM   fis_alcance f,
                     ops$asy.sad_gen g,
                     ops$asy.sad_itm i,
                     ops$asy.sad_itm_vim v,
                     ops$asy.sad_tax ga,
                     ops$asy.sad_tax iva
             WHERE       i.key_year = g.key_year
                     AND i.key_cuo = g.key_cuo
                     AND i.key_dec IS NULL
                     AND g.key_dec IS NULL
                     AND i.key_nber = g.key_nber
                     AND i.sad_num = g.sad_num
                     AND i.key_year = v.key_year
                     AND i.key_cuo = v.key_cuo
                     AND v.key_dec IS NULL
                     AND i.key_nber = v.key_nber
                     AND i.itm_nber = v.itm_nber
                     AND i.sad_num = v.sad_num
                     AND i.key_year = ga.key_year
                     AND i.key_cuo = ga.key_cuo
                     AND ga.key_dec IS NULL
                     AND i.key_nber = ga.key_nber
                     AND i.itm_nber = ga.itm_nber
                     AND i.sad_num = ga.sad_num
                     AND ga.saditm_tax_code = 'GA'
                     AND i.key_year = iva.key_year
                     AND i.key_cuo = iva.key_cuo
                     AND iva.key_dec IS NULL
                     AND i.key_nber = iva.key_nber
                     AND i.itm_nber = iva.itm_nber
                     AND i.sad_num = iva.sad_num
                     AND iva.saditm_tax_code = 'IVA'
                     AND g.sad_num = 0
                     AND g.lst_ope = 'U'
                     AND g.sad_reg_year = f.alc_gestion
                     AND g.key_cuo = f.alc_aduana
                     AND g.sad_reg_serial = 'C'
                     AND g.sad_reg_nber = f.alc_numero
                     AND f.alc_tipo_alcance = 'DECLARACION'
                     AND f.alc_tipo_tramite = 'DUI'
                     AND f.alc_num = 0
                     AND f.alc_lstope = 'U'
                     AND f.ctl_control_id = prm_codigo
            UNION
            SELECT   i.itm_nber,
                     saditm_hs_cod || saditm_hsprec_cod decpartida,
                     '' detpartida,
                     g.sad_reg_year,
                     g.key_cuo,
                     g.sad_reg_serial,
                     g.sad_reg_nber,
                     TO_CHAR (sad_reg_date, 'dd/mm/yyyy') fecval,
                     '' fecvcto,
                     v.sad_iitminv_valc decfob,
                     DECODE (
                         v.sad_iitminv_cur,
                         'USD',
                         v.sad_iitmefr_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmefr_valn / v.sad_iitminv_rat,
                             2))
                         decflete,
                     DECODE (
                         v.sad_iitmins_cur,
                         'USD',
                         v.sad_iitmins_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmins_valn / v.sad_iitminv_rat,
                             2))
                         decseguro,
                     DECODE (
                         v.sad_iitmotc_cur,
                         'USD',
                         v.sad_iitmotc_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmotc_valn / v.sad_iitminv_rat,
                             2))
                         decotros,
                     pkg_general.roundsidunea (
                         v.sad_iitmcif_valn / v.sad_iitminv_rat,
                         2)
                         deccifusd,
                     v.sad_iitminv_rat dectc,
                     v.sad_iitmcif_valn deccifbob,
                     ga.saditm_tax_amount ga,
                     iva.saditm_tax_amount iva,
                     '' detfob,
                     '' detflete,
                     '' detseguro,
                     '' detotros,
                     '' detcifusd,
                     '' detcifbob,
                     '' contravencion,
                     '' ilicito,
                     '' observacion,
                     f.alc_tipo_alcance
              FROM   fis_alcance f,
                     ops$asy.sad_gen g,
                     ops$asy.sad_itm i,
                     ops$asy.sad_itm_vim v,
                     ops$asy.sad_tax ga,
                     ops$asy.sad_tax iva,
                     fis_alcance_item c
             WHERE       i.key_year = g.key_year
                     AND i.key_cuo = g.key_cuo
                     AND i.key_dec = g.key_dec
                     AND i.key_nber = g.key_nber
                     AND i.sad_num = g.sad_num
                     AND i.key_year = v.key_year
                     AND i.key_cuo = v.key_cuo
                     AND i.key_dec = v.key_dec
                     AND i.key_nber = v.key_nber
                     AND i.itm_nber = v.itm_nber
                     AND i.sad_num = v.sad_num
                     AND i.key_year = ga.key_year
                     AND i.key_cuo = ga.key_cuo
                     AND i.key_dec = ga.key_dec
                     AND i.key_nber = ga.key_nber
                     AND i.itm_nber = ga.itm_nber
                     AND i.sad_num = ga.sad_num
                     AND ga.saditm_tax_code = 'GA'
                     AND i.key_year = iva.key_year
                     AND i.key_cuo = iva.key_cuo
                     AND i.key_dec = iva.key_dec
                     AND i.key_nber = iva.key_nber
                     AND i.itm_nber = iva.itm_nber
                     AND i.sad_num = iva.sad_num
                     AND iva.saditm_tax_code = 'IVA'
                     AND g.key_dec IS NOT NULL
                     AND g.sad_num = 0
                     AND g.lst_ope = 'U'
                     AND g.sad_reg_year = f.alc_gestion
                     AND g.key_cuo = f.alc_aduana
                     AND g.sad_reg_serial = 'C'
                     AND g.sad_reg_nber = f.alc_numero
                     AND c.ali_numero_item = i.itm_nber
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = f.alc_alcance_id
                     AND f.alc_tipo_alcance = 'ITEM'
                     AND f.alc_tipo_tramite = 'DUI'
                     AND f.alc_num = 0
                     AND f.alc_lstope = 'U'
                     AND f.ctl_control_id = prm_codigo
            UNION
            SELECT   i.itm_nber,
                     saditm_hs_cod || saditm_hsprec_cod decpartida,
                     '' detpartida,
                     g.sad_reg_year,
                     g.key_cuo,
                     g.sad_reg_serial,
                     g.sad_reg_nber,
                     TO_CHAR (sad_reg_date, 'dd/mm/yyyy') fecval,
                     '' fecvcto,
                     v.sad_iitminv_valc decfob,
                     DECODE (
                         v.sad_iitminv_cur,
                         'USD',
                         v.sad_iitmefr_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmefr_valn / v.sad_iitminv_rat,
                             2))
                         decflete,
                     DECODE (
                         v.sad_iitmins_cur,
                         'USD',
                         v.sad_iitmins_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmins_valn / v.sad_iitminv_rat,
                             2))
                         decseguro,
                     DECODE (
                         v.sad_iitmotc_cur,
                         'USD',
                         v.sad_iitmotc_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmotc_valn / v.sad_iitminv_rat,
                             2))
                         decotros,
                     pkg_general.roundsidunea (
                         v.sad_iitmcif_valn / v.sad_iitminv_rat,
                         2)
                         deccifusd,
                     v.sad_iitminv_rat dectc,
                     v.sad_iitmcif_valn deccifbob,
                     ga.saditm_tax_amount ga,
                     iva.saditm_tax_amount iva,
                     '' detfob,
                     '' detflete,
                     '' detseguro,
                     '' detotros,
                     '' detcifusd,
                     '' detcifbob,
                     '' contravencion,
                     '' ilicito,
                     '' observacion,
                     f.alc_tipo_alcance
              FROM   fis_alcance f,
                     ops$asy.sad_gen g,
                     ops$asy.sad_itm i,
                     ops$asy.sad_itm_vim v,
                     ops$asy.sad_tax ga,
                     ops$asy.sad_tax iva,
                     fis_alcance_item c
             WHERE       i.key_year = g.key_year
                     AND i.key_cuo = g.key_cuo
                     AND i.key_dec IS NULL
                     AND g.key_dec IS NULL
                     AND i.key_nber = g.key_nber
                     AND i.sad_num = g.sad_num
                     AND i.key_year = v.key_year
                     AND i.key_cuo = v.key_cuo
                     AND v.key_dec IS NULL
                     AND i.key_nber = v.key_nber
                     AND i.itm_nber = v.itm_nber
                     AND i.sad_num = v.sad_num
                     AND i.key_year = ga.key_year
                     AND i.key_cuo = ga.key_cuo
                     AND ga.key_dec IS NULL
                     AND i.key_nber = ga.key_nber
                     AND i.itm_nber = ga.itm_nber
                     AND i.sad_num = ga.sad_num
                     AND ga.saditm_tax_code = 'GA'
                     AND i.key_year = iva.key_year
                     AND i.key_cuo = iva.key_cuo
                     AND iva.key_dec IS NULL
                     AND i.key_nber = iva.key_nber
                     AND i.itm_nber = iva.itm_nber
                     AND i.sad_num = iva.sad_num
                     AND iva.saditm_tax_code = 'IVA'
                     AND g.sad_num = 0
                     AND g.lst_ope = 'U'
                     AND g.sad_reg_year = f.alc_gestion
                     AND g.key_cuo = f.alc_aduana
                     AND g.sad_reg_serial = 'C'
                     AND g.sad_reg_nber = f.alc_numero
                     AND c.ali_numero_item = i.itm_nber
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = f.alc_alcance_id
                     AND f.alc_tipo_alcance = 'ITEM'
                     AND f.alc_tipo_tramite = 'DUI'
                     AND f.alc_num = 0
                     AND f.alc_lstope = 'U'
                     AND f.ctl_control_id = prm_codigo
            ORDER BY   4,
                       5,
                       7,
                       1;

        RETURN ct;
    END;

    FUNCTION devuelve_hoja_trabajo_tramite (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
              SELECT   b.alc_alcance_id,
                       b.alc_tipo_tramite,
                          b.alc_gestion
                       || '/'
                       || b.alc_aduana
                       || '/'
                       || 'C-'
                       || b.alc_numero
                           tramite,
                       b.alc_tipo_alcance,
                       COUNT (ali_numero_item),
                       b.alc_tipo_etapa,
                       TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                       UPPER (b.alc_proveedor),
                       UPPER (t.ret_mercancia),
                       t.ret_fob_usd,
                       t.ret_flete_usd,
                       t.ret_seguro_usd,
                       t.ret_otros_usd,
                       t.ret_cif_usd,
                       t.ret_cif_bob,
                       t.ret_cif_ufv,
                       t.ret_ilicito,
                       t.ret_contravorden
                FROM   fis_control a,
                       fis_alcance b,
                       fis_alcance_item c,
                       fis_resultados_tramite t
               WHERE       a.ctl_control_id = b.ctl_control_id
                       AND a.ctl_num = 0
                       AND a.ctl_lstope = 'U'
                       AND b.alc_tipo_alcance = 'ITEM'
                       AND b.alc_tipo_tramite = 'DUE'
                       AND b.alc_num = 0
                       AND b.alc_lstope = 'U'
                       AND c.ali_num = 0
                       AND c.ali_lstope = 'U'
                       AND c.alc_alcance_id = b.alc_alcance_id
                       AND a.ctl_control_id = prm_codigo
                       AND b.alc_alcance_id = t.alc_alcance_id(+)
                       AND t.ret_num(+) = 0
                       AND t.ret_lstope(+) = 'U'
            GROUP BY   b.alc_alcance_id,
                       b.alc_tipo_tramite,
                          b.alc_gestion
                       || '/'
                       || b.alc_aduana
                       || '/'
                       || 'C-'
                       || b.alc_numero,
                       b.alc_tipo_alcance,
                       b.alc_tipo_etapa,
                       b.alc_fecha,
                       b.alc_proveedor,
                       t.ret_mercancia,
                       t.ret_fob_usd,
                       t.ret_flete_usd,
                       t.ret_seguro_usd,
                       t.ret_otros_usd,
                       t.ret_cif_usd,
                       t.ret_cif_bob,
                       t.ret_cif_ufv,
                       t.ret_ilicito,
                       t.ret_contravorden
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '/'
                     || b.alc_aduana
                     || '/'
                     || 'C-'
                     || b.alc_numero
                         tramite,
                     'DECLARACI&Oacute;N',
                     0,
                     b.alc_tipo_etapa,
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     UPPER (b.alc_proveedor),
                     UPPER (t.ret_mercancia),
                     t.ret_fob_usd,
                     t.ret_flete_usd,
                     t.ret_seguro_usd,
                     t.ret_otros_usd,
                     t.ret_cif_usd,
                     t.ret_cif_bob,
                     t.ret_cif_ufv,
                     t.ret_ilicito,
                     t.ret_contravorden
              FROM   fis_control a, fis_alcance b, fis_resultados_tramite t
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'DECLARACION'
                     AND b.alc_tipo_tramite = 'DUE'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = prm_codigo
                     AND b.alc_alcance_id = t.alc_alcance_id(+)
                     AND t.ret_num(+) = 0
                     AND t.ret_lstope(+) = 'U'
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_numero
                     || '-'
                     || TO_CHAR (b.alc_fecha, 'dd/mm/yyyy')
                     || '-'
                     || UPPER (b.alc_proveedor)
                     || '-'
                     || pkg_general.devuelve_pais (b.alc_pais)
                         tramite,
                     b.alc_tipo_alcance,
                     0,
                     b.alc_tipo_etapa,
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     UPPER (b.alc_proveedor),
                     UPPER (t.ret_mercancia),
                     t.ret_fob_usd,
                     t.ret_flete_usd,
                     t.ret_seguro_usd,
                     t.ret_otros_usd,
                     t.ret_cif_usd,
                     t.ret_cif_bob,
                     t.ret_cif_ufv,
                     t.ret_ilicito,
                     t.ret_contravorden
              FROM   fis_control a, fis_alcance b, fis_resultados_tramite t
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'FACTURA'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = prm_codigo
                     AND b.alc_alcance_id = t.alc_alcance_id(+)
                     AND t.ret_num(+) = 0
                     AND t.ret_lstope(+) = 'U'
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '/'
                     || b.alc_aduana
                     || '/'
                     || b.alc_numero
                         tramite,
                     b.alc_tipo_alcance,
                     0,
                     b.alc_tipo_etapa,
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     UPPER (b.alc_proveedor),
                     UPPER (t.ret_mercancia),
                     t.ret_fob_usd,
                     t.ret_flete_usd,
                     t.ret_seguro_usd,
                     t.ret_otros_usd,
                     t.ret_cif_usd,
                     t.ret_cif_bob,
                     t.ret_cif_ufv,
                     t.ret_ilicito,
                     t.ret_contravorden
              FROM   fis_control a, fis_alcance b, fis_resultados_tramite t
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'MANIFIESTO'
                     AND b.alc_tipo_tramite = 'MIC'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = prm_codigo
                     AND b.alc_alcance_id = t.alc_alcance_id(+)
                     AND t.ret_num(+) = 0
                     AND t.ret_lstope(+) = 'U'
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '-'
                     || TO_CHAR (b.alc_fecha, 'dd/mm/yyyy')
                     || '-'
                     || UPPER (b.alc_proveedor)
                         tramite,
                     b.alc_tipo_alcance,
                     0,
                     b.alc_tipo_etapa,
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     UPPER (b.alc_proveedor),
                     UPPER (t.ret_mercancia),
                     t.ret_fob_usd,
                     t.ret_flete_usd,
                     t.ret_seguro_usd,
                     t.ret_otros_usd,
                     t.ret_cif_usd,
                     t.ret_cif_bob,
                     t.ret_cif_ufv,
                     t.ret_ilicito,
                     t.ret_contravorden
              FROM   fis_control a, fis_alcance b, fis_resultados_tramite t
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'TRANSFERENCIA'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = prm_codigo
                     AND b.alc_alcance_id = t.alc_alcance_id(+)
                     AND t.ret_num(+) = 0
                     AND t.ret_lstope(+) = 'U'
            UNION
            SELECT   b.alc_alcance_id,
                     b.alc_tipo_tramite,
                        b.alc_gestion
                     || '-'
                     || TO_CHAR (b.alc_fecha, 'dd/mm/yyyy')
                     || '-'
                     || UPPER (b.alc_proveedor)
                     || '-'
                     || b.alc_tipo_documento
                         tramite,
                     b.alc_tipo_alcance,
                     0,
                     b.alc_tipo_etapa,
                     TO_CHAR (b.alc_fecha, 'dd/mm/yyyy'),
                     UPPER (b.alc_proveedor),
                     UPPER (t.ret_mercancia),
                     t.ret_fob_usd,
                     t.ret_flete_usd,
                     t.ret_seguro_usd,
                     t.ret_otros_usd,
                     t.ret_cif_usd,
                     t.ret_cif_bob,
                     t.ret_cif_ufv,
                     t.ret_ilicito,
                     t.ret_contravorden
              FROM   fis_control a, fis_alcance b, fis_resultados_tramite t
             WHERE       a.ctl_control_id = b.ctl_control_id
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND b.alc_tipo_alcance = 'TRAMITE'
                     AND b.alc_tipo_tramite = 'OTROS'
                     AND b.alc_num = 0
                     AND b.alc_lstope = 'U'
                     AND a.ctl_control_id = prm_codigo
                     AND b.alc_alcance_id = t.alc_alcance_id(+)
                     AND t.ret_num(+) = 0
                     AND t.ret_lstope(+) = 'U'
            ORDER BY   2, 3;

        RETURN ct;
    END;



    FUNCTION dev_fob (prm_dui IN VARCHAR2, prm_item IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (300) := '';
    BEGIN
        SELECT   x.res_numero_item
          INTO   res
          FROM   fis_resultados x
         WHERE       x.res_dui = prm_dui
                 AND x.res_numero_item = prm_item
                 AND x.res_num = 0;

        RETURN res;
    END;

    FUNCTION devuelve_hoja_trabajoxls2 (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
              SELECT   i.itm_nber,
                       (SELECT   x.res_fob_usd --DECODE (x.res_fob_usd, 0, '', x.res_fob_usd)
                          FROM   fis_resultados x
                         WHERE   x.res_dui =
                                        a.alc_gestion
                                     || '/'
                                     || a.alc_aduana
                                     || '/C-'
                                     || a.alc_numero
                                 AND x.res_numero_item = i.itm_nber
                                 AND x.res_num = 0
                                 AND x.res_lstope = 'U'),
                       (SELECT   SUBSTR (x.res_partida, 0, 8)
                          FROM   fis_resultados x
                         WHERE   x.res_dui =
                                        a.alc_gestion
                                     || '/'
                                     || a.alc_aduana
                                     || '/C-'
                                     || a.alc_numero
                                 AND x.res_numero_item = i.itm_nber
                                 AND x.res_num = 0
                                 AND x.res_lstope = 'U'),
                       (SELECT   SUBSTR (x.res_partida, 9)
                          FROM   fis_resultados x
                         WHERE   x.res_dui =
                                        a.alc_gestion
                                     || '/'
                                     || a.alc_aduana
                                     || '/C-'
                                     || a.alc_numero
                                 AND x.res_numero_item = i.itm_nber
                                 AND x.res_num = 0
                                 AND x.res_lstope = 'U')
                FROM   fis_alcance a, ops$asy.sad_gen g, ops$asy.sad_itm i
               WHERE       a.alc_gestion = g.sad_reg_year
                       AND a.alc_aduana = g.key_cuo
                       AND a.alc_numero = g.sad_reg_nber
                       AND a.alc_alcance_id = prm_codigo
                       AND i.key_year = g.key_year
                       AND i.key_cuo = g.key_cuo
                       AND NVL (i.key_dec, 0) = NVL (g.key_dec, 0)
                       AND i.key_nber = g.key_nber
                       AND g.sad_num = 0
                       AND i.sad_num = 0
            ORDER BY   1;

        RETURN ct;
    END;

    FUNCTION devuelve_hoja_trabajoxls_cab (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct       cursortype;

        fob      NUMBER (18, 2);
        flete    NUMBER (18, 2);
        seguro   NUMBER (18, 2);
        otros    NUMBER (18, 2);
        dui      VARCHAR2 (30);
    BEGIN
        /*para tomar los totales de flete seguro y otros a nivel de cabecera*/
        SELECT   sad_itotefr_valc flete,
                 sad_itotins_valc seguro,
                 sad_itototc_valc otros
          INTO   flete, seguro, otros
          FROM   fis_alcance a, ops$asy.sad_gen s, ops$asy.sad_gen_vim i
         WHERE       a.alc_alcance_id = prm_codigo
                 AND a.alc_gestion = s.sad_reg_year
                 AND a.alc_aduana = s.key_cuo
                 AND s.sad_reg_serial = 'C'
                 AND a.alc_numero = s.sad_reg_nber
                 AND a.alc_num = 0
                 AND a.alc_lstope = 'U'
                 AND s.sad_num = 0
                 AND s.key_year = i.key_year
                 AND s.key_cuo = i.key_cuo
                 AND NVL (s.key_dec, 0) = NVL (i.key_dec, 0)
                 AND s.key_nber = i.key_nber
                 AND i.sad_num = 0
                 AND a.alc_tipo_tramite = 'DUI';



          SELECT   SUM(DECODE (r.res_fob_usd,
                               NULL, i.sad_iitminv_valc,
                               --0, i.sad_iitminv_valc,
                               r.res_fob_usd)),
                      s.sad_reg_year
                   || '/'
                   || s.key_cuo
                   || '/C-'
                   || s.sad_reg_nber
            INTO   fob, dui
            FROM   fis_alcance a,
                   ops$asy.sad_gen s,
                   ops$asy.sad_itm_vim i,
                   fis_resultados r
           WHERE       a.alc_alcance_id = prm_codigo
                   AND a.alc_gestion = s.sad_reg_year
                   AND a.alc_aduana = s.key_cuo
                   AND s.sad_reg_serial = 'C'
                   AND a.alc_numero = s.sad_reg_nber
                   AND a.alc_num = 0
                   AND a.alc_lstope = 'U'
                   AND s.sad_num = 0
                   AND s.key_year = i.key_year
                   AND s.key_cuo = i.key_cuo
                   AND NVL (s.key_dec, 0) = NVL (i.key_dec, 0)
                   AND s.key_nber = i.key_nber
                   AND i.sad_num = 0
                   AND r.key_year(+) = i.key_year
                   AND r.key_cuo(+) = i.key_cuo
                   AND NVL (r.key_dec(+), 0) = NVL (i.key_dec, 0)
                   AND r.key_nber(+) = i.key_nber
                   AND r.res_numero_item(+) = i.itm_nber
                   AND r.res_num(+) = 0
                   AND r.res_lstope(+) = 'U'
                   AND a.alc_tipo_tramite = 'DUI'
        GROUP BY      s.sad_reg_year
                   || '/'
                   || s.key_cuo
                   || '/C-'
                   || s.sad_reg_nber;

        OPEN ct FOR
            SELECT   fob,
                     flete,
                     seguro,
                     otros,
                     dui
              FROM   DUAL;

        RETURN ct;
    END;

    FUNCTION devuelve_hoja_trabajoxls (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT   i.itm_nber,
                     saditm_hs_cod || saditm_hsprec_cod decpartida,
                     '' detpartida,
                     g.sad_reg_year,
                     g.key_cuo,
                     g.sad_reg_serial,
                     g.sad_reg_nber,
                     TO_CHAR (sad_reg_date, 'dd/mm/yyyy') fecval,
                     '' fecvcto,
                     v.sad_iitminv_valc decfob,
                     DECODE (
                         v.sad_iitminv_cur,
                         'USD',
                         v.sad_iitmefr_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmefr_valn / v.sad_iitminv_rat,
                             2))
                         decflete,
                     DECODE (
                         v.sad_iitmins_cur,
                         'USD',
                         v.sad_iitmins_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmins_valn / v.sad_iitminv_rat,
                             2))
                         decseguro,
                     DECODE (
                         v.sad_iitmotc_cur,
                         'USD',
                         v.sad_iitmotc_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmotc_valn / v.sad_iitminv_rat,
                             2))
                         decotros,
                     pkg_general.roundsidunea (
                         v.sad_iitmcif_valn / v.sad_iitminv_rat,
                         2)
                         deccifusd,
                     v.sad_iitminv_rat dectc,
                     v.sad_iitmcif_valn deccifbob,
                     ga.saditm_tax_amount ga,
                     iva.saditm_tax_amount iva,
                     '' detfob,
                     '' detflete,
                     '' detseguro,
                     '' detotros,
                     '' detcifusd,
                     '' detcifbob,
                     '' contravencion,
                     '' ilicito,
                     '' observacion,
                     f.alc_tipo_alcance,
                     saditm_hs_cod,
                     saditm_hsprec_cod
              FROM   fis_alcance f,
                     ops$asy.sad_gen g,
                     ops$asy.sad_itm i,
                     ops$asy.sad_itm_vim v,
                     ops$asy.sad_tax ga,
                     ops$asy.sad_tax iva
             WHERE       i.key_year = g.key_year
                     AND i.key_cuo = g.key_cuo
                     AND i.key_dec = g.key_dec
                     AND g.key_dec IS NOT NULL
                     AND i.key_nber = g.key_nber
                     AND i.sad_num = g.sad_num
                     AND i.key_year = v.key_year
                     AND i.key_cuo = v.key_cuo
                     AND i.key_dec = v.key_dec
                     AND i.key_nber = v.key_nber
                     AND i.itm_nber = v.itm_nber
                     AND i.sad_num = v.sad_num
                     AND i.key_year = ga.key_year
                     AND i.key_cuo = ga.key_cuo
                     AND i.key_dec = ga.key_dec
                     AND i.key_nber = ga.key_nber
                     AND i.itm_nber = ga.itm_nber
                     AND i.sad_num = ga.sad_num
                     AND ga.saditm_tax_code = 'GA'
                     AND i.key_year = iva.key_year
                     AND i.key_cuo = iva.key_cuo
                     AND i.key_dec = iva.key_dec
                     AND i.key_nber = iva.key_nber
                     AND i.itm_nber = iva.itm_nber
                     AND i.sad_num = iva.sad_num
                     AND iva.saditm_tax_code = 'IVA'
                     AND g.sad_num = 0
                     AND g.lst_ope = 'U'
                     AND g.sad_reg_year = f.alc_gestion
                     AND g.key_cuo = f.alc_aduana
                     AND g.sad_reg_serial = 'C'
                     AND g.sad_reg_nber = f.alc_numero
                     AND f.alc_tipo_alcance = 'DECLARACION'
                     AND f.alc_tipo_tramite = 'DUI'
                     AND f.alc_num = 0
                     AND f.alc_lstope = 'U'
                     AND f.alc_alcance_id = prm_codigo
            UNION
            SELECT   i.itm_nber,
                     saditm_hs_cod || saditm_hsprec_cod decpartida,
                     '' detpartida,
                     g.sad_reg_year,
                     g.key_cuo,
                     g.sad_reg_serial,
                     g.sad_reg_nber,
                     TO_CHAR (sad_reg_date, 'dd/mm/yyyy') fecval,
                     '' fecvcto,
                     v.sad_iitminv_valc decfob,
                     DECODE (
                         v.sad_iitminv_cur,
                         'USD',
                         v.sad_iitmefr_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmefr_valn / v.sad_iitminv_rat,
                             2))
                         decflete,
                     DECODE (
                         v.sad_iitmins_cur,
                         'USD',
                         v.sad_iitmins_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmins_valn / v.sad_iitminv_rat,
                             2))
                         decseguro,
                     DECODE (
                         v.sad_iitmotc_cur,
                         'USD',
                         v.sad_iitmotc_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmotc_valn / v.sad_iitminv_rat,
                             2))
                         decotros,
                     pkg_general.roundsidunea (
                         v.sad_iitmcif_valn / v.sad_iitminv_rat,
                         2)
                         deccifusd,
                     v.sad_iitminv_rat dectc,
                     v.sad_iitmcif_valn deccifbob,
                     ga.saditm_tax_amount ga,
                     iva.saditm_tax_amount iva,
                     '' detfob,
                     '' detflete,
                     '' detseguro,
                     '' detotros,
                     '' detcifusd,
                     '' detcifbob,
                     '' contravencion,
                     '' ilicito,
                     '' observacion,
                     f.alc_tipo_alcance,
                     saditm_hs_cod,
                     saditm_hsprec_cod
              FROM   fis_alcance f,
                     ops$asy.sad_gen g,
                     ops$asy.sad_itm i,
                     ops$asy.sad_itm_vim v,
                     ops$asy.sad_tax ga,
                     ops$asy.sad_tax iva
             WHERE       i.key_year = g.key_year
                     AND i.key_cuo = g.key_cuo
                     AND i.key_dec IS NULL
                     AND g.key_dec IS NULL
                     AND i.key_nber = g.key_nber
                     AND i.sad_num = g.sad_num
                     AND i.key_year = v.key_year
                     AND i.key_cuo = v.key_cuo
                     AND v.key_dec IS NULL
                     AND i.key_nber = v.key_nber
                     AND i.itm_nber = v.itm_nber
                     AND i.sad_num = v.sad_num
                     AND i.key_year = ga.key_year
                     AND i.key_cuo = ga.key_cuo
                     AND ga.key_dec IS NULL
                     AND i.key_nber = ga.key_nber
                     AND i.itm_nber = ga.itm_nber
                     AND i.sad_num = ga.sad_num
                     AND ga.saditm_tax_code = 'GA'
                     AND i.key_year = iva.key_year
                     AND i.key_cuo = iva.key_cuo
                     AND iva.key_dec IS NULL
                     AND i.key_nber = iva.key_nber
                     AND i.itm_nber = iva.itm_nber
                     AND i.sad_num = iva.sad_num
                     AND iva.saditm_tax_code = 'IVA'
                     AND g.sad_num = 0
                     AND g.lst_ope = 'U'
                     AND g.sad_reg_year = f.alc_gestion
                     AND g.key_cuo = f.alc_aduana
                     AND g.sad_reg_serial = 'C'
                     AND g.sad_reg_nber = f.alc_numero
                     AND f.alc_tipo_alcance = 'DECLARACION'
                     AND f.alc_tipo_tramite = 'DUI'
                     AND f.alc_num = 0
                     AND f.alc_lstope = 'U'
                     AND f.alc_alcance_id = prm_codigo
            UNION
            SELECT   i.itm_nber,
                     saditm_hs_cod || saditm_hsprec_cod decpartida,
                     '' detpartida,
                     g.sad_reg_year,
                     g.key_cuo,
                     g.sad_reg_serial,
                     g.sad_reg_nber,
                     TO_CHAR (sad_reg_date, 'dd/mm/yyyy') fecval,
                     '' fecvcto,
                     v.sad_iitminv_valc decfob,
                     DECODE (
                         v.sad_iitminv_cur,
                         'USD',
                         v.sad_iitmefr_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmefr_valn / v.sad_iitminv_rat,
                             2))
                         decflete,
                     DECODE (
                         v.sad_iitmins_cur,
                         'USD',
                         v.sad_iitmins_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmins_valn / v.sad_iitminv_rat,
                             2))
                         decseguro,
                     DECODE (
                         v.sad_iitmotc_cur,
                         'USD',
                         v.sad_iitmotc_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmotc_valn / v.sad_iitminv_rat,
                             2))
                         decotros,
                     pkg_general.roundsidunea (
                         v.sad_iitmcif_valn / v.sad_iitminv_rat,
                         2)
                         deccifusd,
                     v.sad_iitminv_rat dectc,
                     v.sad_iitmcif_valn deccifbob,
                     ga.saditm_tax_amount ga,
                     iva.saditm_tax_amount iva,
                     '' detfob,
                     '' detflete,
                     '' detseguro,
                     '' detotros,
                     '' detcifusd,
                     '' detcifbob,
                     '' contravencion,
                     '' ilicito,
                     '' observacion,
                     f.alc_tipo_alcance,
                     saditm_hs_cod,
                     saditm_hsprec_cod
              FROM   fis_alcance f,
                     ops$asy.sad_gen g,
                     ops$asy.sad_itm i,
                     ops$asy.sad_itm_vim v,
                     ops$asy.sad_tax ga,
                     ops$asy.sad_tax iva,
                     fis_alcance_item c
             WHERE       i.key_year = g.key_year
                     AND i.key_cuo = g.key_cuo
                     AND i.key_dec = g.key_dec
                     AND i.key_nber = g.key_nber
                     AND i.sad_num = g.sad_num
                     AND i.key_year = v.key_year
                     AND i.key_cuo = v.key_cuo
                     AND i.key_dec = v.key_dec
                     AND i.key_nber = v.key_nber
                     AND i.itm_nber = v.itm_nber
                     AND i.sad_num = v.sad_num
                     AND i.key_year = ga.key_year
                     AND i.key_cuo = ga.key_cuo
                     AND i.key_dec = ga.key_dec
                     AND i.key_nber = ga.key_nber
                     AND i.itm_nber = ga.itm_nber
                     AND i.sad_num = ga.sad_num
                     AND ga.saditm_tax_code = 'GA'
                     AND i.key_year = iva.key_year
                     AND i.key_cuo = iva.key_cuo
                     AND i.key_dec = iva.key_dec
                     AND i.key_nber = iva.key_nber
                     AND i.itm_nber = iva.itm_nber
                     AND i.sad_num = iva.sad_num
                     AND iva.saditm_tax_code = 'IVA'
                     AND g.key_dec IS NOT NULL
                     AND g.sad_num = 0
                     AND g.lst_ope = 'U'
                     AND g.sad_reg_year = f.alc_gestion
                     AND g.key_cuo = f.alc_aduana
                     AND g.sad_reg_serial = 'C'
                     AND g.sad_reg_nber = f.alc_numero
                     AND c.ali_numero_item = i.itm_nber
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = f.alc_alcance_id
                     AND f.alc_tipo_alcance = 'ITEM'
                     AND f.alc_tipo_tramite = 'DUI'
                     AND f.alc_num = 0
                     AND f.alc_lstope = 'U'
                     AND f.alc_alcance_id = prm_codigo
            UNION
            SELECT   i.itm_nber,
                     saditm_hs_cod || saditm_hsprec_cod decpartida,
                     '' detpartida,
                     g.sad_reg_year,
                     g.key_cuo,
                     g.sad_reg_serial,
                     g.sad_reg_nber,
                     TO_CHAR (sad_reg_date, 'dd/mm/yyyy') fecval,
                     '' fecvcto,
                     v.sad_iitminv_valc decfob,
                     DECODE (
                         v.sad_iitminv_cur,
                         'USD',
                         v.sad_iitmefr_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmefr_valn / v.sad_iitminv_rat,
                             2))
                         decflete,
                     DECODE (
                         v.sad_iitmins_cur,
                         'USD',
                         v.sad_iitmins_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmins_valn / v.sad_iitminv_rat,
                             2))
                         decseguro,
                     DECODE (
                         v.sad_iitmotc_cur,
                         'USD',
                         v.sad_iitmotc_valc,
                         pkg_general.roundsidunea (
                             v.sad_iitmotc_valn / v.sad_iitminv_rat,
                             2))
                         decotros,
                     pkg_general.roundsidunea (
                         v.sad_iitmcif_valn / v.sad_iitminv_rat,
                         2)
                         deccifusd,
                     v.sad_iitminv_rat dectc,
                     v.sad_iitmcif_valn deccifbob,
                     ga.saditm_tax_amount ga,
                     iva.saditm_tax_amount iva,
                     '' detfob,
                     '' detflete,
                     '' detseguro,
                     '' detotros,
                     '' detcifusd,
                     '' detcifbob,
                     '' contravencion,
                     '' ilicito,
                     '' observacion,
                     f.alc_tipo_alcance,
                     saditm_hs_cod,
                     saditm_hsprec_cod
              FROM   fis_alcance f,
                     ops$asy.sad_gen g,
                     ops$asy.sad_itm i,
                     ops$asy.sad_itm_vim v,
                     ops$asy.sad_tax ga,
                     ops$asy.sad_tax iva,
                     fis_alcance_item c
             WHERE       i.key_year = g.key_year
                     AND i.key_cuo = g.key_cuo
                     AND i.key_dec IS NULL
                     AND g.key_dec IS NULL
                     AND i.key_nber = g.key_nber
                     AND i.sad_num = g.sad_num
                     AND i.key_year = v.key_year
                     AND i.key_cuo = v.key_cuo
                     AND v.key_dec IS NULL
                     AND i.key_nber = v.key_nber
                     AND i.itm_nber = v.itm_nber
                     AND i.sad_num = v.sad_num
                     AND i.key_year = ga.key_year
                     AND i.key_cuo = ga.key_cuo
                     AND ga.key_dec IS NULL
                     AND i.key_nber = ga.key_nber
                     AND i.itm_nber = ga.itm_nber
                     AND i.sad_num = ga.sad_num
                     AND ga.saditm_tax_code = 'GA'
                     AND i.key_year = iva.key_year
                     AND i.key_cuo = iva.key_cuo
                     AND iva.key_dec IS NULL
                     AND i.key_nber = iva.key_nber
                     AND i.itm_nber = iva.itm_nber
                     AND i.sad_num = iva.sad_num
                     AND iva.saditm_tax_code = 'IVA'
                     AND g.sad_num = 0
                     AND g.lst_ope = 'U'
                     AND g.sad_reg_year = f.alc_gestion
                     AND g.key_cuo = f.alc_aduana
                     AND g.sad_reg_serial = 'C'
                     AND g.sad_reg_nber = f.alc_numero
                     AND c.ali_numero_item = i.itm_nber
                     AND c.ali_num = 0
                     AND c.ali_lstope = 'U'
                     AND c.alc_alcance_id = f.alc_alcance_id
                     AND f.alc_tipo_alcance = 'ITEM'
                     AND f.alc_tipo_tramite = 'DUI'
                     AND f.alc_num = 0
                     AND f.alc_lstope = 'U'
                     AND f.alc_alcance_id = prm_codigo
            ORDER BY   4,
                       5,
                       7,
                       1;

        RETURN ct;
    END;

    FUNCTION devuelve_notificacion (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT   a.ctl_control_id,
                     TO_CHAR (a.not_fecha_notificacion, 'dd/mm/yyyy'),
                     a.not_tipo_notificacion,
                     a.not_obs_notificacion,
                     a.not_num,
                     a.not_lstope,
                     a.not_usuario,
                     a.not_fecsys
              FROM   fis_notificacion a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.not_num = 0
                     AND a.not_lstope = 'U';

        RETURN ct;
    END;

    FUNCTION devuelve_not_conclusion (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT   a.ctl_control_id,
                     TO_CHAR (a.ndc_fecha_notificacion, 'dd/mm/yyyy'),
                     a.ndc_tipo_notificacion,
                     a.ndc_num,
                     a.ndc_lstope,
                     a.ndc_usuario,
                     a.ndc_fecsys
              FROM   fis_not_conclusion a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.ndc_num = 0
                     AND a.ndc_lstope = 'U';

        RETURN ct;
    END;

    FUNCTION devuelve_conclusion (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT   a.ctl_control_id,
                     a.con_tipo_doc_con,
                     a.con_num_doc_con,
                     TO_CHAR (a.con_fecha_doc_con, 'dd/mm/yyyy'),
                     a.con_num,
                     a.con_lstope,
                     a.con_usuario,
                     a.con_fecsys
              FROM   fis_conclusion a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.con_num = 0
                     AND a.con_lstope = 'U';

        RETURN ct;
    END;

    FUNCTION verifica_ampliacion_control (prm_codigo VARCHAR2)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_gestion       VARCHAR2 (4);
        v_numero        NUMBER;
        val             VARCHAR2 (100);
        cad             VARCHAR2 (30000);
        v_key_year      VARCHAR2 (4);
        v_key_cou       VARCHAR2 (3);
        v_reg_nber      VARCHAR2 (10);
        existe          NUMBER;
        error_dui       VARCHAR2 (30000) := '';
        total           NUMBER := 0;
        grabadas        NUMBER := 0;
        v_tipo          VARCHAR2 (10);
        v_tipocontrol   VARCHAR2 (20);
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF existe = 0
        THEN
            RETURN 'No existe el Control';
        END IF;

        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.est_num = 0
                 AND a.est_lstope = 'U'
                 AND est_estado = 'REGISTRADO';

        IF existe = 0
        THEN
            RETURN 'El Control no est&aacute; en estado registrado';
        END IF;

        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           AND v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            RETURN 'No se puede registrar ampliaci&oacute;n de alcance de una fiscalizaci&oacute;n ampliatoria';
        END IF;

        IF v_tipocontrol = 'DIFERIDO'
        THEN
            RETURN 'No se puede registrar ampliaci&oacute;n de alcance de un Control Diferido';
        END IF;


        RETURN 'CORRECTO';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;
END;
/


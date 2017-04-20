CREATE OR REPLACE 
PACKAGE pkg_migracion
/* Formatted on 6-feb.-2017 4:51:30 (QP5 v5.126) */
IS
    TYPE cursortype IS REF CURSOR;

    PROCEDURE migracion_diferido (prm_gestion         VARCHAR2,
                                  prm_gerencia         VARCHAR2,
                                  prm_resultado   OUT VARCHAR2);


    FUNCTION graba_memorizacion_diferido (
        prm_tipo_doc_identidad    IN VARCHAR2,
        prm_nit                   IN VARCHAR2,
        prm_razon_social          IN VARCHAR2,
        prm_ci                    IN VARCHAR2,
        prm_ci_exp                IN VARCHAR2,
        prm_nombres               IN VARCHAR2,
        prm_appat                 IN VARCHAR2,
        prm_apmat                 IN VARCHAR2,
        prm_direccion             IN VARCHAR2,
        prm_actividad_principal   IN VARCHAR2,
        prm_usuario               IN VARCHAR2,
        prm_tipo_operador         IN VARCHAR2,
        prm_periodo               IN VARCHAR2,
        prm_gerencia              IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_tram_dec (prm_id              VARCHAR2,
                             prm_tipo_tramite    VARCHAR2,
                             prm_gestion         VARCHAR2,
                             prm_aduana          VARCHAR2,
                             prm_numero          VARCHAR2,
                             prm_tipo_etapa      VARCHAR2,
                             prm_usuario         VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_asignacion (prm_id         VARCHAR2,
                               prm_usufis     VARCHAR2,
                               prm_cargo      VARCHAR2,
                               prm_usuario    VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION registra_control (prm_codigo                    VARCHAR2,
                               prm_gerencia                  VARCHAR2,
                               prm_usuario                   VARCHAR2,
                               prm_corr                      VARCHAR2,
                               prm_inn_1                     VARCHAR2,
                               prm_inn_2                     VARCHAR2,
                               prm_inn_3                     VARCHAR2,
                               prm_inn_4                     VARCHAR2,
                               prm_inn_5                     VARCHAR2,
                               prm_inn_6                     VARCHAR2,
                               prm_inn_7                     VARCHAR2,
                               prm_inn_8                     VARCHAR2,
                               prm_inn_9                     VARCHAR2,
                               prm_inn_10                    VARCHAR2,
                               prm_inn_11                    VARCHAR2,
                               prm_inn_12                    VARCHAR2,
                               prm_inn_13                    VARCHAR2,
                               prm_inn_14                    VARCHAR2,
                               prm_inn_15                    VARCHAR2,
                               prm_inn_16                    VARCHAR2,
                               prm_inn_17                    VARCHAR2,
                               prm_inn_18                    VARCHAR2,
                               prm_inn_19                    VARCHAR2,
                               prm_inn_20                    VARCHAR2,
                               prm_inn_21                    VARCHAR2,
                               prm_inn_plazo_conclusion      VARCHAR2,
                               prm_tribga                 IN VARCHAR2,
                               prm_tribiva                IN VARCHAR2,
                               prm_tribice                IN VARCHAR2,
                               prm_tribiehd               IN VARCHAR2,
                               prm_tribicd                IN VARCHAR2,
                               prm_tribnoaplica           IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_notificacion (prm_id          VARCHAR2,
                                 prm_usuario     VARCHAR2,
                                 prm_fechanot    VARCHAR2,
                                 prm_tiponot     VARCHAR2,
                                 prm_obs         VARCHAR2)
        RETURN VARCHAR2;

    PROCEDURE migracion_diferido_indice (prm_gestion         VARCHAR2,
                                  prm_resultado   OUT VARCHAR2);
END;
/

CREATE OR REPLACE 
PACKAGE BODY pkg_migracion
/* Formatted on 6-feb.-2017 6:40:25 (QP5 v5.126) */
IS
    PROCEDURE migracion_diferido (prm_gestion         VARCHAR2,
                                  prm_gerencia         VARCHAR2,
                                  prm_resultado   OUT VARCHAR2)
    IS
        v_prueba      VARCHAR2 (1000) := '';
        res           VARCHAR2 (300) := '';
        v_consig      VARCHAR2 (50) := '';
        v_error       VARCHAR2 (1000);
        v_codigo      VARCHAR2 (50);
        v_tipo        VARCHAR2 (10) := '';
        v_emision     VARCHAR2 (10) := '';
        v_razon       VARCHAR2 (100) := '';
        v_nombre      VARCHAR2 (100) := '';
        v_appat       VARCHAR2 (100) := '';
        v_apmat       VARCHAR2 (100) := '';
        v_aux       VARCHAR2 (100) := '';
        v_direccion   VARCHAR2 (150) := '';
        v_actividad   VARCHAR2 (300) := '';
        existe        NUMBER (10);
        cont          NUMBER (10) := 0;
        total         NUMBER (10) := 0;
        rep           NUMBER (10) := 0;
    BEGIN
        FOR i
        IN (  SELECT   a.fis_gestion,
                       a.fis_gerencia,
                       a.fis_nro_control,
                       a.fis_key_year,
                       a.fis_key_cuo,
                       a.fis_key_nber,
                       a.fis_key_dec,
                       a.sad_reg_year,
                       a.sad_reg_serial,
                       a.sad_reg_nber,
                       a.fis_fec_pase_salida,
                       a.fis_fec_registro,
                       a.fis_usuario_registro,
                       a.fis_fec_asignacion,
                       a.fis_usuario_asignacion,
                       a.fis_fec_notificacion,
                       a.fis_obs_notificacion,
                       a.fis_tipo_notificacion,
                       a.fis_usuario_notificacion,
                       a.fis_fec_liquidacion,
                       a.fis_tributo_omitido_ga,
                       a.fis_tributo_omitido_iva,
                       a.fis_tributo_omitido_ice,
                       a.fis_tributo_omitido_iehd,
                       a.fis_sancion_omision,
                       a.fis_multa_contrava,
                       a.fis_multa_contrabc,
                       a.fis_multa_contrabd,
                       a.fis_usuario_resultados,
                       a.fis_fec_aceptacion,
                       a.fis_tipo_doc_con,
                       a.fis_reg_nro_inf,
                       a.fis_reg_fec_inf,
                       a.fis_reg_nro_doc_con,
                       a.fis_reg_fec_doc_con,
                       a.fis_fec_finalizacion,
                       a.fis_reg_fec_not_doc,
                       a.fis_reg_tip_not_doc,
                       a.fis_reg_fec_env_legal,
                       a.fis_reg_nro_env_legal,
                       a.fis_usuario_finalizacion,
                       a.fis_estado,
                       a.fis_lst_ope,
                       a.fis_usuario,
                       a.fis_numver,
                       a.fis_fecha,
                       a.fis_fiscalizador,
                       a.fis_ovalor,
                       a.fis_opartida,
                       a.fis_oorigen,
                       a.fis_osinobs,
                       a.fis_comision,
                       a.fis_ccondel,
                       a.fis_cconcon,
                       a.fis_cconadu,
                       a.fis_tributo_omitido_ufv_ga,
                       a.fis_tributo_omitido_ufv_iva,
                       a.fis_tributo_omitido_ufv_ice,
                       a.fis_tributo_omitido_ufv_iehd,
                       a.fis_sancion_omision_ufv,
                       a.fis_multa_contrava_ufv,
                       a.fis_multa_contrabc_ufv,
                       a.fis_multa_contrabd_ufv,
                       a.fis_valor_ufv,
                       a.fis_usuario_aceptacion,
                       a.fis_usuario_not_doc_con,
                       a.fis_usuario_env_legal,
                       a.fis_origen_control,
                       a.fis_fob_inicial,
                       a.fis_fob_final,
                       a.fis_fecha_anul,
                       a.fis_obs_anulacion,
                       a.fis_fecha_cierre,
                       a.fis_obs_cierre
                FROM   sicodif.cd_fiscalizacion a
               WHERE       a.fis_lst_ope = 'U'
                       AND a.fis_numver = 0
                       AND a.fis_gestion = prm_gestion
                       and a.fis_gerencia = prm_gerencia
            ORDER BY   1, 2, 3)
        LOOP
            --v_prueba := v_prueba || ', ' || TO_CHAR (i.fis_nro_control);
            total := total + 1;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_alcance a
             WHERE       a.alc_tipo_tramite = 'DUI'
                     AND a.alc_gestion = i.sad_reg_year
                     AND a.alc_aduana = i.fis_key_cuo
                     AND a.alc_numero = i.sad_reg_nber
                     AND a.alc_num = 0
                     AND a.alc_lstope = 'U';

            IF existe = 0
            THEN
                cont := cont + 1;

                v_aux := i.sad_reg_year||' '||i.fis_key_cuo||' '||i.sad_reg_nber;

                SELECT   count(1)
                  INTO   existe
                  FROM   ops$asy.sad_gen a
                 WHERE       a.sad_num = 0
                         AND a.sad_reg_year = i.sad_reg_year
                         AND a.key_cuo = i.fis_key_cuo
                         AND a.sad_reg_serial = i.sad_reg_serial
                         AND a.sad_reg_nber = i.sad_reg_nber;

                if existe = 0
                THEN

                    v_error:= v_error ||' - '|| v_aux;
                else
                SELECT   a.sad_consignee
                  INTO   v_consig
                  FROM   ops$asy.sad_gen a
                 WHERE       a.sad_num = 0
                         AND a.sad_reg_year = i.sad_reg_year
                         AND a.key_cuo = i.fis_key_cuo
                         AND a.sad_reg_serial = i.sad_reg_serial
                         AND a.sad_reg_nber = i.sad_reg_nber;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   ops$asy.bo_oce_opecab a
                 WHERE       a.ope_numerodoc = v_consig
                         AND ope_num = 0
                         AND ROWNUM = 1;

                IF (existe > 0)
                THEN
                    SELECT   a.ope_razonsocial,
                                a.ope_direccion
                             || ', N'
                             || CHR (186)
                             || ' '
                             || a.ope_nrodireccion
                             || ', ZONA '
                             || a.ope_zona
                             || ', '
                             || a.ope_ciudad,
                             UPPER(pkg_general.fn_devuelve_actividad (
                                       a.ope_numerodoc)),
                            a.ope_tipodoc,
                            a.ope_nombre,
                            a.ope_paterno,
                            a.ope_materno,
                            a.ope_emisiondoc
                      INTO   v_razon, v_direccion, v_actividad, v_tipo, v_nombre, v_appat, v_apmat, v_emision
                      FROM   ops$asy.bo_oce_opecab a
                     WHERE       a.ope_numerodoc = v_consig
                             AND ope_num = 0
                             AND ROWNUM = 1;
                END IF;

                res :=
                    pkg_migracion.graba_memorizacion_diferido (
                        v_tipo,
                        v_consig,
                        v_razon,
                        v_consig,
                        v_emision,
                        v_nombre,
                        v_appat,
                        v_apmat,
                        v_direccion,
                        v_actividad,
                        'FISCALIZACION',
                        'IMPORTADOR/EXPORTADOR',
                        '2017',
                        SUBSTR (i.fis_gerencia, 0, 3));

                IF (SUBSTR (res, 0, 8) = 'CORRECTO')
                THEN
                    v_codigo := SUBSTR (res, 9);
                    res :=
                        graba_tram_dec (v_codigo,
                                        'DUI',
                                        i.sad_reg_year,
                                        i.fis_key_cuo,
                                        i.sad_reg_nber,
                                        'NORMAL',
                                        'FISCALIZACION');

                    IF NOT i.fis_usuario_asignacion IS NULL
                    THEN
                        res :=
                            graba_asignacion (v_codigo,
                                              i.fis_usuario_asignacion,
                                              'JEFE',
                                              'FISCALIZACION');
                    END IF;

                    IF NOT i.fis_fiscalizador IS NULL
                    THEN
                        res :=
                            graba_asignacion (v_codigo,
                                              i.fis_fiscalizador,
                                              'FISCALIZADOR',
                                              'FISCALIZACION');
                    END IF;

                    IF i.fis_nro_control = '0'
                    THEN
                        res := 'OK';
                    ELSE
                        res :=
                            registra_control (v_codigo,
                                              SUBSTR (i.fis_gerencia, 0, 3),
                                              'FISCALIZACION',
                                              i.fis_nro_control,
                                              'on',
                                              'on',
                                              'on',
                                              'on',
                                              'on',
                                              'on',
                                              'on',
                                              'on',
                                              'on',
                                              'on',
                                              'on',
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              '3',
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL);

                        IF NOT i.fis_usuario_notificacion IS NULL
                        THEN
                            res :=
                                graba_notificacion (v_codigo,
                                                    'FISCALIZACION',
                                                    i.fis_fec_notificacion,
                                                    i.fis_tipo_notificacion,
                                                    i.fis_obs_notificacion);
                        END IF;
                    END IF;
                ELSE
                    v_error :=
                           v_error
                        || ', '
                        || i.sad_reg_year
                        || '/'
                        || i.fis_key_cuo
                        || '/'
                        || i.sad_reg_serial
                        || '-'
                        || i.sad_reg_nber;
                END IF;
                END IF;
            else
                rep := rep + 1;
            END IF;
        END LOOP;

        prm_resultado := 'Total Controles Diferidos : '||to_char(total)||' migrados '||to_char(cont)||' existentes '||to_char(rep)||' error: '||v_error;
    END;


    FUNCTION graba_memorizacion_diferido (
        prm_tipo_doc_identidad    IN VARCHAR2,
        prm_nit                   IN VARCHAR2,
        prm_razon_social          IN VARCHAR2,
        prm_ci                    IN VARCHAR2,
        prm_ci_exp                IN VARCHAR2,
        prm_nombres               IN VARCHAR2,
        prm_appat                 IN VARCHAR2,
        prm_apmat                 IN VARCHAR2,
        prm_direccion             IN VARCHAR2,
        prm_actividad_principal   IN VARCHAR2,
        prm_usuario               IN VARCHAR2,
        prm_tipo_operador         IN VARCHAR2,
        prm_periodo               IN VARCHAR2,
        prm_gerencia              IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res         VARCHAR2 (50);
        v_gestion   VARCHAR2 (4);
        v_numero    NUMBER;
    BEGIN
        v_gestion := TO_CHAR (SYSDATE, 'yyyy');
        v_numero := pkg_memorizacion.numero_control (v_gestion);

        INSERT INTO fis_control (ctl_control_id,
                                 ctl_cod_tipo,
                                 ctl_tipo_doc_identidad,
                                 ctl_nit,
                                 ctl_razon_social,
                                 ctl_ci,
                                 ctl_ci_exp,
                                 ctl_nombres,
                                 ctl_appat,
                                 ctl_apmat,
                                 ctl_direccion,
                                 ctl_actividad_principal,
                                 ctl_num,
                                 ctl_lstope,
                                 ctl_usuario,
                                 ctl_fecsys,
                                 ctl_tipo_operador,
                                 ctl_periodo,
                                 ctl_cod_gerencia)
          VALUES   (v_gestion || v_numero,
                    'DIFERIDO',
                    prm_tipo_doc_identidad,
                    prm_nit,
                    prm_razon_social,
                    prm_ci,
                    prm_ci_exp,
                    prm_nombres,
                    prm_appat,
                    prm_apmat,
                    prm_direccion,
                    prm_actividad_principal,
                    0,
                    'U',
                    prm_usuario,
                    SYSDATE,
                    prm_tipo_operador,
                    prm_periodo,
                    prm_gerencia);



        INSERT INTO fis_estado (ctl_control_id,
                                est_estado,
                                est_num,
                                est_lstope,
                                est_usuario,
                                est_fecsys)
          VALUES   (v_gestion || v_numero,
                    'MEMORIZADO',
                    0,
                    'U',
                    prm_usuario,
                    SYSDATE);

        COMMIT;
        RETURN 'CORRECTO' || v_gestion || v_numero;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            ROLLBACK;
            RETURN 'No se pudo memorizar el control';
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;


    FUNCTION graba_tram_dec (prm_id              VARCHAR2,
                             prm_tipo_tramite    VARCHAR2,
                             prm_gestion         VARCHAR2,
                             prm_aduana          VARCHAR2,
                             prm_numero          VARCHAR2,
                             prm_tipo_etapa      VARCHAR2,
                             prm_usuario         VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (100);
        existe       NUMBER;
        v_gestion    VARCHAR2 (4);
        v_numero     NUMBER;
        declarante   VARCHAR2 (30);
        importador   VARCHAR2 (30);
        totitem      NUMBER := 0;
        v_item       NUMBER (10);
        v_codigo     NUMBER (18, 0);
        existetram   VARCHAR2 (300) := 'SIN CONTROL';
    BEGIN
        IF prm_gestion > TO_CHAR (SYSDATE, 'YYYY')
        THEN
            RETURN 'La Gesti&oacute;n no puede ser mayor a la actual';
        END IF;

        IF prm_tipo_tramite = 'DUI'
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   ops$asy.sad_gen a
             WHERE       a.sad_flw = 1
                     AND a.sad_num = 0
                     AND a.sad_reg_year = prm_gestion
                     AND a.key_cuo = prm_aduana
                     AND a.sad_reg_serial = 'C'
                     AND a.sad_reg_nber = prm_numero;

            IF existe > 0
            THEN
                SELECT   a.key_dec, a.sad_consignee, a.sad_itm_total
                  INTO   declarante, importador, totitem
                  FROM   ops$asy.sad_gen a
                 WHERE       a.sad_flw = 1
                         AND a.sad_num = 0
                         AND a.sad_reg_year = prm_gestion
                         AND a.key_cuo = prm_aduana
                         AND a.sad_reg_serial = 'C'
                         AND a.sad_reg_nber = prm_numero;



                /*SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance b
                 WHERE       b.alc_gestion = prm_gestion
                         AND b.alc_aduana = prm_aduana
                         AND b.alc_numero = prm_numero
                         AND b.alc_tipo_tramite = prm_tipo_tramite
                         AND b.alc_num = 0
                         AND b.alc_lstope = 'U';*/

                IF existetram = 'SIN CONTROL'
                THEN
                    v_item := 1;

                    WHILE (v_item <= totitem)
                    LOOP
                        SELECT   COUNT (1)
                          INTO   existe
                          FROM   fis_alcance b
                         WHERE       b.alc_gestion = prm_gestion
                                 AND b.alc_aduana = prm_aduana
                                 AND b.alc_numero = prm_numero
                                 AND b.alc_tipo_tramite = prm_tipo_tramite
                                 AND b.alc_num = 0
                                 AND b.alc_lstope = 'U'
                                 AND b.ctl_control_id = prm_id;

                        IF existe = 0
                        THEN
                            v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                            v_numero :=
                                pkg_memorizacion.numero_control_alc (
                                    v_gestion);

                            INSERT INTO fis_alcance (alc_alcance_id,
                                                     alc_tipo_alcance,
                                                     alc_tipo_tramite,
                                                     alc_gestion,
                                                     alc_aduana,
                                                     alc_numero,
                                                     alc_num,
                                                     alc_lstope,
                                                     alc_usuario,
                                                     alc_fecsys,
                                                     ctl_control_id,
                                                     alc_tipo_etapa)
                              VALUES   (v_gestion || TO_CHAR (v_numero),
                                        'DECLARACION',
                                        prm_tipo_tramite,
                                        prm_gestion,
                                        prm_aduana,
                                        prm_numero,
                                        0,
                                        'U',
                                        prm_usuario,
                                        SYSDATE,
                                        prm_id,
                                        prm_tipo_etapa);

                            INSERT INTO fis_alcance_item (alc_alcance_id,
                                                          ali_numero_item,
                                                          ali_obs_valor,
                                                          ali_obs_partida,
                                                          ali_obs_origen,
                                                          ali_num,
                                                          ali_lstope,
                                                          ali_usuario,
                                                          ali_fecsys,
                                                          ali_obs_otro,
                                                          ali_tipo_etapa)
                              VALUES   (v_gestion || TO_CHAR (v_numero),
                                        v_item,
                                        'x',
                                        'x',
                                        'x',
                                        0,
                                        'U',
                                        prm_usuario,
                                        SYSDATE,
                                        'x',
                                        prm_tipo_etapa);
                        ELSE
                            SELECT   b.alc_alcance_id
                              INTO   v_codigo
                              FROM   fis_alcance b
                             WHERE       b.alc_gestion = prm_gestion
                                     AND b.alc_aduana = prm_aduana
                                     AND b.alc_numero = prm_numero
                                     AND b.alc_tipo_tramite =
                                            prm_tipo_tramite
                                     AND b.alc_num = 0
                                     AND b.alc_lstope = 'U'
                                     AND b.ctl_control_id = prm_id;

                            SELECT   COUNT (1)
                              INTO   existe
                              FROM   fis_alcance_item b
                             WHERE   b.alc_alcance_id = v_codigo
                                     AND b.ali_numero_item = v_item;

                            IF existe = 0
                            THEN
                                INSERT INTO fis_alcance_item (alc_alcance_id,
                                                              ali_numero_item,
                                                              ali_obs_valor,
                                                              ali_obs_partida,
                                                              ali_obs_origen,
                                                              ali_num,
                                                              ali_lstope,
                                                              ali_usuario,
                                                              ali_fecsys,
                                                              ali_obs_otro,
                                                              ali_tipo_etapa)
                                  VALUES   (v_codigo,
                                            v_item,
                                            'x',
                                            'x',
                                            'x',
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE,
                                            'x',
                                            prm_tipo_etapa);
                            ELSE
                                UPDATE   fis_alcance_item
                                   SET   ali_num = existe
                                 WHERE       alc_alcance_id = v_codigo
                                         AND ali_numero_item = v_item
                                         AND ali_num = 0;

                                INSERT INTO fis_alcance_item a (a.alc_alcance_id,
                                                                a.ali_numero_item,
                                                                a.ali_obs_valor,
                                                                a.ali_obs_partida,
                                                                a.ali_obs_origen,
                                                                a.ali_num,
                                                                a.ali_lstope,
                                                                a.ali_usuario,
                                                                a.ali_fecsys,
                                                                a.ali_obs_otro,
                                                                a.ali_tipo_etapa)
                                  VALUES   (v_codigo,
                                            v_item,
                                            'x',
                                            'x',
                                            'x',
                                            0,
                                            'U',
                                            prm_usuario,
                                            SYSDATE,
                                            'x',
                                            prm_tipo_etapa);
                            END IF;
                        END IF;

                        v_item := v_item + 1;
                        COMMIT;
                    END LOOP;
                END IF;

                COMMIT;
                res :=
                       'CORRECTOSe grabo correctamente la DUI '
                    || prm_gestion
                    || '/'
                    || prm_aduana
                    || '/C-'
                    || prm_numero;
            ELSE
                RETURN 'La DUI no es valida';
            END IF;
        END IF;

        RETURN res;
    END;

    FUNCTION graba_asignacion (prm_id         VARCHAR2,
                               prm_usufis     VARCHAR2,
                               prm_cargo      VARCHAR2,
                               prm_usuario    VARCHAR2)
        RETURN VARCHAR2
    IS
        res         VARCHAR2 (300) := 0;
        existe      NUMBER;
        v_gestion   VARCHAR2 (4);
        v_numero    NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_fiscalizador a
         WHERE       a.fis_codigo_fiscalizador = prm_usufis
                 AND a.ctl_control_id = prm_id
                 AND a.fis_num = 0
                 AND a.fis_lstope = 'U';

        IF existe = 0
        THEN
            IF prm_cargo = 'JEFE'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_fiscalizador a
                 WHERE       a.ctl_control_id = prm_id
                         AND a.fis_num = 0
                         AND a.fis_lstope = 'U'
                         AND a.fis_cargo = 'JEFE';

                IF existe = 1
                THEN
                    RETURN 'Solo se puede registrar un funcionario como Jefe';
                ELSE
                    v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                    v_numero :=
                        pkg_memorizacion.numero_control_asig (v_gestion);

                    INSERT INTO fis_fiscalizador (fis_fiscalizador_id,
                                                  fis_codigo_fiscalizador,
                                                  fis_cargo,
                                                  fis_num,
                                                  fis_lstope,
                                                  fis_usuario,
                                                  fis_fecsys,
                                                  ctl_control_id)
                      VALUES   (v_gestion || TO_CHAR (v_numero),
                                prm_usufis,
                                prm_cargo,
                                0,
                                'U',
                                prm_usuario,
                                SYSDATE,
                                prm_id);

                    COMMIT;
                    RETURN 'CORRECTOSe asign&oacute;  correctamente al fiscalizador '
                           || UPPER (prm_usufis);
                END IF;
            ELSE
                v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                v_numero := pkg_memorizacion.numero_control_asig (v_gestion);

                INSERT INTO fis_fiscalizador (fis_fiscalizador_id,
                                              fis_codigo_fiscalizador,
                                              fis_cargo,
                                              fis_num,
                                              fis_lstope,
                                              fis_usuario,
                                              fis_fecsys,
                                              ctl_control_id)
                  VALUES   (v_gestion || TO_CHAR (v_numero),
                            prm_usufis,
                            prm_cargo,
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE,
                            prm_id);

                COMMIT;
                RETURN 'CORRECTOSe asign&oacute;  correctamente al fiscalizador '
                       || UPPER (prm_usufis);
            END IF;
        ELSE
            RETURN 'El fiscalizador ya se encuentra asignado al Control';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;


    FUNCTION registra_control (prm_codigo                    VARCHAR2,
                               prm_gerencia                  VARCHAR2,
                               prm_usuario                   VARCHAR2,
                               prm_corr                      VARCHAR2,
                               prm_inn_1                     VARCHAR2,
                               prm_inn_2                     VARCHAR2,
                               prm_inn_3                     VARCHAR2,
                               prm_inn_4                     VARCHAR2,
                               prm_inn_5                     VARCHAR2,
                               prm_inn_6                     VARCHAR2,
                               prm_inn_7                     VARCHAR2,
                               prm_inn_8                     VARCHAR2,
                               prm_inn_9                     VARCHAR2,
                               prm_inn_10                    VARCHAR2,
                               prm_inn_11                    VARCHAR2,
                               prm_inn_12                    VARCHAR2,
                               prm_inn_13                    VARCHAR2,
                               prm_inn_14                    VARCHAR2,
                               prm_inn_15                    VARCHAR2,
                               prm_inn_16                    VARCHAR2,
                               prm_inn_17                    VARCHAR2,
                               prm_inn_18                    VARCHAR2,
                               prm_inn_19                    VARCHAR2,
                               prm_inn_20                    VARCHAR2,
                               prm_inn_21                    VARCHAR2,
                               prm_inn_plazo_conclusion      VARCHAR2,
                               prm_tribga                 IN VARCHAR2,
                               prm_tribiva                IN VARCHAR2,
                               prm_tribice                IN VARCHAR2,
                               prm_tribiehd               IN VARCHAR2,
                               prm_tribicd                IN VARCHAR2,
                               prm_tribnoaplica           IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res             VARCHAR2 (300) := 0;
        v_gestion       VARCHAR2 (4);
        v_numero        NUMBER;
        v_numeroinfo    NUMBER;
        v_numeroamp     VARCHAR2 (15);
        val             VARCHAR2 (100);
        cad             VARCHAR2 (30000);
        v_key_year      VARCHAR2 (4);
        v_key_cou       VARCHAR2 (3);
        v_reg_nber      VARCHAR2 (10);
        existe          NUMBER;
        error_dui       VARCHAR2 (30000) := '';
        total           NUMBER := 0;
        grabadas        NUMBER := 0;
        v_tipo          VARCHAR2 (30);
        v_tipocontrol   VARCHAR2 (30);
        v_codigofisca   VARCHAR2 (100);
    BEGIN
        IF     prm_inn_1 IS NULL
           AND prm_inn_2 IS NULL
           AND prm_inn_3 IS NULL
           AND prm_inn_4 IS NULL
           AND prm_inn_5 IS NULL
           AND prm_inn_6 IS NULL
           AND prm_inn_7 IS NULL
           AND prm_inn_8 IS NULL
           AND prm_inn_9 IS NULL
           AND prm_inn_10 IS NULL
           AND prm_inn_11 IS NULL
           AND prm_inn_12 IS NULL
           AND prm_inn_13 IS NULL
           AND prm_inn_14 IS NULL
           AND prm_inn_15 IS NULL
           AND prm_inn_16 IS NULL
           AND prm_inn_17 IS NULL
           AND prm_inn_18 IS NULL
           AND prm_inn_19 IS NULL
           AND prm_inn_20 IS NULL
           AND prm_inn_21 IS NULL
        THEN
            RETURN 'Debe seleccionar por lo menos un elemento para el documento de notificaci&oacute;n';
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_control a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U';

            IF existe = 0
            THEN
                RETURN 'No existe el control';
            END IF;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_estado a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.est_num = 0
                     AND a.est_lstope = 'U'
                     AND est_estado = 'MEMORIZADO';

            IF existe = 0
            THEN
                RETURN 'El control no est&aacute; en estado Memorizado';
            END IF;

            SELECT   ctl_cod_tipo
              INTO   v_tipocontrol
              FROM   fis_control a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U';

            --CONTROL DEL ALCANCE
            IF v_tipocontrol = 'POSTERIOR'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.alc_num = 0
                         AND a.alc_lstope = 'U';

                IF existe = 0
                THEN
                    RETURN 'El control no tiene registrado alcance';
                END IF;
            END IF;

            IF v_tipocontrol = 'DIFERIDO'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.alc_num = 0
                         AND a.alc_lstope = 'U';

                IF existe = 0
                THEN
                    RETURN 'El control no tiene registrado alcance';
                END IF;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.alc_num = 0
                         AND a.alc_lstope = 'U'
                         AND a.alc_tipo_tramite <> 'DUI';

                IF existe > 0
                THEN
                    RETURN 'El control diferido no puede tener otros tipos de tr&aacute;mites registrados en el alcance';
                END IF;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.alc_num = 0
                         AND a.alc_lstope = 'U'
                         AND a.alc_tipo_tramite = 'DUI';

                IF existe > 1
                THEN
                    RETURN 'El control diferido no puede tener m&aacute;s de una declaraci&oacute;n registrada en el alcance';
                END IF;
            END IF;

            IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
               OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_alcance_amp a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.amp_num = 0
                         AND a.amp_lstope = 'U';

                IF existe = 0
                THEN
                    RETURN 'El control ampliatorio no tiene registrado alcance';
                END IF;
            END IF;

            --CONTROL DE LA ASIGNACION DE FISCALIZADORES
            IF v_tipocontrol = 'POSTERIOR' OR v_tipocontrol = 'DIFERIDO'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_fiscalizador a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.fis_cargo = 'FISCALIZADOR'
                         AND fis_num = 0
                         AND fis_lstope = 'U';

                IF existe = 0
                THEN
                    RETURN 'El control no tiene registrado fiscalizador';
                END IF;
            END IF;

            --CONTROL DEL LOS TIPOS PARA GENERAR EL REGISTRO
            IF v_tipocontrol = 'POSTERIOR' OR v_tipocontrol = 'DIFERIDO'
            THEN
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
                            'REGISTRADO',
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE);

                SELECT   a.ctl_cod_tipo
                  INTO   v_tipo
                  FROM   fis_control a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U';

                v_gestion := TO_CHAR (SYSDATE, 'yyyy');
                v_numero := prm_corr;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_control a
                 WHERE   a.ctl_control_id = prm_codigo;

                UPDATE   fis_control
                   SET   ctl_num = existe
                 WHERE   ctl_control_id = prm_codigo AND ctl_num = 0;

                INSERT INTO fis_control
                    SELECT   a.ctl_control_id,
                             v_gestion,
                             a.ctl_cod_tipo,
                             prm_gerencia,
                             v_numero,
                             a.ctl_tipo_documento,
                             a.ctl_nro_documento,
                             a.ctl_fecha_documento,
                             a.ctl_obs_documento,
                             a.ctl_riesgo_identificado,
                             a.ctl_tipo_doc_identidad,
                             a.ctl_nit,
                             a.ctl_razon_social,
                             a.ctl_ci,
                             a.ctl_ci_exp,
                             a.ctl_nombres,
                             a.ctl_appat,
                             a.ctl_apmat,
                             a.ctl_direccion,
                             a.ctl_actividad_principal,
                             a.ctl_amp_correlativo,
                             0,
                             'U',
                             prm_usuario,
                             SYSDATE,
                             a.ctl_tipo_operador,
                             a.ctl_tribtodos,
                             prm_tribga,
                             prm_tribiva,
                             prm_tribice,
                             prm_tribiehd,
                             prm_tribicd,
                             prm_tribnoaplica,
                             a.ctl_periodo,
                             a.ctl_riesgodelito,
                             a.ctl_riesgosubval,
                             a.ctl_riesgoclas,
                             a.ctl_riesgocontrab,
                             a.ctl_amp_control,
                             a.ctl_periodo_solicitar
                      FROM   fis_control a
                     WHERE       ctl_control_id = prm_codigo
                             AND ctl_num = existe
                             AND ROWNUM = 1;

                v_numeroinfo :=
                    pkg_memorizacion.numero_control_gen (v_gestion,
                                                         'INF',
                                                         prm_gerencia);

                INSERT INTO fis_info_notificacion a (a.inn_infnot_id,
                                                     a.inn_plazo_conclusion,
                                                     a.inn_1,
                                                     a.inn_2,
                                                     a.inn_3,
                                                     a.inn_4,
                                                     a.inn_5,
                                                     a.inn_6,
                                                     a.inn_7,
                                                     a.inn_8,
                                                     a.inn_9,
                                                     a.inn_10,
                                                     a.inn_11,
                                                     a.inn_12,
                                                     a.inn_13,
                                                     a.inn_14,
                                                     a.inn_15,
                                                     a.inn_16,
                                                     a.inn_17,
                                                     a.inn_18,
                                                     a.inn_19,
                                                     a.inn_20,
                                                     a.inn_21,
                                                     a.inn_num,
                                                     a.inn_lstope,
                                                     a.inn_usuario,
                                                     a.inn_fecsys,
                                                     a.ctl_control_id)
                  VALUES   (v_gestion || v_numeroinfo,
                            prm_inn_plazo_conclusion,
                            prm_inn_1,
                            prm_inn_2,
                            prm_inn_3,
                            prm_inn_4,
                            prm_inn_5,
                            prm_inn_6,
                            prm_inn_7,
                            prm_inn_8,
                            prm_inn_9,
                            prm_inn_10,
                            prm_inn_11,
                            prm_inn_12,
                            prm_inn_13,
                            prm_inn_14,
                            prm_inn_15,
                            prm_inn_16,
                            prm_inn_17,
                            prm_inn_18,
                            prm_inn_19,
                            prm_inn_20,
                            prm_inn_21,
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE,
                            prm_codigo);

                COMMIT;

                SELECT   a.ctl_cod_gestion
                         || DECODE (a.ctl_cod_tipo,
                                    'DIFERIDO', 'CD',
                                    'POSTERIOR', 'FP',
                                    'AMPLIATORIA DIFERIDO', 'CD',
                                    'AMPLIATORIA POSTERIOR', 'FP',
                                    '-')
                         || a.ctl_cod_gerencia
                         || DECODE (
                                a.ctl_amp_correlativo,
                                NULL,
                                '00',
                                DECODE (LENGTH (a.ctl_amp_correlativo),
                                        1, '0' || a.ctl_amp_correlativo,
                                        a.ctl_amp_correlativo))
                         || DECODE (LENGTH (a.ctl_cod_numero),
                                    1, '0000' || a.ctl_cod_numero,
                                    2, '000' || a.ctl_cod_numero,
                                    3, '00' || a.ctl_cod_numero,
                                    4, '0' || a.ctl_cod_numero,
                                    a.ctl_cod_numero)
                  INTO   v_codigofisca
                  FROM   fis_control a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U';


                res :=
                    'CORRECTOSe registr&oacute; correctamente el Control '
                    || v_codigofisca;
                RETURN res;
            END IF;

            IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
               OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
            THEN
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
                            'REGISTRADO',
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE);

                SELECT   COUNT (1) + 1
                  INTO   v_numero
                  FROM   fis_control a, fis_control c
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.ctl_cod_gestion = c.ctl_cod_gestion
                         AND a.ctl_cod_tipo = c.ctl_cod_tipo
                         AND a.ctl_cod_gerencia = c.ctl_cod_gerencia
                         AND a.ctl_cod_numero = c.ctl_cod_numero
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U'
                         AND c.ctl_num = 0
                         AND c.ctl_lstope = 'U'
                         AND NOT c.ctl_amp_correlativo IS NULL;

                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_control a
                 WHERE   a.ctl_control_id = prm_codigo;

                UPDATE   fis_control
                   SET   ctl_num = existe
                 WHERE   ctl_control_id = prm_codigo AND ctl_num = 0;

                INSERT INTO fis_control
                    SELECT   a.ctl_control_id,
                             a.ctl_cod_gestion,
                             a.ctl_cod_tipo,
                             prm_gerencia,
                             a.ctl_cod_numero,
                             a.ctl_tipo_documento,
                             a.ctl_nro_documento,
                             a.ctl_fecha_documento,
                             a.ctl_obs_documento,
                             a.ctl_riesgo_identificado,
                             a.ctl_tipo_doc_identidad,
                             a.ctl_nit,
                             a.ctl_razon_social,
                             a.ctl_ci,
                             a.ctl_ci_exp,
                             a.ctl_nombres,
                             a.ctl_appat,
                             a.ctl_apmat,
                             a.ctl_direccion,
                             a.ctl_actividad_principal,
                             v_numero,
                             0,
                             'U',
                             prm_usuario,
                             SYSDATE,
                             a.ctl_tipo_operador,
                             a.ctl_tribtodos,
                             prm_tribga,
                             prm_tribiva,
                             prm_tribice,
                             prm_tribiehd,
                             prm_tribicd,
                             prm_tribnoaplica,
                             a.ctl_periodo,
                             a.ctl_riesgodelito,
                             a.ctl_riesgosubval,
                             a.ctl_riesgoclas,
                             a.ctl_riesgocontrab,
                             a.ctl_amp_control,
                             a.ctl_periodo_solicitar
                      FROM   fis_control a
                     WHERE       ctl_control_id = prm_codigo
                             AND ctl_num = existe
                             AND ROWNUM = 1;

                SELECT   ctl_cod_gestion,
                         ctl_cod_tipo,
                         ctl_cod_numero || '/' || ctl_amp_correlativo
                  INTO   v_gestion, v_tipo, v_numeroamp
                  FROM   fis_control a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U';

                v_numero :=
                    pkg_memorizacion.numero_control_gen (v_gestion,
                                                         'INF',
                                                         prm_gerencia);

                INSERT INTO fis_info_notificacion a (a.inn_infnot_id,
                                                     a.inn_plazo_conclusion,
                                                     a.inn_1,
                                                     a.inn_2,
                                                     a.inn_3,
                                                     a.inn_4,
                                                     a.inn_5,
                                                     a.inn_6,
                                                     a.inn_7,
                                                     a.inn_8,
                                                     a.inn_9,
                                                     a.inn_10,
                                                     a.inn_11,
                                                     a.inn_12,
                                                     a.inn_13,
                                                     a.inn_14,
                                                     a.inn_15,
                                                     a.inn_16,
                                                     a.inn_17,
                                                     a.inn_18,
                                                     a.inn_19,
                                                     a.inn_20,
                                                     a.inn_21,
                                                     a.inn_num,
                                                     a.inn_lstope,
                                                     a.inn_usuario,
                                                     a.inn_fecsys,
                                                     a.ctl_control_id)
                  VALUES   (v_gestion || v_numero,
                            prm_inn_plazo_conclusion,
                            prm_inn_1,
                            prm_inn_2,
                            prm_inn_3,
                            prm_inn_4,
                            prm_inn_5,
                            prm_inn_6,
                            prm_inn_7,
                            prm_inn_8,
                            prm_inn_9,
                            prm_inn_10,
                            prm_inn_11,
                            prm_inn_12,
                            prm_inn_13,
                            prm_inn_14,
                            prm_inn_15,
                            prm_inn_16,
                            prm_inn_17,
                            prm_inn_18,
                            prm_inn_19,
                            prm_inn_20,
                            prm_inn_21,
                            0,
                            'U',
                            prm_usuario,
                            SYSDATE,
                            prm_codigo);

                COMMIT;

                SELECT   a.ctl_cod_gestion
                         || DECODE (a.ctl_cod_tipo,
                                    'DIFERIDO', 'CD',
                                    'POSTERIOR', 'FP',
                                    'AMPLIATORIA DIFERIDO', 'CD',
                                    'AMPLIATORIA POSTERIOR', 'FP',
                                    '-')
                         || a.ctl_cod_gerencia
                         || DECODE (
                                a.ctl_amp_correlativo,
                                NULL,
                                '00',
                                DECODE (LENGTH (a.ctl_amp_correlativo),
                                        1, '0' || a.ctl_amp_correlativo,
                                        a.ctl_amp_correlativo))
                         || DECODE (LENGTH (a.ctl_cod_numero),
                                    1, '0000' || a.ctl_cod_numero,
                                    2, '000' || a.ctl_cod_numero,
                                    3, '00' || a.ctl_cod_numero,
                                    4, '0' || a.ctl_cod_numero,
                                    a.ctl_cod_numero)
                  INTO   v_codigofisca
                  FROM   fis_control a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U';


                res :=
                    'CORRECTOSe registr&oacute; correctamente el Control '
                    || v_codigofisca;
                RETURN res;
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
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
            RETURN 'CORRECTOSE REGISTRO CORRECTAMENTE LA NOTIFICACION';
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

            RETURN 'CORRECTOSE MODIFICO CORRECTAMENTE LA NOTIFICACION';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;


    PROCEDURE migracion_diferido_indice (prm_gestion         VARCHAR2,
                                         prm_resultado   OUT VARCHAR2)
    IS
        v_prueba      VARCHAR2 (1000) := '';
        res           VARCHAR2 (300) := '';
        v_consig      VARCHAR2 (50) := '';
        v_error       VARCHAR2 (50);
        v_codigo      VARCHAR2 (50);

        v_razon       VARCHAR2 (100) := '';
        v_direccion   VARCHAR2 (150) := '';
        v_actividad   VARCHAR2 (300) := '';
        existe        NUMBER (10);
    BEGIN
        FOR i
        IN (  SELECT   a.fis_gestion,
                       SUBSTR (a.fis_gerencia, 0, 3) gerencia,
                       MAX (a.fis_nro_control) numero
                FROM   sicodif.cd_fiscalizacion a
               WHERE   a.fis_lst_ope = 'U' AND a.fis_numver = 0
            GROUP BY   fis_gestion, fis_gerencia
            ORDER BY   1, 2)
        LOOP
            SELECT   COUNT (1)
              INTO   existe --a.app_gestion, a.app_tipo, a.app_gerencia, a.app_numero
              FROM   app_ser a
             WHERE       a.app_gestion = i.fis_gestion
                     AND a.app_tipo = 'DIFERIDO'
                     AND a.app_gerencia = i.gerencia;

            IF existe = 0
            THEN
                INSERT INTO app_ser (app_gestion,
                                     app_tipo,
                                     app_gerencia,
                                     app_numero)
                  VALUES   (i.fis_gestion,
                            'DIFERIDO',
                            i.gerencia,
                            i.numero);
            ELSE
                UPDATE   app_ser
                   SET   app_numero = i.numero
                 WHERE       app_gestion = i.fis_gestion
                         AND app_gerencia = i.gerencia
                         AND app_tipo = 'DIFERIDO';
            END IF;
        END LOOP;

        COMMIT;
        prm_resultado := v_prueba;
    END;
END;
/


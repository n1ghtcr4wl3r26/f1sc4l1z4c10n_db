CREATE OR REPLACE 
PACKAGE pkg_general
/* Formatted on 10-oct.-2017 12:16:04 (QP5 v5.126) */
IS
    TYPE cursortype IS REF CURSOR;

    FUNCTION plazo_dias_orden (prm_control IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION origen_dui (prm_sadregyear   IN VARCHAR2,
                         prm_keycuo          VARCHAR2,
                         prm_sadregnber      VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION fecha_registro_orden (prm_control IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION cantidad_tramites (prm_control IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION patron_declaracion (prm_sadregyear   IN VARCHAR2,
                                 prm_keycuo          VARCHAR2,
                                 prm_sadregnber      VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION items_control (prm_control IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION fecha_levante (prm_control IN VARCHAR2)
        RETURN date;

    FUNCTION fecha_levante (prm_sadregyear   IN VARCHAR2,
                            prm_keycuo          VARCHAR2,
                            prm_sadregnber      VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_fecha_levante (prm_key_year   IN VARCHAR2,
                                     prm_key_cuo    IN VARCHAR2,
                                     prm_key_dec    IN VARCHAR2,
                                     prm_key_nber   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION valida_fecha (prm_fecha IN VARCHAR2)
        RETURN NUMBER;

    FUNCTION valida_fechas (prm_fechaini   IN VARCHAR2,
                            prm_fechafin   IN VARCHAR2)
        RETURN NUMBER;

    FUNCTION devuelve_estadocontrol (prm_codigo IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION nombrecompleto (prm_codigo IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_fecha
        RETURN VARCHAR2;

    FUNCTION devuelve_pais (prm_codigo IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_tipo_empresa (nit IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION mostrar_botones (prm_codigo    IN VARCHAR2,
                              prm_usuario   IN VARCHAR2,
                              prm_opcion    IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION mostrar_botones_concluir (prm_codigo    IN VARCHAR2,
                                       prm_usuario   IN VARCHAR2,
                                       prm_opcion    IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION llenar_valores (prm_codigo    IN VARCHAR2,
                             prm_usuario   IN VARCHAR2,
                             prm_opcion    IN VARCHAR2,
                             prm_nivel     IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION lista_aduanas
        RETURN cursortype;

    FUNCTION lista_aduanas (gerencia VARCHAR2)
        RETURN cursortype;

    FUNCTION lista_paises
        RETURN cursortype;

    FUNCTION lista_gerencias (gerencia VARCHAR2)
        RETURN cursortype;

    FUNCTION lista_gerencias2 (gerencia VARCHAR2)
        RETURN cursortype;

    FUNCTION devuelve_datos_nit (prm_nit IN VARCHAR2)
        RETURN cursortype;

    FUNCTION devuelve_fecha_registro (prm_codigo IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_datos_control (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION fn_devuelve_actividad (p_nit IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION lista_fiscalizadores (gerencia VARCHAR)
        RETURN cursortype;

    FUNCTION lista_supervisores (gerencia VARCHAR)
        RETURN cursortype;

    FUNCTION lista_funcionarios (gerencia VARCHAR)
        RETURN cursortype;

    FUNCTION devuelve_codigo (gestion    IN VARCHAR2,
                              tipo       IN VARCHAR2,
                              gerencia   IN VARCHAR2,
                              numero     IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_gerencia (codigo IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_fis_asignados (codigo VARCHAR)
        RETURN cursortype;

    FUNCTION devuelve_fis_accesos (codigo VARCHAR)
        RETURN cursortype;

    FUNCTION roundsidunea (p_numero IN NUMBER, p_preci IN NUMBER)
        RETURN NUMBER;

    FUNCTION verifica_usuariogerencia (prm_codigo    IN VARCHAR2,
                                       prm_usuario   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION devuelve_datos_dui (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION esfechamenorigualahoy (prm_fecha IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION f_matriz_permutaciones (x IN NUMBER, y IN NUMBER)
        RETURN NUMBER;

    FUNCTION f_matriz_verhoeff (x IN NUMBER, y IN NUMBER)
        RETURN NUMBER;

    FUNCTION f_validadigitoverificador (p_numero IN NUMBER)
        RETURN NUMBER;

    FUNCTION is_number (prm_codigo IN VARCHAR2)
        RETURN NUMBER;

    FUNCTION verifica_acceso (prm_codigo     IN VARCHAR2,
                              prm_usuario    IN VARCHAR2,
                              prm_opcion     IN VARCHAR2,
                              prm_gerencia   IN VARCHAR2)
        RETURN VARCHAR2;
END;
/

CREATE OR REPLACE 
PACKAGE BODY pkg_general
/* Formatted on 10-oct.-2017 12:25:10 (QP5 v5.126) */
AS
    FUNCTION plazo_dias_orden (prm_control IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res              VARCHAR2 (30);
        plazo            NUMBER;
        fecreg           DATE;
        dif              NUMBER;
        tipo             VARCHAR2 (50);
        fecha_levante    DATE;
        fecha_registro   DATE;
    BEGIN
        SELECT   a.ctl_cod_tipo
          INTO   tipo
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_control
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF tipo = 'DIFERIDO'
        THEN
            SELECT   a.est_fecsys
              INTO   fecha_registro
              FROM   fis_estado a
             WHERE       a.est_estado = 'REGISTRADO'
                     AND a.est_lstope = 'U'
                     AND a.ctl_control_id = prm_control;

            IF fecha_registro IS NULL
            THEN
                RETURN '-';
            ELSE
                fecha_levante := pkg_general.fecha_levante(prm_control);
                IF fecha_levante IS NULL
                THEN

                    IF fecha_registro > fecha_levante
                    THEN
                        RETURN 'SIN MERCANCIA';

                    ELSE
                        RETURN 'CON MERCANCIA';
                    END IF;
                ELSE
                    RETURN '-';
                END IF;

            END IF;
        ELSE
            IF tipo = 'POSTERIOR'
            THEN
                SELECT   a.est_fecsys
                  INTO   fecreg
                  FROM   fis_estado a
                 WHERE       a.ctl_control_id = prm_control
                         AND a.est_estado = 'REGISTRADO'
                         AND a.est_lstope = 'U';

                IF fecreg IS NULL
                THEN
                    RETURN '-';
                ELSE
                    SELECT   b.inn_plazo_conclusion
                      INTO   plazo
                      FROM   fis_info_notificacion b
                     WHERE       b.ctl_control_id = prm_control
                             AND b.inn_num = 0
                             AND b.inn_lstope = 'U';


                    IF plazo IS NULL
                    THEN
                        RETURN '-';
                    ELSE
                        dif := TRUNC (SYSDATE) - TRUNC (fecreg) + plazo - 200;


                        IF dif > 0
                        THEN
                            RETURN '<span class="label label-danger">Fuera de Plazo por '
                                   || dif
                                   || ' d&iacute;as</span>';
                        ELSE
                            IF dif * (-1) < 10
                            THEN
                                RETURN '<span class="label label-warning">En Plazo, '
                                       || dif * (-1)
                                       || ' d&iacute;as restantes</span>';
                            ELSE
                                RETURN '<span class="label label-success">En Plazo, '
                                       || dif * (-1)
                                       || ' d&iacute;as restantes</span>';
                            END IF;
                        END IF;
                    END IF;
                END IF;
            ELSE
                RETURN '-';
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN '-';
    END;

    FUNCTION origen_dui (prm_sadregyear   IN VARCHAR2,
                         prm_keycuo          VARCHAR2,
                         prm_sadregnber      VARCHAR2)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (50);
        aux   NUMBER;
    BEGIN
        SELECT   COUNT (DISTINCT ciu)
          INTO   aux
          FROM   (SELECT   itm.saditm_cty_origcod ciu
                    FROM   ops$asy.sad_gen, ops$asy.sad_itm itm --,ops$asy.unctytab ctyo
                   WHERE       sad_gen.key_year = itm.key_year
                           AND sad_gen.key_cuo = itm.key_cuo
                           AND sad_gen.key_dec = itm.key_dec
                           AND sad_gen.key_nber = itm.key_nber
                           AND itm.sad_num = 0
                           AND sad_gen.key_dec IS NOT NULL
                           AND sad_gen.sad_reg_year = prm_sadregyear
                           AND sad_gen.key_cuo = prm_keycuo
                           AND sad_gen.sad_reg_serial = 'C'
                           AND sad_gen.sad_reg_nber = prm_sadregnber
                           AND sad_gen.sad_num = 0
                  UNION ALL
                  SELECT   itm.saditm_cty_origcod ciu
                    FROM   ops$asy.sad_gen, ops$asy.sad_itm itm --,ops$asy.unctytab ctyo
                   WHERE       sad_gen.key_year = itm.key_year
                           AND sad_gen.key_cuo = itm.key_cuo
                           AND sad_gen.key_dec IS NULL
                           AND itm.key_dec IS NULL
                           AND sad_gen.key_nber = itm.key_nber
                           AND itm.sad_num = 0
                           AND sad_gen.sad_reg_year = prm_sadregyear
                           AND sad_gen.key_cuo = prm_keycuo
                           AND sad_gen.sad_reg_serial = 'C'
                           AND sad_gen.sad_reg_nber = prm_sadregnber
                           AND sad_gen.sad_num = 0) tbl;

        IF aux = 0
        THEN
            RETURN '-';
        END IF;

        IF aux > 1
        THEN
            RETURN 'VARIOS';
        ELSE
            SELECT   DISTINCT ciu
              INTO   res
              FROM   (SELECT   ctyo.cty_dsc ciu
                        FROM   ops$asy.sad_gen,
                               ops$asy.sad_itm itm,
                               ops$asy.unctytab ctyo
                       WHERE       sad_gen.key_year = itm.key_year
                               AND sad_gen.key_cuo = itm.key_cuo
                               AND sad_gen.key_dec = itm.key_dec
                               AND sad_gen.key_nber = itm.key_nber
                               AND itm.sad_num = 0
                               AND sad_gen.key_dec IS NOT NULL
                               AND sad_gen.sad_reg_year = prm_sadregyear
                               AND sad_gen.key_cuo = prm_keycuo
                               AND sad_gen.sad_reg_serial = 'C'
                               AND sad_gen.sad_reg_nber = prm_sadregnber
                               AND sad_gen.sad_num = 0
                               AND itm.saditm_cty_origcod = ctyo.cty_cod(+)
                               AND ctyo.lst_ope = 'U'
                      UNION ALL
                      SELECT   ctyo.cty_dsc ciu
                        FROM   ops$asy.sad_gen,
                               ops$asy.sad_itm itm,
                               ops$asy.unctytab ctyo
                       WHERE       sad_gen.key_year = itm.key_year
                               AND sad_gen.key_cuo = itm.key_cuo
                               AND sad_gen.key_dec IS NULL
                               AND itm.key_dec IS NULL
                               AND sad_gen.key_nber = itm.key_nber
                               AND itm.sad_num = 0
                               AND sad_gen.sad_reg_year = prm_sadregyear
                               AND sad_gen.key_cuo = prm_keycuo
                               AND sad_gen.sad_reg_serial = 'C'
                               AND sad_gen.sad_reg_nber = prm_sadregnber
                               AND sad_gen.sad_num = 0
                               AND itm.saditm_cty_origcod = ctyo.cty_cod(+)
                               AND ctyo.lst_ope = 'U') tbl;

            RETURN res;
        END IF;
    END;

    FUNCTION fecha_registro_orden (prm_control IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (30);
        aux   NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   aux
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_control
                 AND a.est_estado = 'REGISTRADO'
                 AND est_lstope = 'U';

        IF aux = 0
        THEN
            RETURN '-';
        ELSE
            SELECT   NVL (TO_CHAR (MIN (a.est_fecsys), 'dd/mm/yyyy'), '-')
              INTO   res
              FROM   fis_estado a
             WHERE       a.ctl_control_id = prm_control
                     AND a.est_estado = 'REGISTRADO'
                     AND est_lstope = 'U';

            RETURN res;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN '-';
    END;

    FUNCTION cantidad_tramites (prm_control IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (5);
    BEGIN
        SELECT   COUNT (1)
          INTO   res
          FROM   fis_alcance a
         WHERE       a.ctl_control_id = prm_control
                 AND a.alc_num = 0
                 AND a.alc_lstope = 'U';

        RETURN res;
    END cantidad_tramites;

    FUNCTION patron_declaracion (prm_sadregyear   IN VARCHAR2,
                                 prm_keycuo          VARCHAR2,
                                 prm_sadregnber      VARCHAR2)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (5);
    BEGIN
        SELECT   g.sad_typ_dec || g.sad_typ_proc
          INTO   res
          FROM   ops$asy.sad_gen g
         WHERE       g.sad_reg_year = prm_sadregyear
                 AND g.key_cuo = prm_keycuo
                 AND g.sad_reg_serial = 'C'
                 AND g.sad_reg_nber = prm_sadregnber
                 AND g.sad_num = 0;


        RETURN res;
    END patron_declaracion;

    FUNCTION items_control (prm_control IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (5);
    BEGIN
        SELECT   COUNT (1)
          INTO   res
          FROM   fis_alcance a, fis_alcance_item b
         WHERE       a.ctl_control_id = prm_control
                 AND a.alc_num = 0
                 AND a.alc_lstope = 'U'
                 AND a.alc_alcance_id = b.alc_alcance_id
                 AND b.ali_num = 0
                 AND b.ali_lstope = 'U';

        RETURN res;
    END items_control;

    FUNCTION fecha_levante (prm_sadregyear   IN VARCHAR2,
                            prm_keycuo       IN VARCHAR2,
                            prm_sadregnber   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (50);
    BEGIN
        SELECT   levante
          INTO   res
          FROM   (SELECT      TO_CHAR (n.upd_dat, 'dd/mm/yyyy')
                           || ' '
                           || n.upd_hor
                               levante
                    FROM   ops$asy.sad_spy n, ops$asy.sad_gen g
                   WHERE       n.key_year = g.key_year
                           AND n.key_cuo = g.key_cuo
                           AND n.key_dec = g.key_dec
                           AND g.key_dec IS NOT NULL
                           AND n.key_nber = g.key_nber
                           AND ( (    n.spy_sta = '6'
                                  AND n.spy_act = '9'
                                  AND n.sad_clr = 0)
                                OR (    n.spy_sta = '10'
                                    AND n.spy_act = '24'
                                    AND n.sad_clr = 0))
                           AND g.sad_reg_year = prm_sadregyear
                           AND g.key_cuo = prm_keycuo
                           AND g.sad_reg_serial = 'C'
                           AND g.sad_reg_nber = prm_sadregnber
                           AND g.sad_num = 0
                  UNION ALL
                  SELECT      TO_CHAR (n.upd_dat, 'dd/mm/yyyy')
                           || ' '
                           || n.upd_hor
                               levante
                    FROM   ops$asy.sad_spy n, ops$asy.sad_gen g
                   WHERE       n.key_year = g.key_year
                           AND n.key_cuo = g.key_cuo
                           AND g.key_dec IS NULL
                           AND n.key_dec IS NULL
                           AND n.key_nber = g.key_nber
                           AND ( (    n.spy_sta = '6'
                                  AND n.spy_act = '9'
                                  AND n.sad_clr = 0)
                                OR (    n.spy_sta = '10'
                                    AND n.spy_act = '24'
                                    AND n.sad_clr = 0))
                           AND g.sad_reg_year = prm_sadregyear
                           AND g.key_cuo = prm_keycuo
                           AND g.sad_reg_serial = 'C'
                           AND g.sad_reg_nber = prm_sadregnber
                           AND g.sad_num = 0) tbl;

        RETURN res;
    END;

    FUNCTION fecha_levante (prm_control IN VARCHAR2)
        RETURN DATE
    IS
        res   DATE;
    BEGIN
        SELECT   TO_DATE(levante,'DD/MM/YYYY HH24:MI')
          INTO   res
          FROM   (SELECT      TO_CHAR (n.upd_dat, 'dd/mm/yyyy')
                           || ' '
                           || n.upd_hor
                               levante
                    FROM   ops$asy.sad_spy n,
                           ops$asy.sad_gen g,
                           fis_alcance a
                   WHERE       n.key_year = g.key_year
                           AND n.key_cuo = g.key_cuo
                           AND n.key_dec = g.key_dec
                           AND g.key_dec IS NOT NULL
                           AND n.key_nber = g.key_nber
                           AND ( (    n.spy_sta = '6'
                                  AND n.spy_act = '9'
                                  AND n.sad_clr = 0)
                                OR (    n.spy_sta = '10'
                                    AND n.spy_act = '24'
                                    AND n.sad_clr = 0))
                           AND g.sad_reg_year = a.alc_gestion
                           AND g.key_cuo = a.alc_aduana
                           AND g.sad_reg_serial = 'C'
                           AND g.sad_reg_nber = a.alc_numero
                           AND g.sad_num = 0
                           AND a.ctl_control_id = prm_control
                           AND a.alc_num = 0
                           AND a.alc_lstope = 'U'
                  UNION ALL
                  SELECT      TO_CHAR (n.upd_dat, 'dd/mm/yyyy')
                           || ' '
                           || n.upd_hor
                               levante
                    FROM   ops$asy.sad_spy n,
                           ops$asy.sad_gen g,
                           fis_alcance a
                   WHERE       n.key_year = g.key_year
                           AND n.key_cuo = g.key_cuo
                           AND g.key_dec IS NULL
                           AND n.key_dec IS NULL
                           AND n.key_nber = g.key_nber
                           AND ( (    n.spy_sta = '6'
                                  AND n.spy_act = '9'
                                  AND n.sad_clr = 0)
                                OR (    n.spy_sta = '10'
                                    AND n.spy_act = '24'
                                    AND n.sad_clr = 0))
                           AND g.sad_reg_year = a.alc_gestion
                           AND g.key_cuo = a.alc_aduana
                           AND g.sad_reg_serial = 'C'
                           AND g.sad_reg_nber = a.alc_numero
                           AND g.sad_num = 0
                           AND a.ctl_control_id = prm_control
                           AND a.alc_num = 0
                           AND a.alc_lstope = 'U') tbl;

        RETURN res;
    END;

    FUNCTION devuelve_fecha_levante (prm_key_year   IN VARCHAR2,
                                     prm_key_cuo    IN VARCHAR2,
                                     prm_key_dec    IN VARCHAR2,
                                     prm_key_nber   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res    VARCHAR2 (50) := '';
        cont   NUMBER (8) := 0;
    BEGIN
        SELECT   TO_CHAR (n.upd_dat, 'dd/mm/yyyy') || ' ' || n.upd_hor
                     AS fecha_levante
          INTO   res
          FROM   ops$asy.sad_spy n
         WHERE       n.key_year = prm_key_year
                 AND n.key_cuo = prm_key_cuo
                 AND NVL (n.key_dec, '-') = NVL (prm_key_dec, '-')
                 AND n.key_nber = prm_key_nber
                 AND ( (n.spy_sta = '6' AND n.spy_act = '9' AND n.sad_clr = 0)
                      OR (    n.spy_sta = '10'
                          AND n.spy_act = '24'
                          AND n.sad_clr = 0));

        IF res = ''
        THEN
            res := '-';
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN '-';
    END devuelve_fecha_levante;

    FUNCTION valida_fecha (prm_fecha IN VARCHAR2)
        RETURN NUMBER
    IS
        res   NUMBER;
        fec   DATE;
    BEGIN
        fec := TO_DATE (prm_fecha, 'dd/mm/yyyy');
        RETURN 0;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 1;
    END;

    FUNCTION valida_fechas (prm_fechaini   IN VARCHAR2,
                            prm_fechafin   IN VARCHAR2)
        RETURN NUMBER
    IS
        res      NUMBER;
        fecini   DATE;
        fecfin   DATE;
    BEGIN
        IF valida_fecha (prm_fechaini) = 1
        THEN
            RETURN 2;
        END IF;

        IF valida_fecha (prm_fechafin) = 1
        THEN
            RETURN 3;
        END IF;

        IF TO_DATE (prm_fechafin, 'dd/mm/yyyy') <
               TO_DATE (prm_fechaini, 'dd/mm/yyyy')
        THEN
            RETURN 1;
        END IF;

        RETURN 0;
    END;

    FUNCTION devuelve_estadocontrol (prm_codigo IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res      VARCHAR2 (50) := '';
        existe   NUMBER;
    BEGIN
        SELECT   SUM (tbl.remitido)
          INTO   existe
          FROM   (SELECT   COUNT (1) remitido
                    FROM   fis_con_viscargo a
                   WHERE       a.ctl_control_id = prm_codigo
                           AND cvc_num = 0
                           AND cvc_lstope = 'U'
                           AND NOT cvc_fecha_ci_remision IS NULL
                  UNION
                  SELECT   COUNT (1) remitido
                    FROM   fis_con_actainter a
                   WHERE       a.ctl_control_id = prm_codigo
                           AND cai_num = 0
                           AND cai_lstope = 'U'
                           AND NOT cai_fecha_ci_remision IS NULL
                  UNION
                  SELECT   COUNT (1) remitido
                    FROM   fis_con_autoinicial a
                   WHERE       a.ctl_control_id = prm_codigo
                           AND cas_num = 0
                           AND cas_lstope = 'U'
                           AND NOT cas_ci_remision_gr IS NULL
                  UNION
                  SELECT   COUNT (1) remitido
                    FROM   fis_con_resadmin a
                   WHERE       a.ctl_control_id = prm_codigo
                           AND a.cra_num = 0
                           AND a.cra_lstope = 'U'
                           AND NOT a.cra_fecha_remision_set IS NULL) tbl;

        IF existe > 0
        THEN
            res := 'REMITIDO';
        ELSE
            SELECT   SUM (tbl.remitido)
              INTO   existe
              FROM   (SELECT   COUNT (1) remitido
                        FROM   fis_con_viscargo a
                       WHERE       a.ctl_control_id = prm_codigo
                               AND cvc_num = 0
                               AND cvc_lstope = 'U'
                               AND NOT cvc_fecha_notificacion IS NULL
                      UNION
                      SELECT   COUNT (1) remitido
                        FROM   fis_con_actainter a
                       WHERE       a.ctl_control_id = prm_codigo
                               AND cai_num = 0
                               AND cai_lstope = 'U'
                               AND NOT cai_fecha_acta_interv IS NULL
                      UNION
                      SELECT   COUNT (1) remitido
                        FROM   fis_con_autoinicial a
                       WHERE       a.ctl_control_id = prm_codigo
                               AND cas_num = 0
                               AND cas_lstope = 'U'
                               AND NOT cas_fecha_notificacion IS NULL
                      UNION
                      SELECT   COUNT (1) remitido
                        FROM   fis_con_resadmin a
                       WHERE       a.ctl_control_id = prm_codigo
                               AND a.cra_num = 0
                               AND a.cra_lstope = 'U'
                               AND NOT a.cra_fecha_ra IS NULL
                      UNION
                      SELECT   COUNT (1) remitido
                        FROM   fis_con_resdeter a
                       WHERE       a.ctl_control_id = prm_codigo
                               AND a.crd_num = 0
                               AND a.crd_lstope = 'U'
                               AND NOT a.crd_fecha_not_rd_final IS NULL) tbl;

            IF existe > 0
            THEN
                res := 'CONCLUIDO';
            ELSE
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   fis_notificacion a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.not_num = 0
                         AND a.not_lstope = 'U'
                         AND NOT a.not_fecha_notificacion IS NULL;

                IF existe > 0
                THEN
                    res := 'NOTIFICACION';
                ELSE
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   fis_estado a
                     WHERE       a.ctl_control_id = prm_codigo
                             AND a.est_num = 0
                             AND a.est_lstope = 'U'
                             AND a.est_estado = 'REGISTRADO';

                    IF existe > 0
                    THEN
                        res := 'ASIGNACION';
                    END IF;
                END IF;
            END IF;
        END IF;

        RETURN res;
    END;

    FUNCTION nombrecompleto (prm_codigo IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (50);
    BEGIN
        SELECT   u.usuapepat || ' ' || u.usuapemat || ' ' || u.usunombre
          INTO   res
          FROM   usuario.usuario u
         WHERE   u.usucodusu = prm_codigo AND u.usu_num = 0;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN '-';
    END;

    FUNCTION devuelve_fecha
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (50);
    BEGIN
        SELECT   TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') INTO res FROM DUAL;

        RETURN res;
    END;

    FUNCTION devuelve_pais (prm_codigo IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (50);
    BEGIN
        SELECT   UPPER (c.cty_dsc)
          INTO   res
          FROM   ops$asy.unctytab c
         WHERE   c.lst_ope = 'U' AND c.cty_cod = prm_codigo;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN '-';
    END;

    FUNCTION devuelve_tipo_empresa (nit IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res      VARCHAR2 (50) := 0;
        existe   NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   ops$asy.bo_oce_opecab a
         WHERE   a.ope_numerodoc = nit AND ope_num = 0;

        IF existe = 0
        THEN
            res := 'EMPRESA';
        ELSE
            SELECT   DECODE (a.ope_nombre, NULL, 'EMPRESA', 'UNIPERSONAL')
              INTO   res
              FROM   ops$asy.bo_oce_opecab a
             WHERE   a.ope_numerodoc = nit AND ope_num = 0 AND ROWNUM = 1;
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'EMPRESA';
    END;


    FUNCTION mostrar_botones (prm_codigo    IN VARCHAR2,
                              prm_usuario   IN VARCHAR2,
                              prm_opcion    IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res      VARCHAR2 (50) := 'OCULTAR';
        estado   VARCHAR2 (30);
        existe   NUMBER;
    BEGIN
        SELECT   a.est_estado
          INTO   estado
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.est_num = 0
                 AND a.est_lstope = 'U';

        IF prm_opcion IN ('10', '11', '12')
        THEN
            IF estado = 'MEMORIZADO'
            THEN
                res := 'MOSTRAR';
            ELSE
                res := 'OCULTAR';
            END IF;
        END IF;

        IF prm_opcion IN ('13', '14', '15', '16', '17', '18')
        THEN
            IF estado = 'REGISTRADO'
            THEN
                res := 'MOSTRAR';
            ELSE
                res := 'OCULTAR';
            END IF;
        END IF;

        IF prm_opcion = '19'
        THEN
            IF estado = 'REGISTRADO'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   usuario.usu_rol a
                 WHERE       a.usucodusu = prm_usuario
                         AND a.rol_cod = 'GNF_FISCALIZADORUFR'
                         AND a.lst_ope = 'U'
                         AND a.ult_ver = 0;

                IF existe = 1
                THEN
                    res := 'MOSTRAR';
                ELSE
                    res := 'OCULTAR';
                END IF;
            END IF;


            IF estado = 'CONCLUIDO'
            THEN
                SELECT   COUNT (1)
                  INTO   existe
                  FROM   usuario.usu_rol a
                 WHERE       a.usucodusu = prm_usuario
                         AND a.rol_cod = 'GNF_LEGAL'
                         AND a.lst_ope = 'U'
                         AND a.ult_ver = 0;

                IF existe = 1
                THEN
                    res := 'MOSTRAR';
                ELSE
                    res := 'OCULTAR';
                END IF;
            END IF;
        END IF;

        RETURN res;
    END;

    FUNCTION mostrar_botones_concluir (prm_codigo    IN VARCHAR2,
                                       prm_usuario   IN VARCHAR2,
                                       prm_opcion    IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res      VARCHAR2 (50) := 'OCULTAR';
        estado   VARCHAR2 (30);
        existe   NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_conclusion a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.con_num = 0
                 AND a.con_lstope = 'U';

        IF existe = 0
        THEN
            SELECT   COUNT (1)
              INTO   existe
              FROM   usuario.usu_rol a
             WHERE       a.usucodusu = prm_usuario
                     AND a.rol_cod = 'GNF_FISCALIZADORUFR'
                     AND a.lst_ope = 'U'
                     AND a.ult_ver = 0;

            IF existe = 1
            THEN
                res := 'MOSTRAR';
            ELSE
                res := 'OCULTAR';
            END IF;
        ELSE
            res := 'OCULTAR';
        END IF;

        RETURN res;
    END;

    FUNCTION llenar_valores (prm_codigo    IN VARCHAR2,
                             prm_usuario   IN VARCHAR2,
                             prm_opcion    IN VARCHAR2,
                             prm_nivel     IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res      VARCHAR2 (50) := 'BLOQUEAR';
        estado   VARCHAR2 (30);
        existe   NUMBER;
    --NIVEL FISCA, LEGAL
    BEGIN
        SELECT   a.est_estado
          INTO   estado
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.est_num = 0
                 AND a.est_lstope = 'U';

        IF prm_nivel = 'LEGAL'
        THEN
            IF prm_opcion = '19'
            THEN
                IF estado = 'CONCLUIDO'
                THEN
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   usuario.usu_rol a
                     WHERE       a.usucodusu = prm_usuario
                             AND a.rol_cod = 'GNF_LEGAL'
                             AND a.lst_ope = 'U'
                             AND a.ult_ver = 0;

                    IF existe = 1
                    THEN
                        res := 'LLENAR';
                    ELSE
                        res := 'BLOQUEAR';
                    END IF;
                ELSE
                    res := 'BLOQUEAR';
                END IF;
            END IF;
        END IF;

        IF prm_nivel = 'FISCA'
        THEN
            IF prm_opcion = '19'
            THEN
                IF estado = 'REGISTRADO'
                THEN
                    SELECT   COUNT (1)
                      INTO   existe
                      FROM   usuario.usu_rol a
                     WHERE       a.usucodusu = prm_usuario
                             AND a.rol_cod = 'GNF_FISCALIZADORUFR'
                             AND a.lst_ope = 'U'
                             AND a.ult_ver = 0;

                    IF existe = 1
                    THEN
                        res := 'LLENAR';
                    ELSE
                        res := 'BLOQUEAR';
                    END IF;
                ELSE
                    res := 'BLOQUEAR';
                END IF;
            END IF;
        END IF;



        RETURN res;
    END;

    FUNCTION lista_aduanas
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
              SELECT   cuo_cod, cuo_cod || ':' || cuo_nam cuo_nam
                FROM   ops$asy.uncuotab a
               WHERE   NOT cuo_cod IN ('ALL', 'CUO01') AND lst_ope = 'U'
            ORDER BY   1;


        RETURN ct;
    END;

    FUNCTION lista_aduanas (gerencia VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        IF gerencia = '%'
        THEN
            OPEN ct FOR
                  SELECT   cuo_cod, cuo_cod || ':' || cuo_nam cuo_nam
                    FROM   ops$asy.uncuotab a
                   WHERE   NOT cuo_cod IN ('ALL', 'CUO01') AND lst_ope = 'U'
                ORDER BY   1;
        ELSE
            OPEN ct FOR
                  SELECT   a.cuo_cod, a.cuo_cod || ':' || a.cuo_nam cuo_nam
                    FROM   ops$asy.uncuotab a
                   WHERE   NOT a.cuo_cod IN ('ALL', 'CUO01')
                           AND a.lst_ope = 'U'
                ORDER BY   1;
        END IF;

        RETURN ct;
    END;

    FUNCTION lista_paises
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
              SELECT   a.cty_cod, a.cty_dsc
                FROM   ops$asy.unctytab a
               WHERE   a.lst_ope = 'U'
            ORDER BY   2;

        RETURN ct;
    END;



    FUNCTION devuelve_datos_nit (prm_nit IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            /*SELECT   a.cmp_cod nit,
                     SUBSTR (a.cmp_nam, 0, 29) razon,
                     SUBSTR (
                            a.cmp_adr
                         || ' '
                         || a.cmp_ad2
                         || ' '
                         || a.cmp_ad3
                         || ' '
                         || a.cmp_ad4,
                         0,
                         99)
                         direccion,
                     UPPER (pkg_general.fn_devuelve_actividad (a.cmp_cod))
                         actividad
              FROM   ops$asy.uncmptab a
             WHERE   a.cmp_cod = prm_nit AND a.lst_ope = 'U';*/

            SELECT   a.ope_numerodoc nit,
                     a.ope_razonsocial razon,
                        a.ope_direccion
                     || ', N'
                     || CHR (186)
                     || ' '
                     || a.ope_nrodireccion
                     || ', ZONA '
                     || a.ope_zona
                     || ', '
                     || a.ope_ciudad
                         direccion,
                     UPPER (
                         pkg_general.fn_devuelve_actividad (a.ope_numerodoc))
                         actividad,
                     a.ope_tipodoc tipodoc,
                     a.ope_nombre nombre,
                     a.ope_paterno paterno,
                     a.ope_materno materno,
                     a.ope_emisiondoc emision
              FROM   ops$asy.bo_oce_opecab a
             WHERE   a.ope_numerodoc = prm_nit AND ope_num = 0 AND ROWNUM = 1;

        RETURN ct;
    END;

    FUNCTION devuelve_datos_dui (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT   a.key_year,
                     a.key_cuo,
                     a.key_dec,
                     a.key_nber,
                     a.sad_reg_year,
                     a.sad_reg_serial,
                     a.sad_reg_nber,
                     a.sad_consignee,
                     TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy'),
                     a.sad_itm_total,
                     a.sad_typ_dec || a.sad_typ_proc
              FROM   ops$asy.sad_gen a
             WHERE   a.sad_reg_year = SUBSTR (prm_codigo, 1, 4)
                     AND a.key_cuo = SUBSTR (prm_codigo, 5, 3)
                     AND a.sad_reg_nber =
                            SUBSTR (prm_codigo, 8, LENGTH (prm_codigo) - 7)
                     AND a.sad_flw = 1
                     AND a.lst_ope = 'U'
                     AND a.sad_num = 0;


        RETURN ct;
    END;

    FUNCTION devuelve_datos_nittip (prm_nit IN VARCHAR2, tipo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        IF tipo = 'IMPORTADOR/EXPORTADOR'
        THEN
            OPEN ct FOR
                SELECT   a.cmp_cod nit,
                         SUBSTR (a.cmp_nam, 0, 29) razon,
                         SUBSTR (
                                a.cmp_adr
                             || ' '
                             || a.cmp_ad2
                             || ' '
                             || a.cmp_ad3
                             || ' '
                             || a.cmp_ad4,
                             0,
                             99)
                             direccion,
                         UPPER (
                             pkg_general.fn_devuelve_actividad (a.cmp_cod))
                             actividad
                  FROM   ops$asy.uncmptab a
                 WHERE   a.cmp_cod = prm_nit AND a.lst_ope = 'U';
        END IF;

        IF tipo = 'TRANSPORTISTA'
        THEN
            OPEN ct FOR
                SELECT   a.cmp_cod nit,
                         SUBSTR (a.cmp_nam, 0, 29) razon,
                         SUBSTR (
                                a.cmp_adr
                             || ' '
                             || a.cmp_ad2
                             || ' '
                             || a.cmp_ad3
                             || ' '
                             || a.cmp_ad4,
                             0,
                             99)
                             direccion,
                         UPPER (
                             pkg_general.fn_devuelve_actividad (a.cmp_cod))
                             actividad
                  FROM   ops$asy.uncmptab a
                 WHERE   a.cmp_cod = prm_nit AND a.lst_ope = 'U';
        END IF;



        RETURN ct;
    END;


    FUNCTION devuelve_fecha_registro (prm_codigo IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (20) := '-';
    BEGIN
        SELECT   COUNT (1)
          INTO   res
          FROM   fis_estado a
         WHERE       a.est_estado = 'REGISTRADO'
                 AND a.est_lstope = 'U'
                 AND a.ctl_control_id = prm_codigo;

        IF (res <> '0')
        THEN
            SELECT   TO_CHAR (MIN (a.est_fecsys), 'dd/mm/yyyy')
              INTO   res
              FROM   fis_estado a
             WHERE       a.est_estado = 'REGISTRADO'
                     AND a.est_lstope = 'U'
                     AND a.ctl_control_id = prm_codigo;
        ELSE
            res := '-';
        END IF;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '-';
    END;

    FUNCTION devuelve_datos_control (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct       cursortype;
        existe   VARCHAR2 (5);
    BEGIN
        SELECT   DECODE (COUNT (1), 0, 'NO', 'SI')
          INTO   existe
          FROM   fis_fiscalizador a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.fis_num = 0
                 AND a.fis_lstope = 'U';

        OPEN ct FOR
            SELECT   a.ctl_control_id codigo,
                     DECODE (
                         e.est_estado,
                         'MEMORIZADO',
                         '-',
                         a.ctl_cod_gestion
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
                                    a.ctl_cod_numero))
                         codigo_control,
                     DECODE (a.ctl_cod_tipo,
                             'DIFERIDO',
                             'CONTROL DIFERIDO',
                             'POSTERIOR',
                             'FISCALIZACI&Oacute;N ADUANERA POSTERIOR',
                             'AMPLIATORIA DIFERIDO',
                             'FISCALIZACI&Oacute;N AMPLIATORIA DIFERIDO',
                             'AMPLIATORIA POSTERIOR',
                             'FISCALIZACI&Oacute;N AMPLIATORIA POSTERIOR',
                             a.ctl_cod_tipo)
                         tipo_control,
                     a.ctl_tipo_documento,
                     a.ctl_nro_documento,
                     TO_CHAR (a.ctl_fecha_documento, 'dd/mm/yyyy'),
                     a.ctl_obs_documento,
                     --a.ctl_riesgo_identificado,
                     DECODE (a.ctl_riesgodelito, 'on', 'DELITO, ', '')
                     || DECODE (a.ctl_riesgosubval,
                                'on', 'SUBVALUACI' || CHR (211) || 'N, ',
                                '')
                     || DECODE (a.ctl_riesgoclas,
                                'on', 'CLASIFICACI' || CHR (21) || 'N, ',
                                '')
                     || DECODE (a.ctl_riesgocontrab,
                                'on', 'CONTRABANDO CONTRAVENCIONAL,',
                                ''),
                     e.est_estado estado,
                     a.ctl_tipo_doc_identidad,
                     DECODE (a.ctl_tipo_doc_identidad,
                             'NIT', TO_CHAR (a.ctl_nit),
                             TO_CHAR (a.ctl_ci))
                         identidad_doc,
                     DECODE (
                         a.ctl_tipo_doc_identidad,
                         'NIT',
                         UPPER (a.ctl_razon_social),
                         UPPER(   a.ctl_nombres
                               || ' '
                               || a.ctl_appat
                               || ' '
                               || a.ctl_apmat))
                         identidad_nombre,
                     UPPER (a.ctl_direccion),
                     UPPER (a.ctl_actividad_principal),
                     DECODE (a.ctl_tribga, 'on', 'SI', 'NO'),
                     DECODE (a.ctl_tribiva, 'on', 'SI', 'NO'),
                     DECODE (a.ctl_tribice, 'on', 'SI', 'NO'),
                     DECODE (a.ctl_tribiehd, 'on', 'SI', 'NO'),
                     DECODE (a.ctl_tribicd, 'on', 'SI', 'NO'),
                     DECODE (a.ctl_tribnoaplica, 'on', 'SI', 'NO'),
                     a.ctl_periodo,
                     devuelve_fecha_registro (a.ctl_control_id),
                     a.ctl_tipo_operador,
                     i.inn_plazo_conclusion,
                     i.inn_1,
                     i.inn_2,
                     i.inn_3,
                     i.inn_4,
                     i.inn_5,
                     i.inn_6,
                     i.inn_7,
                     i.inn_8,
                     i.inn_9,
                     i.inn_10,
                     i.inn_11,
                     i.inn_12,
                     i.inn_13,
                     i.inn_14,
                     i.inn_15,
                     i.inn_16,
                     i.inn_17,
                     i.inn_18,
                     i.inn_19,
                     i.inn_20,
                     i.inn_21,
                     DECODE (i.inn_12, NULL, 0, 1),
                     DECODE (i.inn_13, NULL, 0, 1),
                     DECODE (i.inn_14, NULL, 0, 1),
                     DECODE (i.inn_15, NULL, 0, 1),
                     DECODE (i.inn_16, NULL, 0, 1),
                     DECODE (i.inn_17, NULL, 0, 1),
                     DECODE (i.inn_18, NULL, 0, 1),
                     DECODE (i.inn_19, NULL, 0, 1),
                     DECODE (i.inn_20, NULL, 0, 1),
                     DECODE (i.inn_21, NULL, 0, 1),
                     DECODE (a.ctl_tipo_doc_identidad,
                             'NIT',
                             devuelve_tipo_empresa (TO_CHAR (a.ctl_nit)),
                             'UNIPERSONAL'),
                     c.con_tipo_doc_con,
                     c.con_num_doc_con,
                     TO_CHAR (c.con_fecha_doc_con, 'dd/mm/yyyy'),
                     c.con_usuario,
                     TO_CHAR (c.con_fecsys, 'dd/mm/yyyy hh24:mi'),
                     ctl_periodo_solicitar,
                     DECODE (a.ctl_riesgodelito, 'on', 'SI', 'NO'),
                     DECODE (a.ctl_riesgosubval, 'on', 'SI', 'NO'),
                     DECODE (a.ctl_riesgoclas, 'on', 'SI', 'NO'),
                     DECODE (a.ctl_riesgocontrab, 'on', 'SI', 'NO'),
                     existe tiene_asig
              FROM   fis_control a,
                     fis_estado e,
                     fis_info_notificacion i,
                     fis_conclusion c
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND a.ctl_control_id = e.ctl_control_id
                     AND e.est_num = 0
                     AND e.est_lstope = 'U'
                     AND i.ctl_control_id(+) = a.ctl_control_id
                     AND i.inn_num(+) = 0
                     AND i.inn_lstope(+) = 'U'
                     AND c.ctl_control_id(+) = a.ctl_control_id
                     AND c.con_num(+) = 0
                     AND c.con_lstope(+) = 'U';

        RETURN ct;
    END;

    FUNCTION fn_devuelve_actividad (p_nit IN VARCHAR2)
        RETURN VARCHAR2
    IS
        CURSOR c_tipo_ope
        IS
            SELECT   a.ope_numerodoc,
                     DECODE (
                         a.tip_tipooperador,
                         'TRN',
                         'Transp. Internacional Terrestre Carretero Nacional',
                         'AER',
                         'Transp. Internacional Aereo',
                         'FLU',
                         'Transp. Internacional Fluvial',
                         'FER',
                         'Transportador Internacional Terrestre Ferreo',
                         'OTM',
                         'Operador Transporte Multimodal',
                         'DUC',
                         'Transportador Internacional  Ductos/Tuberias/Cables',
                         'DES',
                         'Agencia Despachante de Aduana',
                         'CON',
                         'Consolidador/Desconsolidador Carga Internacional',
                         'COU',
                         'Empresa Servicio Expreso (Courier)',
                         'DFR',
                         'Tienda Libre de Tributos (Duty Free Shops)',
                         'EXP',
                         'Exportador',
                         'IMP',
                         'Importador',
                         'DEP',
                         'Depositos Aduaneros',
                         'ZFR',
                         'Zona Franca (Concesionarios)',
                         'UZF',
                         'Usuario  Zona Franca',
                         'TRE',
                         'Transp. Internacional Terrestre Carretero Extranjero',
                         'NAL',
                         'Transp. Nacional Terrestre Carretero',
                         'UDA',
                         'Usuarios de Depositos Aeroportuarios')
                         actividad
              FROM   ops$asy.bo_oce_opetipo a
             WHERE       a.ope_numerodoc = p_nit
                     AND a.tip_num = 0
                     AND a.tip_lst_ope = 'U';

        /*
                CURSOR c_tipo_ope2
                 IS
                     SELECT   UNIQUE
                              DECODE (
                                  t.ope_tip,
                                  'TRN',
                                  'Transp. Internacional Terrestre Carretero Nacional',
                                  'AER',
                                  'Transp. Internacional Aereo',
                                  'FLU',
                                  'Transp. Internacional Fluvial',
                                  'FER',
                                  'Transportador Internacional Terrestre Ferreo',
                                  'OTM',
                                  'Operador Transporte Multimodal',
                                  'DUC',
                                  'Transportador Internacional  Ductos/Tuberias/Cables',
                                  'DES',
                                  'Agencia Despachante de Aduana',
                                  'CON',
                                  'Consolidador/Desconsolidador Carga Internacional',
                                  'COU',
                                  'Empresa Servicio Expreso (Courier)',
                                  'DFR',
                                  'Tienda Libre de Tributos (Duty Free Shops)',
                                  'EXP',
                                  'Exportador',
                                  'IMP',
                                  'Importador',
                                  'DEP',
                                  'Depositos Aduaneros',
                                  'ZFR',
                                  'Zona Franca (Concesionarios)',
                                  'UZF',
                                  'Usuario  Zona Franca',
                                  'TRE',
                                  'Transp. Internacional Terrestre Carretero Extranjero',
                                  'NAL',
                                  'Transp. Nacional Terrestre Carretero',
                                  'UDA',
                                  'Usuarios de Depositos Aeroportuarios')
                                  actividad
                       FROM   operador.olopetab o, operador.olopetip t
                      WHERE       o.ope_nit = p_nit
                              AND o.ult_ver = 0
                              AND o.emp_cod = t.emp_cod
                              AND t.tbl_sta = 'H';*/

        v_actividad   VARCHAR2 (1000);
        num           NUMBER;
    BEGIN
        IF (p_nit IS NOT NULL)
        THEN
            SELECT   COUNT (1)
              INTO   num
              FROM   ops$asy.bo_oce_opetipo a
             WHERE       a.ope_numerodoc = p_nit
                     AND a.tip_num = 0
                     AND a.tip_lst_ope = 'U';

            IF num > 0
            THEN
                FOR x IN c_tipo_ope
                LOOP
                    v_actividad :=
                        TO_CHAR (x.actividad) || ', ' || v_actividad;
                END LOOP;
            /* ELSE
                 FOR y IN c_tipo_ope2
                 LOOP
                     v_actividad :=
                         TO_CHAR (y.actividad) || ', ' || v_actividad;
                 END LOOP;*/
            END IF;

            RETURN v_actividad;
        ELSE
            v_actividad := '-';
            RETURN v_actividad;
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            RETURN '-';
    END;

    FUNCTION lista_fiscalizadores (gerencia VARCHAR)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        IF gerencia = '%'
        THEN
            OPEN ct FOR
                  SELECT   DISTINCT
                           a.usucodusu AS codigo,
                              NVL (a.usuapepat, ' ')
                           || ' '
                           || NVL (a.usuapemat, ' ')
                           || ' '
                           || a.usunombre
                               AS nombre,
                           a.usudocid || ' ' || a.usulugemi AS ci
                    FROM   usuario.usuario a, usuario.usu_rol b
                   WHERE       a.lst_ope = 'U'
                           AND a.usu_num = 0
                           AND a.usucodusu = b.usucodusu
                           AND b.rol_cod = 'GNF_FISCALIZADORUFR'
                           AND b.ult_ver = 0
                           AND b.lst_ope = 'U'
                ORDER BY   2;
        ELSE
            OPEN ct FOR
                  SELECT   DISTINCT
                           a.usucodusu AS codigo,
                              NVL (a.usuapepat, ' ')
                           || ' '
                           || NVL (a.usuapemat, ' ')
                           || ' '
                           || a.usunombre
                               AS nombre,
                           a.usudocid || ' ' || a.usulugemi AS ci
                    FROM   usuario.usuario a, usuario.usu_rol b
                   WHERE       a.gercodger = gerencia
                           AND a.lst_ope = 'U'
                           AND a.usu_num = 0
                           AND a.usucodusu = b.usucodusu
                           AND b.rol_cod = 'GNF_FISCALIZADORUFR'
                           AND b.ult_ver = 0
                           AND b.lst_ope = 'U'
                ORDER BY   2;
        END IF;

        RETURN ct;
    END;

    FUNCTION lista_supervisores (gerencia VARCHAR)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        IF gerencia = '%'
        THEN
            OPEN ct FOR
                  SELECT   DISTINCT
                           a.usucodusu AS codigo,
                              NVL (a.usuapepat, ' ')
                           || ' '
                           || NVL (a.usuapemat, ' ')
                           || ' '
                           || a.usunombre
                               AS nombre,
                           a.usudocid || ' ' || a.usulugemi AS ci
                    FROM   usuario.usuario a, usuario.usu_rol b
                   WHERE       a.lst_ope = 'U'
                           AND a.usu_num = 0
                           AND a.usucodusu = b.usucodusu
                           AND (b.rol_cod = 'GNF_JEFEUFR'
                                OR b.rol_cod = 'GNF_SUPERVISORUFR')
                           AND b.ult_ver = 0
                           AND b.lst_ope = 'U'
                ORDER BY   2;
        ELSE
            OPEN ct FOR
                  SELECT   DISTINCT
                           a.usucodusu AS codigo,
                              NVL (a.usuapepat, ' ')
                           || ' '
                           || NVL (a.usuapemat, ' ')
                           || ' '
                           || a.usunombre
                               AS nombre,
                           a.usudocid || ' ' || a.usulugemi AS ci
                    FROM   usuario.usuario a, usuario.usu_rol b
                   WHERE       a.gercodger = gerencia
                           AND a.lst_ope = 'U'
                           AND a.usu_num = 0
                           AND a.usucodusu = b.usucodusu
                           AND (b.rol_cod = 'GNF_JEFEUFR'
                                OR b.rol_cod = 'GNF_SUPERVISORUFR')
                           AND b.ult_ver = 0
                           AND b.lst_ope = 'U'
                ORDER BY   2;
        END IF;

        RETURN ct;
    END;

    FUNCTION lista_funcionarios (gerencia VARCHAR)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        IF gerencia = '%'
        THEN
            OPEN ct FOR
                  SELECT   DISTINCT
                           a.usucodusu AS codigo,
                              NVL (a.usuapepat, ' ')
                           || ' '
                           || NVL (a.usuapemat, ' ')
                           || ' '
                           || a.usunombre
                               AS nombre,
                           a.usudocid || ' ' || a.usulugemi AS ci
                    FROM   usuario.usuario a, usuario.usu_rol b
                   WHERE       a.lst_ope = 'U'
                           AND a.usu_num = 0
                           AND a.usucodusu = b.usucodusu
                           AND (   b.rol_cod = 'GNF_FISCALIZADORUFR'
                                OR b.rol_cod = 'GNF_JEFEUFR'
                                OR b.rol_cod = 'GNF_SUPERVISORUFR')
                           AND b.ult_ver = 0
                           AND b.lst_ope = 'U'
                ORDER BY   2;
        ELSE
            OPEN ct FOR
                  SELECT   DISTINCT
                           a.usucodusu AS codigo,
                              NVL (a.usuapepat, ' ')
                           || ' '
                           || NVL (a.usuapemat, ' ')
                           || ' '
                           || a.usunombre
                               AS nombre,
                           a.usudocid || ' ' || a.usulugemi AS ci
                    FROM   usuario.usuario a, usuario.usu_rol b
                   WHERE       a.gercodger = gerencia
                           AND a.lst_ope = 'U'
                           AND a.usu_num = 0
                           AND a.usucodusu = b.usucodusu
                           AND (   b.rol_cod = 'GNF_FISCALIZADORUFR'
                                OR b.rol_cod = 'GNF_JEFEUFR'
                                OR b.rol_cod = 'GNF_SUPERVISORUFR')
                           AND b.ult_ver = 0
                           AND b.lst_ope = 'U'
                ORDER BY   2;
        END IF;

        RETURN ct;
    END;

    FUNCTION lista_gerencias (gerencia VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        IF gerencia = 'Todo'
        THEN
            OPEN ct FOR
                SELECT   -1 id,
                         '-' abrev,
                         'Seleccione...' descripcion,
                         '-' codigo,
                         'U' lstope
                  FROM   DUAL
                UNION
                SELECT   a.ger_id id,
                         a.ger_codigo abrev,
                         a.ger_descripcion descripcion,
                         a.reg_cod codigo,
                         a.reg_lstope lstope
                  FROM   fis_gerencia a
                 WHERE   reg_lstope = 'U'
                ORDER BY   1;
        ELSE
            IF gerencia = 'GNF'
            THEN
                OPEN ct FOR
                      SELECT   a.ger_id id,
                               a.ger_codigo codigo2,
                               a.ger_descripcion descripcion,
                               a.reg_cod codigo,
                               a.reg_lstope lstope
                        FROM   fis_gerencia a
                       WHERE   reg_lstope = 'U' AND a.ger_id > 0
                    ORDER BY   1;
            ELSE
                OPEN ct FOR
                      SELECT   a.ger_id id,
                               a.ger_codigo codigo2,
                               a.ger_descripcion descripcion,
                               a.reg_cod codigo,
                               a.reg_lstope lstope
                        FROM   fis_gerencia a
                       WHERE       reg_lstope = 'U'
                               AND a.ger_id > 0
                               AND a.reg_cod = gerencia
                    ORDER BY   1;
            END IF;
        END IF;

        RETURN ct;
    END;

    FUNCTION lista_gerencias2 (gerencia VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        IF gerencia = '15'
        THEN
            OPEN ct FOR
                  SELECT   a.ger_id id,
                           a.ger_codigo codigo2,
                           a.ger_descripcion descripcion,
                           a.reg_cod codigo,
                           a.reg_lstope lstope
                    FROM   fis_gerencia a
                   WHERE   reg_lstope = 'U' AND a.ger_id > 0
                ORDER BY   1;
        ELSE
            OPEN ct FOR
                  SELECT   a.ger_id id,
                           a.ger_codigo codigo2,
                           a.ger_descripcion descripcion,
                           a.reg_cod codigo,
                           a.reg_lstope lstope
                    FROM   fis_gerencia a
                   WHERE       reg_lstope = 'U'
                           AND a.ger_id > 0
                           AND a.reg_cod = gerencia
                ORDER BY   1;
        END IF;

        RETURN ct;
    END;

    FUNCTION devuelve_codigo (gestion    IN VARCHAR2,
                              tipo       IN VARCHAR2,
                              gerencia   IN VARCHAR2,
                              numero     IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res      VARCHAR2 (50) := 0;
        existe   NUMBER;
    BEGIN
        IF tipo = 'POSTERIOR' OR tipo = 'DIFERIDO'
        THEN
            IF is_number (numero) = 0
            THEN
                RETURN 'El N&uacute;mero de Orden no es v&aacute;lido';
            END IF;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_control a
             WHERE       a.ctl_cod_gestion = gestion
                     AND a.ctl_cod_tipo = tipo
                     AND a.ctl_cod_gerencia = gerencia
                     AND a.ctl_cod_numero = numero
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U';

            IF existe = 0
            THEN
                RETURN 'No existe la Orden';
            ELSE
                SELECT   a.ctl_control_id
                  INTO   res
                  FROM   fis_control a
                 WHERE       a.ctl_cod_gestion = gestion
                         AND a.ctl_cod_tipo = tipo
                         AND a.ctl_cod_gerencia = gerencia
                         AND a.ctl_cod_numero = numero
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U';

                RETURN 'CORRECTO' || res;
            END IF;
        ELSE
            IF INSTR (numero, '/') = 0
            THEN
                RETURN 'El N&uacute;mero de Orden Ampliatoria no es v&aacute;lido';
            ELSE
                IF is_number (SUBSTR (numero, 0, INSTR (numero, '/') - 1)) =
                       0
                   OR is_number(SUBSTR (
                                    numero,
                                    INSTR (numero, '/') + 1,
                                    LENGTH (numero) - INSTR (numero, '/'))) =
                         0
                THEN
                    RETURN 'El N&uacute;mero de Orden Ampliatoria no es v&aacute;lido';
                END IF;
            END IF;

            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_control a
             WHERE       a.ctl_cod_gestion = gestion
                     AND a.ctl_cod_tipo = tipo
                     AND a.ctl_cod_gerencia = gerencia
                     AND a.ctl_cod_numero || '/' || ctl_amp_correlativo =
                            numero
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U';

            IF existe = 0
            THEN
                RETURN 'No existe la Orden';
            ELSE
                SELECT   a.ctl_control_id
                  INTO   res
                  FROM   fis_control a
                 WHERE       a.ctl_cod_gestion = gestion
                         AND a.ctl_cod_tipo = tipo
                         AND a.ctl_cod_gerencia = gerencia
                         AND a.ctl_cod_numero || '/' || ctl_amp_correlativo =
                                numero
                         AND a.ctl_num = 0
                         AND a.ctl_lstope = 'U';

                RETURN 'CORRECTO' || res;
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR'
                   || SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END;

    FUNCTION devuelve_gerencia (codigo IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res      VARCHAR2 (50) := 0;
        existe   NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_control a
         WHERE       a.ctl_control_id = codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF existe = 0
        THEN
            RETURN '-';
        ELSE
            SELECT   a.ctl_cod_gerencia
              INTO   res
              FROM   fis_control a
             WHERE       a.ctl_control_id = codigo
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U';

            RETURN res;
        END IF;
    END;

    FUNCTION devuelve_fis_asignados (codigo VARCHAR)
        RETURN cursortype
    IS
        ct              cursortype;
        v_codigo        VARCHAR2 (20);
        v_tipocontrol   VARCHAR2 (30);
    BEGIN
        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            SELECT   c.ctl_control_id
              INTO   v_codigo
              FROM   fis_control a, fis_control c
             WHERE       a.ctl_control_id = codigo
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND a.ctl_cod_gestion = c.ctl_cod_gestion
                     AND a.ctl_amp_control = c.ctl_cod_tipo
                     AND a.ctl_cod_gerencia = c.ctl_cod_gerencia
                     AND a.ctl_cod_numero = c.ctl_cod_numero
                     AND c.ctl_num = 0
                     AND c.ctl_lstope = 'U';
        ELSE
            v_codigo := codigo;
        END IF;

        OPEN ct FOR
              SELECT   a.fis_fiscalizador_id id,
                       a.fis_codigo_fiscalizador codigo,
                          NVL (u.usuapepat, ' ')
                       || ' '
                       || NVL (u.usuapemat, ' ')
                       || ' '
                       || u.usunombre
                           AS nombre,
                       a.fis_cargo cargo,
                       a.fis_fecsys fecha,
                       a.fis_usuario usuario,
                       u.usudocid || ' ' || u.usulugemi AS ci
                FROM   fis_fiscalizador a, usuario.usuario u
               WHERE       a.ctl_control_id = v_codigo
                       AND a.fis_codigo_fiscalizador = u.usucodusu
                       AND a.fis_num = 0
                       AND a.fis_lstope = 'U'
                       AND u.lst_ope = 'U'
                       AND u.usu_num = 0
            ORDER BY   4, 2;

        RETURN ct;
    END;

    FUNCTION devuelve_fis_accesos (codigo VARCHAR)
        RETURN cursortype
    IS
        ct              cursortype;
        v_codigo        VARCHAR2 (20);
        v_tipocontrol   VARCHAR2 (30);
    BEGIN
        SELECT   ctl_cod_tipo
          INTO   v_tipocontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_tipocontrol = 'AMPLIATORIA DIFERIDO'
           OR v_tipocontrol = 'AMPLIATORIA POSTERIOR'
        THEN
            SELECT   c.ctl_control_id
              INTO   v_codigo
              FROM   fis_control a, fis_control c
             WHERE       a.ctl_control_id = codigo
                     AND a.ctl_num = 0
                     AND a.ctl_lstope = 'U'
                     AND a.ctl_cod_gestion = c.ctl_cod_gestion
                     AND a.ctl_amp_control = c.ctl_cod_tipo
                     AND a.ctl_cod_gerencia = c.ctl_cod_gerencia
                     AND a.ctl_cod_numero = c.ctl_cod_numero
                     AND c.ctl_num = 0
                     AND c.ctl_lstope = 'U';
        ELSE
            v_codigo := codigo;
        END IF;

        OPEN ct FOR
              SELECT   a.fis_acceso_id id,
                       a.fis_codigo_fiscalizador codigo,
                          NVL (u.usuapepat, ' ')
                       || ' '
                       || NVL (u.usuapemat, ' ')
                       || ' '
                       || u.usunombre
                           AS nombre,
                       a.fis_cargo cargo,
                       a.fis_fecsys fecha,
                       a.fis_usuario usuario,
                       u.usudocid || ' ' || u.usulugemi AS ci
                FROM   fis_acceso a, usuario.usuario u
               WHERE       a.ctl_control_id = v_codigo
                       AND a.fis_codigo_fiscalizador = u.usucodusu
                       AND a.fis_num = 0
                       AND a.fis_lstope = 'U'
                       AND u.lst_ope = 'U'
                       AND u.usu_num = 0
            ORDER BY   4, 2;

        RETURN ct;
    END;

    FUNCTION roundsidunea (p_numero IN NUMBER, p_preci IN NUMBER)
        RETURN NUMBER
    IS
        v_valor   NUMBER;
        v_dec     NUMBER;
    BEGIN
        --        IF p_preci = 0         THEN V_dec := 0.5; END IF;
        --        IF p_preci = 1         THEN V_dec := 0.05; END IF;
        --        IF p_preci = 2         THEN V_dec := 0.005; END IF;
        v_dec := 5 / POWER (10, p_preci + 1);
        v_valor := TRUNC (p_numero, p_preci);

        IF v_valor <= p_numero AND p_numero < v_valor + v_dec
        THEN
            RETURN v_valor;
        ELSE
            RETURN v_valor + (1 / POWER (10, p_preci));
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN -1;
    END roundsidunea;

    FUNCTION verifica_usuariogerencia (prm_codigo    IN VARCHAR2,
                                       prm_usuario   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res            VARCHAR2 (50);
        v_gerusuario   VARCHAR2 (30);
        v_gercontrol   VARCHAR2 (30);
    BEGIN
        --Para controlar la gerencia del usuario
        SELECT   DECODE (a.gercodger,
                         15, 'GNF',
                         19, 'GRL',
                         20, 'GRO',
                         21, 'GRC',
                         22, 'GRS',
                         23, 'GRT',
                         24, 'GRP',
                         '-')
          INTO   v_gerusuario
          FROM   usuario.usuario a
         WHERE       a.lst_ope = 'U'
                 AND a.usu_num = 0
                 AND a.usucodusu = prm_usuario;

        SELECT   ctl_cod_gerencia
          INTO   v_gercontrol
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';

        IF v_gerusuario = v_gercontrol
        THEN
            RETURN 'CORRECTO';
        ELSE
            RETURN 'El control no corresponde a la Gerencia del Usuario, la Gerencia del control es: '
                   || v_gercontrol
                   || ' y la Gerencia del usuario es: '
                   || v_gerusuario;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'El Usuario o el Control no tienen Gerencia Asignada';
    END;

    FUNCTION esfechamenorigualahoy (prm_fecha IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res   VARCHAR2 (50);
    BEGIN
        IF TO_DATE (prm_fecha, 'dd/mm/yyyy') <= TRUNC (SYSDATE)
        THEN
            res := 'CORRECTO';
        ELSE
            res := 'FALSO';
        END IF;

        RETURN res;
    END;

    FUNCTION f_matriz_permutaciones (x IN NUMBER, y IN NUMBER)
        RETURN NUMBER
    IS
        v_0        VARCHAR2 (10) := '0123456789';
        v_1        VARCHAR2 (10) := '1576283094';
        v_2        VARCHAR2 (10) := '5803796142';
        v_3        VARCHAR2 (10) := '8916043527';
        v_4        VARCHAR2 (10) := '9453126870';
        v_5        VARCHAR2 (10) := '4286573901';
        v_6        VARCHAR2 (10) := '2793806415';
        v_7        VARCHAR2 (10) := '7046913258';
        v_salida   NUMBER;
    BEGIN
        IF x = 0
        THEN
            v_salida := SUBSTR (v_0, y + 1, 1);
        ELSIF x = 1
        THEN
            v_salida := SUBSTR (v_1, y + 1, 1);
        ELSIF x = 2
        THEN
            v_salida := SUBSTR (v_2, y + 1, 1);
        ELSIF x = 3
        THEN
            v_salida := SUBSTR (v_3, y + 1, 1);
        ELSIF x = 4
        THEN
            v_salida := SUBSTR (v_4, y + 1, 1);
        ELSIF x = 5
        THEN
            v_salida := SUBSTR (v_5, y + 1, 1);
        ELSIF x = 6
        THEN
            v_salida := SUBSTR (v_6, y + 1, 1);
        ELSIF x = 7
        THEN
            v_salida := SUBSTR (v_7, y + 1, 1);
        ELSE
            v_salida := -1;
        END IF;

        RETURN v_salida;
    END;

    FUNCTION f_matriz_verhoeff (x IN NUMBER, y IN NUMBER)
        RETURN NUMBER
    IS
        v_0        VARCHAR2 (10) := '0123456789';
        v_1        VARCHAR2 (10) := '1234067895';
        v_2        VARCHAR2 (10) := '2340178956';
        v_3        VARCHAR2 (10) := '3401289567';
        v_4        VARCHAR2 (10) := '4012395678';
        v_5        VARCHAR2 (10) := '5987604321';
        v_6        VARCHAR2 (10) := '6598710432';
        v_7        VARCHAR2 (10) := '7659821043';
        v_8        VARCHAR2 (10) := '8765932104';
        v_9        VARCHAR2 (10) := '9876543210';
        v_salida   NUMBER;
    BEGIN
        IF x = 0
        THEN
            v_salida := SUBSTR (v_0, y + 1, 1);
        ELSIF x = 1
        THEN
            v_salida := SUBSTR (v_1, y + 1, 1);
        ELSIF x = 2
        THEN
            v_salida := SUBSTR (v_2, y + 1, 1);
        ELSIF x = 3
        THEN
            v_salida := SUBSTR (v_3, y + 1, 1);
        ELSIF x = 4
        THEN
            v_salida := SUBSTR (v_4, y + 1, 1);
        ELSIF x = 5
        THEN
            v_salida := SUBSTR (v_5, y + 1, 1);
        ELSIF x = 6
        THEN
            v_salida := SUBSTR (v_6, y + 1, 1);
        ELSIF x = 7
        THEN
            v_salida := SUBSTR (v_7, y + 1, 1);
        ELSIF x = 8
        THEN
            v_salida := SUBSTR (v_8, y + 1, 1);
        ELSIF x = 9
        THEN
            v_salida := SUBSTR (v_9, y + 1, 1);
        ELSE
            v_salida := -1;
        END IF;

        RETURN v_salida;
    END;

    FUNCTION f_validadigitoverificador (p_numero IN NUMBER)
        RETURN NUMBER
    IS
        v_retorno   NUMBER;
        v_largo     NUMBER;
        v_check     NUMBER := 0;
        i           NUMBER;
        x           NUMBER;
        y           NUMBER;
        z           NUMBER;
    BEGIN
        v_largo := LENGTH (p_numero);

        FOR i IN 0 .. v_largo - 1
        LOOP
            x := MOD (i, 8);
            y := SUBSTR (p_numero, v_largo - i, 1);
            z := f_matriz_permutaciones (x, y);
            v_check := f_matriz_verhoeff (v_check, z);
        END LOOP;

        IF v_check = 0
        THEN
            v_retorno := 1;
        ELSE
            v_retorno := 0;
        END IF;

        RETURN v_retorno;
    END;

    FUNCTION is_number (prm_codigo IN VARCHAR2)
        RETURN NUMBER
    IS
        res        NUMBER (5);
        v_number   NUMBER;
    BEGIN
        v_number := TO_NUMBER (prm_codigo);

        RETURN 1;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION verifica_acceso (prm_codigo     IN VARCHAR2,
                              prm_usuario    IN VARCHAR2,
                              prm_opcion     IN VARCHAR2,
                              prm_gerencia   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        res          VARCHAR2 (50) := 'NOCORRECTO';
        cont         NUMBER (10);
        tipo         VARCHAR (30);
        codigo_amp   VARCHAR (30);
    BEGIN
        SELECT   DECODE (a.ctl_cod_tipo,
                         'POSTERIOR', 'ORDEN',
                         'DIFERIDO', 'ORDEN',
                         'AMPLIATORIA POSTERIOR', 'AMPLIATORIA',
                         'AMPLIATORIA DIFERIDO', 'AMPLIATORIA',
                         '-')
          INTO   tipo
          FROM   fis_control a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.ctl_num = 0
                 AND a.ctl_lstope = 'U';


        IF tipo = 'ORDEN'
        THEN
            IF (   prm_opcion = 'NOTIFICACION'
                OR prm_opcion = 'AMPLIACION'
                OR prm_opcion = 'GENERACION'
                OR prm_opcion = 'SUBIR'
                OR prm_opcion = 'EXCEL'
                OR prm_opcion = 'RECIBOS')
            THEN
                SELECT   COUNT (1)
                  INTO   cont
                  FROM   fis_acceso a
                 WHERE   a.ctl_control_id = prm_codigo
                         AND a.fis_codigo_fiscalizador = prm_usuario
                         AND (a.fis_cargo = 'FISCALIZADOR'
                              OR a.fis_cargo = 'FISCALIZADOR APOYO')
                         AND a.fis_num = 0
                         AND a.fis_lstope = 'U';

                IF cont > 0
                THEN
                    res := 'CORRECTO';
                ELSE
                    res := 'NOCORRECTO';
                END IF;
            END IF;

            IF (prm_opcion = 'CONCLUSION')
            THEN
                SELECT   COUNT (1)
                  INTO   cont
                  FROM   usuario.usu_rol a
                 WHERE       a.usucodusu = prm_usuario
                         AND a.rol_cod = 'GNF_LEGAL'
                         AND a.lst_ope = 'U'
                         AND a.ult_ver = 0;

                IF cont = 0
                THEN
                    SELECT   COUNT (1)
                      INTO   cont
                      FROM   fis_acceso a
                     WHERE   a.ctl_control_id = prm_codigo
                             AND a.fis_codigo_fiscalizador = prm_usuario
                             AND (a.fis_cargo = 'FISCALIZADOR'
                                  OR a.fis_cargo = 'FISCALIZADOR APOYO')
                             AND a.fis_num = 0
                             AND a.fis_lstope = 'U';

                    IF cont > 0
                    THEN
                        res := 'CORRECTO';
                    ELSE
                        res := 'NOCORRECTO';
                    END IF;
                ELSE
                    res := 'CORRECTO';
                END IF;
            END IF;

            IF (   prm_opcion = 'ALCANCE'
                OR prm_opcion = 'ASIGNACION'
                OR prm_opcion = 'REGISTRA')
            THEN
                SELECT   COUNT (1)
                  INTO   cont
                  FROM   usuario.usu_rol a
                 WHERE   a.usucodusu = prm_usuario
                         AND (   a.rol_cod = 'GNF_JEFEUFR'
                              OR a.rol_cod = 'GNF_SUPERVISORUFR'
                              OR a.rol_cod = 'GNF_INVESTIGADORUFR')
                         AND a.lst_ope = 'U'
                         AND a.ult_ver = 0;

                IF cont > 0
                THEN
                    SELECT   COUNT (1)
                      INTO   cont
                      FROM   fis_control a
                     WHERE       a.ctl_control_id = prm_codigo
                             AND a.ctl_num = 0
                             AND a.ctl_lstope = 'U'
                             AND a.ctl_cod_gerencia = prm_gerencia;

                    IF cont > 0
                    THEN
                        res := 'CORRECTO';
                    ELSE
                        res := 'NOGERENCIA';
                    END IF;
                ELSE
                    res := 'NOPERFIL';
                END IF;
            END IF;

            IF (prm_opcion = 'ANULACION' OR prm_opcion = 'REASIGNA')
            THEN
                SELECT   COUNT (1)
                  INTO   cont
                  FROM   usuario.usu_rol a
                 WHERE   a.usucodusu = prm_usuario
                         AND (a.rol_cod = 'GNF_JEFEUFR'
                              OR a.rol_cod = 'GNF_SUPERVISORUFR')
                         AND a.lst_ope = 'U'
                         AND a.ult_ver = 0;

                IF cont > 0
                THEN
                    /*SELECT   COUNT (1)
                      INTO   cont
                      FROM   fis_acceso a
                     WHERE   a.ctl_control_id = prm_codigo
                             AND a.fis_usuario = prm_usuario
                             AND (a.fis_cargo = 'JEFE'
                                  OR a.fis_cargo = 'SUPERVISOR')
                             AND a.fis_num = 0
                             AND a.fis_lstope = 'U';

                    IF cont > 0
                    THEN*/
                    SELECT   COUNT (1)
                      INTO   cont
                      FROM   fis_control a
                     WHERE       a.ctl_control_id = prm_codigo
                             AND a.ctl_num = 0
                             AND a.ctl_lstope = 'U'
                             AND a.ctl_cod_gerencia = prm_gerencia;

                    IF cont > 0
                    THEN
                        res := 'CORRECTO';
                    ELSE
                        res := 'NOGERENCIA';
                    END IF;
                /*ELSE
                    res := 'NOASIGNADO';
                END IF;*/
                ELSE
                    res := 'NOPERFIL';
                END IF;
            END IF;
        END IF;


        IF tipo = 'AMPLIATORIA'
        THEN
            SELECT   ctl.ctl_control_id
              INTO   codigo_amp
              FROM   fis_control amp, fis_control ctl
             WHERE       amp.ctl_control_id = prm_codigo
                     AND amp.ctl_num = 0
                     AND amp.ctl_lstope = 'U'
                     AND amp.ctl_cod_gestion = ctl.ctl_cod_gestion
                     AND amp.ctl_amp_control = ctl.ctl_cod_tipo
                     AND amp.ctl_cod_gerencia = ctl.ctl_cod_gerencia
                     AND amp.ctl_cod_numero = ctl.ctl_cod_numero
                     AND ctl.ctl_num = 0
                     AND ctl.ctl_lstope = 'U';

            IF (   prm_opcion = 'NOTIFICACION'
                OR prm_opcion = 'AMPLIACION'
                OR prm_opcion = 'GENERACION'
                OR prm_opcion = 'SUBIR'
                OR prm_opcion = 'EXCEL'
                OR prm_opcion = 'REASIGNA'
                OR prm_opcion = 'ALCANCE'
                OR prm_opcion = 'ASIGNACION'
                OR prm_opcion = 'REGISTRA'
                OR prm_opcion = 'RECIBOS')
            THEN
                res := 'NOAMPLIATORIA';
            END IF;

            IF (prm_opcion = 'CONCLUSION')
            THEN
                SELECT   COUNT (1)
                  INTO   cont
                  FROM   usuario.usu_rol a
                 WHERE       a.usucodusu = prm_usuario
                         AND a.rol_cod = 'GNF_LEGAL'
                         AND a.lst_ope = 'U'
                         AND a.ult_ver = 0;

                IF cont = 0
                THEN
                    SELECT   COUNT (1)
                      INTO   cont
                      FROM   fis_acceso a
                     WHERE       a.ctl_control_id = codigo_amp
                             AND a.fis_codigo_fiscalizador = prm_usuario
                             AND a.fis_cargo = 'FISCALIZADOR'
                             AND a.fis_num = 0
                             AND a.fis_lstope = 'U';

                    IF cont > 0
                    THEN
                        res := 'CORRECTO';
                    ELSE
                        res := 'NOCORRECTO';
                    END IF;
                ELSE
                    res := 'CORRECTO';
                END IF;
            END IF;

            IF (prm_opcion = 'ANULACION')
            THEN
                SELECT   COUNT (1)
                  INTO   cont
                  FROM   usuario.usu_rol a
                 WHERE   a.usucodusu = prm_usuario
                         AND (a.rol_cod = 'GNF_JEFEUFR'
                              OR a.rol_cod = 'GNF_SUPERVISORUFR')
                         AND a.lst_ope = 'U'
                         AND a.ult_ver = 0;

                IF cont > 0
                THEN
                    SELECT   COUNT (1)
                      INTO   cont
                      FROM   fis_control a
                     WHERE       a.ctl_control_id = codigo_amp
                             AND a.ctl_num = 0
                             AND a.ctl_lstope = 'U'
                             AND a.ctl_cod_gerencia = prm_gerencia;

                    IF cont > 0
                    THEN
                        res := 'CORRECTO';
                    ELSE
                        res := 'NOGERENCIA';
                    END IF;
                ELSE
                    res := 'NOPERFIL';
                END IF;
            END IF;
        END IF;



        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'NOCORRECTO';
    END;
END;
/


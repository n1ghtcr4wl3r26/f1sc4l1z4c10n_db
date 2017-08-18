CREATE OR REPLACE 
PACKAGE pkg_fisca
/* Formatted on 17/08/2017 19:42:43 (QP5 v5.126) */
IS
    TYPE cursortype IS REF CURSOR;

    FUNCTION verifica (gestion   IN VARCHAR2,
                       aduana    IN VARCHAR2,
                       numero    IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION c_diligencia1 (sid IN VARCHAR2)
        RETURN cursortype;

    FUNCTION c_lista_imp (gestion   IN VARCHAR2,
                          aduana    IN VARCHAR2,
                          numero    IN VARCHAR2)
        RETURN cursortype;

    FUNCTION g_control (gestion        IN VARCHAR2,
                        aduana         IN VARCHAR2,
                        numero         IN VARCHAR2,
                        control        IN VARCHAR2,
                        fiscalizador   IN VARCHAR2,
                        archivo        IN VARCHAR2,
                        comentario     IN VARCHAR2,
                        usuario        IN VARCHAR2)
        RETURN VARCHAR2;

    PROCEDURE graba_mira_fis (gestion        IN VARCHAR2,
                              aduana         IN VARCHAR2,
                              numero         IN VARCHAR2,
                              tipo_control   IN VARCHAR2,
                              fiscalizador   IN VARCHAR2,
                              comentario     IN VARCHAR2,
                              usuario        IN VARCHAR2);

    FUNCTION verifica_fisca (gestion    IN     VARCHAR2,
                             aduana     IN     VARCHAR2,
                             numero     IN     VARCHAR2,
                             usuario    IN     VARCHAR2,
                             gerencia      OUT VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION r_listadoficha (aduana IN VARCHAR2)
        RETURN cursortype;

    FUNCTION r_listadocontrol (aduana    IN VARCHAR2,
                               fini      IN VARCHAR2,
                               ffin      IN VARCHAR2,
                               control   IN VARCHAR2)
        RETURN cursortype;

    FUNCTION verifica_control_veh (gestion    IN     VARCHAR2,
                                   aduana     IN     VARCHAR2,
                                   numero     IN     VARCHAR2,
                                   usuario    IN     VARCHAR2,
                                   gerencia      OUT VARCHAR2)
        RETURN VARCHAR2;
END;                                                           -- Package spec
/

CREATE OR REPLACE 
PACKAGE BODY pkg_fisca
/* Formatted on 17/08/2017 19:42:47 (QP5 v5.126) */
IS
    FUNCTION verifica (gestion   IN VARCHAR2,
                       aduana    IN VARCHAR2,
                       numero    IN VARCHAR2)
        RETURN VARCHAR2
    IS
        hay          NUMBER (10) := 0;
        gestionm     VARCHAR2 (5) := '';
        declarante   VARCHAR2 (17) := '';
        knumber      VARCHAR2 (13) := '';
    BEGIN
        SELECT   COUNT (1)
          INTO   hay
          FROM   mir_control a, mir_diligencia1 b
         WHERE       a.con_key_year = gestion
                 AND a.con_key_cuo = aduana
                 AND a.con_reg_nber = numero
                 AND a.con_obs = '1'
                 AND a.con_lst_ope = 'U'
                 AND   a.con_key_year
                    || a.con_key_cuo
                    || a.con_reg_nber
                    || DECODE (a.con_fuente, 'NO', '', '-' || a.con_fuente) =
                        b.id
                 AND b.dil1_factores IS NOT NULL
                 AND b.dil1_nombre IS NULL
                 AND b.dil1_num = 0;

        IF hay = 0
        THEN
            RETURN 'Error: La declaraci&oacute;n no tiene observaciones o ficha informativa';
        END IF;


        SELECT   a.key_year, NVL (a.key_dec, '0'), a.key_nber
          INTO   gestionm, declarante, knumber
          FROM   ops$asy.sad_gen a
         WHERE       a.sad_reg_year = gestion
                 AND a.key_cuo = aduana
                 AND a.sad_reg_nber = numero
                 AND a.sad_num = 0
                 AND a.sad_flw = 1
                 AND a.lst_ope = 'U';

        IF (declarante = '0')
        THEN
            SELECT   COUNT (1)
              INTO   hay
              FROM   ops$asy.sad_spy
             WHERE       key_year = gestionm
                     AND key_cuo = aduana
                     AND key_dec IS NULL
                     AND key_nber = knumber
                     AND spy_sta = '6'
                     AND spy_act = '9'
                     AND sad_clr = 0;
        ELSE
            SELECT   COUNT (1)
              INTO   hay
              FROM   ops$asy.sad_spy
             WHERE       key_year = gestionm
                     AND key_cuo = aduana
                     AND key_dec = declarante
                     AND key_nber = knumber
                     AND spy_sta = '6'
                     AND spy_act = '9'
                     AND sad_clr = 0;
        END IF;

        IF hay = 0
        THEN
            ROLLBACK;
            RETURN    'Error: La Declaraci'
                   || CHR (243)
                   || 'n no tiene Autorizaci'
                   || CHR (243)
                   || 'n de Levante Registrado';
        END IF;


        RETURN ('Correcto');
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN ('Error: ' || SQLERRM);
    END;

    FUNCTION c_diligencia1 (sid IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        IF (INSTR (sid, '-') > 0)
        THEN
            OPEN cr FOR
                SELECT   b.con_key_year || b.con_key_cuo || b.con_reg_nber
                             AS dma,
                            a.sad_reg_year
                         || '/'
                         || a.key_cuo
                         || '/C-'
                         || a.sad_reg_nber
                             AS dui,
                         b.con_fuente || ' ' || NVL (b.con_fuente_obs, ' ')
                             AS dav,
                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy') AS fecha_dui,
                         UPPER (e.cuo_nam) AS aduana,
                            e.cuo_adr
                         || ' '
                         || e.cuo_ad2
                         || ' '
                         || e.cuo_ad3
                         || ' '
                         || e.cuo_ad4
                             AS lugar,
                         --DECODE(a.sad_consignee, NULL, h.sad_con_nam, d.cmp_nam) AS importador,

                         DECODE (a.sad_consignee,
                                 NULL, h.sad_con_nam,
                                 NVL (d.cmp_nam, cab.ope_razonsocial))
                             AS importador,
                         NVL (a.sad_consignee, h.sad_con_zip)
                             AS id_importador,
                         DECODE (a.key_dec, NULL, g.sad_dec_nam, c.dec_nam)
                             AS agencia,
                         NVL (a.key_dec, '-') AS id_agencia,
                         f.dil1_tipo,
                         f.dil1_factores,
                         f.dil1_especifique,
                         f.dil1_notifica,
                         f.dil1_nombre,
                         f.dil1_identificacion,
                         f.dil1_poder,
                         f.dil1_lugar,
                         NVL (f.dil1_aceptacion, '-') dil1_aceptacion,
                         TO_CHAR (b.con_diligencia1, 'dd/mm/yyyy')
                             AS fecha_diligencia,
                         f.dil1_usuario AS usuario,
                         NVL (
                             TO_CHAR (b.con_ndiligencia1,
                                      'DD/MM/YYYY HH24:MI:ss'),
                             '-')
                             AS fecha_notificacion,
                         TO_CHAR (f.dil1_fec_reg, 'dd/mm/yyyy HH24:MI:ss')
                             AS fecha_dili1,
                         b.con_usuario AS tecnico
                  FROM   ops$asy.sad_gen a,
                         mir_control b,
                         ops$asy.undectab c,
                         ops$asy.uncmptab d,
                         bo_oce_opecab cab,
                         ops$asy.uncuotab e,
                         mir_diligencia1 f,
                         ops$asy.sad_occ_dec g,
                         ops$asy.sad_occ_cns h
                 WHERE   a.sad_reg_year = SUBSTR (sid, 1, 4)
                         AND a.key_cuo = SUBSTR (sid, 5, 3)
                         AND a.sad_reg_nber =
                                SUBSTR (sid, 8, INSTR (sid, '-') - 8)
                         AND a.sad_flw = 1
                         AND a.lst_ope = 'U'
                         AND a.sad_num = 0
                         AND a.sad_reg_year = b.con_key_year
                         AND a.key_cuo = b.con_key_cuo
                         AND a.sad_reg_nber = b.con_reg_nber
                         AND b.con_fuente =
                                SUBSTR (sid, INSTR (sid, '-') + 1)
                         AND a.key_cuo = e.cuo_cod
                         AND e.lst_ope = 'U'
                         AND NVL (a.sad_consignee, '-') =
                                NVL (d.cmp_cod(+), '-')
                         AND d.lst_ope(+) = 'U'
                         AND NVL (a.sad_consignee, '-') =
                                NVL (cab.ope_numerodoc(+), '-')
                         AND cab.ope_num(+) = 0
                         AND NVL (a.key_dec, '-') = NVL (c.dec_cod(+), '-')
                         AND c.lst_ope(+) = 'U'
                         AND a.key_year = g.key_year(+)
                         AND a.key_cuo = g.key_cuo(+)
                         AND NVL (a.key_dec, '-') = NVL (g.key_dec(+), '-')
                         AND a.key_nber = g.key_nber(+)
                         AND a.sad_num = g.sad_num(+)
                         AND b.con_key_year = SUBSTR (f.id, 1, 4)
                         AND b.con_key_cuo = SUBSTR (f.id, 5, 3)
                         AND b.con_reg_nber =
                                SUBSTR (f.id, 8, INSTR (f.id, '-') - 8)
                         AND b.con_fuente =
                                SUBSTR (f.id, INSTR (f.id, '-') + 1)
                         AND f.dil1_num = 0
                         AND a.key_year = h.key_year(+)
                         AND a.key_cuo = h.key_cuo(+)
                         AND NVL (a.key_dec, '-') = NVL (h.key_dec(+), '-')
                         AND a.key_nber = h.key_nber(+)
                         AND a.sad_num = h.sad_num(+);
        ELSE
            OPEN cr FOR
                SELECT   b.con_key_year || b.con_key_cuo || b.con_reg_nber
                             AS dma,
                            a.sad_reg_year
                         || '/'
                         || a.key_cuo
                         || '/C-'
                         || a.sad_reg_nber
                             AS dui,
                         b.con_fuente || ' ' || NVL (b.con_fuente_obs, ' ')
                             AS dav,
                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy') AS fecha_dui,
                         UPPER (e.cuo_nam) AS aduana,
                            e.cuo_adr
                         || ' '
                         || e.cuo_ad2
                         || ' '
                         || e.cuo_ad3
                         || ' '
                         || e.cuo_ad4
                             AS lugar,
                         --DECODE(a.sad_consignee, NULL, h.sad_con_nam, d.cmp_nam) AS importador,
                         DECODE (a.sad_consignee,
                                 NULL, h.sad_con_nam,
                                 NVL (d.cmp_nam, cab.ope_razonsocial))
                             AS importador,
                         NVL (a.sad_consignee, h.sad_con_zip)
                             AS id_importador,
                         DECODE (a.key_dec, NULL, g.sad_dec_nam, c.dec_nam)
                             AS agencia,
                         NVL (a.key_dec, '-') AS id_agencia,
                         f.dil1_tipo,
                         f.dil1_factores,
                         f.dil1_especifique,
                         f.dil1_notifica,
                         f.dil1_nombre,
                         f.dil1_identificacion,
                         f.dil1_poder,
                         f.dil1_lugar,
                         NVL (f.dil1_aceptacion, '-') dil1_aceptacion,
                         TO_CHAR (b.con_diligencia1, 'dd/mm/yyyy')
                             AS fecha_diligencia,
                         f.dil1_usuario AS usuario,
                         NVL (
                             TO_CHAR (b.con_ndiligencia1,
                                      'DD/MM/YYYY HH24:MI:ss'),
                             '-')
                             AS fecha_notificacion,
                         TO_CHAR (f.dil1_fec_reg, 'dd/mm/yyyy HH24:MI:ss')
                             AS fecha_dili1,
                         b.con_usuario AS tecnico
                  FROM   ops$asy.sad_gen a,
                         mir_control b,
                         ops$asy.undectab c,
                         ops$asy.uncmptab d,
                         bo_oce_opecab cab,
                         ops$asy.uncuotab e,
                         mir_diligencia1 f,
                         ops$asy.sad_occ_dec g,
                         ops$asy.sad_occ_cns h
                 WHERE   a.sad_reg_year = SUBSTR (sid, 1, 4)
                         AND a.key_cuo = SUBSTR (sid, 5, 3)
                         AND a.sad_reg_nber =
                                SUBSTR (sid, 8, LENGTH (sid) - 7)
                         AND a.sad_flw = 1
                         AND a.lst_ope = 'U'
                         AND a.sad_num = 0
                         AND a.sad_reg_year = b.con_key_year
                         AND a.key_cuo = b.con_key_cuo
                         AND a.sad_reg_nber = b.con_reg_nber
                         AND a.key_cuo = e.cuo_cod
                         AND e.lst_ope = 'U'
                         AND NVL (a.sad_consignee, '-') =
                                NVL (d.cmp_cod(+), '-')
                         AND d.lst_ope(+) = 'U'
                         AND NVL (a.sad_consignee, '-') =
                                NVL (cab.ope_numerodoc(+), '-')
                         AND cab.ope_num(+) = 0
                         AND NVL (a.key_dec, '-') = NVL (c.dec_cod(+), '-')
                         AND c.lst_ope(+) = 'U'
                         AND a.key_year = g.key_year(+)
                         AND a.key_cuo = g.key_cuo(+)
                         AND NVL (a.key_dec, '-') = NVL (g.key_dec(+), '-')
                         AND a.key_nber = g.key_nber(+)
                         AND a.sad_num = g.sad_num(+)
                         AND sid = f.id
                         AND f.dil1_num = 0
                         AND a.key_year = h.key_year(+)
                         AND a.key_cuo = h.key_cuo(+)
                         AND NVL (a.key_dec, '-') = NVL (h.key_dec(+), '-')
                         AND a.key_nber = h.key_nber(+)
                         AND a.sad_num = h.sad_num(+);
        END IF;

        RETURN cr;
    END;

    FUNCTION c_lista_imp (gestion   IN VARCHAR2,
                          aduana    IN VARCHAR2,
                          numero    IN VARCHAR2)
        RETURN cursortype
    IS
        cr                cursortype;
        p_sad_consignee   VARCHAR2 (17) := '';
        p_key_year        VARCHAR2 (4) := '';
        p_key_dec         VARCHAR2 (17) := '';
        p_key_nber        VARCHAR2 (13) := '';
    BEGIN
        SELECT   a.key_year,
                 NVL (a.key_dec, '-'),
                 a.key_nber,
                 NVL (a.sad_consignee, '-')
          INTO   p_key_year,
                 p_key_dec,
                 p_key_nber,
                 p_sad_consignee
          FROM   ops$asy.sad_gen a
         WHERE       a.sad_reg_year = gestion
                 AND a.key_cuo = aduana
                 AND a.sad_reg_nber = numero
                 AND a.sad_flw = '1'
                 AND a.sad_num = 0
                 AND a.lst_ope = 'U';

        IF p_sad_consignee = '-'
        THEN
            SELECT   SUBSTR (sad_con_zip,
                             INSTR (sad_con_zip, ' ') + 1,
                             LENGTH (sad_con_zip))
              INTO   p_sad_consignee
              FROM   ops$asy.sad_occ_cns a
             WHERE       a.key_year = p_key_year
                     AND a.key_cuo = aduana
                     AND NVL (a.key_dec, 0) = NVL (p_key_dec, 0)
                     AND a.key_nber = p_key_nber
                     AND a.sad_num = 0;
        END IF;

        OPEN cr FOR
            SELECT   b.sad_reg_year,
                     b.key_cuo,
                     b.sad_reg_nber,
                     b.sad_typ_dec,
                     b.sad_typ_proc,
                     TO_CHAR (b.sad_reg_date, 'dd/mm/yyyy') AS sad_reg_date,
                     b.sad_clr
              FROM   (SELECT   a.sad_reg_year,
                               a.key_cuo,
                               a.sad_reg_nber,
                               a.sad_typ_dec,
                               a.sad_typ_proc,
                               a.sad_reg_date,
                               NVL (
                                   (SELECT   y.sad_clr
                                      FROM   ops$asy.sad_spy y
                                     WHERE       y.key_year = a.key_year
                                             AND y.key_cuo = a.key_cuo
                                             AND y.key_dec = a.key_dec
                                             AND y.key_nber = a.key_nber
                                             AND y.spy_sta = '10'
                                             AND y.spy_act = '24'),
                                   '-')
                                   AS sad_clr
                        FROM   ops$asy.sad_gen a
                       WHERE       a.sad_reg_year = a.sad_reg_year
                               AND a.key_cuo = a.key_cuo
                               AND a.sad_reg_nber IS NOT NULL
                               AND a.sad_consignee = p_sad_consignee
                               AND a.sad_num = 0
                               AND a.sad_flw = 1
                               AND a.lst_ope = 'U'
                      UNION
                      SELECT   a.sad_reg_year,
                               a.key_cuo,
                               a.sad_reg_nber,
                               a.sad_typ_dec,
                               a.sad_typ_proc,
                               a.sad_reg_date,
                               NVL (
                                   (SELECT   y.sad_clr
                                      FROM   ops$asy.sad_spy y
                                     WHERE       y.key_year = a.key_year
                                             AND y.key_cuo = a.key_cuo
                                             AND y.key_dec = a.key_dec
                                             AND y.key_nber = a.key_nber
                                             AND y.spy_sta = '10'
                                             AND y.spy_act = '24'),
                                   '-')
                                   AS sad_clr
                        FROM   ops$asy.sad_gen a, ops$asy.sad_occ_cns h
                       WHERE   SUBSTR (h.sad_con_zip,
                                       INSTR (h.sad_con_zip, ' ') + 1,
                                       LENGTH (h.sad_con_zip)) =
                                   p_sad_consignee
                               AND h.sad_num = 0
                               AND h.key_year = a.key_year
                               AND h.key_cuo = a.key_cuo
                               AND NVL (h.key_dec, '-') =
                                      NVL (a.key_dec, '-')
                               AND h.key_nber = a.key_nber
                               AND h.sad_num = a.sad_num
                               AND a.sad_reg_nber IS NOT NULL
                               AND a.sad_flw = 1
                               AND a.lst_ope = 'U'
                      ORDER BY   sad_reg_date DESC) b
             WHERE   ROWNUM <= 10;

        RETURN cr;
    END;


    FUNCTION g_control (gestion        IN VARCHAR2,
                        aduana         IN VARCHAR2,
                        numero         IN VARCHAR2,
                        control        IN VARCHAR2,
                        fiscalizador   IN VARCHAR2,
                        archivo        IN VARCHAR2,
                        comentario     IN VARCHAR2,
                        usuario        IN VARCHAR2)
        RETURN VARCHAR2
    IS
        hay           NUMBER := 0;
        nro           NUMBER := 0;
        v_key_year    VARCHAR2 (4);
        v_key_cuo     VARCHAR2 (4);
        v_key_dec     VARCHAR2 (17);
        v_key_nber    VARCHAR2 (13);
        fob_inicial   NUMBER (18, 2);
        v_fec_pase    DATE;
        gerencia      VARCHAR2 (4);
        cont          NUMBER (8) := 0;
    BEGIN
        SELECT   COUNT (1)
          INTO   hay
          FROM   mir_fiscalizacion a
         WHERE       a.fis_key_year = gestion
                 AND a.fis_key_cuo = aduana
                 AND a.fis_reg_nber = numero
                 AND a.fis_num = 0
                 AND a.fis_lst_ope = 'U';

        IF hay > 0
        THEN
            RETURN 'Error: La declaraci&oacute;n ya fue asignada a un control anterior.';
        END IF;

        /*INSERT INTO mir_fiscalizacion VALUES(gestion, aduana, numero, DECODE(control,'POSTERIOR','POSTERIOR_UFR',control),
                                             fiscalizador, archivo, comentario,usuario, 'U', 0, SYSDATE);*/
        --A CONFIRMAR POR GNF 02/02/2017

        INSERT INTO mir_fiscalizacion
          VALUES   (gestion,
                    aduana,
                    numero,
                    control,
                    fiscalizador,
                    archivo,
                    comentario,
                    usuario,
                    'U',
                    0,
                    SYSDATE);

        IF control = 'DIFERIDO'
        THEN
            SELECT   a.key_year,
                     a.key_cuo,
                     a.key_dec,
                     a.key_nber
              INTO   v_key_year,
                     v_key_cuo,
                     v_key_dec,
                     v_key_nber
              FROM   ops$asy.sad_gen a
             WHERE       a.sad_reg_year = gestion
                     AND a.key_cuo = aduana
                     AND a.sad_reg_serial = 'C'
                     AND a.sad_reg_nber = numero
                     AND a.lst_ope = 'U'
                     AND a.sad_num = 0;

            SELECT   COUNT (1)
              INTO   cont
              FROM   ops$asy.sad_spy a
             WHERE       a.key_year = v_key_year
                     AND a.key_cuo = v_key_cuo
                     AND NVL (a.key_dec, 0) = NVL (v_key_dec, 0)
                     AND a.key_nber = v_key_nber
                     AND a.spy_act = 25
                     AND ROWNUM = 1;

            IF cont = 0
            THEN
                v_fec_pase := NULL;
            ELSE
                SELECT   DECODE (
                             a.upd_dat,
                             NULL,
                             NULL,
                             TO_DATE (a.upd_dat || ' ' || a.upd_hor,
                                      'DD/MM/YYYY hh24:mi:ss'))
                  INTO   v_fec_pase
                  FROM   ops$asy.sad_spy a
                 WHERE       a.key_year = v_key_year
                         AND a.key_cuo = v_key_cuo
                         AND NVL (a.key_dec, 0) = NVL (v_key_dec, 0)
                         AND a.key_nber = v_key_nber
                         AND a.spy_act = 25
                         AND ROWNUM = 1;
            END IF;

            SELECT   COUNT (1)
              INTO   cont
              FROM   usuario.usuario a
             WHERE       a.usucodusu = usuario
                     AND a.usu_num = 0
                     AND a.lst_ope = 'U'
                     AND a.gercodger = 15;

            IF cont = 0
            THEN
                SELECT   CASE SUBSTR (aduana, 1, 1)
                             WHEN '2' THEN 'GRLP'
                             WHEN '8' THEN 'GRLP'
                             WHEN '9' THEN 'GRLP'
                             WHEN '3' THEN 'GRCB'
                             -- WHEN '1' THEN 'GRCB'
                         WHEN '1' THEN 'GRPT'
                             WHEN '7' THEN 'GRSC'
                             WHEN '4' THEN 'GROR'
                             WHEN '6' THEN 'GRTJ'
                             WHEN '5' THEN 'GRPT'
                         --ELSE 'OTRO'
                         END
                  INTO   gerencia
                  FROM   DUAL;
            ELSE
                gerencia := 'GNF';
            END IF;

            SELECT   DECODE (MAX (a.fis_nro_control),
                             NULL, 0,
                             MAX (a.fis_nro_control))
              INTO   nro
              FROM   sicodif.cd_fiscalizacion a
             WHERE   a.fis_gestion = TO_CHAR (SYSDATE, 'yyyy')
                     AND a.fis_gerencia = gerencia;

            SELECT   COUNT (1)
              INTO   hay
              FROM   sicodif.cd_fiscalizacion a
             WHERE       a.sad_reg_year = gestion
                     AND a.fis_key_cuo = aduana
                     AND a.sad_reg_serial = 'C'
                     AND a.sad_reg_nber = numero
                     AND a.fis_numver = 0
                     AND a.fis_lst_ope = 'U';

            IF hay = 0
            THEN
                /*AUMENTADO PARA LOS CASOS DE EDGAR SICODIF 17/07/2015*/
                SELECT   a.key_year,
                         a.key_cuo,
                         a.key_dec,
                         a.key_nber,
                         a.sad_tot_invoiced
                  INTO   v_key_year,
                         v_key_cuo,
                         v_key_dec,
                         v_key_nber,
                         fob_inicial
                  FROM   ops$asy.sad_gen a
                 WHERE       a.sad_reg_year = gestion
                         AND a.key_cuo = aduana
                         AND a.sad_reg_serial = 'C'
                         AND a.sad_reg_nber = numero
                         AND a.lst_ope = 'U'
                         AND a.sad_num = 0;

                SELECT   COUNT (1)
                  INTO   cont
                  FROM   ops$asy.sad_spy a
                 WHERE       a.key_year = v_key_year
                         AND a.key_cuo = v_key_cuo
                         AND NVL (a.key_dec, 0) = NVL (v_key_dec, 0)
                         AND a.key_nber = v_key_nber
                         AND a.spy_act = 25
                         AND ROWNUM = 1;



                IF cont = 0
                THEN
                    v_fec_pase := NULL;
                ELSE
                    SELECT   DECODE (
                                 a.upd_dat,
                                 NULL,
                                 NULL,
                                 TO_DATE (a.upd_dat || ' ' || a.upd_hor,
                                          'DD/MM/YYYY hh24:mi:ss')) /*FECHA Y HORA PASE DE SALIDA*/
                      INTO   v_fec_pase
                      FROM   ops$asy.sad_spy a
                     WHERE       a.key_year = v_key_year
                             AND a.key_cuo = v_key_cuo
                             AND NVL (a.key_dec, 0) = NVL (v_key_dec, 0)
                             AND a.key_nber = v_key_nber
                             AND a.spy_act = 25
                             AND ROWNUM = 1;
                END IF;


                /*FIN CASO SICODIF*/

                INSERT INTO sicodif.cd_fiscalizacion a (a.fis_gestion,
                                                        a.fis_gerencia,
                                                        a.fis_nro_control,
                                                        a.fis_key_year,
                                                        a.fis_key_cuo,
                                                        a.fis_key_nber,
                                                        a.fis_key_dec,
                                                        a.sad_reg_year,
                                                        a.sad_reg_serial,
                                                        a.sad_reg_nber,
                                                        a.fis_fec_registro,
                                                        a.fis_usuario_registro,
                                                        a.fis_estado,
                                                        a.fis_lst_ope,
                                                        a.fis_usuario,
                                                        a.fis_numver,
                                                        a.fis_fecha,
                                                        a.fis_fiscalizador,
                                                        a.fis_origen_control,
                                                        a.fis_fec_pase_salida,
                                                        a.fis_fob_inicial)
                  VALUES   (TO_CHAR (SYSDATE, 'yyyy'),
                            gerencia,
                            -- nro + 1,
                            0,                                            -- S
                            v_key_year,
                            v_key_cuo,
                            v_key_nber,
                            v_key_dec,
                            gestion,
                            'C',
                            numero,
                            SYSDATE,
                            usuario,
                            'REGISTRADO-MIRA',
                            'U',
                            usuario,
                            0,
                            SYSDATE,
                            fiscalizador,
                            'MIRA',
                            v_fec_pase,
                            fob_inicial);
            END IF;
        END IF;

        COMMIT;
        RETURN 'Correcto';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN ('Error: ' || SQLERRM);
    END;

    PROCEDURE graba_mira_fis (gestion        IN VARCHAR2,
                              aduana         IN VARCHAR2,
                              numero         IN VARCHAR2,
                              tipo_control   IN VARCHAR2,
                              fiscalizador   IN VARCHAR2,
                              comentario     IN VARCHAR2,
                              usuario        IN VARCHAR2)
    IS
        hay           NUMBER := 0;
        nro           NUMBER := 0;
        v_key_year    VARCHAR2 (4);
        v_key_cuo     VARCHAR2 (4);
        v_key_dec     VARCHAR2 (17);
        v_key_nber    VARCHAR2 (13);
        fob_inicial   NUMBER (18, 2);
        v_fec_pase    DATE;
        gerencia      VARCHAR2 (4);
        cont          NUMBER (8) := 0;
    BEGIN
        /*  VERIFICACION EXISTENCIA FICHA INFORMATIVA   */
        SELECT   COUNT (1)
          INTO   hay
          FROM   mir_control b, mir_diligencia1 m
         WHERE       b.con_key_year = gestion
                 AND b.con_key_cuo = aduana
                 AND b.con_reg_nber = numero
                 AND b.con_num = 0
                 AND b.con_lst_ope = 'U'
                 AND b.con_obs = '0'
                 AND   b.con_key_year
                    || b.con_key_cuo
                    || b.con_reg_nber
                    || DECODE (b.con_fuente, 'NO', '', '-' || b.con_fuente) =
                        m.id
                 AND m.dil1_factores IS NOT NULL
                 AND m.dil1_nombre IS NULL
                 AND m.dil1_num = 0;

        IF hay > 0
        THEN
            /* VERIFICACION DE NO EXISTENCIA DE REGISTRO DE CONTROL */
            SELECT   COUNT (1)
              INTO   hay
              FROM   mir_fiscalizacion a
             WHERE       a.fis_key_year = gestion
                     AND a.fis_key_cuo = aduana
                     AND a.fis_reg_nber = numero
                     AND a.fis_num = 0
                     AND a.fis_lst_ope = 'U';

            IF hay = 0
            THEN
                /*  GRABAMOS EN LA TABLA PARA DESHAPARECER DL LISTADO DEL MIRA  */
                INSERT INTO mir_fiscalizacion
                  VALUES   (gestion,
                            aduana,
                            numero,
                            tipo_control,
                            fiscalizador,
                            NULL,
                            comentario,
                            usuario,
                            'U',
                            0,
                            SYSDATE);

                COMMIT;
            END IF;
        END IF;
    END;

    FUNCTION verifica_fisca (gestion    IN     VARCHAR2,
                             aduana     IN     VARCHAR2,
                             numero     IN     VARCHAR2,
                             usuario    IN     VARCHAR2,
                             gerencia      OUT VARCHAR2)
        RETURN VARCHAR2
    IS
        hay   NUMBER (10) := 0;
    BEGIN
        SELECT   COUNT (1)
          INTO   hay
          FROM   mir_control a, mir_diligencia1 b
         WHERE       a.con_key_year = gestion
                 AND a.con_key_cuo = aduana
                 AND a.con_reg_nber = numero
                 AND a.con_obs = '1'
                 AND a.con_lst_ope = 'U'
                 AND   a.con_key_year
                    || a.con_key_cuo
                    || a.con_reg_nber
                    || DECODE (a.con_fuente, 'NO', '', '-' || a.con_fuente) =
                        b.id
                 AND b.dil1_factores IS NOT NULL
                 AND b.dil1_nombre IS NULL
                 AND b.dil1_num = 0;

        IF hay = 0
        THEN
            gerencia := '-';
            RETURN 'Error: La declaraci&oacute;n no tiene observaciones o ficha informativa';
        END IF;

        SELECT   a.gercodger
          INTO   gerencia
          FROM   usuario.usuario a
         WHERE   a.usucodusu = usuario AND a.lst_ope = 'U' AND a.usu_num = 0;

        RETURN ('Correcto');
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN ('Error: ' || SQLERRM);
    END;

    FUNCTION r_listadoficha (aduana IN VARCHAR2)
        RETURN cursortype
    IS
        cr    cursortype;
        aux   VARCHAR2 (10) := '';
    BEGIN
        IF (SUBSTR (aduana, 3, 1) = '0')
        THEN
            IF (SUBSTR (aduana, 1, 1) = '2')
            THEN
                OPEN cr FOR
                      SELECT   DISTINCT
                                  a.sad_reg_year
                               || '/'
                               || a.key_cuo
                               || '/'
                               || a.sad_reg_serial
                               || '-'
                               || a.sad_reg_nber
                                   AS declaracion,
                               TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                   AS fecha_declaracion,
                               a.sad_typ_dec || '-' || a.sad_typ_proc AS patron,
                               a.sad_itm_total AS items,
                               a.sad_tot_invoiced AS fob,
                               NVL (
                                   DECODE (
                                       a.sad_consignee,
                                       NULL,
                                       l.sad_con_nam,
                                       NVL (d.cmp_nam, cab.ope_razonsocial)),
                                   '-')
                                   AS importador,
                               TRIM(NVL (a.sad_consignee, l.sad_con_zip) || ' '
                                    || DECODE (
                                           sipoea.pkg_consulta.verificar_oea (
                                               NVL (a.sad_consignee,
                                                    l.sad_con_zip),
                                               a.sad_flw,
                                               a.sad_reg_date),
                                           '1',
                                           '- (OEA)',
                                           ' '))
                                   AS nit_importador,
                               DECODE (a.key_dec,
                                       NULL, g.sad_dec_nam,
                                       '0', g.sad_dec_nam,
                                       c.dec_nam)
                                   AS declarante,
                               a.sad_reg_date AS fecha,
                               o.cuo_cod || '-' || o.cuo_nam AS administracion,
                               DECODE (
                                   sipoea.pkg_consulta.verificar_oea (
                                       NVL (a.sad_consignee, l.sad_con_zip),
                                       a.sad_flw,
                                       a.sad_reg_date),
                                   '1',
                                   1,
                                   2)
                                   AS orden,
                               (SELECT   NVL (
                                             TO_CHAR (MAX (c1.con_fecreg),
                                                      'DD/MM/YYYY'),
                                             'SIN LEVANTE')
                                  FROM   mir_control c1
                                 WHERE       c1.con_key_year = b.con_key_year
                                         AND c1.con_key_cuo = b.con_key_cuo
                                         AND c1.con_reg_nber = b.con_reg_nber
                                         AND c1.con_lst_ope = 'U'
                                         AND c1.con_num = 0
                                         AND c1.con_obs = '0')
                                   AS fec_levante,
                               NVL (
                                   (SELECT   NVL (m1.fis_control,
                                                  'SIN CONTROL')
                                      FROM   mir_fiscalizacion m1
                                     WHERE   m1.fis_key_year = b.con_key_year
                                             AND m1.fis_key_cuo = b.con_key_cuo
                                             AND m1.fis_reg_nber =
                                                    b.con_reg_nber
                                             AND m1.fis_lst_ope = 'U'
                                             AND m1.fis_num = 0),
                                   'SIN CONTROL')
                                   AS control,
                               (SELECT   CASE
                                             WHEN COUNT (1) = 0 THEN '-'
                                             ELSE 'CONSULTA A LABORATORIO'
                                         END
                                  FROM   ops$asy.sad_itm_ped p
                                 WHERE       p.key_year = a.key_year
                                         AND p.key_cuo = a.key_cuo
                                         AND p.key_dec = a.key_dec
                                         AND p.key_nber = a.key_nber
                                         AND p.ctr_cod = 'RIESGO-DNA')
                                   AS riesgo_dna
                        FROM   ops$asy.sad_gen a,
                               mir_control b,
                               ops$asy.undectab c,
                               ops$asy.uncmptab d,
                               bo_oce_opecab cab,
                               ops$asy.sad_occ_dec g,
                               ops$asy.sad_occ_cns l,
                               mir_diligencia1 m,
                               ops$asy.uncuotab o
                       WHERE   (   SUBSTR (a.key_cuo, 1, 1) = '2'
                                OR SUBSTR (a.key_cuo, 1, 1) = '8'
                                OR SUBSTR (a.key_cuo, 1, 1) = '9')
                               AND a.sad_flw = 1
                               AND a.lst_ope = 'U'
                               AND a.sad_num = 0
                               AND a.sad_reg_year = b.con_key_year
                               AND a.key_cuo = b.con_key_cuo
                               AND a.sad_reg_nber = b.con_reg_nber
                               AND b.con_lst_ope = 'U'
                               --         AND b.con_num = 0
                               AND b.con_obs = '1'
                               AND NVL (a.key_dec, '-') =
                                      NVL (c.dec_cod(+), '-')
                               AND c.lst_ope(+) = 'U'
                               AND NVL (a.sad_consignee, '-') =
                                      NVL (d.cmp_cod(+), '-')
                               AND d.lst_ope(+) = 'U'
                               AND NVL (a.sad_consignee, '-') =
                                      NVL (cab.ope_numerodoc(+), '-')
                               AND cab.ope_num(+) = 0
                               AND a.key_year = g.key_year(+)
                               AND a.key_cuo = g.key_cuo(+)
                               AND NVL (a.key_dec, '0') =
                                      NVL (g.key_dec(+), '0')
                               AND a.key_nber = g.key_nber(+)
                               AND a.sad_num = g.sad_num(+)
                               AND a.key_year = l.key_year(+)
                               AND a.key_cuo = l.key_cuo(+)
                               AND NVL (a.key_dec, '-') =
                                      NVL (l.key_dec(+), '-')
                               AND a.key_nber = l.key_nber(+)
                               AND a.sad_num = l.sad_num(+)
                               AND   b.con_key_year
                                  || b.con_key_cuo
                                  || b.con_reg_nber
                                  || DECODE (b.con_fuente,
                                             'NO', '',
                                             '-' || b.con_fuente) = m.id
                               AND m.dil1_factores IS NOT NULL
                               AND m.dil1_nombre IS NULL
                               AND m.dil1_num = 0
                               AND a.key_cuo = o.cuo_cod
                               AND o.lst_ope = 'U'
                    ORDER BY   orden, administracion, fecha DESC;
            ELSIF (SUBSTR (aduana, 1, 1) = '3')
            THEN
                OPEN cr FOR
                      SELECT   DISTINCT
                                  a.sad_reg_year
                               || '/'
                               || a.key_cuo
                               || '/'
                               || a.sad_reg_serial
                               || '-'
                               || a.sad_reg_nber
                                   AS declaracion,
                               TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                   AS fecha_declaracion,
                               a.sad_typ_dec || '-' || a.sad_typ_proc AS patron,
                               a.sad_itm_total AS items,
                               a.sad_tot_invoiced AS fob,
                               --NVL(DECODE(a.sad_consignee, NULL, l.sad_con_nam, d.cmp_nam),'-') as importador,
                               NVL (
                                   DECODE (
                                       a.sad_consignee,
                                       NULL,
                                       l.sad_con_nam,
                                       NVL (d.cmp_nam, cab.ope_razonsocial)),
                                   '-')
                                   AS importador,
                               TRIM(NVL (a.sad_consignee, l.sad_con_zip) || ' '
                                    || DECODE (
                                           sipoea.pkg_consulta.verificar_oea (
                                               NVL (a.sad_consignee,
                                                    l.sad_con_zip),
                                               a.sad_flw,
                                               a.sad_reg_date),
                                           '1',
                                           '- (OEA)',
                                           ' '))
                                   AS nit_importador,
                               DECODE (a.key_dec,
                                       NULL, g.sad_dec_nam,
                                       '0', g.sad_dec_nam,
                                       c.dec_nam)
                                   AS declarante,
                               a.sad_reg_date AS fecha,
                               o.cuo_cod || '-' || o.cuo_nam AS administracion,
                               DECODE (
                                   sipoea.pkg_consulta.verificar_oea (
                                       NVL (a.sad_consignee, l.sad_con_zip),
                                       a.sad_flw,
                                       a.sad_reg_date),
                                   '1',
                                   1,
                                   2)
                                   AS orden,
                               (SELECT   NVL (
                                             TO_CHAR (MAX (c1.con_fecreg),
                                                      'DD/MM/YYYY'),
                                             'SIN LEVANTE')
                                  FROM   mir_control c1
                                 WHERE       c1.con_key_year = b.con_key_year
                                         AND c1.con_key_cuo = b.con_key_cuo
                                         AND c1.con_reg_nber = b.con_reg_nber
                                         AND c1.con_lst_ope = 'U'
                                         AND c1.con_num = 0
                                         AND c1.con_obs = 0)
                                   AS fec_levante,
                               NVL (
                                   (SELECT   NVL (m1.fis_control,
                                                  'SIN CONTROL')
                                      FROM   mir_fiscalizacion m1
                                     WHERE   m1.fis_key_year = b.con_key_year
                                             AND m1.fis_key_cuo = b.con_key_cuo
                                             AND m1.fis_reg_nber =
                                                    b.con_reg_nber
                                             AND m1.fis_lst_ope = 'U'
                                             AND m1.fis_num = 0),
                                   'SIN CONTROL')
                                   AS control,
                               (SELECT   CASE
                                             WHEN COUNT (1) = 0 THEN '-'
                                             ELSE 'CONSULTA A LABORATORIO'
                                         END
                                  FROM   ops$asy.sad_itm_ped p
                                 WHERE       p.key_year = a.key_year
                                         AND p.key_cuo = a.key_cuo
                                         AND p.key_dec = a.key_dec
                                         AND p.key_nber = a.key_nber
                                         AND p.ctr_cod = 'RIESGO-DNA')
                                   AS riesgo_dna
                        FROM   ops$asy.sad_gen a,
                               mir_control b,
                               ops$asy.undectab c,
                               ops$asy.uncmptab d,
                               bo_oce_opecab cab,
                               ops$asy.sad_occ_dec g,
                               ops$asy.sad_occ_cns l,
                               mir_diligencia1 m,
                               ops$asy.uncuotab o
                       WHERE   (SUBSTR (cuo_cod, 1, 1) = '1'
                                OR SUBSTR (cuo_cod, 1, 1) = '3')
                               AND a.sad_flw = 1
                               AND a.lst_ope = 'U'
                               AND a.sad_num = 0
                               AND a.sad_reg_year = b.con_key_year
                               AND a.key_cuo = b.con_key_cuo
                               AND a.sad_reg_nber = b.con_reg_nber
                               AND b.con_lst_ope = 'U'
                               --         AND b.con_num = 0
                               AND b.con_obs = '1'
                               AND NVL (a.key_dec, '-') =
                                      NVL (c.dec_cod(+), '-')
                               AND c.lst_ope(+) = 'U'
                               AND NVL (a.sad_consignee, '-') =
                                      NVL (d.cmp_cod(+), '-')
                               AND d.lst_ope(+) = 'U'
                               AND NVL (a.sad_consignee, '-') =
                                      NVL (cab.ope_numerodoc(+), '-')
                               AND cab.ope_num(+) = 0
                               AND a.key_year = g.key_year(+)
                               AND a.key_cuo = g.key_cuo(+)
                               AND NVL (a.key_dec, '0') =
                                      NVL (g.key_dec(+), '0')
                               AND a.key_nber = g.key_nber(+)
                               AND a.sad_num = g.sad_num(+)
                               AND a.key_year = l.key_year(+)
                               AND a.key_cuo = l.key_cuo(+)
                               AND NVL (a.key_dec, '-') =
                                      NVL (l.key_dec(+), '-')
                               AND a.key_nber = l.key_nber(+)
                               AND a.sad_num = l.sad_num(+)
                               AND   b.con_key_year
                                  || b.con_key_cuo
                                  || b.con_reg_nber
                                  || DECODE (b.con_fuente,
                                             'NO', '',
                                             '-' || b.con_fuente) = m.id
                               AND m.dil1_factores IS NOT NULL
                               AND m.dil1_nombre IS NULL
                               AND m.dil1_num = 0
                               AND a.key_cuo = o.cuo_cod
                               AND o.lst_ope = 'U'
                    ORDER BY   orden, administracion, fecha DESC;
            ELSIF (SUBSTR (aduana, 1, 1) = '0')
            THEN
                OPEN cr FOR
                      SELECT   DISTINCT
                                  a.sad_reg_year
                               || '/'
                               || a.key_cuo
                               || '/'
                               || a.sad_reg_serial
                               || '-'
                               || a.sad_reg_nber
                                   AS declaracion,
                               TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                   AS fecha_declaracion,
                               a.sad_typ_dec || '-' || a.sad_typ_proc AS patron,
                               a.sad_itm_total AS items,
                               a.sad_tot_invoiced AS fob,
                               NVL (
                                   DECODE (a.sad_consignee,
                                           NULL, l.sad_con_nam,
                                           NVL (d.cmp_nam, ope_razonsocial)),
                                   '-')
                                   AS importador,
                               TRIM(NVL (a.sad_consignee, l.sad_con_zip) || ' '
                                    || DECODE (
                                           sipoea.pkg_consulta.verificar_oea (
                                               NVL (a.sad_consignee,
                                                    l.sad_con_zip),
                                               a.sad_flw,
                                               a.sad_reg_date),
                                           '1',
                                           '- (OEA)',
                                           ' '))
                                   AS nit_importador,
                               DECODE (a.key_dec,
                                       NULL, g.sad_dec_nam,
                                       '0', g.sad_dec_nam,
                                       c.dec_nam)
                                   AS declarante,
                               a.sad_reg_date AS fecha,
                               o.cuo_cod || '-' || o.cuo_nam AS administracion,
                               DECODE (
                                   sipoea.pkg_consulta.verificar_oea (
                                       NVL (a.sad_consignee, l.sad_con_zip),
                                       a.sad_flw,
                                       a.sad_reg_date),
                                   '1',
                                   1,
                                   2)
                                   AS orden,
                               (SELECT   NVL (
                                             TO_CHAR (MAX (c1.con_fecreg),
                                                      'DD/MM/YYYY'),
                                             'SIN LEVANTE')
                                  FROM   mir_control c1
                                 WHERE       c1.con_key_year = b.con_key_year
                                         AND c1.con_key_cuo = b.con_key_cuo
                                         AND c1.con_reg_nber = b.con_reg_nber
                                         AND c1.con_lst_ope = 'U'
                                         AND c1.con_num = 0
                                         AND c1.con_obs = 0)
                                   AS fec_levante,
                               NVL (
                                   (SELECT   NVL (m1.fis_control,
                                                  'SIN CONTROL')
                                      FROM   mir_fiscalizacion m1
                                     WHERE   m1.fis_key_year = b.con_key_year
                                             AND m1.fis_key_cuo = b.con_key_cuo
                                             AND m1.fis_reg_nber =
                                                    b.con_reg_nber
                                             AND m1.fis_lst_ope = 'U'
                                             AND m1.fis_num = 0),
                                   'SIN CONTROL')
                                   AS control,
                               (SELECT   CASE
                                             WHEN COUNT (1) = 0 THEN '-'
                                             ELSE 'CONSULTA A LABORATORIO'
                                         END
                                  FROM   ops$asy.sad_itm_ped p
                                 WHERE       p.key_year = a.key_year
                                         AND p.key_cuo = a.key_cuo
                                         AND p.key_dec = a.key_dec
                                         AND p.key_nber = a.key_nber
                                         AND p.ctr_cod = 'RIESGO-DNA')
                                   AS riesgo_dna
                        FROM   ops$asy.sad_gen a,
                               mir_control b,
                               ops$asy.undectab c,
                               ops$asy.uncmptab d,
                               bo_oce_opecab cab,
                               ops$asy.sad_occ_dec g,
                               ops$asy.sad_occ_cns l,
                               mir_diligencia1 m,
                               ops$asy.uncuotab o
                       WHERE /*(  SUBSTR(CUO_COD,1,1) = '1' OR SUBSTR(CUO_COD,1,1) = '3')
                          AND*/
                            a  .sad_flw =
                                   1
                               AND a.lst_ope = 'U'
                               AND a.sad_num = 0
                               AND a.sad_reg_year = b.con_key_year
                               AND a.key_cuo = b.con_key_cuo
                               AND a.sad_reg_nber = b.con_reg_nber
                               AND b.con_lst_ope = 'U'
                               --         AND b.con_num = 0
                               AND b.con_obs = '1'
                               AND NVL (a.key_dec, '-') =
                                      NVL (c.dec_cod(+), '-')
                               AND c.lst_ope(+) = 'U'
                               AND NVL (a.sad_consignee, '-') =
                                      NVL (d.cmp_cod(+), '-')
                               AND d.lst_ope(+) = 'U'
                               AND NVL (a.sad_consignee, '-') =
                                      NVL (cab.ope_numerodoc(+), '-')
                               AND cab.ope_num(+) = 0
                               AND a.key_year = g.key_year(+)
                               AND a.key_cuo = g.key_cuo(+)
                               AND NVL (a.key_dec, '0') =
                                      NVL (g.key_dec(+), '0')
                               AND a.key_nber = g.key_nber(+)
                               AND a.sad_num = g.sad_num(+)
                               AND a.key_year = l.key_year(+)
                               AND a.key_cuo = l.key_cuo(+)
                               AND NVL (a.key_dec, '-') =
                                      NVL (l.key_dec(+), '-')
                               AND a.key_nber = l.key_nber(+)
                               AND a.sad_num = l.sad_num(+)
                               AND   b.con_key_year
                                  || b.con_key_cuo
                                  || b.con_reg_nber
                                  || DECODE (b.con_fuente,
                                             'NO', '',
                                             '-' || b.con_fuente) = m.id
                               AND m.dil1_factores IS NOT NULL
                               AND m.dil1_nombre IS NULL
                               AND m.dil1_num = 0
                               AND a.key_cuo = o.cuo_cod
                               AND o.lst_ope = 'U'
                    ORDER BY   orden, administracion, fecha DESC;
            ELSE
                OPEN cr FOR
                      SELECT   DISTINCT
                                  a.sad_reg_year
                               || '/'
                               || a.key_cuo
                               || '/'
                               || a.sad_reg_serial
                               || '-'
                               || a.sad_reg_nber
                                   AS declaracion,
                               TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                   AS fecha_declaracion,
                               a.sad_typ_dec || '-' || a.sad_typ_proc AS patron,
                               a.sad_itm_total AS items,
                               a.sad_tot_invoiced AS fob,
                               NVL (
                                   DECODE (
                                       a.sad_consignee,
                                       NULL,
                                       l.sad_con_nam,
                                       NVL (d.cmp_nam, cab.ope_razonsocial)),
                                   '-')
                                   AS importador,
                               TRIM(NVL (a.sad_consignee, l.sad_con_zip) || ' '
                                    || DECODE (
                                           sipoea.pkg_consulta.verificar_oea (
                                               NVL (a.sad_consignee,
                                                    l.sad_con_zip),
                                               a.sad_flw,
                                               a.sad_reg_date),
                                           '1',
                                           '- (OEA)',
                                           ' '))
                                   AS nit_importador,
                               DECODE (a.key_dec,
                                       NULL, g.sad_dec_nam,
                                       '0', g.sad_dec_nam,
                                       c.dec_nam)
                                   AS declarante,
                               a.sad_reg_date AS fecha,
                               o.cuo_cod || '-' || o.cuo_nam AS administracion,
                               DECODE (
                                   sipoea.pkg_consulta.verificar_oea (
                                       NVL (a.sad_consignee, l.sad_con_zip),
                                       a.sad_flw,
                                       a.sad_reg_date),
                                   '1',
                                   1,
                                   2)
                                   AS orden,
                               (SELECT   NVL (
                                             TO_CHAR (MAX (c1.con_fecreg),
                                                      'DD/MM/YYYY'),
                                             'SIN LEVANTE')
                                  FROM   mir_control c1
                                 WHERE       c1.con_key_year = b.con_key_year
                                         AND c1.con_key_cuo = b.con_key_cuo
                                         AND c1.con_reg_nber = b.con_reg_nber
                                         AND c1.con_lst_ope = 'U'
                                         AND c1.con_num = 0
                                         AND c1.con_obs = 0)
                                   AS fec_levante,
                               NVL (
                                   (SELECT   NVL (m1.fis_control,
                                                  'SIN CONTROL')
                                      FROM   mir_fiscalizacion m1
                                     WHERE   m1.fis_key_year = b.con_key_year
                                             AND m1.fis_key_cuo = b.con_key_cuo
                                             AND m1.fis_reg_nber =
                                                    b.con_reg_nber
                                             AND m1.fis_lst_ope = 'U'
                                             AND m1.fis_num = 0),
                                   'SIN CONTROL')
                                   AS control,
                               (SELECT   CASE
                                             WHEN COUNT (1) = 0 THEN '-'
                                             ELSE 'CONSULTA A LABORATORIO'
                                         END
                                  FROM   ops$asy.sad_itm_ped p
                                 WHERE       p.key_year = a.key_year
                                         AND p.key_cuo = a.key_cuo
                                         AND p.key_dec = a.key_dec
                                         AND p.key_nber = a.key_nber
                                         AND p.ctr_cod = 'RIESGO-DNA')
                                   AS riesgo_dna
                        FROM   ops$asy.sad_gen a,
                               mir_control b,
                               ops$asy.undectab c,
                               ops$asy.uncmptab d,
                               bo_oce_opecab cab,
                               ops$asy.sad_occ_dec g,
                               ops$asy.sad_occ_cns l,
                               mir_diligencia1 m,
                               ops$asy.uncuotab o
                       WHERE   SUBSTR (cuo_cod, 1, 1) = SUBSTR (aduana, 1, 1)
                               AND a.sad_flw = 1
                               AND a.lst_ope = 'U'
                               AND a.sad_num = 0
                               AND a.sad_reg_year = b.con_key_year
                               AND a.key_cuo = b.con_key_cuo
                               AND a.sad_reg_nber = b.con_reg_nber
                               AND b.con_lst_ope = 'U'
                               --         AND b.con_num = 0
                               AND b.con_obs = '1'
                               AND NVL (a.key_dec, '-') =
                                      NVL (c.dec_cod(+), '-')
                               AND c.lst_ope(+) = 'U'
                               AND NVL (a.sad_consignee, '-') =
                                      NVL (d.cmp_cod(+), '-')
                               AND d.lst_ope(+) = 'U'
                               AND NVL (a.sad_consignee, '-') =
                                      NVL (cab.ope_numerodoc(+), '-')
                               AND cab.ope_num(+) = 0
                               AND a.key_year = g.key_year(+)
                               AND a.key_cuo = g.key_cuo(+)
                               AND NVL (a.key_dec, '0') =
                                      NVL (g.key_dec(+), '0')
                               AND a.key_nber = g.key_nber(+)
                               AND a.sad_num = g.sad_num(+)
                               AND a.key_year = l.key_year(+)
                               AND a.key_cuo = l.key_cuo(+)
                               AND NVL (a.key_dec, '-') =
                                      NVL (l.key_dec(+), '-')
                               AND a.key_nber = l.key_nber(+)
                               AND a.sad_num = l.sad_num(+)
                               AND   b.con_key_year
                                  || b.con_key_cuo
                                  || b.con_reg_nber
                                  || DECODE (b.con_fuente,
                                             'NO', '',
                                             '-' || b.con_fuente) = m.id
                               AND m.dil1_factores IS NOT NULL
                               AND m.dil1_nombre IS NULL
                               AND m.dil1_num = 0
                               AND a.key_cuo = o.cuo_cod
                               AND o.lst_ope = 'U'
                    ORDER BY   orden, administracion, fecha DESC;
            END IF;
        ELSE
            OPEN cr FOR
                  SELECT   DISTINCT
                              a.sad_reg_year
                           || '/'
                           || a.key_cuo
                           || '/'
                           || a.sad_reg_serial
                           || '-'
                           || a.sad_reg_nber
                               AS declaracion,
                           TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                               AS fecha_declaracion,
                           a.sad_typ_dec || '-' || a.sad_typ_proc AS patron,
                           a.sad_itm_total AS items,
                           a.sad_tot_invoiced AS fob,
                           NVL (
                               DECODE (a.sad_consignee,
                                       NULL, l.sad_con_nam,
                                       NVL (d.cmp_nam, cab.ope_razonsocial)),
                               '-')
                               AS importador,
                           TRIM(NVL (a.sad_consignee, l.sad_con_zip) || ' '
                                || DECODE (
                                       sipoea.pkg_consulta.verificar_oea (
                                           NVL (a.sad_consignee, l.sad_con_zip),
                                           a.sad_flw,
                                           a.sad_reg_date),
                                       '1',
                                       '- (OEA)',
                                       ' '))
                               AS nit_importador,
                           DECODE (a.key_dec,
                                   NULL, g.sad_dec_nam,
                                   '0', g.sad_dec_nam,
                                   c.dec_nam)
                               AS declarante,
                           a.sad_reg_date AS fecha,
                           o.cuo_cod || '-' || o.cuo_nam AS administracion,
                           DECODE (
                               sipoea.pkg_consulta.verificar_oea (
                                   NVL (a.sad_consignee, l.sad_con_zip),
                                   a.sad_flw,
                                   a.sad_reg_date),
                               '1',
                               1,
                               2)
                               AS orden,
                           (SELECT   NVL (
                                         TO_CHAR (MAX (c1.con_fecreg),
                                                  'DD/MM/YYYY'),
                                         'SIN LEVANTE')
                              FROM   mir_control c1
                             WHERE       c1.con_key_year = b.con_key_year
                                     AND c1.con_key_cuo = b.con_key_cuo
                                     AND c1.con_reg_nber = b.con_reg_nber
                                     AND c1.con_lst_ope = 'U'
                                     AND c1.con_num = 0
                                     AND c1.con_obs = 0)
                               AS fec_levante,
                           NVL (
                               (SELECT   NVL (m1.fis_control, 'SIN CONTROL')
                                  FROM   mir_fiscalizacion m1
                                 WHERE       m1.fis_key_year = b.con_key_year
                                         AND m1.fis_key_cuo = b.con_key_cuo
                                         AND m1.fis_reg_nber = b.con_reg_nber
                                         AND m1.fis_lst_ope = 'U'
                                         AND m1.fis_num = 0),
                               'SIN CONTROL')
                               AS control,
                           (SELECT   CASE
                                         WHEN COUNT (1) = 0 THEN '-'
                                         ELSE 'CONSULTA A LABORATORIO'
                                     END
                              FROM   ops$asy.sad_itm_ped p
                             WHERE       p.key_year = a.key_year
                                     AND p.key_cuo = a.key_cuo
                                     AND p.key_dec = a.key_dec
                                     AND p.key_nber = a.key_nber
                                     AND p.ctr_cod = 'RIESGO-DNA')
                               AS riesgo_dna
                    FROM   ops$asy.sad_gen a,
                           mir_control b,
                           ops$asy.undectab c,
                           ops$asy.uncmptab d,
                           bo_oce_opecab cab,
                           ops$asy.sad_occ_dec g,
                           ops$asy.sad_occ_cns l,
                           mir_diligencia1 m,
                           ops$asy.uncuotab o
                   WHERE       a.key_cuo = aduana
                           AND a.sad_flw = 1
                           AND a.lst_ope = 'U'
                           AND a.sad_num = 0
                           AND a.sad_reg_year = b.con_key_year
                           AND a.key_cuo = b.con_key_cuo
                           AND a.sad_reg_nber = b.con_reg_nber
                           AND b.con_lst_ope = 'U'
                           --         AND b.con_num = 0
                           AND b.con_obs = '1'
                           AND NVL (a.key_dec, '-') = NVL (c.dec_cod(+), '-')
                           AND c.lst_ope(+) = 'U'
                           AND NVL (a.sad_consignee, '-') =
                                  NVL (d.cmp_cod(+), '-')
                           AND d.lst_ope(+) = 'U'
                           AND NVL (a.sad_consignee, '-') =
                                  NVL (cab.ope_numerodoc(+), '-')
                           AND cab.ope_num(+) = 0
                           AND a.key_year = g.key_year(+)
                           AND a.key_cuo = g.key_cuo(+)
                           AND NVL (a.key_dec, '0') = NVL (g.key_dec(+), '0')
                           AND a.key_nber = g.key_nber(+)
                           AND a.sad_num = g.sad_num(+)
                           AND a.key_year = l.key_year(+)
                           AND a.key_cuo = l.key_cuo(+)
                           AND NVL (a.key_dec, '-') = NVL (l.key_dec(+), '-')
                           AND a.key_nber = l.key_nber(+)
                           AND a.sad_num = l.sad_num(+)
                           AND   b.con_key_year
                              || b.con_key_cuo
                              || b.con_reg_nber
                              || DECODE (b.con_fuente,
                                         'NO', '',
                                         '-' || b.con_fuente) = m.id
                           AND m.dil1_factores IS NOT NULL
                           AND m.dil1_nombre IS NULL
                           AND m.dil1_num = 0
                           AND a.key_cuo = o.cuo_cod
                           AND o.lst_ope = 'U'
                ORDER BY   orden, administracion, fecha DESC;
        END IF;

        RETURN cr;
    EXCEPTION
        WHEN OTHERS
        THEN
            OPEN cr FOR
                SELECT   *
                  FROM   DUAL
                 WHERE   1 = 2;
    END;

    FUNCTION r_listadocontrol (aduana    IN VARCHAR2,
                               fini      IN VARCHAR2,
                               ffin      IN VARCHAR2,
                               control   IN VARCHAR2)
        RETURN cursortype
    IS
        cr    cursortype;
        aux   VARCHAR2 (10) := '';
    BEGIN
        IF (SUBSTR (aduana, 3, 1) = '0')
        THEN
            IF (SUBSTR (aduana, 1, 1) = '2')
            THEN
                OPEN cr FOR
                      SELECT   DISTINCT
                                  a.sad_reg_year
                               || '/'
                               || a.key_cuo
                               || '/'
                               || a.sad_reg_serial
                               || '-'
                               || a.sad_reg_nber
                                   AS declaracion,
                               TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                   AS fecha_declaracion,
                               a.sad_typ_dec || '-' || a.sad_typ_proc AS patron,
                               a.sad_itm_total AS items,
                               a.sad_tot_invoiced AS fob,
                               DECODE (a.sad_consignee,
                                       NULL, l.sad_con_nam,
                                       NVL (d.cmp_nam, cab.ope_razonsocial))
                                   AS importador,
                               --NVL(a.sad_consignee,l.sad_con_zip) as nit_importador,
                               TRIM(NVL (a.sad_consignee, l.sad_con_zip) || ' '
                                    || DECODE (
                                           sipoea.pkg_consulta.verificar_oea (
                                               NVL (a.sad_consignee,
                                                    l.sad_con_zip),
                                               a.sad_flw,
                                               a.sad_reg_date),
                                           '1',
                                           '- (OEA)',
                                           ' '))
                                   AS nit_importador,
                               DECODE (a.key_dec,
                                       NULL, g.sad_dec_nam,
                                       '0', g.sad_dec_nam,
                                       c.dec_nam)
                                   AS declarante,
                               b.fis_fecreg AS fecha,
                               o.cuo_cod || '-' || o.cuo_nam AS administracion,
                               b.fis_control AS control,
                               NVL (b.fis_fiscalizador, '-') AS fiscalizador,
                               NVL (b.fis_comentario, '-') AS comentario,
                               TO_CHAR (b.fis_fecreg, 'dd/mm/yyyy')
                                   AS fecha_control,
                               DECODE (
                                   sipoea.pkg_consulta.verificar_oea (
                                       NVL (a.sad_consignee, l.sad_con_zip),
                                       a.sad_flw,
                                       a.sad_reg_date),
                                   '1',
                                   1,
                                   2)
                                   AS orden
                        FROM   ops$asy.sad_gen a,
                               mir_fiscalizacion b,
                               ops$asy.undectab c,
                               ops$asy.uncmptab d,
                               bo_oce_opecab cab,
                               ops$asy.sad_occ_dec g,
                               ops$asy.sad_occ_cns l,
                               ops$asy.uncuotab o
                       WHERE   (   SUBSTR (b.fis_key_cuo, 1, 1) = '2'
                                OR SUBSTR (b.fis_key_cuo, 1, 1) = '8'
                                OR SUBSTR (b.fis_key_cuo, 1, 1) = '9')
                               AND b.fis_control = control
                               AND TRUNC (b.fis_fecreg) BETWEEN TO_DATE (
                                                                    fini,
                                                                    'dd/mm/yyyy')
                                                            AND  TO_DATE (
                                                                     ffin,
                                                                     'dd/mm/yyyy')
                               AND b.fis_lst_ope = 'U'
                               AND b.fis_num = 0
                               AND b.fis_key_year = a.sad_reg_year
                               AND b.fis_key_cuo = a.key_cuo
                               AND b.fis_reg_nber = a.sad_reg_nber
                               AND a.sad_flw = 1
                               AND a.lst_ope = 'U'
                               AND a.sad_num = 0
                               AND NVL (a.key_dec, '-') =
                                      NVL (c.dec_cod(+), '-')
                               AND c.lst_ope(+) = 'U'
                               AND NVL (a.sad_consignee, '-') =
                                      NVL (d.cmp_cod(+), '-')
                               AND d.lst_ope(+) = 'U'
                               AND NVL (a.sad_consignee, '-') =
                                      NVL (cab.ope_numerodoc(+), '-')
                               AND cab.ope_num(+) = 0
                               AND a.key_year = g.key_year(+)
                               AND a.key_cuo = g.key_cuo(+)
                               AND NVL (a.key_dec, '0') =
                                      NVL (g.key_dec(+), '0')
                               AND a.key_nber = g.key_nber(+)
                               AND a.sad_num = g.sad_num(+)
                               AND a.key_year = l.key_year(+)
                               AND a.key_cuo = l.key_cuo(+)
                               AND NVL (a.key_dec, '-') =
                                      NVL (l.key_dec(+), '-')
                               AND a.key_nber = l.key_nber(+)
                               AND a.sad_num = l.sad_num(+)
                               AND a.key_cuo = o.cuo_cod
                               AND o.lst_ope = 'U'
                    ORDER BY   orden, administracion, fecha DESC;
            ELSIF (SUBSTR (aduana, 1, 1) = '3')
            THEN
                OPEN cr FOR
                      SELECT   DISTINCT
                                  a.sad_reg_year
                               || '/'
                               || a.key_cuo
                               || '/'
                               || a.sad_reg_serial
                               || '-'
                               || a.sad_reg_nber
                                   AS declaracion,
                               TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                   AS fecha_declaracion,
                               a.sad_typ_dec || '-' || a.sad_typ_proc AS patron,
                               a.sad_itm_total AS items,
                               a.sad_tot_invoiced AS fob,
                               DECODE (a.sad_consignee,
                                       NULL, l.sad_con_nam,
                                       NVL (d.cmp_nam, cab.ope_razonsocial))
                                   AS importador,
                               --NVL(a.sad_consignee,l.sad_con_zip) as nit_importador,
                               TRIM(NVL (a.sad_consignee, l.sad_con_zip) || ' '
                                    || DECODE (
                                           sipoea.pkg_consulta.verificar_oea (
                                               NVL (a.sad_consignee,
                                                    l.sad_con_zip),
                                               a.sad_flw,
                                               a.sad_reg_date),
                                           '1',
                                           '- (OEA)',
                                           ' '))
                                   AS nit_importador,
                               DECODE (a.key_dec,
                                       NULL, g.sad_dec_nam,
                                       '0', g.sad_dec_nam,
                                       c.dec_nam)
                                   AS declarante,
                               b.fis_fecreg AS fecha,
                               o.cuo_cod || '-' || o.cuo_nam AS administracion,
                               b.fis_control AS control,
                               NVL (b.fis_fiscalizador, '-') AS fiscalizador,
                               NVL (b.fis_comentario, '-') AS comentario,
                               TO_CHAR (b.fis_fecreg, 'dd/mm/yyyy')
                                   AS fecha_control,
                               DECODE (
                                   sipoea.pkg_consulta.verificar_oea (
                                       NVL (a.sad_consignee, l.sad_con_zip),
                                       a.sad_flw,
                                       a.sad_reg_date),
                                   '1',
                                   1,
                                   2)
                                   AS orden
                        FROM   ops$asy.sad_gen a,
                               mir_fiscalizacion b,
                               ops$asy.undectab c,
                               ops$asy.uncmptab d,
                               bo_oce_opecab cab,
                               ops$asy.sad_occ_dec g,
                               ops$asy.sad_occ_cns l,
                               ops$asy.uncuotab o
                       WHERE   (SUBSTR (b.fis_key_cuo, 1, 1) = '1'
                                OR SUBSTR (b.fis_key_cuo, 1, 1) = '3')
                               AND b.fis_control = control
                               AND TRUNC (b.fis_fecreg) BETWEEN TO_DATE (
                                                                    fini,
                                                                    'dd/mm/yyyy')
                                                            AND  TO_DATE (
                                                                     ffin,
                                                                     'dd/mm/yyyy')
                               AND b.fis_lst_ope = 'U'
                               AND b.fis_num = 0
                               AND b.fis_key_year = a.sad_reg_year
                               AND b.fis_key_cuo = a.key_cuo
                               AND b.fis_reg_nber = a.sad_reg_nber
                               AND a.sad_flw = 1
                               AND a.lst_ope = 'U'
                               AND a.sad_num = 0
                               AND NVL (a.key_dec, '-') =
                                      NVL (c.dec_cod(+), '-')
                               AND c.lst_ope(+) = 'U'
                               AND NVL (a.sad_consignee, '-') =
                                      NVL (d.cmp_cod(+), '-')
                               AND d.lst_ope(+) = 'U'
                               AND NVL (a.sad_consignee, '-') =
                                      NVL (cab.ope_numerodoc(+), '-')
                               AND cab.ope_num(+) = 0
                               AND a.key_year = g.key_year(+)
                               AND a.key_cuo = g.key_cuo(+)
                               AND NVL (a.key_dec, '0') =
                                      NVL (g.key_dec(+), '0')
                               AND a.key_nber = g.key_nber(+)
                               AND a.sad_num = g.sad_num(+)
                               AND a.key_year = l.key_year(+)
                               AND a.key_cuo = l.key_cuo(+)
                               AND NVL (a.key_dec, '-') =
                                      NVL (l.key_dec(+), '-')
                               AND a.key_nber = l.key_nber(+)
                               AND a.sad_num = l.sad_num(+)
                               AND a.key_cuo = o.cuo_cod
                               AND o.lst_ope = 'U'
                    ORDER BY   orden, administracion, fecha DESC;
            ELSIF (SUBSTR (aduana, 1, 1) = '0')
            THEN
                OPEN cr FOR
                      SELECT   DISTINCT
                                  a.sad_reg_year
                               || '/'
                               || a.key_cuo
                               || '/'
                               || a.sad_reg_serial
                               || '-'
                               || a.sad_reg_nber
                                   AS declaracion,
                               TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                   AS fecha_declaracion,
                               a.sad_typ_dec || '-' || a.sad_typ_proc AS patron,
                               a.sad_itm_total AS items,
                               a.sad_tot_invoiced AS fob,
                               DECODE (a.sad_consignee,
                                       NULL, l.sad_con_nam,
                                       NVL (d.cmp_nam, cab.ope_razonsocial))
                                   AS importador,
                               --NVL(a.sad_consignee,l.sad_con_zip) as nit_importador,
                               TRIM(NVL (a.sad_consignee, l.sad_con_zip) || ' '
                                    || DECODE (
                                           sipoea.pkg_consulta.verificar_oea (
                                               NVL (a.sad_consignee,
                                                    l.sad_con_zip),
                                               a.sad_flw,
                                               a.sad_reg_date),
                                           '1',
                                           '- (OEA)',
                                           ' '))
                                   AS nit_importador,
                               DECODE (a.key_dec,
                                       NULL, g.sad_dec_nam,
                                       '0', g.sad_dec_nam,
                                       c.dec_nam)
                                   AS declarante,
                               b.fis_fecreg AS fecha,
                               o.cuo_cod || '-' || o.cuo_nam AS administracion,
                               b.fis_control AS control,
                               NVL (b.fis_fiscalizador, '-') AS fiscalizador,
                               NVL (b.fis_comentario, '-') AS comentario,
                               TO_CHAR (b.fis_fecreg, 'dd/mm/yyyy')
                                   AS fecha_control,
                               DECODE (
                                   sipoea.pkg_consulta.verificar_oea (
                                       NVL (a.sad_consignee, l.sad_con_zip),
                                       a.sad_flw,
                                       a.sad_reg_date),
                                   '1',
                                   1,
                                   2)
                                   AS orden
                        FROM   ops$asy.sad_gen a,
                               mir_fiscalizacion b,
                               ops$asy.undectab c,
                               ops$asy.uncmptab d,
                               bo_oce_opecab cab,
                               ops$asy.sad_occ_dec g,
                               ops$asy.sad_occ_cns l,
                               ops$asy.uncuotab o
                       WHERE /*  (  SUBSTR(b.fis_key_cuo,1,1) = '1' OR SUBSTR(b.fis_key_cuo,1,1) = '3')
                           AND*/
                            b  .fis_control =
                                   control
                               AND TRUNC (b.fis_fecreg) BETWEEN TO_DATE (
                                                                    fini,
                                                                    'dd/mm/yyyy')
                                                            AND  TO_DATE (
                                                                     ffin,
                                                                     'dd/mm/yyyy')
                               AND b.fis_lst_ope = 'U'
                               AND b.fis_num = 0
                               AND b.fis_key_year = a.sad_reg_year
                               AND b.fis_key_cuo = a.key_cuo
                               AND b.fis_reg_nber = a.sad_reg_nber
                               AND a.sad_flw = 1
                               AND a.lst_ope = 'U'
                               AND a.sad_num = 0
                               AND NVL (a.key_dec, '-') =
                                      NVL (c.dec_cod(+), '-')
                               AND c.lst_ope(+) = 'U'
                               AND NVL (a.sad_consignee, '-') =
                                      NVL (d.cmp_cod(+), '-')
                               AND d.lst_ope(+) = 'U'
                               AND NVL (a.sad_consignee, '-') =
                                      NVL (cab.ope_numerodoc(+), '-')
                               AND cab.ope_num(+) = 0
                               AND a.key_year = g.key_year(+)
                               AND a.key_cuo = g.key_cuo(+)
                               AND NVL (a.key_dec, '0') =
                                      NVL (g.key_dec(+), '0')
                               AND a.key_nber = g.key_nber(+)
                               AND a.sad_num = g.sad_num(+)
                               AND a.key_year = l.key_year(+)
                               AND a.key_cuo = l.key_cuo(+)
                               AND NVL (a.key_dec, '-') =
                                      NVL (l.key_dec(+), '-')
                               AND a.key_nber = l.key_nber(+)
                               AND a.sad_num = l.sad_num(+)
                               AND a.key_cuo = o.cuo_cod
                               AND o.lst_ope = 'U'
                    ORDER BY   orden, administracion, fecha DESC;
            ELSE
                OPEN cr FOR
                      SELECT   DISTINCT
                                  a.sad_reg_year
                               || '/'
                               || a.key_cuo
                               || '/'
                               || a.sad_reg_serial
                               || '-'
                               || a.sad_reg_nber
                                   AS declaracion,
                               TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                   AS fecha_declaracion,
                               a.sad_typ_dec || '-' || a.sad_typ_proc AS patron,
                               a.sad_itm_total AS items,
                               a.sad_tot_invoiced AS fob,
                               DECODE (a.sad_consignee,
                                       NULL, l.sad_con_nam,
                                       NVL (d.cmp_nam, cab.ope_razonsocial))
                                   AS importador,
                               --NVL(a.sad_consignee,l.sad_con_zip) as nit_importador,
                               TRIM(NVL (a.sad_consignee, l.sad_con_zip) || ' '
                                    || DECODE (
                                           sipoea.pkg_consulta.verificar_oea (
                                               NVL (a.sad_consignee,
                                                    l.sad_con_zip),
                                               a.sad_flw,
                                               a.sad_reg_date),
                                           '1',
                                           '- (OEA)',
                                           ' '))
                                   AS nit_importador,
                               DECODE (a.key_dec,
                                       NULL, g.sad_dec_nam,
                                       '0', g.sad_dec_nam,
                                       c.dec_nam)
                                   AS declarante,
                               b.fis_fecreg AS fecha,
                               o.cuo_cod || '-' || o.cuo_nam AS administracion,
                               b.fis_control AS control,
                               NVL (b.fis_fiscalizador, '-') AS fiscalizador,
                               NVL (b.fis_comentario, '-') AS comentario,
                               TO_CHAR (b.fis_fecreg, 'dd/mm/yyyy')
                                   AS fecha_control,
                               DECODE (
                                   sipoea.pkg_consulta.verificar_oea (
                                       NVL (a.sad_consignee, l.sad_con_zip),
                                       a.sad_flw,
                                       a.sad_reg_date),
                                   '1',
                                   1,
                                   2)
                                   AS orden
                        FROM   ops$asy.sad_gen a,
                               mir_fiscalizacion b,
                               ops$asy.undectab c,
                               ops$asy.uncmptab d,
                               bo_oce_opecab cab,
                               ops$asy.sad_occ_dec g,
                               ops$asy.sad_occ_cns l,
                               ops$asy.uncuotab o
                       WHERE   SUBSTR (b.fis_key_cuo, 1, 1) =
                                   SUBSTR (aduana, 1, 1)
                               AND b.fis_control = control
                               AND TRUNC (b.fis_fecreg) BETWEEN TO_DATE (
                                                                    fini,
                                                                    'dd/mm/yyyy')
                                                            AND  TO_DATE (
                                                                     ffin,
                                                                     'dd/mm/yyyy')
                               AND b.fis_lst_ope = 'U'
                               AND b.fis_num = 0
                               AND b.fis_key_year = a.sad_reg_year
                               AND b.fis_key_cuo = a.key_cuo
                               AND b.fis_reg_nber = a.sad_reg_nber
                               AND a.sad_flw = 1
                               AND a.lst_ope = 'U'
                               AND a.sad_num = 0
                               AND NVL (a.key_dec, '-') =
                                      NVL (c.dec_cod(+), '-')
                               AND c.lst_ope(+) = 'U'
                               AND NVL (a.sad_consignee, '-') =
                                      NVL (d.cmp_cod(+), '-')
                               AND d.lst_ope(+) = 'U'
                               AND NVL (a.sad_consignee, '-') =
                                      NVL (cab.ope_numerodoc(+), '-')
                               AND cab.ope_num(+) = 0
                               AND a.key_year = g.key_year(+)
                               AND a.key_cuo = g.key_cuo(+)
                               AND NVL (a.key_dec, '0') =
                                      NVL (g.key_dec(+), '0')
                               AND a.key_nber = g.key_nber(+)
                               AND a.sad_num = g.sad_num(+)
                               AND a.key_year = l.key_year(+)
                               AND a.key_cuo = l.key_cuo(+)
                               AND NVL (a.key_dec, '-') =
                                      NVL (l.key_dec(+), '-')
                               AND a.key_nber = l.key_nber(+)
                               AND a.sad_num = l.sad_num(+)
                               AND a.key_cuo = o.cuo_cod
                               AND o.lst_ope = 'U'
                    ORDER BY   orden, administracion, fecha DESC;
            END IF;
        ELSE
            OPEN cr FOR
                  SELECT   DISTINCT
                              a.sad_reg_year
                           || '/'
                           || a.key_cuo
                           || '/'
                           || a.sad_reg_serial
                           || '-'
                           || a.sad_reg_nber
                               AS declaracion,
                           TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                               AS fecha_declaracion,
                           a.sad_typ_dec || '-' || a.sad_typ_proc AS patron,
                           a.sad_itm_total AS items,
                           a.sad_tot_invoiced AS fob,
                           DECODE (a.sad_consignee,
                                   NULL, l.sad_con_nam,
                                   d.cmp_nam)
                               AS importador,
                           --NVL(a.sad_consignee,l.sad_con_zip) as nit_importador,
                           TRIM(NVL (a.sad_consignee, l.sad_con_zip) || ' '
                                || DECODE (
                                       sipoea.pkg_consulta.verificar_oea (
                                           NVL (a.sad_consignee, l.sad_con_zip),
                                           a.sad_flw,
                                           a.sad_reg_date),
                                       '1',
                                       '- (OEA)',
                                       ' '))
                               AS nit_importador,
                           DECODE (a.key_dec,
                                   NULL, g.sad_dec_nam,
                                   '0', g.sad_dec_nam,
                                   c.dec_nam)
                               AS declarante,
                           b.fis_fecreg AS fecha,
                           o.cuo_cod || '-' || o.cuo_nam AS administracion,
                           b.fis_control AS control,
                           NVL (b.fis_fiscalizador, '-') AS fiscalizador,
                           NVL (b.fis_comentario, '-') AS comentario,
                           TO_CHAR (b.fis_fecreg, 'dd/mm/yyyy')
                               AS fecha_control,
                           DECODE (
                               sipoea.pkg_consulta.verificar_oea (
                                   NVL (a.sad_consignee, l.sad_con_zip),
                                   a.sad_flw,
                                   a.sad_reg_date),
                               '1',
                               1,
                               2)
                               AS orden
                    FROM   ops$asy.sad_gen a,
                           mir_fiscalizacion b,
                           ops$asy.undectab c,
                           ops$asy.uncmptab d,
                           ops$asy.sad_occ_dec g,
                           ops$asy.sad_occ_cns l,
                           ops$asy.uncuotab o
                   WHERE   b.fis_key_cuo = aduana AND b.fis_control = control
                           AND TRUNC (b.fis_fecreg) BETWEEN TO_DATE (
                                                                fini,
                                                                'dd/mm/yyyy')
                                                        AND  TO_DATE (
                                                                 ffin,
                                                                 'dd/mm/yyyy')
                           AND b.fis_lst_ope = 'U'
                           AND b.fis_num = 0
                           AND b.fis_key_year = a.sad_reg_year
                           AND b.fis_key_cuo = a.key_cuo
                           AND b.fis_reg_nber = a.sad_reg_nber
                           AND a.sad_flw = 1
                           AND a.lst_ope = 'U'
                           AND a.sad_num = 0
                           AND NVL (a.key_dec, '-') = NVL (c.dec_cod(+), '-')
                           AND c.lst_ope(+) = 'U'
                           AND NVL (a.sad_consignee, '-') =
                                  NVL (d.cmp_cod(+), '-')
                           AND d.lst_ope(+) = 'U'
                           AND a.key_year = g.key_year(+)
                           AND a.key_cuo = g.key_cuo(+)
                           AND NVL (a.key_dec, '0') = NVL (g.key_dec(+), '0')
                           AND a.key_nber = g.key_nber(+)
                           AND a.sad_num = g.sad_num(+)
                           AND a.key_year = l.key_year(+)
                           AND a.key_cuo = l.key_cuo(+)
                           AND NVL (a.key_dec, '-') = NVL (l.key_dec(+), '-')
                           AND a.key_nber = l.key_nber(+)
                           AND a.sad_num = l.sad_num(+)
                           AND a.key_cuo = o.cuo_cod
                           AND o.lst_ope = 'U'
                ORDER BY   orden, administracion, fecha DESC;
        END IF;

        RETURN cr;
    EXCEPTION
        WHEN OTHERS
        THEN
            OPEN cr FOR
                SELECT   *
                  FROM   DUAL
                 WHERE   1 = 2;
    END;


    FUNCTION verifica_control_veh (gestion    IN     VARCHAR2,
                                   aduana     IN     VARCHAR2,
                                   numero     IN     VARCHAR2,
                                   usuario    IN     VARCHAR2,
                                   gerencia      OUT VARCHAR2)
        RETURN VARCHAR2
    IS
        hay   NUMBER (10) := 0;
    BEGIN
        SELECT   COUNT (1)
          INTO   hay
          FROM   ops$asy.sad_gen a, ops$asy.sad_gen_ped b
         WHERE       a.sad_reg_year = b.sad_reg_year
                 AND a.key_cuo = b.key_cuo
                 AND a.sad_reg_serial = b.sad_reg_serial
                 AND a.sad_reg_nber = b.sad_reg_nber
                 AND a.sad_reg_year = gestion
                 AND a.key_cuo = aduana
                 AND a.sad_reg_nber = numero
                 AND a.sad_flw = 1
                 AND a.sad_num = 0
                 AND a.lst_ope = 'U'
                 AND b.sad_clr IN ('0')
                 AND b.usr_ex1 IS NOT NULL;

        IF hay = 0
        THEN
            gerencia := '-';
            RETURN    'Error: La Declaraci'
                   || CHR (243)
                   || 'n no tiene Autorizaci'
                   || CHR (243)
                   || 'n de Levante';
        END IF;

        SELECT   a.gercodger
          INTO   gerencia
          FROM   usuario.usuario a
         WHERE   a.usucodusu = usuario AND a.lst_ope = 'U' AND a.usu_num = 0;

        RETURN ('Correcto');
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN ('Error: ' || SQLERRM);
    END;
END;
/


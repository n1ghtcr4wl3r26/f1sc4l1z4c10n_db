CREATE OR REPLACE 
PACKAGE pkg_reporte
/* Formatted on 8-jun.-2017 12:06:44 (QP5 v5.126) */
IS
    TYPE cursortype IS REF CURSOR;

    FUNCTION devuelve_tributos (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION devuelve_tributos2 (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION devuelve_tributos3 (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION devuelve_tributos3tot (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION devuelve_liquidacion (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION devuelve_liquidacion2 (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION dev_liquidacion (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION dev_liquidacionfecha (prm_codigo   IN VARCHAR2,
                                   prm_fecha    IN VARCHAR2)
        RETURN cursortype;

    FUNCTION dev_tributoomitidofechatotal (prm_codigo   IN VARCHAR2,
                                           prm_fecha    IN VARCHAR2)
        RETURN cursortype;

    FUNCTION dev_tributoomitidofecha (prm_codigo   IN VARCHAR2,
                                      prm_fecha    IN VARCHAR2)
        RETURN cursortype;

    FUNCTION devuelve_liquidaciontab (prm_codigo    IN VARCHAR2,
                                      prm_codigo2   IN VARCHAR2)
        RETURN cursortype;

    FUNCTION tipocambio (fecha IN DATE, tipo IN VARCHAR2)
        RETURN NUMBER;

    FUNCTION devuelve_sanciones (prm_codigo IN VARCHAR2)
        RETURN cursortype;

    FUNCTION fecha_vencimiento (prm_aduana   IN VARCHAR2,
                                prm_fecha    IN VARCHAR2)
        RETURN DATE;

    FUNCTION aumentardiashabiles (prm_gerencia   IN VARCHAR2,
                                  prm_fecha      IN VARCHAR2,
                                  prm_dias   IN NUMBER)
        RETURN DATE;

    FUNCTION c_diligencia1_x (sid IN VARCHAR2)
        RETURN cursortype;

    FUNCTION resumen_controles (prm_supervisor   IN VARCHAR2,
                                prm_fecini       IN VARCHAR2,
                                prm_fecfin       IN VARCHAR2,
                                prm_gerencia     IN VARCHAR2)
        RETURN cursortype;

    FUNCTION resumen_controles_tot (prm_supervisor   IN VARCHAR2,
                                    prm_fecini       IN VARCHAR2,
                                    prm_fecfin       IN VARCHAR2,
                                    prm_gerencia     IN VARCHAR2)
        RETURN cursortype;

    FUNCTION detalle_controles_sup (prm_fiscalizador   IN VARCHAR2,
                                    prm_fecini         IN VARCHAR2,
                                    prm_fecfin         IN VARCHAR2,
                                    prm_tipo_tramite   IN VARCHAR2,
                                    prm_estado         IN VARCHAR2,
                                    prm_gerencia       IN VARCHAR2)
        RETURN cursortype;

    FUNCTION detalle_cantidad_sup (prm_supervisor   IN VARCHAR2,
                                   prm_fecini       IN VARCHAR2,
                                   prm_fecfin       IN VARCHAR2,
                                   prm_gerencia     IN VARCHAR2)
        RETURN cursortype;

    FUNCTION detalle_cantidad_sup_tot (prm_supervisor   IN VARCHAR2,
                                       prm_fecini       IN VARCHAR2,
                                       prm_fecfin       IN VARCHAR2,
                                       prm_gerencia     IN VARCHAR2)
        RETURN cursortype;
END;
/

CREATE OR REPLACE 
PACKAGE BODY pkg_reporte
/* Formatted on 19-jun.-2017 17:45:54 (QP5 v5.126) */
IS
    FUNCTION devuelve_tributos (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
              SELECT      u.sad_reg_year
                       || '/'
                       || u.key_cuo
                       || '/C-'
                       || u.sad_reg_nber,
                       TO_CHAR (u.sad_reg_date, 'dd/mm/yyyy'),
                       SUM (gau.saditm_tax_amount - gaa.saditm_tax_amount) ga,
                       SUM (ivu.saditm_tax_amount - iva.saditm_tax_amount) iva,
                       SUM(NVL (icu.saditm_tax_amount, 0)
                           - NVL (ica.saditm_tax_amount, 0))
                           ice,
                       SUM (gau.saditm_tax_amount - gaa.saditm_tax_amount)
                       + SUM (ivu.saditm_tax_amount - iva.saditm_tax_amount)
                       + SUM(NVL (icu.saditm_tax_amount, 0)
                             - NVL (ica.saditm_tax_amount, 0))
                FROM   fis_alcance f,
                       ops$asy.sad_gen u,
                       ops$asy.sad_gen a,
                       ops$asy.sad_itm iu,
                       ops$asy.sad_itm ia,
                       ops$asy.sad_tax gau,
                       ops$asy.sad_tax gaa,
                       ops$asy.sad_tax ivu,
                       ops$asy.sad_tax iva,
                       ops$asy.sad_tax icu,
                       ops$asy.sad_tax ica
               WHERE       u.key_year = a.key_year
                       AND u.key_cuo = a.key_cuo
                       AND u.key_dec = a.key_dec
                       AND u.key_nber = a.key_nber
                       AND a.sad_num =
                              (SELECT   MAX (t.sad_num)
                                 FROM   ops$asy.sad_gen t
                                WHERE       t.key_year = u.key_year
                                        AND t.key_cuo = u.key_cuo
                                        AND t.key_dec = u.key_dec
                                        AND t.key_nber = u.key_nber)
                       AND u.key_year = iu.key_year
                       AND u.key_cuo = iu.key_cuo
                       AND u.key_dec = iu.key_dec
                       AND u.key_nber = iu.key_nber
                       AND u.sad_num = iu.sad_num
                       AND a.key_year = ia.key_year
                       AND a.key_cuo = ia.key_cuo
                       AND a.key_dec = ia.key_dec
                       AND a.key_nber = ia.key_nber
                       AND a.sad_num = ia.sad_num
                       AND iu.key_year = ia.key_year
                       AND iu.key_cuo = ia.key_cuo
                       AND iu.key_dec = ia.key_dec
                       AND iu.key_nber = ia.key_nber
                       AND iu.itm_nber = ia.itm_nber
                       AND iu.key_year = gau.key_year
                       AND iu.key_cuo = gau.key_cuo
                       AND iu.key_dec = gau.key_dec
                       AND iu.key_nber = gau.key_nber
                       AND iu.itm_nber = gau.itm_nber
                       AND iu.sad_num = gau.sad_num
                       AND gau.saditm_tax_code = 'GA'
                       AND ia.key_year = gaa.key_year
                       AND ia.key_cuo = gaa.key_cuo
                       AND ia.key_dec = gaa.key_dec
                       AND ia.key_nber = gaa.key_nber
                       AND ia.itm_nber = gaa.itm_nber
                       AND ia.sad_num = gaa.sad_num
                       AND gaa.saditm_tax_code = 'GA'
                       AND iu.key_year = ivu.key_year
                       AND iu.key_cuo = ivu.key_cuo
                       AND iu.key_dec = ivu.key_dec
                       AND iu.key_nber = ivu.key_nber
                       AND iu.itm_nber = ivu.itm_nber
                       AND iu.sad_num = ivu.sad_num
                       AND ivu.saditm_tax_code = 'IVA'
                       AND ia.key_year = iva.key_year
                       AND ia.key_cuo = iva.key_cuo
                       AND ia.key_dec = iva.key_dec
                       AND ia.key_nber = iva.key_nber
                       AND ia.itm_nber = iva.itm_nber
                       AND ia.sad_num = iva.sad_num
                       AND iva.saditm_tax_code = 'IVA'
                       AND iu.key_year = icu.key_year(+)
                       AND iu.key_cuo = icu.key_cuo(+)
                       AND iu.key_dec = icu.key_dec(+)
                       AND iu.key_nber = icu.key_nber(+)
                       AND iu.itm_nber = icu.itm_nber(+)
                       AND iu.sad_num = icu.sad_num(+)
                       AND icu.saditm_tax_code(+) = 'ICE'
                       AND ia.key_year = ica.key_year(+)
                       AND ia.key_cuo = ica.key_cuo(+)
                       AND ia.key_dec = ica.key_dec(+)
                       AND ia.key_nber = ica.key_nber(+)
                       AND ia.itm_nber = ica.itm_nber(+)
                       AND ia.sad_num = ica.sad_num(+)
                       AND ica.saditm_tax_code(+) = 'ICE'
                       AND u.sad_flw = 1
                       AND u.sad_num = 0
                       AND u.lst_ope = 'U'
                       AND u.key_dec IS NOT NULL
                       AND f.alc_tipo_tramite = 'DUI'
                       AND f.alc_gestion = u.sad_reg_year
                       AND f.alc_aduana = u.key_cuo
                       AND u.sad_reg_serial = 'C'
                       AND f.alc_numero = u.sad_reg_nber
                       AND f.ctl_control_id = prm_codigo
            GROUP BY      u.sad_reg_year
                       || '/'
                       || u.key_cuo
                       || '/C-'
                       || u.sad_reg_nber,
                       TO_CHAR (u.sad_reg_date, 'dd/mm/yyyy')
            UNION
              SELECT      u.sad_reg_year
                       || '/'
                       || u.key_cuo
                       || '/C-'
                       || u.sad_reg_nber,
                       TO_CHAR (u.sad_reg_date, 'dd/mm/yyyy'),
                       SUM (gau.saditm_tax_amount - gaa.saditm_tax_amount) ga,
                       SUM (ivu.saditm_tax_amount - iva.saditm_tax_amount) iva,
                       SUM(NVL (icu.saditm_tax_amount, 0)
                           - NVL (ica.saditm_tax_amount, 0))
                           ice,
                       SUM (gau.saditm_tax_amount - gaa.saditm_tax_amount)
                       + SUM (ivu.saditm_tax_amount - iva.saditm_tax_amount)
                       + SUM(NVL (icu.saditm_tax_amount, 0)
                             - NVL (ica.saditm_tax_amount, 0))
                FROM   fis_alcance f,
                       ops$asy.sad_gen u,
                       ops$asy.sad_gen a,
                       ops$asy.sad_itm iu,
                       ops$asy.sad_itm ia,
                       ops$asy.sad_tax gau,
                       ops$asy.sad_tax gaa,
                       ops$asy.sad_tax ivu,
                       ops$asy.sad_tax iva,
                       ops$asy.sad_tax icu,
                       ops$asy.sad_tax ica
               WHERE       u.key_year = a.key_year
                       AND u.key_cuo = a.key_cuo
                       AND u.key_dec IS NULL
                       AND a.key_dec IS NULL
                       AND u.key_nber = a.key_nber
                       AND a.sad_num =
                              (SELECT   MAX (t.sad_num)
                                 FROM   ops$asy.sad_gen t
                                WHERE       t.key_year = u.key_year
                                        AND t.key_cuo = u.key_cuo
                                        AND t.key_dec = u.key_dec
                                        AND t.key_nber = u.key_nber)
                       AND u.key_year = iu.key_year
                       AND u.key_cuo = iu.key_cuo
                       AND iu.key_dec IS NULL
                       AND u.key_nber = iu.key_nber
                       AND u.sad_num = iu.sad_num
                       AND a.key_year = ia.key_year
                       AND a.key_cuo = ia.key_cuo
                       AND ia.key_dec IS NULL
                       AND a.key_nber = ia.key_nber
                       AND a.sad_num = ia.sad_num
                       AND iu.key_year = ia.key_year
                       AND iu.key_cuo = ia.key_cuo
                       AND iu.key_nber = ia.key_nber
                       AND iu.itm_nber = ia.itm_nber
                       AND iu.key_year = gau.key_year
                       AND iu.key_cuo = gau.key_cuo
                       AND gau.key_dec IS NULL
                       AND iu.key_nber = gau.key_nber
                       AND iu.itm_nber = gau.itm_nber
                       AND iu.sad_num = gau.sad_num
                       AND gau.saditm_tax_code = 'GA'
                       AND ia.key_year = gaa.key_year
                       AND ia.key_cuo = gaa.key_cuo
                       AND gaa.key_dec IS NULL
                       AND ia.key_nber = gaa.key_nber
                       AND ia.itm_nber = gaa.itm_nber
                       AND ia.sad_num = gaa.sad_num
                       AND gaa.saditm_tax_code = 'GA'
                       AND iu.key_year = ivu.key_year
                       AND iu.key_cuo = ivu.key_cuo
                       AND ivu.key_dec IS NULL
                       AND iu.key_nber = ivu.key_nber
                       AND iu.itm_nber = ivu.itm_nber
                       AND iu.sad_num = ivu.sad_num
                       AND ivu.saditm_tax_code = 'IVA'
                       AND ia.key_year = iva.key_year
                       AND ia.key_cuo = iva.key_cuo
                       AND iva.key_dec IS NULL
                       AND ia.key_nber = iva.key_nber
                       AND ia.itm_nber = iva.itm_nber
                       AND ia.sad_num = iva.sad_num
                       AND iva.saditm_tax_code = 'IVA'
                       AND iu.key_year = icu.key_year(+)
                       AND iu.key_cuo = icu.key_cuo(+)
                       AND icu.key_dec(+) IS NULL
                       AND iu.key_nber = icu.key_nber(+)
                       AND iu.itm_nber = icu.itm_nber(+)
                       AND iu.sad_num = icu.sad_num(+)
                       AND icu.saditm_tax_code(+) = 'ICE'
                       AND ia.key_year = ica.key_year(+)
                       AND ia.key_cuo = ica.key_cuo(+)
                       AND ica.key_dec(+) IS NULL
                       AND ia.key_nber = ica.key_nber(+)
                       AND ia.itm_nber = ica.itm_nber(+)
                       AND ia.sad_num = ica.sad_num(+)
                       AND ica.saditm_tax_code(+) = 'ICE'
                       AND u.sad_flw = 1
                       AND u.sad_num = 0
                       AND u.lst_ope = 'U'
                       AND f.alc_tipo_tramite = 'DUI'
                       AND f.alc_gestion = u.sad_reg_year
                       AND f.alc_aduana = u.key_cuo
                       AND u.sad_reg_serial = 'C'
                       AND f.alc_numero = u.sad_reg_nber
                       AND f.ctl_control_id = prm_codigo
            GROUP BY      u.sad_reg_year
                       || '/'
                       || u.key_cuo
                       || '/C-'
                       || u.sad_reg_nber,
                       TO_CHAR (u.sad_reg_date, 'dd/mm/yyyy')
            ORDER BY   2;

        RETURN ct;
    END;

    FUNCTION devuelve_tributos2 (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
              SELECT   t.itm,
                       t.reg_year,
                       t.key_cuo,
                       t.reg_nber,
                       t.fecha_reg,
                       t.fecha_calculo,
                       t.ga_dt dt_ga,
                       t.iva_dt dt_iva,
                       t.ice_dt dt_ice,
                       t.iehd_dt dt_iehd,
                       t.icd_dt dt_icd,
                       ROUND (
                           (  t.ga_dt
                            + t.iva_dt
                            + t.ice_dt
                            + t.iehd_dt
                            + t.icd_dt)
                           * t.tc_ufvfecvenc,
                           2)
                           dt_total,
                       ( (t.to_ga + t.to_iva + t.to_ice + t.to_iehd + t.to_icd)
                        / t.tc_ufvhoy)
                       * t.tc_ufvfecvenc
                           sancionufv,
                       ( ( (  t.to_ga
                            + t.to_iva
                            + t.to_ice
                            + t.to_iehd
                            + t.to_icd)
                          / t.tc_ufvhoy)
                        * t.tc_ufvfecvenc)
                       / t.tc_ufvhoy
                           sancionbs,
                       ROUND (
                           (  t.ga_dt
                            + t.iva_dt
                            + t.ice_dt
                            + t.iehd_dt
                            + t.icd_dt)
                           + ( ( (  t.to_ga
                                  + t.to_iva
                                  + t.to_ice
                                  + t.to_iehd
                                  + t.to_icd)
                                / t.tc_ufvhoy)
                              * t.tc_ufvfecvenc),
                           2)
                           adeudo_totalbs
                FROM   (SELECT   iu.itm_nber itm,
                                 u.sad_reg_year reg_year,
                                 u.key_cuo key_cuo,
                                 u.sad_reg_nber reg_nber,
                                 TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                     fecha_reg,
                                 TO_CHAR (SYSDATE, 'dd/mm/yyyy') fecha_calculo,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     gau.saditm_tax_amount
                                     - gaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     ga_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     ivau.saditm_tax_amount
                                     - ivaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     iva_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iceu.saditm_tax_amount, 0)
                                     - NVL (icea.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     ice_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iehdu.saditm_tax_amount, 0)
                                     - NVL (iehda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     iehd_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (icdu.saditm_tax_amount, 0)
                                     - NVL (icda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     icd_dt,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'UFV')
                                     tc_ufvfecvenc,
                                 pkg_reporte.tipocambio (TRUNC (SYSDATE),
                                                         'UFV')
                                     tc_ufvhoy,
                                 gau.saditm_tax_amount - gaa.saditm_tax_amount
                                     to_ga,
                                 ivau.saditm_tax_amount
                                 - ivaa.saditm_tax_amount
                                     to_iva,
                                 NVL (iceu.saditm_tax_amount, 0)
                                 - NVL (icea.saditm_tax_amount, 0)
                                     to_ice,
                                 NVL (iehdu.saditm_tax_amount, 0)
                                 - NVL (iehda.saditm_tax_amount, 0)
                                     to_iehd,
                                 NVL (icdu.saditm_tax_amount, 0)
                                 - NVL (icda.saditm_tax_amount, 0)
                                     to_icd
                          FROM   ops$asy.sad_gen u,
                                 ops$asy.sad_gen a,
                                 ops$asy.sad_itm iu,
                                 ops$asy.sad_itm ia,
                                 ops$asy.sad_tax gau,
                                 ops$asy.sad_tax gaa,
                                 ops$asy.sad_tax ivau,
                                 ops$asy.sad_tax ivaa,
                                 ops$asy.sad_tax iceu,
                                 ops$asy.sad_tax icea,
                                 ops$asy.sad_tax iehdu,
                                 ops$asy.sad_tax iehda,
                                 ops$asy.sad_tax icdu,
                                 ops$asy.sad_tax icda,
                                 fis_alcance f,
                                 fis_notificacion n
                         WHERE       u.key_year = a.key_year
                                 AND u.key_cuo = a.key_cuo
                                 AND u.key_dec IS NOT NULL
                                 AND u.key_dec = a.key_dec
                                 AND u.key_nber = a.key_nber
                                 AND a.sad_num =
                                        NVL (
                                            (SELECT   MAX (x.sad_pst_num)
                                               FROM   ops$asy.sad_gen x
                                              WHERE   x.key_cuo = u.key_cuo
                                                      AND x.sad_reg_year =
                                                             u.sad_reg_year
                                                      AND x.sad_reg_serial =
                                                             u.sad_reg_serial
                                                      AND x.sad_reg_nber =
                                                             u.sad_reg_nber
                                                      AND x.sad_pst_dat <=
                                                             TO_DATE (
                                                                 n.not_fecha_notificacion,
                                                                 'dd/mm/yyyy')),
                                            0)
                                 AND u.sad_flw = 1
                                 AND u.sad_num = 0
                                 AND u.lst_ope = 'U'
                                 AND u.key_year = iu.key_year
                                 AND u.key_cuo = iu.key_cuo
                                 AND u.key_dec = iu.key_dec
                                 AND u.key_nber = iu.key_nber
                                 AND u.sad_num = iu.sad_num
                                 AND a.key_year = ia.key_year
                                 AND a.key_cuo = ia.key_cuo
                                 AND a.key_dec = ia.key_dec
                                 AND a.key_nber = ia.key_nber
                                 AND a.sad_num = ia.sad_num
                                 AND iu.key_year = ia.key_year
                                 AND iu.key_cuo = ia.key_cuo
                                 AND iu.key_dec = ia.key_dec
                                 AND iu.key_nber = ia.key_nber
                                 AND iu.itm_nber = ia.itm_nber
                                 --tributo GA
                                 AND iu.key_year = gau.key_year
                                 AND iu.key_cuo = gau.key_cuo
                                 AND iu.key_dec = gau.key_dec
                                 AND iu.key_nber = gau.key_nber
                                 AND iu.itm_nber = gau.itm_nber
                                 AND iu.sad_num = gau.sad_num
                                 AND gau.saditm_tax_code = 'GA'
                                 AND ia.key_year = gaa.key_year
                                 AND ia.key_cuo = gaa.key_cuo
                                 AND ia.key_dec = gaa.key_dec
                                 AND ia.key_nber = gaa.key_nber
                                 AND ia.itm_nber = gaa.itm_nber
                                 AND ia.sad_num = gaa.sad_num
                                 AND gaa.saditm_tax_code = 'GA'
                                 --tributo IVA
                                 AND iu.key_year = ivau.key_year
                                 AND iu.key_cuo = ivau.key_cuo
                                 AND iu.key_dec = ivau.key_dec
                                 AND iu.key_nber = ivau.key_nber
                                 AND iu.itm_nber = ivau.itm_nber
                                 AND iu.sad_num = ivau.sad_num
                                 AND ivau.saditm_tax_code = 'IVA'
                                 AND ia.key_year = ivaa.key_year
                                 AND ia.key_cuo = ivaa.key_cuo
                                 AND ia.key_dec = ivaa.key_dec
                                 AND ia.key_nber = ivaa.key_nber
                                 AND ia.itm_nber = ivaa.itm_nber
                                 AND ia.sad_num = ivaa.sad_num
                                 AND ivaa.saditm_tax_code = 'IVA'
                                 --tributo ICE
                                 AND iu.key_year = iceu.key_year(+)
                                 AND iu.key_cuo = iceu.key_cuo(+)
                                 AND iu.key_dec = iceu.key_dec(+)
                                 AND iu.key_nber = iceu.key_nber(+)
                                 AND iu.itm_nber = iceu.itm_nber(+)
                                 AND iu.sad_num = iceu.sad_num(+)
                                 AND iceu.saditm_tax_code(+) = 'ICE'
                                 AND ia.key_year = icea.key_year(+)
                                 AND ia.key_cuo = icea.key_cuo(+)
                                 AND ia.key_dec = icea.key_dec(+)
                                 AND ia.key_nber = icea.key_nber(+)
                                 AND ia.itm_nber = icea.itm_nber(+)
                                 AND ia.sad_num = icea.sad_num(+)
                                 AND icea.saditm_tax_code(+) = 'ICE'
                                 --tributo IEHD
                                 AND iu.key_year = iehdu.key_year(+)
                                 AND iu.key_cuo = iehdu.key_cuo(+)
                                 AND iu.key_dec = iehdu.key_dec(+)
                                 AND iu.key_nber = iehdu.key_nber(+)
                                 AND iu.itm_nber = iehdu.itm_nber(+)
                                 AND iu.sad_num = iehdu.sad_num(+)
                                 AND iehdu.saditm_tax_code(+) = 'IEHD'
                                 AND ia.key_year = iehda.key_year(+)
                                 AND ia.key_cuo = iehda.key_cuo(+)
                                 AND ia.key_dec = iehda.key_dec(+)
                                 AND ia.key_nber = iehda.key_nber(+)
                                 AND ia.itm_nber = iehda.itm_nber(+)
                                 AND ia.sad_num = iehda.sad_num(+)
                                 AND iehda.saditm_tax_code(+) = 'IEHD'
                                 --tributo ICD
                                 AND iu.key_year = icdu.key_year(+)
                                 AND iu.key_cuo = icdu.key_cuo(+)
                                 AND iu.key_dec = icdu.key_dec(+)
                                 AND iu.key_nber = icdu.key_nber(+)
                                 AND iu.itm_nber = icdu.itm_nber(+)
                                 AND iu.sad_num = icdu.sad_num(+)
                                 AND icdu.saditm_tax_code(+) = 'ICD'
                                 AND ia.key_year = icda.key_year(+)
                                 AND ia.key_cuo = icda.key_cuo(+)
                                 AND ia.key_dec = icda.key_dec(+)
                                 AND ia.key_nber = icda.key_nber(+)
                                 AND ia.itm_nber = icda.itm_nber(+)
                                 AND ia.sad_num = icda.sad_num(+)
                                 AND icda.saditm_tax_code(+) = 'ICD'
                                 --para recuperar informacion del control
                                 AND f.alc_tipo_tramite = 'DUI'
                                 AND f.alc_gestion = u.sad_reg_year
                                 AND f.alc_aduana = u.key_cuo
                                 AND u.sad_reg_serial = 'C'
                                 AND f.alc_numero = u.sad_reg_nber
                                 AND f.ctl_control_id = prm_codigo
                                 AND f.alc_num = 0
                                 AND f.alc_lstope = 'U'
                                 AND f.ctl_control_id = n.ctl_control_id
                                 AND n.not_num = 0
                                 AND n.not_lstope = 'U'
                        UNION
                        SELECT   iu.itm_nber itm,
                                 u.sad_reg_year reg_year,
                                 u.key_cuo key_cuo,
                                 u.sad_reg_nber reg_nber,
                                 TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                     fecha_reg,
                                 TO_CHAR (SYSDATE, 'dd/mm/yyyy') fecha_calculo,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     gau.saditm_tax_amount
                                     - gaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     ga_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     ivau.saditm_tax_amount
                                     - ivaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     iva_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iceu.saditm_tax_amount, 0)
                                     - NVL (icea.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     ice_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iehdu.saditm_tax_amount, 0)
                                     - NVL (iehda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     iehd_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (icdu.saditm_tax_amount, 0)
                                     - NVL (icda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     icd_dt,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'UFV')
                                     tc_ufvfecvenc,
                                 pkg_reporte.tipocambio (TRUNC (SYSDATE),
                                                         'UFV')
                                     tc_ufvhoy,
                                 gau.saditm_tax_amount - gaa.saditm_tax_amount
                                     to_ga,
                                 ivau.saditm_tax_amount
                                 - ivaa.saditm_tax_amount
                                     to_iva,
                                 NVL (iceu.saditm_tax_amount, 0)
                                 - NVL (icea.saditm_tax_amount, 0)
                                     to_ice,
                                 NVL (iehdu.saditm_tax_amount, 0)
                                 - NVL (iehda.saditm_tax_amount, 0)
                                     to_iehd,
                                 NVL (icdu.saditm_tax_amount, 0)
                                 - NVL (icda.saditm_tax_amount, 0)
                                     to_icd
                          FROM   ops$asy.sad_gen u,
                                 ops$asy.sad_gen a,
                                 ops$asy.sad_itm iu,
                                 ops$asy.sad_itm ia,
                                 ops$asy.sad_tax gau,
                                 ops$asy.sad_tax gaa,
                                 ops$asy.sad_tax ivau,
                                 ops$asy.sad_tax ivaa,
                                 ops$asy.sad_tax iceu,
                                 ops$asy.sad_tax icea,
                                 ops$asy.sad_tax iehdu,
                                 ops$asy.sad_tax iehda,
                                 ops$asy.sad_tax icdu,
                                 ops$asy.sad_tax icda,
                                 fis_alcance f,
                                 fis_notificacion n
                         WHERE       u.key_year = a.key_year
                                 AND u.key_cuo = a.key_cuo
                                 AND u.key_dec IS NULL
                                 AND a.key_dec IS NULL
                                 AND u.key_nber = a.key_nber
                                 AND a.sad_num =
                                        NVL (
                                            (SELECT   MAX (x.sad_pst_num)
                                               FROM   ops$asy.sad_gen x
                                              WHERE   x.key_cuo = u.key_cuo
                                                      AND x.sad_reg_year =
                                                             u.sad_reg_year
                                                      AND x.sad_reg_serial =
                                                             u.sad_reg_serial
                                                      AND x.sad_reg_nber =
                                                             u.sad_reg_nber
                                                      AND x.sad_pst_dat <=
                                                             TO_DATE (
                                                                 n.not_fecha_notificacion,
                                                                 'dd/mm/yyyy')),
                                            0)
                                 AND u.sad_flw = 1
                                 AND u.sad_num = 0
                                 AND u.lst_ope = 'U'
                                 AND u.key_year = iu.key_year
                                 AND u.key_cuo = iu.key_cuo
                                 AND iu.key_dec IS NULL
                                 AND u.key_nber = iu.key_nber
                                 AND u.sad_num = iu.sad_num
                                 AND a.key_year = ia.key_year
                                 AND a.key_cuo = ia.key_cuo
                                 AND ia.key_dec IS NULL
                                 AND a.key_nber = ia.key_nber
                                 AND a.sad_num = ia.sad_num
                                 AND iu.key_year = ia.key_year
                                 AND iu.key_cuo = ia.key_cuo
                                 AND iu.key_nber = ia.key_nber
                                 AND iu.itm_nber = ia.itm_nber
                                 --tributo GA
                                 AND iu.key_year = gau.key_year
                                 AND iu.key_cuo = gau.key_cuo
                                 AND gau.key_dec IS NULL
                                 AND iu.key_nber = gau.key_nber
                                 AND iu.itm_nber = gau.itm_nber
                                 AND iu.sad_num = gau.sad_num
                                 AND gau.saditm_tax_code = 'GA'
                                 AND ia.key_year = gaa.key_year
                                 AND ia.key_cuo = gaa.key_cuo
                                 AND gaa.key_dec IS NULL
                                 AND ia.key_nber = gaa.key_nber
                                 AND ia.itm_nber = gaa.itm_nber
                                 AND ia.sad_num = gaa.sad_num
                                 AND gaa.saditm_tax_code = 'GA'
                                 --tributo IVA
                                 AND iu.key_year = ivau.key_year
                                 AND iu.key_cuo = ivau.key_cuo
                                 AND ivau.key_dec IS NULL
                                 AND iu.key_nber = ivau.key_nber
                                 AND iu.itm_nber = ivau.itm_nber
                                 AND iu.sad_num = ivau.sad_num
                                 AND ivau.saditm_tax_code = 'IVA'
                                 AND ia.key_year = ivaa.key_year
                                 AND ia.key_cuo = ivaa.key_cuo
                                 AND ivaa.key_dec IS NULL
                                 AND ia.key_nber = ivaa.key_nber
                                 AND ia.itm_nber = ivaa.itm_nber
                                 AND ia.sad_num = ivaa.sad_num
                                 AND ivaa.saditm_tax_code = 'IVA'
                                 --tributo ICE
                                 AND iu.key_year = iceu.key_year(+)
                                 AND iu.key_cuo = iceu.key_cuo(+)
                                 AND iceu.key_dec(+) IS NULL
                                 AND iu.key_nber = iceu.key_nber(+)
                                 AND iu.itm_nber = iceu.itm_nber(+)
                                 AND iu.sad_num = iceu.sad_num(+)
                                 AND iceu.saditm_tax_code(+) = 'ICE'
                                 AND ia.key_year = icea.key_year(+)
                                 AND ia.key_cuo = icea.key_cuo(+)
                                 AND icea.key_dec(+) IS NULL
                                 AND ia.key_nber = icea.key_nber(+)
                                 AND ia.itm_nber = icea.itm_nber(+)
                                 AND ia.sad_num = icea.sad_num(+)
                                 AND icea.saditm_tax_code(+) = 'ICE'
                                 --tributo IEHD
                                 AND iu.key_year = iehdu.key_year(+)
                                 AND iu.key_cuo = iehdu.key_cuo(+)
                                 AND iehdu.key_dec(+) IS NULL
                                 AND iu.key_nber = iehdu.key_nber(+)
                                 AND iu.itm_nber = iehdu.itm_nber(+)
                                 AND iu.sad_num = iehdu.sad_num(+)
                                 AND iehdu.saditm_tax_code(+) = 'IEHD'
                                 AND ia.key_year = iehda.key_year(+)
                                 AND ia.key_cuo = iehda.key_cuo(+)
                                 AND iehda.key_dec(+) IS NULL
                                 AND ia.key_nber = iehda.key_nber(+)
                                 AND ia.itm_nber = iehda.itm_nber(+)
                                 AND ia.sad_num = iehda.sad_num(+)
                                 AND iehda.saditm_tax_code(+) = 'IEHD'
                                 --tributo ICD
                                 AND iu.key_year = icdu.key_year(+)
                                 AND iu.key_cuo = icdu.key_cuo(+)
                                 AND icdu.key_dec(+) IS NULL
                                 AND iu.key_nber = icdu.key_nber(+)
                                 AND iu.itm_nber = icdu.itm_nber(+)
                                 AND iu.sad_num = icdu.sad_num(+)
                                 AND icdu.saditm_tax_code(+) = 'ICD'
                                 AND ia.key_year = icda.key_year(+)
                                 AND ia.key_cuo = icda.key_cuo(+)
                                 AND icda.key_dec(+) IS NULL
                                 AND ia.key_nber = icda.key_nber(+)
                                 AND ia.itm_nber = icda.itm_nber(+)
                                 AND ia.sad_num = icda.sad_num(+)
                                 AND icda.saditm_tax_code(+) = 'ICD'
                                 --para recuperar informacion del control
                                 AND f.alc_tipo_tramite = 'DUI'
                                 AND f.alc_gestion = u.sad_reg_year
                                 AND f.alc_aduana = u.key_cuo
                                 AND u.sad_reg_serial = 'C'
                                 AND f.alc_numero = u.sad_reg_nber
                                 AND f.ctl_control_id = prm_codigo
                                 AND f.alc_num = 0
                                 AND f.alc_lstope = 'U'
                                 AND f.ctl_control_id = n.ctl_control_id
                                 AND n.not_num = 0
                                 AND n.not_lstope = 'U') t
            ORDER BY   2,
                       3,
                       4,
                       1;

        RETURN ct;
    END;



    FUNCTION devuelve_tributos3 (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct            cursortype;
        existe        NUMBER;
        dias          NUMBER;
        fechanot      DATE;
        coeficiente   NUMBER (10, 2) := 0;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.est_num = 0
                 AND a.est_lstope = 'U'
                 AND a.est_estado = 'CONCLUIDO';

        IF existe = 0
        THEN
            fechanot := NULL;
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_con_viscargo a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.cvc_num = 0
                     AND a.cvc_lstope = 'U';

            IF existe = 0
            THEN
                fechanot := NULL;
            ELSE
                SELECT   a.cvc_fecha_notificacion
                  INTO   fechanot
                  FROM   fis_con_viscargo a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.cvc_num = 0
                         AND a.cvc_lstope = 'U';

                dias := TRUNC (SYSDATE) - fechanot;

                IF dias <= 10
                THEN
                    coeficiente := 0;
                ELSE
                    coeficiente := 0.2;
                END IF;
            END IF;
        END IF;

        OPEN ct FOR
              SELECT   t.reg_year || '/' || t.key_cuo || '/C-' || t.reg_nber,
                       t.fecha_reg,
                       t.fecha_calculo,
                       t.ga_dt dt_ga,
                       t.iva_dt dt_iva,
                       t.ice_dt dt_ice,
                       t.iehd_dt dt_iehd,
                       t.icd_dt dt_icd,
                       ROUND (
                           (  t.ga_dt
                            + t.iva_dt
                            + t.ice_dt
                            + t.iehd_dt
                            + t.icd_dt)
                           * t.tc_ufvfecvenc,
                           2)
                           dt_total,
                       ROUND (
                           ( (  t.to_ga
                              + t.to_iva
                              + t.to_ice
                              + t.to_iehd
                              + t.to_icd)
                            / t.tc_ufvhoy)
                           * t.tc_ufvfecvenc,
                           2)
                           sancionufv,
                       ROUND (
                           coeficiente
                           * ( ( (  t.to_ga
                                  + t.to_iva
                                  + t.to_ice
                                  + t.to_iehd
                                  + t.to_icd)
                                / t.tc_ufvhoy)
                              * t.tc_ufvfecvenc)
                           / t.tc_ufvhoy,
                           2)
                           sancionbs,
                       ROUND (
                           coeficiente
                           * (  t.ga_dt
                              + t.iva_dt
                              + t.ice_dt
                              + t.iehd_dt
                              + t.icd_dt)
                           + ( ( (  t.to_ga
                                  + t.to_iva
                                  + t.to_ice
                                  + t.to_iehd
                                  + t.to_icd)
                                / t.tc_ufvhoy)
                              * t.tc_ufvfecvenc),
                           2)
                           adeudo_totalbs,
                       fechanot,
                       coeficiente
                FROM   (SELECT   x.sad_reg_year reg_year,
                                 x.key_cuo key_cuo,
                                 x.sad_reg_nber reg_nber,
                                 TO_CHAR (x.sad_reg_date, 'dd/mm/yyyy')
                                     fecha_reg,
                                 TO_CHAR (SYSDATE, 'dd/mm/yyyy') fecha_calculo,
                                 ops$asy.fcalculadeudatributaria (
                                     x.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     x.key_year,
                                     x.key_cuo,
                                     x.key_dec,
                                     x.key_nber,
                                     x.gau - x.gaa,
                                     x.sad_top_cod)
                                     ga_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     x.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     x.key_year,
                                     x.key_cuo,
                                     x.key_dec,
                                     x.key_nber,
                                     x.ivau - x.ivaa,
                                     x.sad_top_cod)
                                     iva_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     x.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     x.key_year,
                                     x.key_cuo,
                                     x.key_dec,
                                     x.key_nber,
                                     NVL (x.iceu, 0) - NVL (x.icea, 0),
                                     x.sad_top_cod)
                                     ice_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     x.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     x.key_year,
                                     x.key_cuo,
                                     x.key_dec,
                                     x.key_nber,
                                     NVL (x.iehdu, 0) - NVL (x.iehda, 0),
                                     x.sad_top_cod)
                                     iehd_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     x.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     x.key_year,
                                     x.key_cuo,
                                     x.key_dec,
                                     x.key_nber,
                                     NVL (x.icdu, 0) - NVL (x.icda, 0),
                                     x.sad_top_cod)
                                     icd_dt,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         x.key_cuo,
                                         TO_CHAR (x.sad_reg_date, 'dd/mm/yyyy')),
                                     'UFV')
                                     tc_ufvfecvenc,
                                 pkg_reporte.tipocambio (TRUNC (SYSDATE),
                                                         'UFV')
                                     tc_ufvhoy,
                                 x.gau - x.gaa to_ga,
                                 x.ivau - x.ivaa to_iva,
                                 x.iceu - x.icea to_ice,
                                 x.iehdu - x.iehda to_iehd,
                                 x.icdu - x.icda to_icd
                          FROM   (  SELECT   u.sad_reg_year,
                                             u.key_cuo,
                                             u.sad_reg_nber,
                                             u.sad_reg_date,
                                             u.key_year,
                                             u.key_dec,
                                             u.key_nber,
                                             u.sad_top_cod,
                                             SUM (gau.saditm_tax_amount) gau,
                                             SUM (gaa.saditm_tax_amount) gaa,
                                             SUM (ivau.saditm_tax_amount) ivau,
                                             SUM (ivaa.saditm_tax_amount) ivaa,
                                             SUM (
                                                 NVL (iceu.saditm_tax_amount, 0))
                                                 iceu,
                                             SUM (
                                                 NVL (icea.saditm_tax_amount, 0))
                                                 icea,
                                             SUM(NVL (iehdu.saditm_tax_amount, 0))
                                                 iehdu,
                                             SUM(NVL (iehda.saditm_tax_amount, 0))
                                                 iehda,
                                             SUM (
                                                 NVL (icdu.saditm_tax_amount, 0))
                                                 icdu,
                                             SUM (
                                                 NVL (icda.saditm_tax_amount, 0))
                                                 icda
                                      FROM   ops$asy.sad_gen u,
                                             ops$asy.sad_gen a,
                                             ops$asy.sad_itm iu,
                                             ops$asy.sad_itm ia,
                                             ops$asy.sad_tax gau,
                                             ops$asy.sad_tax gaa,
                                             ops$asy.sad_tax ivau,
                                             ops$asy.sad_tax ivaa,
                                             ops$asy.sad_tax iceu,
                                             ops$asy.sad_tax icea,
                                             ops$asy.sad_tax iehdu,
                                             ops$asy.sad_tax iehda,
                                             ops$asy.sad_tax icdu,
                                             ops$asy.sad_tax icda,
                                             fis_alcance f,
                                             fis_notificacion n
                                     WHERE       u.key_year = a.key_year
                                             AND u.key_cuo = a.key_cuo
                                             AND u.key_dec IS NOT NULL
                                             AND u.key_dec = a.key_dec
                                             AND u.key_nber = a.key_nber
                                             AND a.sad_num =
                                                    NVL (
                                                        (SELECT   MAX(x.sad_pst_num)
                                                           FROM   ops$asy.sad_gen x
                                                          WHERE   x.key_cuo =
                                                                      u.key_cuo
                                                                  AND x.sad_reg_year =
                                                                         u.sad_reg_year
                                                                  AND x.sad_reg_serial =
                                                                         u.sad_reg_serial
                                                                  AND x.sad_reg_nber =
                                                                         u.sad_reg_nber
                                                                  AND x.sad_pst_dat <=
                                                                         n.not_fecha_notificacion),
                                                        0)
                                             AND u.sad_flw = 1
                                             AND u.sad_num = 0
                                             AND u.lst_ope = 'U'
                                             AND u.key_year = iu.key_year
                                             AND u.key_cuo = iu.key_cuo
                                             AND u.key_dec = iu.key_dec
                                             AND u.key_nber = iu.key_nber
                                             AND u.sad_num = iu.sad_num
                                             AND a.key_year = ia.key_year
                                             AND a.key_cuo = ia.key_cuo
                                             AND a.key_dec = ia.key_dec
                                             AND a.key_nber = ia.key_nber
                                             AND a.sad_num = ia.sad_num
                                             AND iu.key_year = ia.key_year
                                             AND iu.key_cuo = ia.key_cuo
                                             AND iu.key_dec = ia.key_dec
                                             AND iu.key_nber = ia.key_nber
                                             AND iu.itm_nber = ia.itm_nber
                                             --tributo GA
                                             AND iu.key_year = gau.key_year
                                             AND iu.key_cuo = gau.key_cuo
                                             AND iu.key_dec = gau.key_dec
                                             AND iu.key_nber = gau.key_nber
                                             AND iu.itm_nber = gau.itm_nber
                                             AND iu.sad_num = gau.sad_num
                                             AND gau.saditm_tax_code = 'GA'
                                             AND ia.key_year = gaa.key_year
                                             AND ia.key_cuo = gaa.key_cuo
                                             AND ia.key_dec = gaa.key_dec
                                             AND ia.key_nber = gaa.key_nber
                                             AND ia.itm_nber = gaa.itm_nber
                                             AND ia.sad_num = gaa.sad_num
                                             AND gaa.saditm_tax_code = 'GA'
                                             --tributo IVA
                                             AND iu.key_year = ivau.key_year
                                             AND iu.key_cuo = ivau.key_cuo
                                             AND iu.key_dec = ivau.key_dec
                                             AND iu.key_nber = ivau.key_nber
                                             AND iu.itm_nber = ivau.itm_nber
                                             AND iu.sad_num = ivau.sad_num
                                             AND ivau.saditm_tax_code = 'IVA'
                                             AND ia.key_year = ivaa.key_year
                                             AND ia.key_cuo = ivaa.key_cuo
                                             AND ia.key_dec = ivaa.key_dec
                                             AND ia.key_nber = ivaa.key_nber
                                             AND ia.itm_nber = ivaa.itm_nber
                                             AND ia.sad_num = ivaa.sad_num
                                             AND ivaa.saditm_tax_code = 'IVA'
                                             --tributo ICE
                                             AND iu.key_year = iceu.key_year(+)
                                             AND iu.key_cuo = iceu.key_cuo(+)
                                             AND iu.key_dec = iceu.key_dec(+)
                                             AND iu.key_nber = iceu.key_nber(+)
                                             AND iu.itm_nber = iceu.itm_nber(+)
                                             AND iu.sad_num = iceu.sad_num(+)
                                             AND iceu.saditm_tax_code(+) = 'ICE'
                                             AND ia.key_year = icea.key_year(+)
                                             AND ia.key_cuo = icea.key_cuo(+)
                                             AND ia.key_dec = icea.key_dec(+)
                                             AND ia.key_nber = icea.key_nber(+)
                                             AND ia.itm_nber = icea.itm_nber(+)
                                             AND ia.sad_num = icea.sad_num(+)
                                             AND icea.saditm_tax_code(+) = 'ICE'
                                             --tributo IEHD
                                             AND iu.key_year = iehdu.key_year(+)
                                             AND iu.key_cuo = iehdu.key_cuo(+)
                                             AND iu.key_dec = iehdu.key_dec(+)
                                             AND iu.key_nber = iehdu.key_nber(+)
                                             AND iu.itm_nber = iehdu.itm_nber(+)
                                             AND iu.sad_num = iehdu.sad_num(+)
                                             AND iehdu.saditm_tax_code(+) =
                                                    'IEHD'
                                             AND ia.key_year = iehda.key_year(+)
                                             AND ia.key_cuo = iehda.key_cuo(+)
                                             AND ia.key_dec = iehda.key_dec(+)
                                             AND ia.key_nber = iehda.key_nber(+)
                                             AND ia.itm_nber = iehda.itm_nber(+)
                                             AND ia.sad_num = iehda.sad_num(+)
                                             AND iehda.saditm_tax_code(+) =
                                                    'IEHD'
                                             --tributo ICD
                                             AND iu.key_year = icdu.key_year(+)
                                             AND iu.key_cuo = icdu.key_cuo(+)
                                             AND iu.key_dec = icdu.key_dec(+)
                                             AND iu.key_nber = icdu.key_nber(+)
                                             AND iu.itm_nber = icdu.itm_nber(+)
                                             AND iu.sad_num = icdu.sad_num(+)
                                             AND icdu.saditm_tax_code(+) = 'ICD'
                                             AND ia.key_year = icda.key_year(+)
                                             AND ia.key_cuo = icda.key_cuo(+)
                                             AND ia.key_dec = icda.key_dec(+)
                                             AND ia.key_nber = icda.key_nber(+)
                                             AND ia.itm_nber = icda.itm_nber(+)
                                             AND ia.sad_num = icda.sad_num(+)
                                             AND icda.saditm_tax_code(+) = 'ICD'
                                             --para recuperar informacion del control
                                             AND f.alc_tipo_tramite = 'DUI'
                                             AND f.alc_gestion = u.sad_reg_year
                                             AND f.alc_aduana = u.key_cuo
                                             AND u.sad_reg_serial = 'C'
                                             AND f.alc_numero = u.sad_reg_nber
                                             AND f.ctl_control_id = prm_codigo
                                             AND f.alc_num = 0
                                             AND f.alc_lstope = 'U'
                                             AND f.ctl_control_id =
                                                    n.ctl_control_id
                                             AND n.not_num = 0
                                             AND n.not_lstope = 'U'
                                  GROUP BY   u.sad_reg_year,
                                             u.key_cuo,
                                             u.sad_reg_nber,
                                             u.sad_reg_date,
                                             u.key_year,
                                             u.key_dec,
                                             u.key_nber,
                                             u.sad_top_cod
                                  UNION
                                    SELECT   u.sad_reg_year,
                                             u.key_cuo,
                                             u.sad_reg_nber,
                                             u.sad_reg_date,
                                             u.key_year,
                                             u.key_dec,
                                             u.key_nber,
                                             u.sad_top_cod,
                                             SUM (gau.saditm_tax_amount) gau,
                                             SUM (gaa.saditm_tax_amount) gaa,
                                             SUM (ivau.saditm_tax_amount) ivau,
                                             SUM (ivaa.saditm_tax_amount) ivaa,
                                             SUM (
                                                 NVL (iceu.saditm_tax_amount, 0))
                                                 iceu,
                                             SUM (
                                                 NVL (icea.saditm_tax_amount, 0))
                                                 icea,
                                             SUM(NVL (iehdu.saditm_tax_amount, 0))
                                                 iehdu,
                                             SUM(NVL (iehda.saditm_tax_amount, 0))
                                                 iehda,
                                             SUM (
                                                 NVL (icdu.saditm_tax_amount, 0))
                                                 icdu,
                                             SUM (
                                                 NVL (icda.saditm_tax_amount, 0))
                                                 icda
                                      FROM   ops$asy.sad_gen u,
                                             ops$asy.sad_gen a,
                                             ops$asy.sad_itm iu,
                                             ops$asy.sad_itm ia,
                                             ops$asy.sad_tax gau,
                                             ops$asy.sad_tax gaa,
                                             ops$asy.sad_tax ivau,
                                             ops$asy.sad_tax ivaa,
                                             ops$asy.sad_tax iceu,
                                             ops$asy.sad_tax icea,
                                             ops$asy.sad_tax iehdu,
                                             ops$asy.sad_tax iehda,
                                             ops$asy.sad_tax icdu,
                                             ops$asy.sad_tax icda,
                                             fis_alcance f,
                                             fis_notificacion n
                                     WHERE       u.key_year = a.key_year
                                             AND u.key_cuo = a.key_cuo
                                             AND u.key_dec IS NULL
                                             AND a.key_dec IS NULL
                                             AND u.key_nber = a.key_nber
                                             AND a.sad_num =
                                                    NVL (
                                                        (SELECT   MAX(x.sad_pst_num)
                                                           FROM   ops$asy.sad_gen x
                                                          WHERE   x.key_cuo =
                                                                      u.key_cuo
                                                                  AND x.sad_reg_year =
                                                                         u.sad_reg_year
                                                                  AND x.sad_reg_serial =
                                                                         u.sad_reg_serial
                                                                  AND x.sad_reg_nber =
                                                                         u.sad_reg_nber
                                                                  AND x.sad_pst_dat <=
                                                                         n.not_fecha_notificacion),
                                                        0)
                                             AND u.sad_flw = 1
                                             AND u.sad_num = 0
                                             AND u.lst_ope = 'U'
                                             AND u.key_year = iu.key_year
                                             AND u.key_cuo = iu.key_cuo
                                             AND iu.key_dec IS NULL
                                             AND u.key_nber = iu.key_nber
                                             AND u.sad_num = iu.sad_num
                                             AND a.key_year = ia.key_year
                                             AND a.key_cuo = ia.key_cuo
                                             AND ia.key_dec IS NULL
                                             AND a.key_nber = ia.key_nber
                                             AND a.sad_num = ia.sad_num
                                             AND iu.key_year = ia.key_year
                                             AND iu.key_cuo = ia.key_cuo
                                             AND iu.key_nber = ia.key_nber
                                             AND iu.itm_nber = ia.itm_nber
                                             --tributo GA
                                             AND iu.key_year = gau.key_year
                                             AND iu.key_cuo = gau.key_cuo
                                             AND gau.key_dec IS NULL
                                             AND iu.key_nber = gau.key_nber
                                             AND iu.itm_nber = gau.itm_nber
                                             AND iu.sad_num = gau.sad_num
                                             AND gau.saditm_tax_code = 'GA'
                                             AND ia.key_year = gaa.key_year
                                             AND ia.key_cuo = gaa.key_cuo
                                             AND gaa.key_dec IS NULL
                                             AND ia.key_nber = gaa.key_nber
                                             AND ia.itm_nber = gaa.itm_nber
                                             AND ia.sad_num = gaa.sad_num
                                             AND gaa.saditm_tax_code = 'GA'
                                             --tributo IVA
                                             AND iu.key_year = ivau.key_year
                                             AND iu.key_cuo = ivau.key_cuo
                                             AND ivau.key_dec IS NULL
                                             AND iu.key_nber = ivau.key_nber
                                             AND iu.itm_nber = ivau.itm_nber
                                             AND iu.sad_num = ivau.sad_num
                                             AND ivau.saditm_tax_code = 'IVA'
                                             AND ia.key_year = ivaa.key_year
                                             AND ia.key_cuo = ivaa.key_cuo
                                             AND ivaa.key_dec IS NULL
                                             AND ia.key_nber = ivaa.key_nber
                                             AND ia.itm_nber = ivaa.itm_nber
                                             AND ia.sad_num = ivaa.sad_num
                                             AND ivaa.saditm_tax_code = 'IVA'
                                             --tributo ICE
                                             AND iu.key_year = iceu.key_year(+)
                                             AND iu.key_cuo = iceu.key_cuo(+)
                                             AND iu.key_dec = iceu.key_dec(+)
                                             AND iceu.key_nber(+) IS NULL
                                             AND iu.itm_nber = iceu.itm_nber(+)
                                             AND iu.sad_num = iceu.sad_num(+)
                                             AND iceu.saditm_tax_code(+) = 'ICE'
                                             AND ia.key_year = icea.key_year(+)
                                             AND ia.key_cuo = icea.key_cuo(+)
                                             AND icea.key_dec(+) IS NULL
                                             AND ia.key_nber = icea.key_nber(+)
                                             AND ia.itm_nber = icea.itm_nber(+)
                                             AND ia.sad_num = icea.sad_num(+)
                                             AND icea.saditm_tax_code(+) = 'ICE'
                                             --tributo IEHD
                                             AND iu.key_year = iehdu.key_year(+)
                                             AND iu.key_cuo = iehdu.key_cuo(+)
                                             AND iehdu.key_dec(+) IS NULL
                                             AND iu.key_nber = iehdu.key_nber(+)
                                             AND iu.itm_nber = iehdu.itm_nber(+)
                                             AND iu.sad_num = iehdu.sad_num(+)
                                             AND iehdu.saditm_tax_code(+) =
                                                    'IEHD'
                                             AND ia.key_year = iehda.key_year(+)
                                             AND ia.key_cuo = iehda.key_cuo(+)
                                             AND iehda.key_dec(+) IS NULL
                                             AND ia.key_nber = iehda.key_nber(+)
                                             AND ia.itm_nber = iehda.itm_nber(+)
                                             AND ia.sad_num = iehda.sad_num(+)
                                             AND iehda.saditm_tax_code(+) =
                                                    'IEHD'
                                             --tributo ICD
                                             AND iu.key_year = icdu.key_year(+)
                                             AND iu.key_cuo = icdu.key_cuo(+)
                                             AND icdu.key_dec(+) IS NULL
                                             AND iu.key_nber = icdu.key_nber(+)
                                             AND iu.itm_nber = icdu.itm_nber(+)
                                             AND iu.sad_num = icdu.sad_num(+)
                                             AND icdu.saditm_tax_code(+) = 'ICD'
                                             AND ia.key_year = icda.key_year(+)
                                             AND ia.key_cuo = icda.key_cuo(+)
                                             AND icda.key_dec(+) IS NULL
                                             AND ia.key_nber = icda.key_nber(+)
                                             AND ia.itm_nber = icda.itm_nber(+)
                                             AND ia.sad_num = icda.sad_num(+)
                                             AND icda.saditm_tax_code(+) = 'ICD'
                                             --para recuperar informacion del control
                                             AND f.alc_tipo_tramite = 'DUI'
                                             AND f.alc_gestion = u.sad_reg_year
                                             AND f.alc_aduana = u.key_cuo
                                             AND u.sad_reg_serial = 'C'
                                             AND f.alc_numero = u.sad_reg_nber
                                             AND f.ctl_control_id = prm_codigo
                                             AND f.alc_num = 0
                                             AND f.alc_lstope = 'U'
                                             AND f.ctl_control_id =
                                                    n.ctl_control_id
                                             AND n.not_num = 0
                                             AND n.not_lstope = 'U'
                                  GROUP BY   u.sad_reg_year,
                                             u.key_cuo,
                                             u.sad_reg_nber,
                                             u.sad_reg_date,
                                             u.key_year,
                                             u.key_dec,
                                             u.key_nber,
                                             u.sad_top_cod) x) t
            ORDER BY   2, 3, 4;

        RETURN ct;
    END;

    FUNCTION devuelve_tributos3tot (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct               cursortype;
        existe           NUMBER;
        dias             NUMBER;
        fechanot         DATE;
        coeficiente      NUMBER (10, 2) := 0;

        v_contrav        NUMBER (10, 2) := 0;
        v_contravorden   NUMBER (10, 2) := 0;
    BEGIN
        SELECT   COUNT (1)
          INTO   existe
          FROM   fis_estado a
         WHERE       a.ctl_control_id = prm_codigo
                 AND a.est_num = 0
                 AND a.est_lstope = 'U'
                 AND a.est_estado = 'CONCLUIDO';

        IF existe = 0
        THEN
            fechanot := NULL;
        ELSE
            SELECT   COUNT (1)
              INTO   existe
              FROM   fis_con_viscargo a
             WHERE       a.ctl_control_id = prm_codigo
                     AND a.cvc_num = 0
                     AND a.cvc_lstope = 'U';

            IF existe = 0
            THEN
                fechanot := NULL;
            ELSE
                SELECT   a.cvc_fecha_notificacion
                  INTO   fechanot
                  FROM   fis_con_viscargo a
                 WHERE       a.ctl_control_id = prm_codigo
                         AND a.cvc_num = 0
                         AND a.cvc_lstope = 'U';

                dias := TRUNC (SYSDATE) - fechanot;

                IF dias <= 10
                THEN
                    coeficiente := 0;
                ELSE
                    coeficiente := 0.2;
                END IF;
            END IF;
        END IF;


        SELECT   NVL (SUM (res_contrav), 0), NVL (SUM (res_contravorden), 0)
          INTO   v_contrav, v_contravorden
          FROM   fis_alcance a, fis_resultados b
         WHERE   a.alc_tipo_tramite = 'DUI'
                 AND res_dui =
                           a.alc_gestion
                        || '/'
                        || a.alc_aduana
                        || '/C-'
                        || a.alc_numero
                 AND a.alc_num = 0
                 AND a.alc_lstope = 'U'
                 AND b.res_num = 0
                 AND b.res_lstope = 'U'
                 AND a.ctl_control_id = prm_codigo;

        OPEN ct FOR
            SELECT   SUM (d.dt_ga),
                     SUM (d.dt_iva),
                     SUM (d.dt_ice),
                     SUM (d.dt_iehd),
                     SUM (d.dt_icd),
                     SUM (d.dt_total),
                     SUM (d.sancionufv),
                     SUM (d.sancionbs),
                     SUM (d.adeudo_totalbs) + v_contrav + v_contravorden
                         total,
                     v_contrav,
                     v_contravorden,
                     SUM (d.adeudo_totalbs) subtotal
              FROM   (SELECT      t.reg_year
                               || '/'
                               || t.key_cuo
                               || '/C-'
                               || t.reg_nber,
                               t.fecha_reg,
                               t.fecha_calculo,
                               t.ga_dt dt_ga,
                               t.iva_dt dt_iva,
                               t.ice_dt dt_ice,
                               t.iehd_dt dt_iehd,
                               t.icd_dt dt_icd,
                               ROUND (
                                   (  t.ga_dt
                                    + t.iva_dt
                                    + t.ice_dt
                                    + t.iehd_dt
                                    + t.icd_dt)
                                   * t.tc_ufvfecvenc,
                                   2)
                                   dt_total,
                               ROUND (
                                   ( (  t.to_ga
                                      + t.to_iva
                                      + t.to_ice
                                      + t.to_iehd
                                      + t.to_icd)
                                    / t.tc_ufvhoy)
                                   * t.tc_ufvfecvenc,
                                   2)
                                   sancionufv,
                               ROUND (
                                   coeficiente
                                   * ( ( (  t.to_ga
                                          + t.to_iva
                                          + t.to_ice
                                          + t.to_iehd
                                          + t.to_icd)
                                        / t.tc_ufvhoy)
                                      * t.tc_ufvfecvenc)
                                   / t.tc_ufvhoy,
                                   2)
                                   sancionbs,
                               ROUND (
                                   coeficiente
                                   * (  t.ga_dt
                                      + t.iva_dt
                                      + t.ice_dt
                                      + t.iehd_dt
                                      + t.icd_dt)
                                   + ( ( (  t.to_ga
                                          + t.to_iva
                                          + t.to_ice
                                          + t.to_iehd
                                          + t.to_icd)
                                        / t.tc_ufvhoy)
                                      * t.tc_ufvfecvenc),
                                   2)
                                   adeudo_totalbs,
                               fechanot,
                               coeficiente
                        FROM   (SELECT   x.sad_reg_year reg_year,
                                         x.key_cuo key_cuo,
                                         x.sad_reg_nber reg_nber,
                                         TO_CHAR (x.sad_reg_date,
                                                  'dd/mm/yyyy')
                                             fecha_reg,
                                         TO_CHAR (SYSDATE, 'dd/mm/yyyy')
                                             fecha_calculo,
                                         ops$asy.fcalculadeudatributaria (
                                             x.sad_reg_date,
                                             TRUNC (SYSDATE),
                                             x.key_year,
                                             x.key_cuo,
                                             x.key_dec,
                                             x.key_nber,
                                             x.gau - x.gaa,
                                             x.sad_top_cod)
                                             ga_dt,
                                         ops$asy.fcalculadeudatributaria (
                                             x.sad_reg_date,
                                             TRUNC (SYSDATE),
                                             x.key_year,
                                             x.key_cuo,
                                             x.key_dec,
                                             x.key_nber,
                                             x.ivau - x.ivaa,
                                             x.sad_top_cod)
                                             iva_dt,
                                         ops$asy.fcalculadeudatributaria (
                                             x.sad_reg_date,
                                             TRUNC (SYSDATE),
                                             x.key_year,
                                             x.key_cuo,
                                             x.key_dec,
                                             x.key_nber,
                                             NVL (x.iceu, 0)
                                             - NVL (x.icea, 0),
                                             x.sad_top_cod)
                                             ice_dt,
                                         ops$asy.fcalculadeudatributaria (
                                             x.sad_reg_date,
                                             TRUNC (SYSDATE),
                                             x.key_year,
                                             x.key_cuo,
                                             x.key_dec,
                                             x.key_nber,
                                             NVL (x.iehdu, 0)
                                             - NVL (x.iehda, 0),
                                             x.sad_top_cod)
                                             iehd_dt,
                                         ops$asy.fcalculadeudatributaria (
                                             x.sad_reg_date,
                                             TRUNC (SYSDATE),
                                             x.key_year,
                                             x.key_cuo,
                                             x.key_dec,
                                             x.key_nber,
                                             NVL (x.icdu, 0)
                                             - NVL (x.icda, 0),
                                             x.sad_top_cod)
                                             icd_dt,
                                         pkg_reporte.tipocambio (
                                             pkg_reporte.fecha_vencimiento (
                                                 x.key_cuo,
                                                 TO_CHAR (x.sad_reg_date,
                                                          'dd/mm/yyyy')),
                                             'UFV')
                                             tc_ufvfecvenc,
                                         pkg_reporte.tipocambio (
                                             TRUNC (SYSDATE),
                                             'UFV')
                                             tc_ufvhoy,
                                         x.gau - x.gaa to_ga,
                                         x.ivau - x.ivaa to_iva,
                                         x.iceu - x.icea to_ice,
                                         x.iehdu - x.iehda to_iehd,
                                         x.icdu - x.icda to_icd
                                  FROM   (  SELECT   u.sad_reg_year,
                                                     u.key_cuo,
                                                     u.sad_reg_nber,
                                                     u.sad_reg_date,
                                                     u.key_year,
                                                     u.key_dec,
                                                     u.key_nber,
                                                     u.sad_top_cod,
                                                     SUM (
                                                         gau.saditm_tax_amount)
                                                         gau,
                                                     SUM (
                                                         gaa.saditm_tax_amount)
                                                         gaa,
                                                     SUM(ivau.saditm_tax_amount)
                                                         ivau,
                                                     SUM(ivaa.saditm_tax_amount)
                                                         ivaa,
                                                     SUM(NVL (
                                                             iceu.saditm_tax_amount,
                                                             0))
                                                         iceu,
                                                     SUM(NVL (
                                                             icea.saditm_tax_amount,
                                                             0))
                                                         icea,
                                                     SUM(NVL (
                                                             iehdu.saditm_tax_amount,
                                                             0))
                                                         iehdu,
                                                     SUM(NVL (
                                                             iehda.saditm_tax_amount,
                                                             0))
                                                         iehda,
                                                     SUM(NVL (
                                                             icdu.saditm_tax_amount,
                                                             0))
                                                         icdu,
                                                     SUM(NVL (
                                                             icda.saditm_tax_amount,
                                                             0))
                                                         icda
                                              FROM   ops$asy.sad_gen u,
                                                     ops$asy.sad_gen a,
                                                     ops$asy.sad_itm iu,
                                                     ops$asy.sad_itm ia,
                                                     ops$asy.sad_tax gau,
                                                     ops$asy.sad_tax gaa,
                                                     ops$asy.sad_tax ivau,
                                                     ops$asy.sad_tax ivaa,
                                                     ops$asy.sad_tax iceu,
                                                     ops$asy.sad_tax icea,
                                                     ops$asy.sad_tax iehdu,
                                                     ops$asy.sad_tax iehda,
                                                     ops$asy.sad_tax icdu,
                                                     ops$asy.sad_tax icda,
                                                     fis_alcance f,
                                                     fis_notificacion n
                                             WHERE   u.key_year = a.key_year
                                                     AND u.key_cuo = a.key_cuo
                                                     AND u.key_dec IS NOT NULL
                                                     AND u.key_dec = a.key_dec
                                                     AND u.key_nber =
                                                            a.key_nber
                                                     AND a.sad_num =
                                                            NVL (
                                                                (SELECT   MAX(x.sad_pst_num)
                                                                   FROM   ops$asy.sad_gen x
                                                                  WHERE   x.key_cuo =
                                                                              u.key_cuo
                                                                          AND x.sad_reg_year =
                                                                                 u.sad_reg_year
                                                                          AND x.sad_reg_serial =
                                                                                 u.sad_reg_serial
                                                                          AND x.sad_reg_nber =
                                                                                 u.sad_reg_nber
                                                                          AND x.sad_pst_dat <=
                                                                                 n.not_fecha_notificacion),
                                                                0)
                                                     AND u.sad_flw = 1
                                                     AND u.sad_num = 0
                                                     AND u.lst_ope = 'U'
                                                     AND u.key_year =
                                                            iu.key_year
                                                     AND u.key_cuo = iu.key_cuo
                                                     AND u.key_dec = iu.key_dec
                                                     AND u.key_nber =
                                                            iu.key_nber
                                                     AND u.sad_num = iu.sad_num
                                                     AND a.key_year =
                                                            ia.key_year
                                                     AND a.key_cuo = ia.key_cuo
                                                     AND a.key_dec = ia.key_dec
                                                     AND a.key_nber =
                                                            ia.key_nber
                                                     AND a.sad_num = ia.sad_num
                                                     AND iu.key_year =
                                                            ia.key_year
                                                     AND iu.key_cuo =
                                                            ia.key_cuo
                                                     AND iu.key_dec =
                                                            ia.key_dec
                                                     AND iu.key_nber =
                                                            ia.key_nber
                                                     AND iu.itm_nber =
                                                            ia.itm_nber
                                                     --tributo GA
                                                     AND iu.key_year =
                                                            gau.key_year
                                                     AND iu.key_cuo =
                                                            gau.key_cuo
                                                     AND iu.key_dec =
                                                            gau.key_dec
                                                     AND iu.key_nber =
                                                            gau.key_nber
                                                     AND iu.itm_nber =
                                                            gau.itm_nber
                                                     AND iu.sad_num =
                                                            gau.sad_num
                                                     AND gau.saditm_tax_code =
                                                            'GA'
                                                     AND ia.key_year =
                                                            gaa.key_year
                                                     AND ia.key_cuo =
                                                            gaa.key_cuo
                                                     AND ia.key_dec =
                                                            gaa.key_dec
                                                     AND ia.key_nber =
                                                            gaa.key_nber
                                                     AND ia.itm_nber =
                                                            gaa.itm_nber
                                                     AND ia.sad_num =
                                                            gaa.sad_num
                                                     AND gaa.saditm_tax_code =
                                                            'GA'
                                                     --tributo IVA
                                                     AND iu.key_year =
                                                            ivau.key_year
                                                     AND iu.key_cuo =
                                                            ivau.key_cuo
                                                     AND iu.key_dec =
                                                            ivau.key_dec
                                                     AND iu.key_nber =
                                                            ivau.key_nber
                                                     AND iu.itm_nber =
                                                            ivau.itm_nber
                                                     AND iu.sad_num =
                                                            ivau.sad_num
                                                     AND ivau.saditm_tax_code =
                                                            'IVA'
                                                     AND ia.key_year =
                                                            ivaa.key_year
                                                     AND ia.key_cuo =
                                                            ivaa.key_cuo
                                                     AND ia.key_dec =
                                                            ivaa.key_dec
                                                     AND ia.key_nber =
                                                            ivaa.key_nber
                                                     AND ia.itm_nber =
                                                            ivaa.itm_nber
                                                     AND ia.sad_num =
                                                            ivaa.sad_num
                                                     AND ivaa.saditm_tax_code =
                                                            'IVA'
                                                     --tributo ICE
                                                     AND iu.key_year =
                                                            iceu.key_year(+)
                                                     AND iu.key_cuo =
                                                            iceu.key_cuo(+)
                                                     AND iu.key_dec =
                                                            iceu.key_dec(+)
                                                     AND iu.key_nber =
                                                            iceu.key_nber(+)
                                                     AND iu.itm_nber =
                                                            iceu.itm_nber(+)
                                                     AND iu.sad_num =
                                                            iceu.sad_num(+)
                                                     AND iceu.saditm_tax_code(+) =
                                                            'ICE'
                                                     AND ia.key_year =
                                                            icea.key_year(+)
                                                     AND ia.key_cuo =
                                                            icea.key_cuo(+)
                                                     AND ia.key_dec =
                                                            icea.key_dec(+)
                                                     AND ia.key_nber =
                                                            icea.key_nber(+)
                                                     AND ia.itm_nber =
                                                            icea.itm_nber(+)
                                                     AND ia.sad_num =
                                                            icea.sad_num(+)
                                                     AND icea.saditm_tax_code(+) =
                                                            'ICE'
                                                     --tributo IEHD
                                                     AND iu.key_year =
                                                            iehdu.key_year(+)
                                                     AND iu.key_cuo =
                                                            iehdu.key_cuo(+)
                                                     AND iu.key_dec =
                                                            iehdu.key_dec(+)
                                                     AND iu.key_nber =
                                                            iehdu.key_nber(+)
                                                     AND iu.itm_nber =
                                                            iehdu.itm_nber(+)
                                                     AND iu.sad_num =
                                                            iehdu.sad_num(+)
                                                     AND iehdu.saditm_tax_code(+) =
                                                            'IEHD'
                                                     AND ia.key_year =
                                                            iehda.key_year(+)
                                                     AND ia.key_cuo =
                                                            iehda.key_cuo(+)
                                                     AND ia.key_dec =
                                                            iehda.key_dec(+)
                                                     AND ia.key_nber =
                                                            iehda.key_nber(+)
                                                     AND ia.itm_nber =
                                                            iehda.itm_nber(+)
                                                     AND ia.sad_num =
                                                            iehda.sad_num(+)
                                                     AND iehda.saditm_tax_code(+) =
                                                            'IEHD'
                                                     --tributo ICD
                                                     AND iu.key_year =
                                                            icdu.key_year(+)
                                                     AND iu.key_cuo =
                                                            icdu.key_cuo(+)
                                                     AND iu.key_dec =
                                                            icdu.key_dec(+)
                                                     AND iu.key_nber =
                                                            icdu.key_nber(+)
                                                     AND iu.itm_nber =
                                                            icdu.itm_nber(+)
                                                     AND iu.sad_num =
                                                            icdu.sad_num(+)
                                                     AND icdu.saditm_tax_code(+) =
                                                            'ICD'
                                                     AND ia.key_year =
                                                            icda.key_year(+)
                                                     AND ia.key_cuo =
                                                            icda.key_cuo(+)
                                                     AND ia.key_dec =
                                                            icda.key_dec(+)
                                                     AND ia.key_nber =
                                                            icda.key_nber(+)
                                                     AND ia.itm_nber =
                                                            icda.itm_nber(+)
                                                     AND ia.sad_num =
                                                            icda.sad_num(+)
                                                     AND icda.saditm_tax_code(+) =
                                                            'ICD'
                                                     --para recuperar informacion del control
                                                     AND f.alc_tipo_tramite =
                                                            'DUI'
                                                     AND f.alc_gestion =
                                                            u.sad_reg_year
                                                     AND f.alc_aduana =
                                                            u.key_cuo
                                                     AND u.sad_reg_serial = 'C'
                                                     AND f.alc_numero =
                                                            u.sad_reg_nber
                                                     AND f.ctl_control_id =
                                                            prm_codigo
                                                     AND f.alc_num = 0
                                                     AND f.alc_lstope = 'U'
                                                     AND f.ctl_control_id =
                                                            n.ctl_control_id
                                                     AND n.not_num = 0
                                                     AND n.not_lstope = 'U'
                                          GROUP BY   u.sad_reg_year,
                                                     u.key_cuo,
                                                     u.sad_reg_nber,
                                                     u.sad_reg_date,
                                                     u.key_year,
                                                     u.key_dec,
                                                     u.key_nber,
                                                     u.sad_top_cod
                                          UNION
                                            SELECT   u.sad_reg_year,
                                                     u.key_cuo,
                                                     u.sad_reg_nber,
                                                     u.sad_reg_date,
                                                     u.key_year,
                                                     u.key_dec,
                                                     u.key_nber,
                                                     u.sad_top_cod,
                                                     SUM (
                                                         gau.saditm_tax_amount)
                                                         gau,
                                                     SUM (
                                                         gaa.saditm_tax_amount)
                                                         gaa,
                                                     SUM(ivau.saditm_tax_amount)
                                                         ivau,
                                                     SUM(ivaa.saditm_tax_amount)
                                                         ivaa,
                                                     SUM(NVL (
                                                             iceu.saditm_tax_amount,
                                                             0))
                                                         iceu,
                                                     SUM(NVL (
                                                             icea.saditm_tax_amount,
                                                             0))
                                                         icea,
                                                     SUM(NVL (
                                                             iehdu.saditm_tax_amount,
                                                             0))
                                                         iehdu,
                                                     SUM(NVL (
                                                             iehda.saditm_tax_amount,
                                                             0))
                                                         iehda,
                                                     SUM(NVL (
                                                             icdu.saditm_tax_amount,
                                                             0))
                                                         icdu,
                                                     SUM(NVL (
                                                             icda.saditm_tax_amount,
                                                             0))
                                                         icda
                                              FROM   ops$asy.sad_gen u,
                                                     ops$asy.sad_gen a,
                                                     ops$asy.sad_itm iu,
                                                     ops$asy.sad_itm ia,
                                                     ops$asy.sad_tax gau,
                                                     ops$asy.sad_tax gaa,
                                                     ops$asy.sad_tax ivau,
                                                     ops$asy.sad_tax ivaa,
                                                     ops$asy.sad_tax iceu,
                                                     ops$asy.sad_tax icea,
                                                     ops$asy.sad_tax iehdu,
                                                     ops$asy.sad_tax iehda,
                                                     ops$asy.sad_tax icdu,
                                                     ops$asy.sad_tax icda,
                                                     fis_alcance f,
                                                     fis_notificacion n
                                             WHERE   u.key_year = a.key_year
                                                     AND u.key_cuo = a.key_cuo
                                                     AND u.key_dec IS NULL
                                                     AND a.key_dec IS NULL
                                                     AND u.key_nber =
                                                            a.key_nber
                                                     AND a.sad_num =
                                                            NVL (
                                                                (SELECT   MAX(x.sad_pst_num)
                                                                   FROM   ops$asy.sad_gen x
                                                                  WHERE   x.key_cuo =
                                                                              u.key_cuo
                                                                          AND x.sad_reg_year =
                                                                                 u.sad_reg_year
                                                                          AND x.sad_reg_serial =
                                                                                 u.sad_reg_serial
                                                                          AND x.sad_reg_nber =
                                                                                 u.sad_reg_nber
                                                                          AND x.sad_pst_dat <=
                                                                                 n.not_fecha_notificacion),
                                                                0)
                                                     AND u.sad_flw = 1
                                                     AND u.sad_num = 0
                                                     AND u.lst_ope = 'U'
                                                     AND u.key_year =
                                                            iu.key_year
                                                     AND u.key_cuo = iu.key_cuo
                                                     AND iu.key_dec IS NULL
                                                     AND u.key_nber =
                                                            iu.key_nber
                                                     AND u.sad_num = iu.sad_num
                                                     AND a.key_year =
                                                            ia.key_year
                                                     AND a.key_cuo = ia.key_cuo
                                                     AND ia.key_dec IS NULL
                                                     AND a.key_nber =
                                                            ia.key_nber
                                                     AND a.sad_num = ia.sad_num
                                                     AND iu.key_year =
                                                            ia.key_year
                                                     AND iu.key_cuo =
                                                            ia.key_cuo
                                                     AND iu.key_nber =
                                                            ia.key_nber
                                                     AND iu.itm_nber =
                                                            ia.itm_nber
                                                     --tributo GA
                                                     AND iu.key_year =
                                                            gau.key_year
                                                     AND iu.key_cuo =
                                                            gau.key_cuo
                                                     AND gau.key_dec IS NULL
                                                     AND iu.key_nber =
                                                            gau.key_nber
                                                     AND iu.itm_nber =
                                                            gau.itm_nber
                                                     AND iu.sad_num =
                                                            gau.sad_num
                                                     AND gau.saditm_tax_code =
                                                            'GA'
                                                     AND ia.key_year =
                                                            gaa.key_year
                                                     AND ia.key_cuo =
                                                            gaa.key_cuo
                                                     AND gaa.key_dec IS NULL
                                                     AND ia.key_nber =
                                                            gaa.key_nber
                                                     AND ia.itm_nber =
                                                            gaa.itm_nber
                                                     AND ia.sad_num =
                                                            gaa.sad_num
                                                     AND gaa.saditm_tax_code =
                                                            'GA'
                                                     --tributo IVA
                                                     AND iu.key_year =
                                                            ivau.key_year
                                                     AND iu.key_cuo =
                                                            ivau.key_cuo
                                                     AND ivau.key_dec IS NULL
                                                     AND iu.key_nber =
                                                            ivau.key_nber
                                                     AND iu.itm_nber =
                                                            ivau.itm_nber
                                                     AND iu.sad_num =
                                                            ivau.sad_num
                                                     AND ivau.saditm_tax_code =
                                                            'IVA'
                                                     AND ia.key_year =
                                                            ivaa.key_year
                                                     AND ia.key_cuo =
                                                            ivaa.key_cuo
                                                     AND ivaa.key_dec IS NULL
                                                     AND ia.key_nber =
                                                            ivaa.key_nber
                                                     AND ia.itm_nber =
                                                            ivaa.itm_nber
                                                     AND ia.sad_num =
                                                            ivaa.sad_num
                                                     AND ivaa.saditm_tax_code =
                                                            'IVA'
                                                     --tributo ICE
                                                     AND iu.key_year =
                                                            iceu.key_year(+)
                                                     AND iu.key_cuo =
                                                            iceu.key_cuo(+)
                                                     AND iu.key_dec =
                                                            iceu.key_dec(+)
                                                     AND iceu.key_nber(+) IS NULL
                                                     AND iu.itm_nber =
                                                            iceu.itm_nber(+)
                                                     AND iu.sad_num =
                                                            iceu.sad_num(+)
                                                     AND iceu.saditm_tax_code(+) =
                                                            'ICE'
                                                     AND ia.key_year =
                                                            icea.key_year(+)
                                                     AND ia.key_cuo =
                                                            icea.key_cuo(+)
                                                     AND icea.key_dec(+) IS NULL
                                                     AND ia.key_nber =
                                                            icea.key_nber(+)
                                                     AND ia.itm_nber =
                                                            icea.itm_nber(+)
                                                     AND ia.sad_num =
                                                            icea.sad_num(+)
                                                     AND icea.saditm_tax_code(+) =
                                                            'ICE'
                                                     --tributo IEHD
                                                     AND iu.key_year =
                                                            iehdu.key_year(+)
                                                     AND iu.key_cuo =
                                                            iehdu.key_cuo(+)
                                                     AND iehdu.key_dec(+) IS NULL
                                                     AND iu.key_nber =
                                                            iehdu.key_nber(+)
                                                     AND iu.itm_nber =
                                                            iehdu.itm_nber(+)
                                                     AND iu.sad_num =
                                                            iehdu.sad_num(+)
                                                     AND iehdu.saditm_tax_code(+) =
                                                            'IEHD'
                                                     AND ia.key_year =
                                                            iehda.key_year(+)
                                                     AND ia.key_cuo =
                                                            iehda.key_cuo(+)
                                                     AND iehda.key_dec(+) IS NULL
                                                     AND ia.key_nber =
                                                            iehda.key_nber(+)
                                                     AND ia.itm_nber =
                                                            iehda.itm_nber(+)
                                                     AND ia.sad_num =
                                                            iehda.sad_num(+)
                                                     AND iehda.saditm_tax_code(+) =
                                                            'IEHD'
                                                     --tributo ICD
                                                     AND iu.key_year =
                                                            icdu.key_year(+)
                                                     AND iu.key_cuo =
                                                            icdu.key_cuo(+)
                                                     AND icdu.key_dec(+) IS NULL
                                                     AND iu.key_nber =
                                                            icdu.key_nber(+)
                                                     AND iu.itm_nber =
                                                            icdu.itm_nber(+)
                                                     AND iu.sad_num =
                                                            icdu.sad_num(+)
                                                     AND icdu.saditm_tax_code(+) =
                                                            'ICD'
                                                     AND ia.key_year =
                                                            icda.key_year(+)
                                                     AND ia.key_cuo =
                                                            icda.key_cuo(+)
                                                     AND icda.key_dec(+) IS NULL
                                                     AND ia.key_nber =
                                                            icda.key_nber(+)
                                                     AND ia.itm_nber =
                                                            icda.itm_nber(+)
                                                     AND ia.sad_num =
                                                            icda.sad_num(+)
                                                     AND icda.saditm_tax_code(+) =
                                                            'ICD'
                                                     --para recuperar informacion del control
                                                     AND f.alc_tipo_tramite =
                                                            'DUI'
                                                     AND f.alc_gestion =
                                                            u.sad_reg_year
                                                     AND f.alc_aduana =
                                                            u.key_cuo
                                                     AND u.sad_reg_serial = 'C'
                                                     AND f.alc_numero =
                                                            u.sad_reg_nber
                                                     AND f.ctl_control_id =
                                                            prm_codigo
                                                     AND f.alc_num = 0
                                                     AND f.alc_lstope = 'U'
                                                     AND f.ctl_control_id =
                                                            n.ctl_control_id
                                                     AND n.not_num = 0
                                                     AND n.not_lstope = 'U'
                                          GROUP BY   u.sad_reg_year,
                                                     u.key_cuo,
                                                     u.sad_reg_nber,
                                                     u.sad_reg_date,
                                                     u.key_year,
                                                     u.key_dec,
                                                     u.key_nber,
                                                     u.sad_top_cod) x) t) d;

        RETURN ct;
    END;



    FUNCTION devuelve_liquidacion (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT   iu.itm_nber,
                     ia.saditm_hs_cod || ia.saditm_hsprec_cod nandina_ant,
                     u.sad_reg_year,
                     u.key_cuo,
                     'C',
                     u.sad_reg_nber,
                     TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy') fecval,
                     TO_CHAR (a.sad_reg_date + 3, 'dd/mm/yyyy') fecvven,
                     a.sad_tot_invoiced fob$_ant,
                     a.sad_stat_val cif_ant,
                     gaa.saditm_tax_amount ga_a,
                     iva.saditm_tax_amount iva_a,
                     NVL (icu.saditm_tax_amount, 0),
                     iu.saditm_hs_cod || iu.saditm_hsprec_cod nandina_u,
                     u.sad_tot_invoiced fob$_u,
                     u.sad_stat_val cif_u,
                     gau.saditm_tax_amount ga_u,
                     ivu.saditm_tax_amount iva_u
              FROM   fis_alcance f,
                     ops$asy.sad_gen u,
                     ops$asy.sad_gen a,
                     ops$asy.sad_itm iu,
                     ops$asy.sad_itm ia,
                     ops$asy.sad_tax gau,
                     ops$asy.sad_tax gaa,
                     ops$asy.sad_tax ivu,
                     ops$asy.sad_tax iva,
                     ops$asy.sad_tax icu,
                     ops$asy.sad_tax ica
             WHERE       u.key_year = a.key_year
                     AND u.key_cuo = a.key_cuo
                     AND u.key_dec = a.key_dec
                     AND u.key_nber = a.key_nber
                     AND a.sad_num =
                            (SELECT   MAX (t.sad_num)
                               FROM   ops$asy.sad_gen t
                              WHERE       t.key_year = u.key_year
                                      AND t.key_cuo = u.key_cuo
                                      AND t.key_dec = u.key_dec
                                      AND t.key_nber = u.key_nber)
                     AND u.key_year = iu.key_year
                     AND u.key_cuo = iu.key_cuo
                     AND u.key_dec = iu.key_dec
                     AND u.key_nber = iu.key_nber
                     AND u.sad_num = iu.sad_num
                     AND a.key_year = ia.key_year
                     AND a.key_cuo = ia.key_cuo
                     AND a.key_dec = ia.key_dec
                     AND a.key_nber = ia.key_nber
                     AND a.sad_num = ia.sad_num
                     AND iu.key_year = ia.key_year
                     AND iu.key_cuo = ia.key_cuo
                     AND iu.key_dec = ia.key_dec
                     AND iu.key_nber = ia.key_nber
                     AND iu.itm_nber = ia.itm_nber
                     AND iu.key_year = gau.key_year
                     AND iu.key_cuo = gau.key_cuo
                     AND iu.key_dec = gau.key_dec
                     AND iu.key_nber = gau.key_nber
                     AND iu.itm_nber = gau.itm_nber
                     AND iu.sad_num = gau.sad_num
                     AND gau.saditm_tax_code = 'GA'
                     AND ia.key_year = gaa.key_year
                     AND ia.key_cuo = gaa.key_cuo
                     AND ia.key_dec = gaa.key_dec
                     AND ia.key_nber = gaa.key_nber
                     AND ia.itm_nber = gaa.itm_nber
                     AND ia.sad_num = gaa.sad_num
                     AND gaa.saditm_tax_code = 'GA'
                     AND iu.key_year = ivu.key_year
                     AND iu.key_cuo = ivu.key_cuo
                     AND iu.key_dec = ivu.key_dec
                     AND iu.key_nber = ivu.key_nber
                     AND iu.itm_nber = ivu.itm_nber
                     AND iu.sad_num = ivu.sad_num
                     AND ivu.saditm_tax_code = 'IVA'
                     AND ia.key_year = iva.key_year
                     AND ia.key_cuo = iva.key_cuo
                     AND ia.key_dec = iva.key_dec
                     AND ia.key_nber = iva.key_nber
                     AND ia.itm_nber = iva.itm_nber
                     AND ia.sad_num = iva.sad_num
                     AND iva.saditm_tax_code = 'IVA'
                     AND iu.key_year = icu.key_year(+)
                     AND iu.key_cuo = icu.key_cuo(+)
                     AND iu.key_dec = icu.key_dec(+)
                     AND iu.key_nber = icu.key_nber(+)
                     AND iu.itm_nber = icu.itm_nber(+)
                     AND iu.sad_num = icu.sad_num(+)
                     AND icu.saditm_tax_code(+) = 'ICE'
                     AND ia.key_year = ica.key_year(+)
                     AND ia.key_cuo = ica.key_cuo(+)
                     AND ia.key_dec = ica.key_dec(+)
                     AND ia.key_nber = ica.key_nber(+)
                     AND ia.itm_nber = ica.itm_nber(+)
                     AND ia.sad_num = ica.sad_num(+)
                     AND ica.saditm_tax_code(+) = 'ICE'
                     AND u.sad_flw = 1
                     AND u.sad_num = 0
                     AND u.lst_ope = 'U'
                     AND u.key_dec IS NOT NULL
                     AND f.alc_tipo_tramite = 'DUI'
                     AND f.alc_gestion = u.sad_reg_year
                     AND f.alc_aduana = u.key_cuo
                     AND u.sad_reg_serial = 'C'
                     AND f.alc_numero = u.sad_reg_nber
                     AND f.ctl_control_id = prm_codigo
            UNION
            SELECT   iu.itm_nber,
                     ia.saditm_hs_cod || ia.saditm_hsprec_cod nandina_ant,
                     u.sad_reg_year,
                     u.key_cuo,
                     'C',
                     u.sad_reg_nber,
                     TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy') fecval,
                     TO_CHAR (a.sad_reg_date + 3, 'dd/mm/yyyy') fecvven,
                     a.sad_tot_invoiced fob$_ant,
                     a.sad_stat_val cif_ant,
                     gaa.saditm_tax_amount ga_a,
                     iva.saditm_tax_amount iva_a,
                     NVL (icu.saditm_tax_amount, 0),
                     iu.saditm_hs_cod || iu.saditm_hsprec_cod nandina_u,
                     u.sad_tot_invoiced fob$_u,
                     u.sad_stat_val cif_u,
                     gau.saditm_tax_amount ga_u,
                     ivu.saditm_tax_amount iva_u
              FROM   fis_alcance f,
                     ops$asy.sad_gen u,
                     ops$asy.sad_gen a,
                     ops$asy.sad_itm iu,
                     ops$asy.sad_itm ia,
                     ops$asy.sad_tax gau,
                     ops$asy.sad_tax gaa,
                     ops$asy.sad_tax ivu,
                     ops$asy.sad_tax iva,
                     ops$asy.sad_tax icu,
                     ops$asy.sad_tax ica
             WHERE       u.key_year = a.key_year
                     AND u.key_cuo = a.key_cuo
                     AND u.key_dec IS NULL
                     AND a.key_dec IS NULL
                     AND u.key_nber = a.key_nber
                     AND a.sad_num =
                            (SELECT   MAX (t.sad_num)
                               FROM   ops$asy.sad_gen t
                              WHERE       t.key_year = u.key_year
                                      AND t.key_cuo = u.key_cuo
                                      AND t.key_dec = u.key_dec
                                      AND t.key_nber = u.key_nber)
                     AND u.key_year = iu.key_year
                     AND u.key_cuo = iu.key_cuo
                     AND iu.key_dec IS NULL
                     AND u.key_nber = iu.key_nber
                     AND u.sad_num = iu.sad_num
                     AND a.key_year = ia.key_year
                     AND a.key_cuo = ia.key_cuo
                     AND ia.key_dec IS NULL
                     AND a.key_nber = ia.key_nber
                     AND a.sad_num = ia.sad_num
                     AND iu.key_year = ia.key_year
                     AND iu.key_cuo = ia.key_cuo
                     AND iu.key_nber = ia.key_nber
                     AND iu.itm_nber = ia.itm_nber
                     AND iu.key_year = gau.key_year
                     AND iu.key_cuo = gau.key_cuo
                     AND gau.key_dec IS NULL
                     AND iu.key_nber = gau.key_nber
                     AND iu.itm_nber = gau.itm_nber
                     AND iu.sad_num = gau.sad_num
                     AND gau.saditm_tax_code = 'GA'
                     AND ia.key_year = gaa.key_year
                     AND ia.key_cuo = gaa.key_cuo
                     AND gaa.key_dec IS NULL
                     AND ia.key_nber = gaa.key_nber
                     AND ia.itm_nber = gaa.itm_nber
                     AND ia.sad_num = gaa.sad_num
                     AND gaa.saditm_tax_code = 'GA'
                     AND iu.key_year = ivu.key_year
                     AND iu.key_cuo = ivu.key_cuo
                     AND ivu.key_dec IS NULL
                     AND iu.key_nber = ivu.key_nber
                     AND iu.itm_nber = ivu.itm_nber
                     AND iu.sad_num = ivu.sad_num
                     AND ivu.saditm_tax_code = 'IVA'
                     AND ia.key_year = iva.key_year
                     AND ia.key_cuo = iva.key_cuo
                     AND iva.key_dec IS NULL
                     AND ia.key_nber = iva.key_nber
                     AND ia.itm_nber = iva.itm_nber
                     AND ia.sad_num = iva.sad_num
                     AND iva.saditm_tax_code = 'IVA'
                     AND iu.key_year = icu.key_year(+)
                     AND iu.key_cuo = icu.key_cuo(+)
                     AND icu.key_dec(+) IS NULL
                     AND iu.key_nber = icu.key_nber(+)
                     AND iu.itm_nber = icu.itm_nber(+)
                     AND iu.sad_num = icu.sad_num(+)
                     AND icu.saditm_tax_code(+) = 'ICE'
                     AND ia.key_year = ica.key_year(+)
                     AND ia.key_cuo = ica.key_cuo(+)
                     AND ica.key_dec(+) IS NULL
                     AND ia.key_nber = ica.key_nber(+)
                     AND ia.itm_nber = ica.itm_nber(+)
                     AND ia.sad_num = ica.sad_num(+)
                     AND ica.saditm_tax_code(+) = 'ICE'
                     AND u.sad_flw = 1
                     AND u.sad_num = 0
                     AND u.lst_ope = 'U'
                     AND f.alc_tipo_tramite = 'DUI'
                     AND f.alc_gestion = u.sad_reg_year
                     AND f.alc_aduana = u.key_cuo
                     AND u.sad_reg_serial = 'C'
                     AND f.alc_numero = u.sad_reg_nber
                     AND f.ctl_control_id = prm_codigo
            ORDER BY   3,
                       4,
                       6,
                       1;

        RETURN ct;
    END;



    FUNCTION devuelve_liquidacion2 (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT                                                         --1
                  t  .itm,
                     t.nandina_ant,
                     t.nandina_u,
                     t.reg_year,
                     t.key_cuo,
                     t.reg_nber,
                     t.fecha_reg,
                     t.fecha_venc,
                     t.fecha_calculo,
                     --10
                     t.dec_fob,
                     t.dec_flete,
                     t.dec_seguro,
                     t.dec_otros,
                     t.dec_cifusd,
                     t.dec_tc,
                     t.dec_cifbs,
                     t.dec_ga,
                     t.dec_iva,
                     t.dec_ice,
                     --20
                     t.dec_iehd,
                     t.dec_icd,
                     --22
                     t.enc_fob,
                     t.enc_flete,
                     t.enc_seguro,
                     t.enc_otros,
                     t.enc_cifusd,
                     t.enc_tc,
                     t.enc_cifbs,
                     t.enc_ga,
                     --30
                     t.enc_iva,
                     t.enc_ice,
                     t.enc_iehd,
                     t.enc_icd,
                     --34
                     t.tc_ufvfecvenc,
                     t.to_ga,
                     t.to_iva,
                     t.to_ice,
                     t.to_iehd,
                     t.to_icd,
                     --40
                     t.to_ga + t.to_iva + t.to_ice + t.to_iehd + t.to_icd
                         to_total,
                     --41
                     ROUND (t.to_ga * t.tc_ufvfecvenc, 2) toufv_ga,
                     ROUND (t.to_iva * t.tc_ufvfecvenc, 2) toufv_iva,
                     ROUND (t.to_ice * t.tc_ufvfecvenc, 2) toufv_ice,
                     ROUND (t.to_iehd * t.tc_ufvfecvenc, 2) toufv_iehd,
                     ROUND (t.to_icd * t.tc_ufvfecvenc, 2) toufv_icd,
                     ROUND (
                         (  t.to_ga
                          + t.to_iva
                          + t.to_ice
                          + t.to_iehd
                          + t.to_icd)
                         * t.tc_ufvfecvenc,
                         2)
                         toufv_total,
                     t.dias,
                     ROUND (POWER (1 + (t.tc_tprfecvenc / 360), t.dias), 4)
                         formula,
                     ROUND (t.ga_dt * t.tc_ufvfecvenc, 2)
                     - ROUND (t.to_ga * t.tc_ufvfecvenc, 2)
                         itufv_ga,
                     --50
                     ROUND (t.to_iva * t.tc_ufvfecvenc, 2)
                     - ROUND (t.iva_dt * t.tc_ufvfecvenc, 2)
                         itufv_iva,
                     ROUND (t.to_ice * t.tc_ufvfecvenc, 2)
                     - ROUND (t.ice_dt * t.tc_ufvfecvenc, 2)
                         itufv_ice,
                     ROUND (t.to_iehd * t.tc_ufvfecvenc, 2)
                     - ROUND (t.iehd_dt * t.tc_ufvfecvenc, 2)
                         itufv_iehd,
                     ROUND (t.to_icd * t.tc_ufvfecvenc, 2)
                     - ROUND (t.icd_dt * t.tc_ufvfecvenc, 2)
                         itufv_icd,
                     (ROUND (
                          (  t.to_ga
                           + t.to_iva
                           + t.to_ice
                           + t.to_iehd
                           + t.to_icd)
                          * t.tc_ufvfecvenc,
                          2)
                      - ROUND (
                            (  t.ga_dt
                             + t.iva_dt
                             + t.ice_dt
                             + t.iehd_dt
                             + t.icd_dt)
                            * t.tc_ufvfecvenc,
                            2))
                         itufv_total,
                     --55
                     ROUND (t.ga_dt * t.tc_ufvfecvenc, 2) dt_ga,
                     ROUND (t.iva_dt * t.tc_ufvfecvenc, 2) dt_iva,
                     ROUND (t.ice_dt * t.tc_ufvfecvenc, 2) dt_ice,
                     ROUND (t.iehd_dt * t.tc_ufvfecvenc, 2) dt_iehd,
                     ROUND (t.icd_dt * t.tc_ufvfecvenc, 2) dt_icd,
                     --60
                     ROUND (
                         (  t.ga_dt
                          + t.iva_dt
                          + t.ice_dt
                          + t.iehd_dt
                          + t.icd_dt)
                         * t.tc_ufvfecvenc,
                         2)
                         dt_total,
                     --61
                     ( (t.to_ga + t.to_iva + t.to_ice + t.to_iehd + t.to_icd)
                      / t.tc_ufvhoy)
                     * t.tc_ufvfecvenc
                         sancion,
                     --62
                     ROUND (
                         t.ga_dt + t.iva_dt + t.ice_dt + t.iehd_dt + t.icd_dt,
                         2)
                         adeudo_totalbs,
                     --63
                     ROUND (
                         (  t.ga_dt
                          + t.iva_dt
                          + t.ice_dt
                          + t.iehd_dt
                          + t.icd_dt)
                         * t.tc_ufvhoy,
                         2)
                         adeudo_totalufv
              FROM   (SELECT   iu.itm_nber itm,
                               ia.saditm_hs_cod || ia.saditm_hsprec_cod
                                   nandina_ant,
                               iu.saditm_hs_cod || iu.saditm_hsprec_cod
                                   nandina_u,
                               u.sad_reg_year reg_year,
                               u.key_cuo key_cuo,
                               u.sad_reg_nber reg_nber,
                               TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                   fecha_reg,
                               TO_CHAR (
                                   pkg_reporte.fecha_vencimiento (
                                       u.key_cuo,
                                       TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                   'dd/mm/yyyy')
                                   fecha_venc,
                               TO_CHAR (SYSDATE, 'dd/mm/yyyy') fecha_calculo,
                               va.sad_iitminv_valc dec_fob,
                               va.sad_iitmefr_valc dec_flete,
                               va.sad_iitmins_valc dec_seguro,
                               va.sad_iitmotc_valc dec_otros,
                               ROUND (
                                   va.sad_iitmcif_valn / va.sad_iitminv_rat,
                                   2)
                                   dec_cifusd,
                               va.sad_iitminv_rat dec_tc,
                               va.sad_iitmcif_valn dec_cifbs,
                               gaa.saditm_tax_amount dec_ga,
                               ivaa.saditm_tax_amount dec_iva,
                               NVL (icea.saditm_tax_amount, 0) dec_ice,
                               NVL (iehda.saditm_tax_amount, 0) dec_iehd,
                               NVL (icda.saditm_tax_amount, 0) dec_icd,
                               vu.sad_iitminv_valc enc_fob,
                               vu.sad_iitmefr_valc enc_flete,
                               vu.sad_iitmins_valc enc_seguro,
                               vu.sad_iitmotc_valc enc_otros,
                               ROUND (
                                   vu.sad_iitmcif_valn / vu.sad_iitminv_rat,
                                   2)
                                   enc_cifusd,
                               vu.sad_iitminv_rat enc_tc,
                               vu.sad_iitmcif_valn enc_cifbs,
                               gau.saditm_tax_amount enc_ga,
                               ivau.saditm_tax_amount enc_iva,
                               NVL (iceu.saditm_tax_amount, 0) enc_ice,
                               NVL (iehdu.saditm_tax_amount, 0) enc_iehd,
                               NVL (icdu.saditm_tax_amount, 0) enc_icd,
                               pkg_reporte.tipocambio (
                                   pkg_reporte.fecha_vencimiento (
                                       u.key_cuo,
                                       TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                   'UFV')
                                   tc_ufvfecvenc,
                               pkg_reporte.tipocambio (TRUNC (SYSDATE),
                                                       'UFV')
                                   tc_ufvhoy,
                               gau.saditm_tax_amount - gaa.saditm_tax_amount
                                   to_ga,
                               ivau.saditm_tax_amount
                               - ivaa.saditm_tax_amount
                                   to_iva,
                               NVL (iceu.saditm_tax_amount, 0)
                               - NVL (icea.saditm_tax_amount, 0)
                                   to_ice,
                               NVL (iehdu.saditm_tax_amount, 0)
                               - NVL (iehda.saditm_tax_amount, 0)
                                   to_iehd,
                               NVL (icdu.saditm_tax_amount, 0)
                               - NVL (icda.saditm_tax_amount, 0)
                                   to_icd,
                               TRUNC (SYSDATE)
                               - pkg_reporte.fecha_vencimiento (
                                     u.key_cuo,
                                     TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy'))
                                   dias,
                               pkg_reporte.tipocambio (
                                   pkg_reporte.fecha_vencimiento (
                                       u.key_cuo,
                                       TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                   'TPR')
                                   tc_tprfecvenc,
                               ops$asy.fcalculadeudatributaria (
                                   u.sad_reg_date,
                                   TRUNC (SYSDATE),
                                   u.key_year,
                                   u.key_cuo,
                                   u.key_dec,
                                   u.key_nber,
                                   gau.saditm_tax_amount
                                   - gaa.saditm_tax_amount,
                                   u.sad_top_cod)
                                   ga_dt,
                               ops$asy.fcalculadeudatributaria (
                                   u.sad_reg_date,
                                   TRUNC (SYSDATE),
                                   u.key_year,
                                   u.key_cuo,
                                   u.key_dec,
                                   u.key_nber,
                                   ivau.saditm_tax_amount
                                   - ivaa.saditm_tax_amount,
                                   u.sad_top_cod)
                                   iva_dt,
                               ops$asy.fcalculadeudatributaria (
                                   u.sad_reg_date,
                                   TRUNC (SYSDATE),
                                   u.key_year,
                                   u.key_cuo,
                                   u.key_dec,
                                   u.key_nber,
                                   NVL (iceu.saditm_tax_amount, 0)
                                   - NVL (icea.saditm_tax_amount, 0),
                                   u.sad_top_cod)
                                   ice_dt,
                               ops$asy.fcalculadeudatributaria (
                                   u.sad_reg_date,
                                   TRUNC (SYSDATE),
                                   u.key_year,
                                   u.key_cuo,
                                   u.key_dec,
                                   u.key_nber,
                                   NVL (iehdu.saditm_tax_amount, 0)
                                   - NVL (iehda.saditm_tax_amount, 0),
                                   u.sad_top_cod)
                                   iehd_dt,
                               ops$asy.fcalculadeudatributaria (
                                   u.sad_reg_date,
                                   TRUNC (SYSDATE),
                                   u.key_year,
                                   u.key_cuo,
                                   u.key_dec,
                                   u.key_nber,
                                   NVL (icdu.saditm_tax_amount, 0)
                                   - NVL (icda.saditm_tax_amount, 0),
                                   u.sad_top_cod)
                                   icd_dt
                        FROM   ops$asy.sad_gen u,
                               ops$asy.sad_gen a,
                               ops$asy.sad_itm iu,
                               ops$asy.sad_itm ia,
                               ops$asy.sad_tax gau,
                               ops$asy.sad_tax gaa,
                               ops$asy.sad_tax ivau,
                               ops$asy.sad_tax ivaa,
                               ops$asy.sad_tax iceu,
                               ops$asy.sad_tax icea,
                               ops$asy.sad_tax iehdu,
                               ops$asy.sad_tax iehda,
                               ops$asy.sad_tax icdu,
                               ops$asy.sad_tax icda,
                               ops$asy.sad_itm_vim vu,
                               ops$asy.sad_itm_vim va,
                               fis_alcance f,
                               fis_notificacion n
                       WHERE       u.key_year = a.key_year
                               AND u.key_cuo = a.key_cuo
                               AND u.key_dec IS NOT NULL
                               AND u.key_dec = a.key_dec
                               AND u.key_nber = a.key_nber
                               AND a.sad_num =
                                      NVL (
                                          (SELECT   MAX (x.sad_pst_num)
                                             FROM   ops$asy.sad_gen x
                                            WHERE   x.key_cuo = u.key_cuo
                                                    AND x.sad_reg_year =
                                                           u.sad_reg_year
                                                    AND x.sad_reg_serial =
                                                           u.sad_reg_serial
                                                    AND x.sad_reg_nber =
                                                           u.sad_reg_nber
                                                    AND x.sad_pst_dat <=
                                                           TO_DATE (
                                                               n.not_fecha_notificacion,
                                                               'dd/mm/yyyy')),
                                          0)
                               AND u.sad_flw = 1
                               AND u.sad_num = 0
                               AND u.lst_ope = 'U'
                               AND u.key_year = iu.key_year
                               AND u.key_cuo = iu.key_cuo
                               AND u.key_dec = iu.key_dec
                               AND u.key_nber = iu.key_nber
                               AND u.sad_num = iu.sad_num
                               AND a.key_year = ia.key_year
                               AND a.key_cuo = ia.key_cuo
                               AND a.key_dec = ia.key_dec
                               AND a.key_nber = ia.key_nber
                               AND a.sad_num = ia.sad_num
                               AND iu.key_year = ia.key_year
                               AND iu.key_cuo = ia.key_cuo
                               AND iu.key_dec = ia.key_dec
                               AND iu.key_nber = ia.key_nber
                               AND iu.itm_nber = ia.itm_nber
                               --tributo GA
                               AND iu.key_year = gau.key_year
                               AND iu.key_cuo = gau.key_cuo
                               AND iu.key_dec = gau.key_dec
                               AND iu.key_nber = gau.key_nber
                               AND iu.itm_nber = gau.itm_nber
                               AND iu.sad_num = gau.sad_num
                               AND gau.saditm_tax_code = 'GA'
                               AND ia.key_year = gaa.key_year
                               AND ia.key_cuo = gaa.key_cuo
                               AND ia.key_dec = gaa.key_dec
                               AND ia.key_nber = gaa.key_nber
                               AND ia.itm_nber = gaa.itm_nber
                               AND ia.sad_num = gaa.sad_num
                               AND gaa.saditm_tax_code = 'GA'
                               --tributo IVA
                               AND iu.key_year = ivau.key_year
                               AND iu.key_cuo = ivau.key_cuo
                               AND iu.key_dec = ivau.key_dec
                               AND iu.key_nber = ivau.key_nber
                               AND iu.itm_nber = ivau.itm_nber
                               AND iu.sad_num = ivau.sad_num
                               AND ivau.saditm_tax_code = 'IVA'
                               AND ia.key_year = ivaa.key_year
                               AND ia.key_cuo = ivaa.key_cuo
                               AND ia.key_dec = ivaa.key_dec
                               AND ia.key_nber = ivaa.key_nber
                               AND ia.itm_nber = ivaa.itm_nber
                               AND ia.sad_num = ivaa.sad_num
                               AND ivaa.saditm_tax_code = 'IVA'
                               --tributo ICE
                               AND iu.key_year = iceu.key_year(+)
                               AND iu.key_cuo = iceu.key_cuo(+)
                               AND iu.key_dec = iceu.key_dec(+)
                               AND iu.key_nber = iceu.key_nber(+)
                               AND iu.itm_nber = iceu.itm_nber(+)
                               AND iu.sad_num = iceu.sad_num(+)
                               AND iceu.saditm_tax_code(+) = 'ICE'
                               AND ia.key_year = icea.key_year(+)
                               AND ia.key_cuo = icea.key_cuo(+)
                               AND ia.key_dec = icea.key_dec(+)
                               AND ia.key_nber = icea.key_nber(+)
                               AND ia.itm_nber = icea.itm_nber(+)
                               AND ia.sad_num = icea.sad_num(+)
                               AND icea.saditm_tax_code(+) = 'ICE'
                               --tributo IEHD
                               AND iu.key_year = iehdu.key_year(+)
                               AND iu.key_cuo = iehdu.key_cuo(+)
                               AND iu.key_dec = iehdu.key_dec(+)
                               AND iu.key_nber = iehdu.key_nber(+)
                               AND iu.itm_nber = iehdu.itm_nber(+)
                               AND iu.sad_num = iehdu.sad_num(+)
                               AND iehdu.saditm_tax_code(+) = 'IEHD'
                               AND ia.key_year = iehda.key_year(+)
                               AND ia.key_cuo = iehda.key_cuo(+)
                               AND ia.key_dec = iehda.key_dec(+)
                               AND ia.key_nber = iehda.key_nber(+)
                               AND ia.itm_nber = iehda.itm_nber(+)
                               AND ia.sad_num = iehda.sad_num(+)
                               AND iehda.saditm_tax_code(+) = 'IEHD'
                               --tributo ICD
                               AND iu.key_year = icdu.key_year(+)
                               AND iu.key_cuo = icdu.key_cuo(+)
                               AND iu.key_dec = icdu.key_dec(+)
                               AND iu.key_nber = icdu.key_nber(+)
                               AND iu.itm_nber = icdu.itm_nber(+)
                               AND iu.sad_num = icdu.sad_num(+)
                               AND icdu.saditm_tax_code(+) = 'ICD'
                               AND ia.key_year = icda.key_year(+)
                               AND ia.key_cuo = icda.key_cuo(+)
                               AND ia.key_dec = icda.key_dec(+)
                               AND ia.key_nber = icda.key_nber(+)
                               AND ia.itm_nber = icda.itm_nber(+)
                               AND ia.sad_num = icda.sad_num(+)
                               AND icda.saditm_tax_code(+) = 'ICD'
                               --para los valores FOB FLETE SEGURO OTROS CIF
                               AND iu.key_year = vu.key_year
                               AND iu.key_cuo = vu.key_cuo
                               AND iu.key_dec = vu.key_dec
                               AND iu.key_nber = vu.key_nber
                               AND iu.itm_nber = vu.itm_nber
                               AND iu.sad_num = vu.sad_num
                               AND ia.key_year = va.key_year
                               AND ia.key_cuo = va.key_cuo
                               AND ia.key_dec = va.key_dec
                               AND ia.key_nber = va.key_nber
                               AND ia.itm_nber = va.itm_nber
                               AND ia.sad_num = va.sad_num
                               --para recuperar informacion del control
                               AND f.alc_tipo_tramite = 'DUI'
                               AND f.alc_gestion = u.sad_reg_year
                               AND f.alc_aduana = u.key_cuo
                               AND u.sad_reg_serial = 'C'
                               AND f.alc_numero = u.sad_reg_nber
                               AND f.ctl_control_id = prm_codigo
                               AND f.alc_num = 0
                               AND f.alc_lstope = 'U'
                               AND f.ctl_control_id = n.ctl_control_id
                               AND n.not_num = 0
                               AND n.not_lstope = 'U'
                      UNION
                      SELECT   iu.itm_nber itm,
                               ia.saditm_hs_cod || ia.saditm_hsprec_cod
                                   nandina_ant,
                               iu.saditm_hs_cod || iu.saditm_hsprec_cod
                                   nandina_u,
                               u.sad_reg_year reg_year,
                               u.key_cuo key_cuo,
                               u.sad_reg_nber reg_nber,
                               TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                   fecha_reg,
                               TO_CHAR (
                                   pkg_reporte.fecha_vencimiento (
                                       u.key_cuo,
                                       TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                   'dd/mm/yyyy')
                                   fecha_venc,
                               TO_CHAR (SYSDATE, 'dd/mm/yyyy') fecha_calculo,
                               va.sad_iitminv_valc dec_fob,
                               va.sad_iitmefr_valc dec_flete,
                               va.sad_iitmins_valc dec_seguro,
                               va.sad_iitmotc_valc dec_otros,
                               ROUND (
                                   va.sad_iitmcif_valn / va.sad_iitminv_rat,
                                   2)
                                   dec_cifusd,
                               va.sad_iitminv_rat dec_tc,
                               va.sad_iitmcif_valn dec_cifbs,
                               gaa.saditm_tax_amount dec_ga,
                               ivaa.saditm_tax_amount dec_iva,
                               NVL (icea.saditm_tax_amount, 0) dec_ice,
                               NVL (iehda.saditm_tax_amount, 0) dec_iehd,
                               NVL (icda.saditm_tax_amount, 0) dec_icd,
                               vu.sad_iitminv_valc enc_fob,
                               vu.sad_iitmefr_valc enc_flete,
                               vu.sad_iitmins_valc enc_seguro,
                               vu.sad_iitmotc_valc enc_otros,
                               ROUND (
                                   vu.sad_iitmcif_valn / vu.sad_iitminv_rat,
                                   2)
                                   enc_cifusd,
                               vu.sad_iitminv_rat enc_tc,
                               vu.sad_iitmcif_valn enc_cifbs,
                               gau.saditm_tax_amount enc_ga,
                               ivau.saditm_tax_amount enc_iva,
                               NVL (iceu.saditm_tax_amount, 0) enc_ice,
                               NVL (iehdu.saditm_tax_amount, 0) enc_iehd,
                               NVL (icdu.saditm_tax_amount, 0) enc_icd,
                               pkg_reporte.tipocambio (
                                   pkg_reporte.fecha_vencimiento (
                                       u.key_cuo,
                                       TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                   'UFV')
                                   tc_ufvfecvenc,
                               pkg_reporte.tipocambio (TRUNC (SYSDATE),
                                                       'UFV')
                                   tc_ufvhoy,
                               gau.saditm_tax_amount - gaa.saditm_tax_amount
                                   to_ga,
                               ivau.saditm_tax_amount
                               - ivaa.saditm_tax_amount
                                   to_iva,
                               NVL (iceu.saditm_tax_amount, 0)
                               - NVL (icea.saditm_tax_amount, 0)
                                   to_ice,
                               NVL (iehdu.saditm_tax_amount, 0)
                               - NVL (iehda.saditm_tax_amount, 0)
                                   to_iehd,
                               NVL (icdu.saditm_tax_amount, 0)
                               - NVL (icda.saditm_tax_amount, 0)
                                   to_icd,
                               TRUNC (SYSDATE)
                               - pkg_reporte.fecha_vencimiento (
                                     u.key_cuo,
                                     TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy'))
                                   dias,
                               pkg_reporte.tipocambio (
                                   pkg_reporte.fecha_vencimiento (
                                       u.key_cuo,
                                       TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                   'TPR')
                                   tc_tprfecvenc,
                               ops$asy.fcalculadeudatributaria (
                                   u.sad_reg_date,
                                   TRUNC (SYSDATE),
                                   u.key_year,
                                   u.key_cuo,
                                   u.key_dec,
                                   u.key_nber,
                                   gau.saditm_tax_amount
                                   - gaa.saditm_tax_amount,
                                   u.sad_top_cod)
                                   ga_dt,
                               ops$asy.fcalculadeudatributaria (
                                   u.sad_reg_date,
                                   TRUNC (SYSDATE),
                                   u.key_year,
                                   u.key_cuo,
                                   u.key_dec,
                                   u.key_nber,
                                   ivau.saditm_tax_amount
                                   - ivaa.saditm_tax_amount,
                                   u.sad_top_cod)
                                   iva_dt,
                               ops$asy.fcalculadeudatributaria (
                                   u.sad_reg_date,
                                   TRUNC (SYSDATE),
                                   u.key_year,
                                   u.key_cuo,
                                   u.key_dec,
                                   u.key_nber,
                                   NVL (iceu.saditm_tax_amount, 0)
                                   - NVL (icea.saditm_tax_amount, 0),
                                   u.sad_top_cod)
                                   ice_dt,
                               ops$asy.fcalculadeudatributaria (
                                   u.sad_reg_date,
                                   TRUNC (SYSDATE),
                                   u.key_year,
                                   u.key_cuo,
                                   u.key_dec,
                                   u.key_nber,
                                   NVL (iehdu.saditm_tax_amount, 0)
                                   - NVL (iehda.saditm_tax_amount, 0),
                                   u.sad_top_cod)
                                   iehd_dt,
                               ops$asy.fcalculadeudatributaria (
                                   u.sad_reg_date,
                                   TRUNC (SYSDATE),
                                   u.key_year,
                                   u.key_cuo,
                                   u.key_dec,
                                   u.key_nber,
                                   NVL (icdu.saditm_tax_amount, 0)
                                   - NVL (icda.saditm_tax_amount, 0),
                                   u.sad_top_cod)
                                   icd_dt
                        FROM   ops$asy.sad_gen u,
                               ops$asy.sad_gen a,
                               ops$asy.sad_itm iu,
                               ops$asy.sad_itm ia,
                               ops$asy.sad_tax gau,
                               ops$asy.sad_tax gaa,
                               ops$asy.sad_tax ivau,
                               ops$asy.sad_tax ivaa,
                               ops$asy.sad_tax iceu,
                               ops$asy.sad_tax icea,
                               ops$asy.sad_tax iehdu,
                               ops$asy.sad_tax iehda,
                               ops$asy.sad_tax icdu,
                               ops$asy.sad_tax icda,
                               ops$asy.sad_itm_vim vu,
                               ops$asy.sad_itm_vim va,
                               fis_alcance f,
                               fis_notificacion n
                       WHERE       u.key_year = a.key_year
                               AND u.key_cuo = a.key_cuo
                               AND u.key_dec IS NULL
                               AND a.key_dec IS NULL
                               AND u.key_nber = a.key_nber
                               AND a.sad_num =
                                      NVL (
                                          (SELECT   MAX (x.sad_pst_num)
                                             FROM   ops$asy.sad_gen x
                                            WHERE   x.key_cuo = u.key_cuo
                                                    AND x.sad_reg_year =
                                                           u.sad_reg_year
                                                    AND x.sad_reg_serial =
                                                           u.sad_reg_serial
                                                    AND x.sad_reg_nber =
                                                           u.sad_reg_nber
                                                    AND x.sad_pst_dat <=
                                                           TO_DATE (
                                                               n.not_fecha_notificacion,
                                                               'dd/mm/yyyy')),
                                          0)
                               AND u.sad_flw = 1
                               AND u.sad_num = 0
                               AND u.lst_ope = 'U'
                               AND u.key_year = iu.key_year
                               AND u.key_cuo = iu.key_cuo
                               AND iu.key_dec IS NULL
                               AND u.key_nber = iu.key_nber
                               AND u.sad_num = iu.sad_num
                               AND a.key_year = ia.key_year
                               AND a.key_cuo = ia.key_cuo
                               AND ia.key_dec IS NULL
                               AND a.key_nber = ia.key_nber
                               AND a.sad_num = ia.sad_num
                               AND iu.key_year = ia.key_year
                               AND iu.key_cuo = ia.key_cuo
                               AND iu.key_nber = ia.key_nber
                               AND iu.itm_nber = ia.itm_nber
                               --tributo GA
                               AND iu.key_year = gau.key_year
                               AND iu.key_cuo = gau.key_cuo
                               AND gau.key_dec IS NULL
                               AND iu.key_nber = gau.key_nber
                               AND iu.itm_nber = gau.itm_nber
                               AND iu.sad_num = gau.sad_num
                               AND gau.saditm_tax_code = 'GA'
                               AND ia.key_year = gaa.key_year
                               AND ia.key_cuo = gaa.key_cuo
                               AND gaa.key_dec IS NULL
                               AND ia.key_nber = gaa.key_nber
                               AND ia.itm_nber = gaa.itm_nber
                               AND ia.sad_num = gaa.sad_num
                               AND gaa.saditm_tax_code = 'GA'
                               --tributo IVA
                               AND iu.key_year = ivau.key_year
                               AND iu.key_cuo = ivau.key_cuo
                               AND ivau.key_dec IS NULL
                               AND iu.key_nber = ivau.key_nber
                               AND iu.itm_nber = ivau.itm_nber
                               AND iu.sad_num = ivau.sad_num
                               AND ivau.saditm_tax_code = 'IVA'
                               AND ia.key_year = ivaa.key_year
                               AND ia.key_cuo = ivaa.key_cuo
                               AND ivaa.key_dec IS NULL
                               AND ia.key_nber = ivaa.key_nber
                               AND ia.itm_nber = ivaa.itm_nber
                               AND ia.sad_num = ivaa.sad_num
                               AND ivaa.saditm_tax_code = 'IVA'
                               --tributo ICE
                               AND iu.key_year = iceu.key_year(+)
                               AND iu.key_cuo = iceu.key_cuo(+)
                               AND iceu.key_dec(+) IS NULL
                               AND iu.key_nber = iceu.key_nber(+)
                               AND iu.itm_nber = iceu.itm_nber(+)
                               AND iu.sad_num = iceu.sad_num(+)
                               AND iceu.saditm_tax_code(+) = 'ICE'
                               AND ia.key_year = icea.key_year(+)
                               AND ia.key_cuo = icea.key_cuo(+)
                               AND icea.key_dec(+) IS NULL
                               AND ia.key_nber = icea.key_nber(+)
                               AND ia.itm_nber = icea.itm_nber(+)
                               AND ia.sad_num = icea.sad_num(+)
                               AND icea.saditm_tax_code(+) = 'ICE'
                               --tributo IEHD
                               AND iu.key_year = iehdu.key_year(+)
                               AND iu.key_cuo = iehdu.key_cuo(+)
                               AND iehdu.key_dec(+) IS NULL
                               AND iu.key_nber = iehdu.key_nber(+)
                               AND iu.itm_nber = iehdu.itm_nber(+)
                               AND iu.sad_num = iehdu.sad_num(+)
                               AND iehdu.saditm_tax_code(+) = 'IEHD'
                               AND ia.key_year = iehda.key_year(+)
                               AND ia.key_cuo = iehda.key_cuo(+)
                               AND iehda.key_dec(+) IS NULL
                               AND ia.key_nber = iehda.key_nber(+)
                               AND ia.itm_nber = iehda.itm_nber(+)
                               AND ia.sad_num = iehda.sad_num(+)
                               AND iehda.saditm_tax_code(+) = 'IEHD'
                               --tributo ICD
                               AND iu.key_year = icdu.key_year(+)
                               AND iu.key_cuo = icdu.key_cuo(+)
                               AND icdu.key_dec(+) IS NULL
                               AND iu.key_nber = icdu.key_nber(+)
                               AND iu.itm_nber = icdu.itm_nber(+)
                               AND iu.sad_num = icdu.sad_num(+)
                               AND icdu.saditm_tax_code(+) = 'ICD'
                               AND ia.key_year = icda.key_year(+)
                               AND ia.key_cuo = icda.key_cuo(+)
                               AND icda.key_dec(+) IS NULL
                               AND ia.key_nber = icda.key_nber(+)
                               AND ia.itm_nber = icda.itm_nber(+)
                               AND ia.sad_num = icda.sad_num(+)
                               AND icda.saditm_tax_code(+) = 'ICD'
                               --para los valores FOB FLETE SEGURO OTROS CIF
                               AND iu.key_year = vu.key_year
                               AND iu.key_cuo = vu.key_cuo
                               AND vu.key_dec IS NULL
                               AND iu.key_nber = vu.key_nber
                               AND iu.itm_nber = vu.itm_nber
                               AND iu.sad_num = vu.sad_num
                               AND ia.key_year = va.key_year
                               AND ia.key_cuo = va.key_cuo
                               AND va.key_dec IS NULL
                               AND ia.key_nber = va.key_nber
                               AND ia.itm_nber = va.itm_nber
                               AND ia.sad_num = va.sad_num
                               --para recuperar informacion del control
                               AND f.alc_tipo_tramite = 'DUI'
                               AND f.alc_gestion = u.sad_reg_year
                               AND f.alc_aduana = u.key_cuo
                               AND u.sad_reg_serial = 'C'
                               AND f.alc_numero = u.sad_reg_nber
                               AND f.ctl_control_id = prm_codigo
                               AND f.alc_num = 0
                               AND f.alc_lstope = 'U'
                               AND f.ctl_control_id = n.ctl_control_id
                               AND n.not_num = 0
                               AND n.not_lstope = 'U') t;

        RETURN ct;
    END;


    FUNCTION devuelve_liquidaciontab (prm_codigo    IN VARCHAR2,
                                      prm_codigo2   IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT   *
              FROM   (SELECT   u.*
                        FROM   ops$asy.sad_gen u,
                               ops$asy.sad_gen a,
                               ops$asy.sad_itm iu,
                               ops$asy.sad_itm ia,
                               ops$asy.sad_tax gau,
                               ops$asy.sad_tax gaa,
                               ops$asy.sad_tax ivau,
                               ops$asy.sad_tax ivaa,
                               ops$asy.sad_tax iceu,
                               ops$asy.sad_tax icea,
                               ops$asy.sad_tax iehdu,
                               ops$asy.sad_tax iehda,
                               ops$asy.sad_tax icdu,
                               ops$asy.sad_tax icda,
                               ops$asy.sad_itm_vim vu,
                               ops$asy.sad_itm_vim va,
                               fis_alcance f,
                               fis_notificacion n
                       WHERE       u.key_year = a.key_year
                               AND u.key_cuo = a.key_cuo
                               AND u.key_dec IS NOT NULL
                               AND u.key_dec = a.key_dec
                               AND u.key_nber = a.key_nber
                               AND a.sad_num =
                                      NVL (
                                          (SELECT   MAX (x.sad_pst_num)
                                             FROM   ops$asy.sad_gen x
                                            WHERE   x.key_cuo = u.key_cuo
                                                    AND x.sad_reg_year =
                                                           u.sad_reg_year
                                                    AND x.sad_reg_serial =
                                                           u.sad_reg_serial
                                                    AND x.sad_reg_nber =
                                                           u.sad_reg_nber
                                                    AND x.sad_pst_dat <=
                                                           n.not_fecha_notificacion),
                                          0)
                               AND u.sad_flw = 1
                               AND u.sad_num = 0
                               AND u.lst_ope = 'U'
                               AND u.key_year = iu.key_year
                               AND u.key_cuo = iu.key_cuo
                               AND u.key_dec = iu.key_dec
                               AND u.key_nber = iu.key_nber
                               AND u.sad_num = iu.sad_num
                               AND a.key_year = ia.key_year
                               AND a.key_cuo = ia.key_cuo
                               AND a.key_dec = ia.key_dec
                               AND a.key_nber = ia.key_nber
                               AND a.sad_num = ia.sad_num
                               AND iu.key_year = ia.key_year
                               AND iu.key_cuo = ia.key_cuo
                               AND iu.key_dec = ia.key_dec
                               AND iu.key_nber = ia.key_nber
                               AND iu.itm_nber = ia.itm_nber
                               --tributo GA
                               AND iu.key_year = gau.key_year
                               AND iu.key_cuo = gau.key_cuo
                               AND iu.key_dec = gau.key_dec
                               AND iu.key_nber = gau.key_nber
                               AND iu.itm_nber = gau.itm_nber
                               AND iu.sad_num = gau.sad_num
                               AND gau.saditm_tax_code = 'GA'
                               AND ia.key_year = gaa.key_year
                               AND ia.key_cuo = gaa.key_cuo
                               AND ia.key_dec = gaa.key_dec
                               AND ia.key_nber = gaa.key_nber
                               AND ia.itm_nber = gaa.itm_nber
                               AND ia.sad_num = gaa.sad_num
                               AND gaa.saditm_tax_code = 'GA'
                               --tributo IVA
                               AND iu.key_year = ivau.key_year
                               AND iu.key_cuo = ivau.key_cuo
                               AND iu.key_dec = ivau.key_dec
                               AND iu.key_nber = ivau.key_nber
                               AND iu.itm_nber = ivau.itm_nber
                               AND iu.sad_num = ivau.sad_num
                               AND ivau.saditm_tax_code = 'IVA'
                               AND ia.key_year = ivaa.key_year
                               AND ia.key_cuo = ivaa.key_cuo
                               AND ia.key_dec = ivaa.key_dec
                               AND ia.key_nber = ivaa.key_nber
                               AND ia.itm_nber = ivaa.itm_nber
                               AND ia.sad_num = ivaa.sad_num
                               AND ivaa.saditm_tax_code = 'IVA'
                               --tributo ICE
                               AND iu.key_year = iceu.key_year(+)
                               AND iu.key_cuo = iceu.key_cuo(+)
                               AND iu.key_dec = iceu.key_dec(+)
                               AND iu.key_nber = iceu.key_nber(+)
                               AND iu.itm_nber = iceu.itm_nber(+)
                               AND iu.sad_num = iceu.sad_num(+)
                               AND iceu.saditm_tax_code(+) = 'ICE'
                               AND ia.key_year = icea.key_year(+)
                               AND ia.key_cuo = icea.key_cuo(+)
                               AND ia.key_dec = icea.key_dec(+)
                               AND ia.key_nber = icea.key_nber(+)
                               AND ia.itm_nber = icea.itm_nber(+)
                               AND ia.sad_num = icea.sad_num(+)
                               AND icea.saditm_tax_code(+) = 'ICE'
                               --tributo IEHD
                               AND iu.key_year = iehdu.key_year(+)
                               AND iu.key_cuo = iehdu.key_cuo(+)
                               AND iu.key_dec = iehdu.key_dec(+)
                               AND iu.key_nber = iehdu.key_nber(+)
                               AND iu.itm_nber = iehdu.itm_nber(+)
                               AND iu.sad_num = iehdu.sad_num(+)
                               AND iehdu.saditm_tax_code(+) = 'IEHD'
                               AND ia.key_year = iehda.key_year(+)
                               AND ia.key_cuo = iehda.key_cuo(+)
                               AND ia.key_dec = iehda.key_dec(+)
                               AND ia.key_nber = iehda.key_nber(+)
                               AND ia.itm_nber = iehda.itm_nber(+)
                               AND ia.sad_num = iehda.sad_num(+)
                               AND iehda.saditm_tax_code(+) = 'IEHD'
                               --tributo ICD
                               AND iu.key_year = icdu.key_year(+)
                               AND iu.key_cuo = icdu.key_cuo(+)
                               AND iu.key_dec = icdu.key_dec(+)
                               AND iu.key_nber = icdu.key_nber(+)
                               AND iu.itm_nber = icdu.itm_nber(+)
                               AND iu.sad_num = icdu.sad_num(+)
                               AND icdu.saditm_tax_code(+) = 'ICD'
                               AND ia.key_year = icda.key_year(+)
                               AND ia.key_cuo = icda.key_cuo(+)
                               AND ia.key_dec = icda.key_dec(+)
                               AND ia.key_nber = icda.key_nber(+)
                               AND ia.itm_nber = icda.itm_nber(+)
                               AND ia.sad_num = icda.sad_num(+)
                               AND icda.saditm_tax_code(+) = 'ICD'
                               --para los valores FOB FLETE SEGURO OTROS CIF
                               AND iu.key_year = vu.key_year
                               AND iu.key_cuo = vu.key_cuo
                               AND iu.key_dec = vu.key_dec
                               AND iu.key_nber = vu.key_nber
                               AND iu.itm_nber = vu.itm_nber
                               AND iu.sad_num = vu.sad_num
                               AND ia.key_year = va.key_year
                               AND ia.key_cuo = va.key_cuo
                               AND ia.key_dec = va.key_dec
                               AND ia.key_nber = va.key_nber
                               AND ia.itm_nber = va.itm_nber
                               AND ia.sad_num = va.sad_num
                               --para recuperar informacion del control
                               AND f.alc_tipo_tramite = 'DUI'
                               AND f.alc_gestion = u.sad_reg_year
                               AND f.alc_aduana = u.key_cuo
                               AND u.sad_reg_serial = 'C'
                               AND f.alc_numero = u.sad_reg_nber
                               AND f.ctl_control_id = '2017250'
                               AND f.alc_num = 0
                               AND f.alc_lstope = 'U'
                               AND f.ctl_control_id = n.ctl_control_id
                               AND n.not_num = 0
                               AND n.not_lstope = 'U'
                      UNION
                      SELECT   u.*
                        FROM   ops$asy.sad_gen u,
                               ops$asy.sad_gen a,
                               ops$asy.sad_itm iu,
                               ops$asy.sad_itm ia,
                               ops$asy.sad_tax gau,
                               ops$asy.sad_tax gaa,
                               ops$asy.sad_tax ivau,
                               ops$asy.sad_tax ivaa,
                               ops$asy.sad_tax iceu,
                               ops$asy.sad_tax icea,
                               ops$asy.sad_tax iehdu,
                               ops$asy.sad_tax iehda,
                               ops$asy.sad_tax icdu,
                               ops$asy.sad_tax icda,
                               ops$asy.sad_itm_vim vu,
                               ops$asy.sad_itm_vim va,
                               fis_alcance f,
                               fis_notificacion n
                       WHERE       u.key_year = a.key_year
                               AND u.key_cuo = a.key_cuo
                               AND u.key_dec IS NULL
                               AND a.key_dec IS NULL
                               AND u.key_nber = a.key_nber
                               AND a.sad_num =
                                      NVL (
                                          (SELECT   MAX (x.sad_pst_num)
                                             FROM   ops$asy.sad_gen x
                                            WHERE   x.key_cuo = u.key_cuo
                                                    AND x.sad_reg_year =
                                                           u.sad_reg_year
                                                    AND x.sad_reg_serial =
                                                           u.sad_reg_serial
                                                    AND x.sad_reg_nber =
                                                           u.sad_reg_nber
                                                    AND x.sad_pst_dat <=
                                                           n.not_fecha_notificacion),
                                          0)
                               AND u.sad_flw = 1
                               AND u.sad_num = 0
                               AND u.lst_ope = 'U'
                               AND u.key_year = iu.key_year
                               AND u.key_cuo = iu.key_cuo
                               AND iu.key_dec IS NULL
                               AND u.key_nber = iu.key_nber
                               AND u.sad_num = iu.sad_num
                               AND a.key_year = ia.key_year
                               AND a.key_cuo = ia.key_cuo
                               AND ia.key_dec IS NULL
                               AND a.key_nber = ia.key_nber
                               AND a.sad_num = ia.sad_num
                               AND iu.key_year = ia.key_year
                               AND iu.key_cuo = ia.key_cuo
                               AND iu.key_nber = ia.key_nber
                               AND iu.itm_nber = ia.itm_nber
                               --tributo GA
                               AND iu.key_year = gau.key_year
                               AND iu.key_cuo = gau.key_cuo
                               AND gau.key_dec IS NULL
                               AND iu.key_nber = gau.key_nber
                               AND iu.itm_nber = gau.itm_nber
                               AND iu.sad_num = gau.sad_num
                               AND gau.saditm_tax_code = 'GA'
                               AND ia.key_year = gaa.key_year
                               AND ia.key_cuo = gaa.key_cuo
                               AND gaa.key_dec IS NULL
                               AND ia.key_nber = gaa.key_nber
                               AND ia.itm_nber = gaa.itm_nber
                               AND ia.sad_num = gaa.sad_num
                               AND gaa.saditm_tax_code = 'GA'
                               --tributo IVA
                               AND iu.key_year = ivau.key_year
                               AND iu.key_cuo = ivau.key_cuo
                               AND ivau.key_dec IS NULL
                               AND iu.key_nber = ivau.key_nber
                               AND iu.itm_nber = ivau.itm_nber
                               AND iu.sad_num = ivau.sad_num
                               AND ivau.saditm_tax_code = 'IVA'
                               AND ia.key_year = ivaa.key_year
                               AND ia.key_cuo = ivaa.key_cuo
                               AND ivaa.key_dec IS NULL
                               AND ia.key_nber = ivaa.key_nber
                               AND ia.itm_nber = ivaa.itm_nber
                               AND ia.sad_num = ivaa.sad_num
                               AND ivaa.saditm_tax_code = 'IVA'
                               --tributo ICE
                               AND iu.key_year = iceu.key_year(+)
                               AND iu.key_cuo = iceu.key_cuo(+)
                               AND iceu.key_dec(+) IS NULL
                               AND iu.key_nber = iceu.key_nber(+)
                               AND iu.itm_nber = iceu.itm_nber(+)
                               AND iu.sad_num = iceu.sad_num(+)
                               AND iceu.saditm_tax_code(+) = 'ICE'
                               AND ia.key_year = icea.key_year(+)
                               AND ia.key_cuo = icea.key_cuo(+)
                               AND icea.key_dec(+) IS NULL
                               AND ia.key_nber = icea.key_nber(+)
                               AND ia.itm_nber = icea.itm_nber(+)
                               AND ia.sad_num = icea.sad_num(+)
                               AND icea.saditm_tax_code(+) = 'ICE'
                               --tributo IEHD
                               AND iu.key_year = iehdu.key_year(+)
                               AND iu.key_cuo = iehdu.key_cuo(+)
                               AND iehdu.key_dec(+) IS NULL
                               AND iu.key_nber = iehdu.key_nber(+)
                               AND iu.itm_nber = iehdu.itm_nber(+)
                               AND iu.sad_num = iehdu.sad_num(+)
                               AND iehdu.saditm_tax_code(+) = 'IEHD'
                               AND ia.key_year = iehda.key_year(+)
                               AND ia.key_cuo = iehda.key_cuo(+)
                               AND iehda.key_dec(+) IS NULL
                               AND ia.key_nber = iehda.key_nber(+)
                               AND ia.itm_nber = iehda.itm_nber(+)
                               AND ia.sad_num = iehda.sad_num(+)
                               AND iehda.saditm_tax_code(+) = 'IEHD'
                               --tributo ICD
                               AND iu.key_year = icdu.key_year(+)
                               AND iu.key_cuo = icdu.key_cuo(+)
                               AND icdu.key_dec(+) IS NULL
                               AND iu.key_nber = icdu.key_nber(+)
                               AND iu.itm_nber = icdu.itm_nber(+)
                               AND iu.sad_num = icdu.sad_num(+)
                               AND icdu.saditm_tax_code(+) = 'ICD'
                               AND ia.key_year = icda.key_year(+)
                               AND ia.key_cuo = icda.key_cuo(+)
                               AND icda.key_dec(+) IS NULL
                               AND ia.key_nber = icda.key_nber(+)
                               AND ia.itm_nber = icda.itm_nber(+)
                               AND ia.sad_num = icda.sad_num(+)
                               AND icda.saditm_tax_code(+) = 'ICD'
                               --para los valores FOB FLETE SEGURO OTROS CIF
                               AND iu.key_year = vu.key_year
                               AND iu.key_cuo = vu.key_cuo
                               AND vu.key_dec IS NULL
                               AND iu.key_nber = vu.key_nber
                               AND iu.itm_nber = vu.itm_nber
                               AND iu.sad_num = vu.sad_num
                               AND ia.key_year = va.key_year
                               AND ia.key_cuo = va.key_cuo
                               AND va.key_dec IS NULL
                               AND ia.key_nber = va.key_nber
                               AND ia.itm_nber = va.itm_nber
                               AND ia.sad_num = va.sad_num
                               --para recuperar informacion del control
                               AND f.alc_tipo_tramite = 'DUI'
                               AND f.alc_gestion = u.sad_reg_year
                               AND f.alc_aduana = u.key_cuo
                               AND u.sad_reg_serial = 'C'
                               AND f.alc_numero = u.sad_reg_nber
                               AND f.ctl_control_id = '2017250'
                               AND f.alc_num = 0
                               AND f.alc_lstope = 'U'
                               AND f.ctl_control_id = n.ctl_control_id
                               AND n.not_num = 0
                               AND n.not_lstope = 'U') t;

        RETURN ct;
    END;

    FUNCTION dev_liquidacion (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
              SELECT                                                       --1
                    t  .itm,
                       t.nandina_ant,
                       t.nandina_u,
                       t.reg_year,
                       t.key_cuo,
                       t.reg_nber,
                       t.fecha_reg,
                       t.fecha_venc,
                       t.fecha_calculo,
                       --10
                       t.dec_fob,
                       t.dec_flete,
                       t.dec_seguro,
                       t.dec_otros,
                       t.dec_cifusd,
                       t.dec_tc,
                       t.dec_cifbs,
                       t.dec_ga,
                       t.dec_iva,
                       t.dec_ice,
                       --20
                       t.dec_iehd,
                       t.dec_icd,
                       --22
                       t.enc_fob,
                       t.enc_flete,
                       t.enc_seguro,
                       t.enc_otros,
                       t.enc_cifusd,
                       t.enc_tc,
                       t.enc_cifbs,
                       t.enc_ga,
                       --30
                       t.enc_iva,
                       t.enc_ice,
                       t.enc_iehd,
                       t.enc_icd,
                       --34
                       t.tc_ufvfecvenc,
                       t.to_ga,
                       t.to_iva,
                       t.to_ice,
                       t.to_iehd,
                       t.to_icd,
                       --40
                       t.to_ga + t.to_iva + t.to_ice + t.to_iehd + t.to_icd
                           to_total,
                       --41
                       ROUND (t.to_ga / t.tc_ufvfecvenc, 2) toufv_ga,
                       ROUND (t.to_iva / t.tc_ufvfecvenc, 2) toufv_iva,
                       ROUND (t.to_ice / t.tc_ufvfecvenc, 2) toufv_ice,
                       ROUND (t.to_iehd / t.tc_ufvfecvenc, 2) toufv_iehd,
                       ROUND (t.to_icd / t.tc_ufvfecvenc, 2) toufv_icd,
                       ROUND (
                           (  t.to_ga
                            + t.to_iva
                            + t.to_ice
                            + t.to_iehd
                            + t.to_icd)
                           / t.tc_ufvfecvenc,
                           2)
                           toufv_total,
                       t.dias,
                       ROUND (POWER (1 + (t.tc_tprfecvenc / 360), t.dias), 4)
                           formula,
                       ROUND (t.ga_dt / t.tc_ufvfecvenc, 2)
                       - ROUND (t.to_ga / t.tc_ufvfecvenc, 2)
                           itufv_ga,
                       --50
                       ROUND (t.to_iva / t.tc_ufvfecvenc, 2)
                       - ROUND (t.iva_dt / t.tc_ufvfecvenc, 2)
                           itufv_iva,
                       ROUND (t.to_ice / t.tc_ufvfecvenc, 2)
                       - ROUND (t.ice_dt / t.tc_ufvfecvenc, 2)
                           itufv_ice,
                       ROUND (t.to_iehd / t.tc_ufvfecvenc, 2)
                       - ROUND (t.iehd_dt / t.tc_ufvfecvenc, 2)
                           itufv_iehd,
                       ROUND (t.to_icd / t.tc_ufvfecvenc, 2)
                       - ROUND (t.icd_dt / t.tc_ufvfecvenc, 2)
                           itufv_icd,
                       (ROUND (
                            (  t.to_ga
                             + t.to_iva
                             + t.to_ice
                             + t.to_iehd
                             + t.to_icd)
                            / t.tc_ufvfecvenc,
                            2)
                        - ROUND (
                              (  t.ga_dt
                               + t.iva_dt
                               + t.ice_dt
                               + t.iehd_dt
                               + t.icd_dt)
                              / t.tc_ufvfecvenc,
                              2))
                           itufv_total,
                       --55
                       ROUND ( (t.to_ga + t.ga_dt) / t.tc_ufvhoy, 2) dt_ga,
                       ROUND ( (t.to_iva + t.iva_dt) / t.tc_ufvhoy, 2) dt_iva,
                       ROUND ( (t.to_ice + t.ice_dt) / t.tc_ufvhoy, 2) dt_ice,
                       ROUND ( (t.to_iehd + t.iehd_dt) / t.tc_ufvhoy, 2)
                           dt_iehd,
                       ROUND ( (t.to_icd + t.icd_dt) / t.tc_ufvhoy, 2) dt_icd,
                       --60
                       ROUND (
                           (  t.to_ga
                            + t.to_iva
                            + t.to_ice
                            + t.to_iehd
                            + t.to_icd
                            + t.ga_dt
                            + t.iva_dt
                            + t.ice_dt
                            + t.iehd_dt
                            + t.icd_dt)
                           / t.tc_ufvfecvenc,
                           2)
                           dt_total,
                       --61
                       ROUND (
                           ( (  t.to_ga
                              + t.to_iva
                              + t.to_ice
                              + t.to_iehd
                              + t.to_icd)
                            / t.tc_ufvhoy)
                           * t.tc_ufvfecvenc,
                           2)
                           sancion,
                       --62
                       ROUND (
                             t.to_ga
                           + t.to_iva
                           + t.to_ice
                           + t.to_iehd
                           + t.to_icd
                           + t.ga_dt
                           + t.iva_dt
                           + t.ice_dt
                           + t.iehd_dt
                           + t.icd_dt,
                           2)
                           adeudo_totalbs,
                       --63
                       ROUND (
                           (  t.to_ga
                            + t.to_iva
                            + t.to_ice
                            + t.to_iehd
                            + t.to_icd
                            + t.ga_dt
                            + t.iva_dt
                            + t.ice_dt
                            + t.iehd_dt
                            + t.icd_dt)
                           / t.tc_ufvhoy,
                           2)
                           adeudo_totalufv,
                       --64
                       t.tc_ufvhoy
                FROM   (SELECT   iu.itm_nber itm,
                                 ia.saditm_hs_cod || ia.saditm_hsprec_cod
                                     nandina_ant,
                                 iu.saditm_hs_cod || iu.saditm_hsprec_cod
                                     nandina_u,
                                 u.sad_reg_year reg_year,
                                 u.key_cuo key_cuo,
                                 u.sad_reg_nber reg_nber,
                                 TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                     fecha_reg,
                                 TO_CHAR (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'dd/mm/yyyy')
                                     fecha_venc,
                                 TO_CHAR (SYSDATE, 'dd/mm/yyyy') fecha_calculo,
                                 va.sad_iitminv_valc dec_fob,
                                 va.sad_iitmefr_valc dec_flete,
                                 va.sad_iitmins_valc dec_seguro,
                                 va.sad_iitmotc_valc dec_otros,
                                 ROUND (
                                     va.sad_iitmcif_valn / va.sad_iitminv_rat,
                                     2)
                                     dec_cifusd,
                                 va.sad_iitminv_rat dec_tc,
                                 va.sad_iitmcif_valn dec_cifbs,
                                 gaa.saditm_tax_amount dec_ga,
                                 ivaa.saditm_tax_amount dec_iva,
                                 NVL (icea.saditm_tax_amount, 0) dec_ice,
                                 NVL (iehda.saditm_tax_amount, 0) dec_iehd,
                                 NVL (icda.saditm_tax_amount, 0) dec_icd,
                                 vu.sad_iitminv_valc enc_fob,
                                 vu.sad_iitmefr_valc enc_flete,
                                 vu.sad_iitmins_valc enc_seguro,
                                 vu.sad_iitmotc_valc enc_otros,
                                 ROUND (
                                     vu.sad_iitmcif_valn / vu.sad_iitminv_rat,
                                     2)
                                     enc_cifusd,
                                 vu.sad_iitminv_rat enc_tc,
                                 vu.sad_iitmcif_valn enc_cifbs,
                                 gau.saditm_tax_amount enc_ga,
                                 ivau.saditm_tax_amount enc_iva,
                                 NVL (iceu.saditm_tax_amount, 0) enc_ice,
                                 NVL (iehdu.saditm_tax_amount, 0) enc_iehd,
                                 NVL (icdu.saditm_tax_amount, 0) enc_icd,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'UFV')
                                     tc_ufvfecvenc,
                                 pkg_reporte.tipocambio (TRUNC (SYSDATE),
                                                         'UFV')
                                     tc_ufvhoy,
                                 gau.saditm_tax_amount - gaa.saditm_tax_amount
                                     to_ga,
                                 ivau.saditm_tax_amount
                                 - ivaa.saditm_tax_amount
                                     to_iva,
                                 NVL (iceu.saditm_tax_amount, 0)
                                 - NVL (icea.saditm_tax_amount, 0)
                                     to_ice,
                                 NVL (iehdu.saditm_tax_amount, 0)
                                 - NVL (iehda.saditm_tax_amount, 0)
                                     to_iehd,
                                 NVL (icdu.saditm_tax_amount, 0)
                                 - NVL (icda.saditm_tax_amount, 0)
                                     to_icd,
                                 TRUNC (SYSDATE)
                                 - pkg_reporte.fecha_vencimiento (
                                       u.key_cuo,
                                       TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy'))
                                     dias,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'TPR')
                                     tc_tprfecvenc,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     gau.saditm_tax_amount
                                     - gaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     ga_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     ivau.saditm_tax_amount
                                     - ivaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     iva_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iceu.saditm_tax_amount, 0)
                                     - NVL (icea.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     ice_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iehdu.saditm_tax_amount, 0)
                                     - NVL (iehda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     iehd_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (icdu.saditm_tax_amount, 0)
                                     - NVL (icda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     icd_dt
                          FROM   ops$asy.sad_gen u,
                                 ops$asy.sad_gen a,
                                 ops$asy.sad_itm iu,
                                 ops$asy.sad_itm ia,
                                 ops$asy.sad_tax gau,
                                 ops$asy.sad_tax gaa,
                                 ops$asy.sad_tax ivau,
                                 ops$asy.sad_tax ivaa,
                                 ops$asy.sad_tax iceu,
                                 ops$asy.sad_tax icea,
                                 ops$asy.sad_tax iehdu,
                                 ops$asy.sad_tax iehda,
                                 ops$asy.sad_tax icdu,
                                 ops$asy.sad_tax icda,
                                 ops$asy.sad_itm_vim vu,
                                 ops$asy.sad_itm_vim va,
                                 fis_alcance f,
                                 fis_notificacion n
                         WHERE       u.key_year = a.key_year
                                 AND u.key_cuo = a.key_cuo
                                 AND u.key_dec IS NOT NULL
                                 AND u.key_dec = a.key_dec
                                 AND u.key_nber = a.key_nber
                                 AND a.sad_num =
                                        NVL (
                                            (SELECT   MIN (x.sad_pst_num)
                                               FROM   ops$asy.sad_gen x
                                              WHERE   x.key_cuo = u.key_cuo
                                                      AND x.sad_reg_year =
                                                             u.sad_reg_year
                                                      AND x.sad_reg_serial =
                                                             u.sad_reg_serial
                                                      AND x.sad_reg_nber =
                                                             u.sad_reg_nber
                                                      AND x.sad_pst_dat >=
                                                             n.not_fecha_notificacion),
                                            0)
                                 AND u.sad_flw = 1
                                 AND u.sad_num = 0
                                 AND u.lst_ope = 'U'
                                 AND u.key_year = iu.key_year
                                 AND u.key_cuo = iu.key_cuo
                                 AND u.key_dec = iu.key_dec
                                 AND u.key_nber = iu.key_nber
                                 AND u.sad_num = iu.sad_num
                                 AND a.key_year = ia.key_year
                                 AND a.key_cuo = ia.key_cuo
                                 AND a.key_dec = ia.key_dec
                                 AND a.key_nber = ia.key_nber
                                 AND a.sad_num = ia.sad_num
                                 AND iu.key_year = ia.key_year
                                 AND iu.key_cuo = ia.key_cuo
                                 AND iu.key_dec = ia.key_dec
                                 AND iu.key_nber = ia.key_nber
                                 AND iu.itm_nber = ia.itm_nber
                                 --tributo GA
                                 AND iu.key_year = gau.key_year
                                 AND iu.key_cuo = gau.key_cuo
                                 AND iu.key_dec = gau.key_dec
                                 AND iu.key_nber = gau.key_nber
                                 AND iu.itm_nber = gau.itm_nber
                                 AND iu.sad_num = gau.sad_num
                                 AND gau.saditm_tax_code = 'GA'
                                 AND ia.key_year = gaa.key_year
                                 AND ia.key_cuo = gaa.key_cuo
                                 AND ia.key_dec = gaa.key_dec
                                 AND ia.key_nber = gaa.key_nber
                                 AND ia.itm_nber = gaa.itm_nber
                                 AND ia.sad_num = gaa.sad_num
                                 AND gaa.saditm_tax_code = 'GA'
                                 --tributo IVA
                                 AND iu.key_year = ivau.key_year
                                 AND iu.key_cuo = ivau.key_cuo
                                 AND iu.key_dec = ivau.key_dec
                                 AND iu.key_nber = ivau.key_nber
                                 AND iu.itm_nber = ivau.itm_nber
                                 AND iu.sad_num = ivau.sad_num
                                 AND ivau.saditm_tax_code = 'IVA'
                                 AND ia.key_year = ivaa.key_year
                                 AND ia.key_cuo = ivaa.key_cuo
                                 AND ia.key_dec = ivaa.key_dec
                                 AND ia.key_nber = ivaa.key_nber
                                 AND ia.itm_nber = ivaa.itm_nber
                                 AND ia.sad_num = ivaa.sad_num
                                 AND ivaa.saditm_tax_code = 'IVA'
                                 --tributo ICE
                                 AND iu.key_year = iceu.key_year(+)
                                 AND iu.key_cuo = iceu.key_cuo(+)
                                 AND iu.key_dec = iceu.key_dec(+)
                                 AND iu.key_nber = iceu.key_nber(+)
                                 AND iu.itm_nber = iceu.itm_nber(+)
                                 AND iu.sad_num = iceu.sad_num(+)
                                 AND iceu.saditm_tax_code(+) = 'ICE'
                                 AND ia.key_year = icea.key_year(+)
                                 AND ia.key_cuo = icea.key_cuo(+)
                                 AND ia.key_dec = icea.key_dec(+)
                                 AND ia.key_nber = icea.key_nber(+)
                                 AND ia.itm_nber = icea.itm_nber(+)
                                 AND ia.sad_num = icea.sad_num(+)
                                 AND icea.saditm_tax_code(+) = 'ICE'
                                 --tributo IEHD
                                 AND iu.key_year = iehdu.key_year(+)
                                 AND iu.key_cuo = iehdu.key_cuo(+)
                                 AND iu.key_dec = iehdu.key_dec(+)
                                 AND iu.key_nber = iehdu.key_nber(+)
                                 AND iu.itm_nber = iehdu.itm_nber(+)
                                 AND iu.sad_num = iehdu.sad_num(+)
                                 AND iehdu.saditm_tax_code(+) = 'IEHD'
                                 AND ia.key_year = iehda.key_year(+)
                                 AND ia.key_cuo = iehda.key_cuo(+)
                                 AND ia.key_dec = iehda.key_dec(+)
                                 AND ia.key_nber = iehda.key_nber(+)
                                 AND ia.itm_nber = iehda.itm_nber(+)
                                 AND ia.sad_num = iehda.sad_num(+)
                                 AND iehda.saditm_tax_code(+) = 'IEHD'
                                 --tributo ICD
                                 AND iu.key_year = icdu.key_year(+)
                                 AND iu.key_cuo = icdu.key_cuo(+)
                                 AND iu.key_dec = icdu.key_dec(+)
                                 AND iu.key_nber = icdu.key_nber(+)
                                 AND iu.itm_nber = icdu.itm_nber(+)
                                 AND iu.sad_num = icdu.sad_num(+)
                                 AND icdu.saditm_tax_code(+) = 'ICD'
                                 AND ia.key_year = icda.key_year(+)
                                 AND ia.key_cuo = icda.key_cuo(+)
                                 AND ia.key_dec = icda.key_dec(+)
                                 AND ia.key_nber = icda.key_nber(+)
                                 AND ia.itm_nber = icda.itm_nber(+)
                                 AND ia.sad_num = icda.sad_num(+)
                                 AND icda.saditm_tax_code(+) = 'ICD'
                                 --para los valores FOB FLETE SEGURO OTROS CIF
                                 AND iu.key_year = vu.key_year
                                 AND iu.key_cuo = vu.key_cuo
                                 AND iu.key_dec = vu.key_dec
                                 AND iu.key_nber = vu.key_nber
                                 AND iu.itm_nber = vu.itm_nber
                                 AND iu.sad_num = vu.sad_num
                                 AND ia.key_year = va.key_year
                                 AND ia.key_cuo = va.key_cuo
                                 AND ia.key_dec = va.key_dec
                                 AND ia.key_nber = va.key_nber
                                 AND ia.itm_nber = va.itm_nber
                                 AND ia.sad_num = va.sad_num
                                 --para recuperar informacion del control
                                 AND f.alc_tipo_tramite = 'DUI'
                                 AND f.alc_gestion = u.sad_reg_year
                                 AND f.alc_aduana = u.key_cuo
                                 AND u.sad_reg_serial = 'C'
                                 AND f.alc_numero = u.sad_reg_nber
                                 AND f.ctl_control_id = prm_codigo
                                 AND f.alc_num = 0
                                 AND f.alc_lstope = 'U'
                                 AND f.ctl_control_id = n.ctl_control_id
                                 AND n.not_num = 0
                                 AND n.not_lstope = 'U'
                        UNION
                        SELECT   iu.itm_nber itm,
                                 ia.saditm_hs_cod || ia.saditm_hsprec_cod
                                     nandina_ant,
                                 iu.saditm_hs_cod || iu.saditm_hsprec_cod
                                     nandina_u,
                                 u.sad_reg_year reg_year,
                                 u.key_cuo key_cuo,
                                 u.sad_reg_nber reg_nber,
                                 TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                     fecha_reg,
                                 TO_CHAR (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'dd/mm/yyyy')
                                     fecha_venc,
                                 TO_CHAR (SYSDATE, 'dd/mm/yyyy') fecha_calculo,
                                 va.sad_iitminv_valc dec_fob,
                                 va.sad_iitmefr_valc dec_flete,
                                 va.sad_iitmins_valc dec_seguro,
                                 va.sad_iitmotc_valc dec_otros,
                                 ROUND (
                                     va.sad_iitmcif_valn / va.sad_iitminv_rat,
                                     2)
                                     dec_cifusd,
                                 va.sad_iitminv_rat dec_tc,
                                 va.sad_iitmcif_valn dec_cifbs,
                                 gaa.saditm_tax_amount dec_ga,
                                 ivaa.saditm_tax_amount dec_iva,
                                 NVL (icea.saditm_tax_amount, 0) dec_ice,
                                 NVL (iehda.saditm_tax_amount, 0) dec_iehd,
                                 NVL (icda.saditm_tax_amount, 0) dec_icd,
                                 vu.sad_iitminv_valc enc_fob,
                                 vu.sad_iitmefr_valc enc_flete,
                                 vu.sad_iitmins_valc enc_seguro,
                                 vu.sad_iitmotc_valc enc_otros,
                                 ROUND (
                                     vu.sad_iitmcif_valn / vu.sad_iitminv_rat,
                                     2)
                                     enc_cifusd,
                                 vu.sad_iitminv_rat enc_tc,
                                 vu.sad_iitmcif_valn enc_cifbs,
                                 gau.saditm_tax_amount enc_ga,
                                 ivau.saditm_tax_amount enc_iva,
                                 NVL (iceu.saditm_tax_amount, 0) enc_ice,
                                 NVL (iehdu.saditm_tax_amount, 0) enc_iehd,
                                 NVL (icdu.saditm_tax_amount, 0) enc_icd,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'UFV')
                                     tc_ufvfecvenc,
                                 pkg_reporte.tipocambio (TRUNC (SYSDATE),
                                                         'UFV')
                                     tc_ufvhoy,
                                 gau.saditm_tax_amount - gaa.saditm_tax_amount
                                     to_ga,
                                 ivau.saditm_tax_amount
                                 - ivaa.saditm_tax_amount
                                     to_iva,
                                 NVL (iceu.saditm_tax_amount, 0)
                                 - NVL (icea.saditm_tax_amount, 0)
                                     to_ice,
                                 NVL (iehdu.saditm_tax_amount, 0)
                                 - NVL (iehda.saditm_tax_amount, 0)
                                     to_iehd,
                                 NVL (icdu.saditm_tax_amount, 0)
                                 - NVL (icda.saditm_tax_amount, 0)
                                     to_icd,
                                 TRUNC (SYSDATE)
                                 - pkg_reporte.fecha_vencimiento (
                                       u.key_cuo,
                                       TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy'))
                                     dias,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'TPR')
                                     tc_tprfecvenc,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     gau.saditm_tax_amount
                                     - gaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     ga_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     ivau.saditm_tax_amount
                                     - ivaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     iva_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iceu.saditm_tax_amount, 0)
                                     - NVL (icea.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     ice_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iehdu.saditm_tax_amount, 0)
                                     - NVL (iehda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     iehd_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (SYSDATE),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (icdu.saditm_tax_amount, 0)
                                     - NVL (icda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     icd_dt
                          FROM   ops$asy.sad_gen u,
                                 ops$asy.sad_gen a,
                                 ops$asy.sad_itm iu,
                                 ops$asy.sad_itm ia,
                                 ops$asy.sad_tax gau,
                                 ops$asy.sad_tax gaa,
                                 ops$asy.sad_tax ivau,
                                 ops$asy.sad_tax ivaa,
                                 ops$asy.sad_tax iceu,
                                 ops$asy.sad_tax icea,
                                 ops$asy.sad_tax iehdu,
                                 ops$asy.sad_tax iehda,
                                 ops$asy.sad_tax icdu,
                                 ops$asy.sad_tax icda,
                                 ops$asy.sad_itm_vim vu,
                                 ops$asy.sad_itm_vim va,
                                 fis_alcance f,
                                 fis_notificacion n
                         WHERE       u.key_year = a.key_year
                                 AND u.key_cuo = a.key_cuo
                                 AND u.key_dec IS NULL
                                 AND a.key_dec IS NULL
                                 AND u.key_nber = a.key_nber
                                 AND a.sad_num =
                                        NVL (
                                            (SELECT   MIN (x.sad_pst_num)
                                               FROM   ops$asy.sad_gen x
                                              WHERE   x.key_cuo = u.key_cuo
                                                      AND x.sad_reg_year =
                                                             u.sad_reg_year
                                                      AND x.sad_reg_serial =
                                                             u.sad_reg_serial
                                                      AND x.sad_reg_nber =
                                                             u.sad_reg_nber
                                                      AND x.sad_pst_dat >=
                                                             n.not_fecha_notificacion),
                                            0)
                                 AND u.sad_flw = 1
                                 AND u.sad_num = 0
                                 AND u.lst_ope = 'U'
                                 AND u.key_year = iu.key_year
                                 AND u.key_cuo = iu.key_cuo
                                 AND iu.key_dec IS NULL
                                 AND u.key_nber = iu.key_nber
                                 AND u.sad_num = iu.sad_num
                                 AND a.key_year = ia.key_year
                                 AND a.key_cuo = ia.key_cuo
                                 AND ia.key_dec IS NULL
                                 AND a.key_nber = ia.key_nber
                                 AND a.sad_num = ia.sad_num
                                 AND iu.key_year = ia.key_year
                                 AND iu.key_cuo = ia.key_cuo
                                 AND iu.key_nber = ia.key_nber
                                 AND iu.itm_nber = ia.itm_nber
                                 --tributo GA
                                 AND iu.key_year = gau.key_year
                                 AND iu.key_cuo = gau.key_cuo
                                 AND gau.key_dec IS NULL
                                 AND iu.key_nber = gau.key_nber
                                 AND iu.itm_nber = gau.itm_nber
                                 AND iu.sad_num = gau.sad_num
                                 AND gau.saditm_tax_code = 'GA'
                                 AND ia.key_year = gaa.key_year
                                 AND ia.key_cuo = gaa.key_cuo
                                 AND gaa.key_dec IS NULL
                                 AND ia.key_nber = gaa.key_nber
                                 AND ia.itm_nber = gaa.itm_nber
                                 AND ia.sad_num = gaa.sad_num
                                 AND gaa.saditm_tax_code = 'GA'
                                 --tributo IVA
                                 AND iu.key_year = ivau.key_year
                                 AND iu.key_cuo = ivau.key_cuo
                                 AND ivau.key_dec IS NULL
                                 AND iu.key_nber = ivau.key_nber
                                 AND iu.itm_nber = ivau.itm_nber
                                 AND iu.sad_num = ivau.sad_num
                                 AND ivau.saditm_tax_code = 'IVA'
                                 AND ia.key_year = ivaa.key_year
                                 AND ia.key_cuo = ivaa.key_cuo
                                 AND ivaa.key_dec IS NULL
                                 AND ia.key_nber = ivaa.key_nber
                                 AND ia.itm_nber = ivaa.itm_nber
                                 AND ia.sad_num = ivaa.sad_num
                                 AND ivaa.saditm_tax_code = 'IVA'
                                 --tributo ICE
                                 AND iu.key_year = iceu.key_year(+)
                                 AND iu.key_cuo = iceu.key_cuo(+)
                                 AND iceu.key_dec(+) IS NULL
                                 AND iu.key_nber = iceu.key_nber(+)
                                 AND iu.itm_nber = iceu.itm_nber(+)
                                 AND iu.sad_num = iceu.sad_num(+)
                                 AND iceu.saditm_tax_code(+) = 'ICE'
                                 AND ia.key_year = icea.key_year(+)
                                 AND ia.key_cuo = icea.key_cuo(+)
                                 AND icea.key_dec(+) IS NULL
                                 AND ia.key_nber = icea.key_nber(+)
                                 AND ia.itm_nber = icea.itm_nber(+)
                                 AND ia.sad_num = icea.sad_num(+)
                                 AND icea.saditm_tax_code(+) = 'ICE'
                                 --tributo IEHD
                                 AND iu.key_year = iehdu.key_year(+)
                                 AND iu.key_cuo = iehdu.key_cuo(+)
                                 AND iehdu.key_dec(+) IS NULL
                                 AND iu.key_nber = iehdu.key_nber(+)
                                 AND iu.itm_nber = iehdu.itm_nber(+)
                                 AND iu.sad_num = iehdu.sad_num(+)
                                 AND iehdu.saditm_tax_code(+) = 'IEHD'
                                 AND ia.key_year = iehda.key_year(+)
                                 AND ia.key_cuo = iehda.key_cuo(+)
                                 AND iehda.key_dec(+) IS NULL
                                 AND ia.key_nber = iehda.key_nber(+)
                                 AND ia.itm_nber = iehda.itm_nber(+)
                                 AND ia.sad_num = iehda.sad_num(+)
                                 AND iehda.saditm_tax_code(+) = 'IEHD'
                                 --tributo ICD
                                 AND iu.key_year = icdu.key_year(+)
                                 AND iu.key_cuo = icdu.key_cuo(+)
                                 AND icdu.key_dec(+) IS NULL
                                 AND iu.key_nber = icdu.key_nber(+)
                                 AND iu.itm_nber = icdu.itm_nber(+)
                                 AND iu.sad_num = icdu.sad_num(+)
                                 AND icdu.saditm_tax_code(+) = 'ICD'
                                 AND ia.key_year = icda.key_year(+)
                                 AND ia.key_cuo = icda.key_cuo(+)
                                 AND icda.key_dec(+) IS NULL
                                 AND ia.key_nber = icda.key_nber(+)
                                 AND ia.itm_nber = icda.itm_nber(+)
                                 AND ia.sad_num = icda.sad_num(+)
                                 AND icda.saditm_tax_code(+) = 'ICD'
                                 --para los valores FOB FLETE SEGURO OTROS CIF
                                 AND iu.key_year = vu.key_year
                                 AND iu.key_cuo = vu.key_cuo
                                 AND vu.key_dec IS NULL
                                 AND iu.key_nber = vu.key_nber
                                 AND iu.itm_nber = vu.itm_nber
                                 AND iu.sad_num = vu.sad_num
                                 AND ia.key_year = va.key_year
                                 AND ia.key_cuo = va.key_cuo
                                 AND va.key_dec IS NULL
                                 AND ia.key_nber = va.key_nber
                                 AND ia.itm_nber = va.itm_nber
                                 AND ia.sad_num = va.sad_num
                                 --para recuperar informacion del control
                                 AND f.alc_tipo_tramite = 'DUI'
                                 AND f.alc_gestion = u.sad_reg_year
                                 AND f.alc_aduana = u.key_cuo
                                 AND u.sad_reg_serial = 'C'
                                 AND f.alc_numero = u.sad_reg_nber
                                 AND f.ctl_control_id = prm_codigo
                                 AND f.alc_num = 0
                                 AND f.alc_lstope = 'U'
                                 AND f.ctl_control_id = n.ctl_control_id
                                 AND n.not_num = 0
                                 AND n.not_lstope = 'U') t
            ORDER BY   4,
                       5,
                       6,
                       1;

        RETURN ct;
    END;

    FUNCTION dev_liquidacionfecha (prm_codigo   IN VARCHAR2,
                                   prm_fecha    IN VARCHAR2)
        RETURN cursortype
    IS
        ct              cursortype;
        fecha_reporte   DATE;
    BEGIN
        IF prm_fecha IS NULL
        THEN
            fecha_reporte := TRUNC (SYSDATE);
        ELSE
            fecha_reporte := TO_DATE (prm_fecha, 'dd/mm/yyyy');
        END IF;

        OPEN ct FOR
              SELECT                                                       --1
                    t  .itm,
                       t.nandina_ant,
                       t.nandina_u,
                       t.reg_year,
                       t.key_cuo,
                       t.reg_nber,
                       t.fecha_reg,
                       t.fecha_venc,
                       t.fecha_calculo,
                       --10
                       t.dec_fob,
                       t.dec_flete,
                       t.dec_seguro,
                       t.dec_otros,
                       t.dec_cifusd,
                       t.dec_tc,
                       t.dec_cifbs,
                       t.dec_ga,
                       t.dec_iva,
                       t.dec_ice,
                       --20
                       t.dec_iehd,
                       t.dec_icd,
                       --22
                       t.enc_fob,
                       t.enc_flete,
                       t.enc_seguro,
                       t.enc_otros,
                       t.enc_cifusd,
                       t.enc_tc,
                       t.enc_cifbs,
                       t.enc_ga,
                       --30
                       t.enc_iva,
                       t.enc_ice,
                       t.enc_iehd,
                       t.enc_icd,
                       --34
                       t.tc_ufvfecvenc,
                       t.to_ga,
                       t.to_iva,
                       t.to_ice,
                       t.to_iehd,
                       t.to_icd,
                       --40
                       t.to_ga + t.to_iva + t.to_ice + t.to_iehd + t.to_icd
                           to_total,
                       --41
                       ROUND (t.to_ga / t.tc_ufvfecvenc, 2) toufv_ga,
                       ROUND (t.to_iva / t.tc_ufvfecvenc, 2) toufv_iva,
                       ROUND (t.to_ice / t.tc_ufvfecvenc, 2) toufv_ice,
                       ROUND (t.to_iehd / t.tc_ufvfecvenc, 2) toufv_iehd,
                       ROUND (t.to_icd / t.tc_ufvfecvenc, 2) toufv_icd,
                       ROUND (
                           (  t.to_ga
                            + t.to_iva
                            + t.to_ice
                            + t.to_iehd
                            + t.to_icd)
                           / t.tc_ufvfecvenc,
                           2)
                           toufv_total,
                       t.dias,
                       ROUND (POWER (1 + (t.tc_tprfecvenc / 360), t.dias), 4)
                           formula,
                       ROUND (t.ga_dt / t.tc_ufvfecvenc, 2)
                       - ROUND (t.to_ga / t.tc_ufvfecvenc, 2)
                           itufv_ga,
                       --50
                       ROUND (t.to_iva / t.tc_ufvfecvenc, 2)
                       - ROUND (t.iva_dt / t.tc_ufvfecvenc, 2)
                           itufv_iva,
                       ROUND (t.to_ice / t.tc_ufvfecvenc, 2)
                       - ROUND (t.ice_dt / t.tc_ufvfecvenc, 2)
                           itufv_ice,
                       ROUND (t.to_iehd / t.tc_ufvfecvenc, 2)
                       - ROUND (t.iehd_dt / t.tc_ufvfecvenc, 2)
                           itufv_iehd,
                       ROUND (t.to_icd / t.tc_ufvfecvenc, 2)
                       - ROUND (t.icd_dt / t.tc_ufvfecvenc, 2)
                           itufv_icd,
                       (ROUND (
                            (  t.to_ga
                             + t.to_iva
                             + t.to_ice
                             + t.to_iehd
                             + t.to_icd)
                            / t.tc_ufvfecvenc,
                            2)
                        - ROUND (
                              (  t.ga_dt
                               + t.iva_dt
                               + t.ice_dt
                               + t.iehd_dt
                               + t.icd_dt)
                              / t.tc_ufvfecvenc,
                              2))
                           itufv_total,
                       --55
                       ROUND ( (t.to_ga + t.ga_dt) / t.tc_ufvhoy, 2) dt_ga,
                       ROUND ( (t.to_iva + t.iva_dt) / t.tc_ufvhoy, 2) dt_iva,
                       ROUND ( (t.to_ice + t.ice_dt) / t.tc_ufvhoy, 2) dt_ice,
                       ROUND ( (t.to_iehd + t.iehd_dt) / t.tc_ufvhoy, 2)
                           dt_iehd,
                       ROUND ( (t.to_icd + t.icd_dt) / t.tc_ufvhoy, 2) dt_icd,
                       --60
                       ROUND (
                           (  t.to_ga
                            + t.to_iva
                            + t.to_ice
                            + t.to_iehd
                            + t.to_icd
                            + t.ga_dt
                            + t.iva_dt
                            + t.ice_dt
                            + t.iehd_dt
                            + t.icd_dt)
                           / t.tc_ufvfecvenc,
                           2)
                           dt_total,
                       --61
                       ROUND (
                           ( (  t.to_ga
                              + t.to_iva
                              + t.to_ice
                              + t.to_iehd
                              + t.to_icd)
                            / t.tc_ufvhoy)
                           * t.tc_ufvfecvenc,
                           2)
                           sancion,
                       --62
                       ROUND (
                             t.to_ga
                           + t.to_iva
                           + t.to_ice
                           + t.to_iehd
                           + t.to_icd
                           + t.ga_dt
                           + t.iva_dt
                           + t.ice_dt
                           + t.iehd_dt
                           + t.icd_dt,
                           2)
                           adeudo_totalbs,
                       --63
                       ROUND (
                           (  t.to_ga
                            + t.to_iva
                            + t.to_ice
                            + t.to_iehd
                            + t.to_icd
                            + t.ga_dt
                            + t.iva_dt
                            + t.ice_dt
                            + t.iehd_dt
                            + t.icd_dt)
                           / t.tc_ufvhoy,
                           2)
                           adeudo_totalufv,
                       --64
                       t.tc_ufvhoy
                FROM   (SELECT   iu.itm_nber itm,
                                 ia.saditm_hs_cod || ia.saditm_hsprec_cod
                                     nandina_ant,
                                 iu.saditm_hs_cod || iu.saditm_hsprec_cod
                                     nandina_u,
                                 u.sad_reg_year reg_year,
                                 u.key_cuo key_cuo,
                                 u.sad_reg_nber reg_nber,
                                 TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                     fecha_reg,
                                 TO_CHAR (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'dd/mm/yyyy')
                                     fecha_venc,
                                 TO_CHAR (fecha_reporte, 'dd/mm/yyyy')
                                     fecha_calculo,
                                 va.sad_iitminv_valc dec_fob,
                                 va.sad_iitmefr_valc dec_flete,
                                 va.sad_iitmins_valc dec_seguro,
                                 va.sad_iitmotc_valc dec_otros,
                                 ROUND (
                                     va.sad_iitmcif_valn / va.sad_iitminv_rat,
                                     2)
                                     dec_cifusd,
                                 va.sad_iitminv_rat dec_tc,
                                 va.sad_iitmcif_valn dec_cifbs,
                                 gaa.saditm_tax_amount dec_ga,
                                 ivaa.saditm_tax_amount dec_iva,
                                 NVL (icea.saditm_tax_amount, 0) dec_ice,
                                 NVL (iehda.saditm_tax_amount, 0) dec_iehd,
                                 NVL (icda.saditm_tax_amount, 0) dec_icd,
                                 vu.sad_iitminv_valc enc_fob,
                                 vu.sad_iitmefr_valc enc_flete,
                                 vu.sad_iitmins_valc enc_seguro,
                                 vu.sad_iitmotc_valc enc_otros,
                                 ROUND (
                                     vu.sad_iitmcif_valn / vu.sad_iitminv_rat,
                                     2)
                                     enc_cifusd,
                                 vu.sad_iitminv_rat enc_tc,
                                 vu.sad_iitmcif_valn enc_cifbs,
                                 gau.saditm_tax_amount enc_ga,
                                 ivau.saditm_tax_amount enc_iva,
                                 NVL (iceu.saditm_tax_amount, 0) enc_ice,
                                 NVL (iehdu.saditm_tax_amount, 0) enc_iehd,
                                 NVL (icdu.saditm_tax_amount, 0) enc_icd,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'UFV')
                                     tc_ufvfecvenc,
                                 pkg_reporte.tipocambio (TRUNC (fecha_reporte),
                                                         'UFV')
                                     tc_ufvhoy,
                                 gau.saditm_tax_amount - gaa.saditm_tax_amount
                                     to_ga,
                                 ivau.saditm_tax_amount
                                 - ivaa.saditm_tax_amount
                                     to_iva,
                                 NVL (iceu.saditm_tax_amount, 0)
                                 - NVL (icea.saditm_tax_amount, 0)
                                     to_ice,
                                 NVL (iehdu.saditm_tax_amount, 0)
                                 - NVL (iehda.saditm_tax_amount, 0)
                                     to_iehd,
                                 NVL (icdu.saditm_tax_amount, 0)
                                 - NVL (icda.saditm_tax_amount, 0)
                                     to_icd,
                                 TRUNC (fecha_reporte)
                                 - pkg_reporte.fecha_vencimiento (
                                       u.key_cuo,
                                       TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy'))
                                     dias,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'TPR')
                                     tc_tprfecvenc,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     gau.saditm_tax_amount
                                     - gaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     ga_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     ivau.saditm_tax_amount
                                     - ivaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     iva_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iceu.saditm_tax_amount, 0)
                                     - NVL (icea.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     ice_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iehdu.saditm_tax_amount, 0)
                                     - NVL (iehda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     iehd_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (icdu.saditm_tax_amount, 0)
                                     - NVL (icda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     icd_dt
                          FROM   ops$asy.sad_gen u,
                                 ops$asy.sad_gen a,
                                 ops$asy.sad_itm iu,
                                 ops$asy.sad_itm ia,
                                 ops$asy.sad_tax gau,
                                 ops$asy.sad_tax gaa,
                                 ops$asy.sad_tax ivau,
                                 ops$asy.sad_tax ivaa,
                                 ops$asy.sad_tax iceu,
                                 ops$asy.sad_tax icea,
                                 ops$asy.sad_tax iehdu,
                                 ops$asy.sad_tax iehda,
                                 ops$asy.sad_tax icdu,
                                 ops$asy.sad_tax icda,
                                 ops$asy.sad_itm_vim vu,
                                 ops$asy.sad_itm_vim va,
                                 fis_alcance f,
                                 fis_notificacion n
                         WHERE       u.key_year = a.key_year
                                 AND u.key_cuo = a.key_cuo
                                 AND u.key_dec IS NOT NULL
                                 AND u.key_dec = a.key_dec
                                 AND u.key_nber = a.key_nber
                                 AND a.sad_num =
                                        NVL (
                                            (SELECT   MIN (x.sad_pst_num)
                                               FROM   ops$asy.sad_gen x
                                              WHERE   x.key_cuo = u.key_cuo
                                                      AND x.sad_reg_year =
                                                             u.sad_reg_year
                                                      AND x.sad_reg_serial =
                                                             u.sad_reg_serial
                                                      AND x.sad_reg_nber =
                                                             u.sad_reg_nber
                                                      AND x.sad_pst_dat >=
                                                             n.not_fecha_notificacion),
                                            0)
                                 AND u.sad_flw = 1
                                 AND u.sad_num = 0
                                 AND u.lst_ope = 'U'
                                 AND u.key_year = iu.key_year
                                 AND u.key_cuo = iu.key_cuo
                                 AND u.key_dec = iu.key_dec
                                 AND u.key_nber = iu.key_nber
                                 AND u.sad_num = iu.sad_num
                                 AND a.key_year = ia.key_year
                                 AND a.key_cuo = ia.key_cuo
                                 AND a.key_dec = ia.key_dec
                                 AND a.key_nber = ia.key_nber
                                 AND a.sad_num = ia.sad_num
                                 AND iu.key_year = ia.key_year
                                 AND iu.key_cuo = ia.key_cuo
                                 AND iu.key_dec = ia.key_dec
                                 AND iu.key_nber = ia.key_nber
                                 AND iu.itm_nber = ia.itm_nber
                                 --tributo GA
                                 AND iu.key_year = gau.key_year
                                 AND iu.key_cuo = gau.key_cuo
                                 AND iu.key_dec = gau.key_dec
                                 AND iu.key_nber = gau.key_nber
                                 AND iu.itm_nber = gau.itm_nber
                                 AND iu.sad_num = gau.sad_num
                                 AND gau.saditm_tax_code = 'GA'
                                 AND ia.key_year = gaa.key_year
                                 AND ia.key_cuo = gaa.key_cuo
                                 AND ia.key_dec = gaa.key_dec
                                 AND ia.key_nber = gaa.key_nber
                                 AND ia.itm_nber = gaa.itm_nber
                                 AND ia.sad_num = gaa.sad_num
                                 AND gaa.saditm_tax_code = 'GA'
                                 --tributo IVA
                                 AND iu.key_year = ivau.key_year
                                 AND iu.key_cuo = ivau.key_cuo
                                 AND iu.key_dec = ivau.key_dec
                                 AND iu.key_nber = ivau.key_nber
                                 AND iu.itm_nber = ivau.itm_nber
                                 AND iu.sad_num = ivau.sad_num
                                 AND ivau.saditm_tax_code = 'IVA'
                                 AND ia.key_year = ivaa.key_year
                                 AND ia.key_cuo = ivaa.key_cuo
                                 AND ia.key_dec = ivaa.key_dec
                                 AND ia.key_nber = ivaa.key_nber
                                 AND ia.itm_nber = ivaa.itm_nber
                                 AND ia.sad_num = ivaa.sad_num
                                 AND ivaa.saditm_tax_code = 'IVA'
                                 --tributo ICE
                                 AND iu.key_year = iceu.key_year(+)
                                 AND iu.key_cuo = iceu.key_cuo(+)
                                 AND iu.key_dec = iceu.key_dec(+)
                                 AND iu.key_nber = iceu.key_nber(+)
                                 AND iu.itm_nber = iceu.itm_nber(+)
                                 AND iu.sad_num = iceu.sad_num(+)
                                 AND iceu.saditm_tax_code(+) = 'ICE'
                                 AND ia.key_year = icea.key_year(+)
                                 AND ia.key_cuo = icea.key_cuo(+)
                                 AND ia.key_dec = icea.key_dec(+)
                                 AND ia.key_nber = icea.key_nber(+)
                                 AND ia.itm_nber = icea.itm_nber(+)
                                 AND ia.sad_num = icea.sad_num(+)
                                 AND icea.saditm_tax_code(+) = 'ICE'
                                 --tributo IEHD
                                 AND iu.key_year = iehdu.key_year(+)
                                 AND iu.key_cuo = iehdu.key_cuo(+)
                                 AND iu.key_dec = iehdu.key_dec(+)
                                 AND iu.key_nber = iehdu.key_nber(+)
                                 AND iu.itm_nber = iehdu.itm_nber(+)
                                 AND iu.sad_num = iehdu.sad_num(+)
                                 AND iehdu.saditm_tax_code(+) = 'IEHD'
                                 AND ia.key_year = iehda.key_year(+)
                                 AND ia.key_cuo = iehda.key_cuo(+)
                                 AND ia.key_dec = iehda.key_dec(+)
                                 AND ia.key_nber = iehda.key_nber(+)
                                 AND ia.itm_nber = iehda.itm_nber(+)
                                 AND ia.sad_num = iehda.sad_num(+)
                                 AND iehda.saditm_tax_code(+) = 'IEHD'
                                 --tributo ICD
                                 AND iu.key_year = icdu.key_year(+)
                                 AND iu.key_cuo = icdu.key_cuo(+)
                                 AND iu.key_dec = icdu.key_dec(+)
                                 AND iu.key_nber = icdu.key_nber(+)
                                 AND iu.itm_nber = icdu.itm_nber(+)
                                 AND iu.sad_num = icdu.sad_num(+)
                                 AND icdu.saditm_tax_code(+) = 'ICD'
                                 AND ia.key_year = icda.key_year(+)
                                 AND ia.key_cuo = icda.key_cuo(+)
                                 AND ia.key_dec = icda.key_dec(+)
                                 AND ia.key_nber = icda.key_nber(+)
                                 AND ia.itm_nber = icda.itm_nber(+)
                                 AND ia.sad_num = icda.sad_num(+)
                                 AND icda.saditm_tax_code(+) = 'ICD'
                                 --para los valores FOB FLETE SEGURO OTROS CIF
                                 AND iu.key_year = vu.key_year
                                 AND iu.key_cuo = vu.key_cuo
                                 AND iu.key_dec = vu.key_dec
                                 AND iu.key_nber = vu.key_nber
                                 AND iu.itm_nber = vu.itm_nber
                                 AND iu.sad_num = vu.sad_num
                                 AND ia.key_year = va.key_year
                                 AND ia.key_cuo = va.key_cuo
                                 AND ia.key_dec = va.key_dec
                                 AND ia.key_nber = va.key_nber
                                 AND ia.itm_nber = va.itm_nber
                                 AND ia.sad_num = va.sad_num
                                 --para recuperar informacion del control
                                 AND f.alc_tipo_tramite = 'DUI'
                                 AND f.alc_gestion = u.sad_reg_year
                                 AND f.alc_aduana = u.key_cuo
                                 AND u.sad_reg_serial = 'C'
                                 AND f.alc_numero = u.sad_reg_nber
                                 AND f.ctl_control_id = prm_codigo
                                 AND f.alc_num = 0
                                 AND f.alc_lstope = 'U'
                                 AND f.ctl_control_id = n.ctl_control_id
                                 AND n.not_num = 0
                                 AND n.not_lstope = 'U'
                        UNION
                        SELECT   iu.itm_nber itm,
                                 ia.saditm_hs_cod || ia.saditm_hsprec_cod
                                     nandina_ant,
                                 iu.saditm_hs_cod || iu.saditm_hsprec_cod
                                     nandina_u,
                                 u.sad_reg_year reg_year,
                                 u.key_cuo key_cuo,
                                 u.sad_reg_nber reg_nber,
                                 TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                     fecha_reg,
                                 TO_CHAR (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'dd/mm/yyyy')
                                     fecha_venc,
                                 TO_CHAR (fecha_reporte, 'dd/mm/yyyy')
                                     fecha_calculo,
                                 va.sad_iitminv_valc dec_fob,
                                 va.sad_iitmefr_valc dec_flete,
                                 va.sad_iitmins_valc dec_seguro,
                                 va.sad_iitmotc_valc dec_otros,
                                 ROUND (
                                     va.sad_iitmcif_valn / va.sad_iitminv_rat,
                                     2)
                                     dec_cifusd,
                                 va.sad_iitminv_rat dec_tc,
                                 va.sad_iitmcif_valn dec_cifbs,
                                 gaa.saditm_tax_amount dec_ga,
                                 ivaa.saditm_tax_amount dec_iva,
                                 NVL (icea.saditm_tax_amount, 0) dec_ice,
                                 NVL (iehda.saditm_tax_amount, 0) dec_iehd,
                                 NVL (icda.saditm_tax_amount, 0) dec_icd,
                                 vu.sad_iitminv_valc enc_fob,
                                 vu.sad_iitmefr_valc enc_flete,
                                 vu.sad_iitmins_valc enc_seguro,
                                 vu.sad_iitmotc_valc enc_otros,
                                 ROUND (
                                     vu.sad_iitmcif_valn / vu.sad_iitminv_rat,
                                     2)
                                     enc_cifusd,
                                 vu.sad_iitminv_rat enc_tc,
                                 vu.sad_iitmcif_valn enc_cifbs,
                                 gau.saditm_tax_amount enc_ga,
                                 ivau.saditm_tax_amount enc_iva,
                                 NVL (iceu.saditm_tax_amount, 0) enc_ice,
                                 NVL (iehdu.saditm_tax_amount, 0) enc_iehd,
                                 NVL (icdu.saditm_tax_amount, 0) enc_icd,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'UFV')
                                     tc_ufvfecvenc,
                                 pkg_reporte.tipocambio (TRUNC (fecha_reporte),
                                                         'UFV')
                                     tc_ufvhoy,
                                 gau.saditm_tax_amount - gaa.saditm_tax_amount
                                     to_ga,
                                 ivau.saditm_tax_amount
                                 - ivaa.saditm_tax_amount
                                     to_iva,
                                 NVL (iceu.saditm_tax_amount, 0)
                                 - NVL (icea.saditm_tax_amount, 0)
                                     to_ice,
                                 NVL (iehdu.saditm_tax_amount, 0)
                                 - NVL (iehda.saditm_tax_amount, 0)
                                     to_iehd,
                                 NVL (icdu.saditm_tax_amount, 0)
                                 - NVL (icda.saditm_tax_amount, 0)
                                     to_icd,
                                 TRUNC (fecha_reporte)
                                 - pkg_reporte.fecha_vencimiento (
                                       u.key_cuo,
                                       TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy'))
                                     dias,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'TPR')
                                     tc_tprfecvenc,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     gau.saditm_tax_amount
                                     - gaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     ga_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     ivau.saditm_tax_amount
                                     - ivaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     iva_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iceu.saditm_tax_amount, 0)
                                     - NVL (icea.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     ice_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iehdu.saditm_tax_amount, 0)
                                     - NVL (iehda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     iehd_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (icdu.saditm_tax_amount, 0)
                                     - NVL (icda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     icd_dt
                          FROM   ops$asy.sad_gen u,
                                 ops$asy.sad_gen a,
                                 ops$asy.sad_itm iu,
                                 ops$asy.sad_itm ia,
                                 ops$asy.sad_tax gau,
                                 ops$asy.sad_tax gaa,
                                 ops$asy.sad_tax ivau,
                                 ops$asy.sad_tax ivaa,
                                 ops$asy.sad_tax iceu,
                                 ops$asy.sad_tax icea,
                                 ops$asy.sad_tax iehdu,
                                 ops$asy.sad_tax iehda,
                                 ops$asy.sad_tax icdu,
                                 ops$asy.sad_tax icda,
                                 ops$asy.sad_itm_vim vu,
                                 ops$asy.sad_itm_vim va,
                                 fis_alcance f,
                                 fis_notificacion n
                         WHERE       u.key_year = a.key_year
                                 AND u.key_cuo = a.key_cuo
                                 AND u.key_dec IS NULL
                                 AND a.key_dec IS NULL
                                 AND u.key_nber = a.key_nber
                                 AND a.sad_num =
                                        NVL (
                                            (SELECT   MIN (x.sad_pst_num)
                                               FROM   ops$asy.sad_gen x
                                              WHERE   x.key_cuo = u.key_cuo
                                                      AND x.sad_reg_year =
                                                             u.sad_reg_year
                                                      AND x.sad_reg_serial =
                                                             u.sad_reg_serial
                                                      AND x.sad_reg_nber =
                                                             u.sad_reg_nber
                                                      AND x.sad_pst_dat >=
                                                             n.not_fecha_notificacion),
                                            0)
                                 AND u.sad_flw = 1
                                 AND u.sad_num = 0
                                 AND u.lst_ope = 'U'
                                 AND u.key_year = iu.key_year
                                 AND u.key_cuo = iu.key_cuo
                                 AND iu.key_dec IS NULL
                                 AND u.key_nber = iu.key_nber
                                 AND u.sad_num = iu.sad_num
                                 AND a.key_year = ia.key_year
                                 AND a.key_cuo = ia.key_cuo
                                 AND ia.key_dec IS NULL
                                 AND a.key_nber = ia.key_nber
                                 AND a.sad_num = ia.sad_num
                                 AND iu.key_year = ia.key_year
                                 AND iu.key_cuo = ia.key_cuo
                                 AND iu.key_nber = ia.key_nber
                                 AND iu.itm_nber = ia.itm_nber
                                 --tributo GA
                                 AND iu.key_year = gau.key_year
                                 AND iu.key_cuo = gau.key_cuo
                                 AND gau.key_dec IS NULL
                                 AND iu.key_nber = gau.key_nber
                                 AND iu.itm_nber = gau.itm_nber
                                 AND iu.sad_num = gau.sad_num
                                 AND gau.saditm_tax_code = 'GA'
                                 AND ia.key_year = gaa.key_year
                                 AND ia.key_cuo = gaa.key_cuo
                                 AND gaa.key_dec IS NULL
                                 AND ia.key_nber = gaa.key_nber
                                 AND ia.itm_nber = gaa.itm_nber
                                 AND ia.sad_num = gaa.sad_num
                                 AND gaa.saditm_tax_code = 'GA'
                                 --tributo IVA
                                 AND iu.key_year = ivau.key_year
                                 AND iu.key_cuo = ivau.key_cuo
                                 AND ivau.key_dec IS NULL
                                 AND iu.key_nber = ivau.key_nber
                                 AND iu.itm_nber = ivau.itm_nber
                                 AND iu.sad_num = ivau.sad_num
                                 AND ivau.saditm_tax_code = 'IVA'
                                 AND ia.key_year = ivaa.key_year
                                 AND ia.key_cuo = ivaa.key_cuo
                                 AND ivaa.key_dec IS NULL
                                 AND ia.key_nber = ivaa.key_nber
                                 AND ia.itm_nber = ivaa.itm_nber
                                 AND ia.sad_num = ivaa.sad_num
                                 AND ivaa.saditm_tax_code = 'IVA'
                                 --tributo ICE
                                 AND iu.key_year = iceu.key_year(+)
                                 AND iu.key_cuo = iceu.key_cuo(+)
                                 AND iceu.key_dec(+) IS NULL
                                 AND iu.key_nber = iceu.key_nber(+)
                                 AND iu.itm_nber = iceu.itm_nber(+)
                                 AND iu.sad_num = iceu.sad_num(+)
                                 AND iceu.saditm_tax_code(+) = 'ICE'
                                 AND ia.key_year = icea.key_year(+)
                                 AND ia.key_cuo = icea.key_cuo(+)
                                 AND icea.key_dec(+) IS NULL
                                 AND ia.key_nber = icea.key_nber(+)
                                 AND ia.itm_nber = icea.itm_nber(+)
                                 AND ia.sad_num = icea.sad_num(+)
                                 AND icea.saditm_tax_code(+) = 'ICE'
                                 --tributo IEHD
                                 AND iu.key_year = iehdu.key_year(+)
                                 AND iu.key_cuo = iehdu.key_cuo(+)
                                 AND iehdu.key_dec(+) IS NULL
                                 AND iu.key_nber = iehdu.key_nber(+)
                                 AND iu.itm_nber = iehdu.itm_nber(+)
                                 AND iu.sad_num = iehdu.sad_num(+)
                                 AND iehdu.saditm_tax_code(+) = 'IEHD'
                                 AND ia.key_year = iehda.key_year(+)
                                 AND ia.key_cuo = iehda.key_cuo(+)
                                 AND iehda.key_dec(+) IS NULL
                                 AND ia.key_nber = iehda.key_nber(+)
                                 AND ia.itm_nber = iehda.itm_nber(+)
                                 AND ia.sad_num = iehda.sad_num(+)
                                 AND iehda.saditm_tax_code(+) = 'IEHD'
                                 --tributo ICD
                                 AND iu.key_year = icdu.key_year(+)
                                 AND iu.key_cuo = icdu.key_cuo(+)
                                 AND icdu.key_dec(+) IS NULL
                                 AND iu.key_nber = icdu.key_nber(+)
                                 AND iu.itm_nber = icdu.itm_nber(+)
                                 AND iu.sad_num = icdu.sad_num(+)
                                 AND icdu.saditm_tax_code(+) = 'ICD'
                                 AND ia.key_year = icda.key_year(+)
                                 AND ia.key_cuo = icda.key_cuo(+)
                                 AND icda.key_dec(+) IS NULL
                                 AND ia.key_nber = icda.key_nber(+)
                                 AND ia.itm_nber = icda.itm_nber(+)
                                 AND ia.sad_num = icda.sad_num(+)
                                 AND icda.saditm_tax_code(+) = 'ICD'
                                 --para los valores FOB FLETE SEGURO OTROS CIF
                                 AND iu.key_year = vu.key_year
                                 AND iu.key_cuo = vu.key_cuo
                                 AND vu.key_dec IS NULL
                                 AND iu.key_nber = vu.key_nber
                                 AND iu.itm_nber = vu.itm_nber
                                 AND iu.sad_num = vu.sad_num
                                 AND ia.key_year = va.key_year
                                 AND ia.key_cuo = va.key_cuo
                                 AND va.key_dec IS NULL
                                 AND ia.key_nber = va.key_nber
                                 AND ia.itm_nber = va.itm_nber
                                 AND ia.sad_num = va.sad_num
                                 --para recuperar informacion del control
                                 AND f.alc_tipo_tramite = 'DUI'
                                 AND f.alc_gestion = u.sad_reg_year
                                 AND f.alc_aduana = u.key_cuo
                                 AND u.sad_reg_serial = 'C'
                                 AND f.alc_numero = u.sad_reg_nber
                                 AND f.ctl_control_id = prm_codigo
                                 AND f.alc_num = 0
                                 AND f.alc_lstope = 'U'
                                 AND f.ctl_control_id = n.ctl_control_id
                                 AND n.not_num = 0
                                 AND n.not_lstope = 'U') t
            ORDER BY   4,
                       5,
                       6,
                       1;

        RETURN ct;
    END;

    FUNCTION dev_tributoomitidofechatotal (prm_codigo   IN VARCHAR2,
                                           prm_fecha    IN VARCHAR2)
        RETURN cursortype
    IS
        ct                cursortype;
        fecha_reporte     DATE;
        vcontravdui       NUMBER (18, 2);
        vcontravorden     NUMBER (18, 2);

        vsancioncontrab   NUMBER (18, 2);
        vsanciondefraud   NUMBER (18, 2);
        vsanciondelito    NUMBER (18, 2);
    BEGIN
        --Determinar las sancones por ilicitos

        SELECT   SUM (cif)
          INTO   vsancioncontrab
          FROM   (SELECT   i.saditm_stat_val cif
                    FROM   fis_alcance a,
                           fis_resultados b,
                           ops$asy.sad_gen g,
                           ops$asy.sad_itm i
                   WHERE       a.ctl_control_id = prm_codigo
                           AND a.alc_num = 0
                           AND a.alc_lstope = 'U'
                           AND a.alc_alcance_id = b.alc_alcance_id
                           AND b.res_num = 0
                           AND b.res_lstope = 'U'
                           AND b.res_ilicito = 'CONTRABANDO CONTRAVENCIONAL'
                           AND g.sad_num = 0
                           AND g.lst_ope = 'U'
                           AND i.sad_num = 0
                           AND g.key_year = i.key_year
                           AND g.key_cuo = i.key_cuo
                           AND g.key_dec = i.key_dec
                           AND g.key_nber = i.key_nber
                           AND g.sad_reg_year = SUBSTR (b.res_dui, 1, 4)
                           AND g.key_cuo = SUBSTR (b.res_dui, 6, 3)
                           AND g.sad_reg_serial = 'C'
                           AND g.sad_reg_nber = SUBSTR (b.res_dui, 12)
                           AND i.itm_nber = b.res_numero_item
                  UNION
                  SELECT   ret_cif_bob cif
                    FROM   fis_alcance a, fis_resultados_tramite b
                   WHERE       a.ctl_control_id = prm_codigo
                           AND a.alc_num = 0
                           AND a.alc_lstope = 'U'
                           AND a.alc_alcance_id = b.alc_alcance_id
                           AND b.ret_num = 0
                           AND b.ret_lstope = 'U'
                           AND ret_ilicito = 'CONTRABANDO CONTRAVENCIONAL')
                 tbl;

        SELECT   SUM (cif)
          INTO   vsancioncontrab
          FROM   (SELECT   i.saditm_stat_val cif
                    FROM   fis_alcance a,
                           fis_resultados b,
                           ops$asy.sad_gen g,
                           ops$asy.sad_itm i
                   WHERE       a.ctl_control_id = prm_codigo
                           AND a.alc_num = 0
                           AND a.alc_lstope = 'U'
                           AND a.alc_alcance_id = b.alc_alcance_id
                           AND b.res_num = 0
                           AND b.res_lstope = 'U'
                           AND b.res_ilicito = 'CONTRABANDO DELITO'
                           AND g.sad_num = 0
                           AND g.lst_ope = 'U'
                           AND i.sad_num = 0
                           AND g.key_year = i.key_year
                           AND g.key_cuo = i.key_cuo
                           AND g.key_dec = i.key_dec
                           AND g.key_nber = i.key_nber
                           AND g.sad_reg_year = SUBSTR (b.res_dui, 1, 4)
                           AND g.key_cuo = SUBSTR (b.res_dui, 6, 3)
                           AND g.sad_reg_serial = 'C'
                           AND g.sad_reg_nber = SUBSTR (b.res_dui, 12)
                           AND i.itm_nber = b.res_numero_item
                  UNION
                  SELECT   ret_cif_bob cif
                    FROM   fis_alcance a, fis_resultados_tramite b
                   WHERE       a.ctl_control_id = prm_codigo
                           AND a.alc_num = 0
                           AND a.alc_lstope = 'U'
                           AND a.alc_alcance_id = b.alc_alcance_id
                           AND b.ret_num = 0
                           AND b.ret_lstope = 'U'
                           AND ret_ilicito = 'CONTRABANDO DELITO') tbl;

        SELECT   SUM (cif)
          INTO   vsancioncontrab
          FROM   (SELECT   i.saditm_stat_val cif
                    FROM   fis_alcance a,
                           fis_resultados b,
                           ops$asy.sad_gen g,
                           ops$asy.sad_itm i
                   WHERE       a.ctl_control_id = prm_codigo
                           AND a.alc_num = 0
                           AND a.alc_lstope = 'U'
                           AND a.alc_alcance_id = b.alc_alcance_id
                           AND b.res_num = 0
                           AND b.res_lstope = 'U'
                           AND b.res_ilicito = 'OTROS DELITOS'
                           AND g.sad_num = 0
                           AND g.lst_ope = 'U'
                           AND i.sad_num = 0
                           AND g.key_year = i.key_year
                           AND g.key_cuo = i.key_cuo
                           AND g.key_dec = i.key_dec
                           AND g.key_nber = i.key_nber
                           AND g.sad_reg_year = SUBSTR (b.res_dui, 1, 4)
                           AND g.key_cuo = SUBSTR (b.res_dui, 6, 3)
                           AND g.sad_reg_serial = 'C'
                           AND g.sad_reg_nber = SUBSTR (b.res_dui, 12)
                           AND i.itm_nber = b.res_numero_item
                  UNION
                  SELECT   ret_cif_bob cif
                    FROM   fis_alcance a, fis_resultados_tramite b
                   WHERE       a.ctl_control_id = prm_codigo
                           AND a.alc_num = 0
                           AND a.alc_lstope = 'U'
                           AND a.alc_alcance_id = b.alc_alcance_id
                           AND b.ret_num = 0
                           AND b.ret_lstope = 'U'
                           AND ret_ilicito = 'OTROS DELITOS') tbl;


        --Determinar las contravenciones
        SELECT   ROUND (SUM (contravdui), 2), ROUND (SUM (contravorden), 2)
          INTO   vcontravdui, vcontravorden
          FROM   (SELECT   SUM (b.res_contrav)
                           * pkg_reporte.tipocambio (
                                 TO_DATE (prm_fecha, 'dd/mm/yyyy'),
                                 'UFV')
                               contravdui,
                           SUM (b.res_contravorden)
                           * pkg_reporte.tipocambio (
                                 TO_DATE (prm_fecha, 'dd/mm/yyyy'),
                                 'UFV')
                               contravorden
                    FROM   fis_alcance a, fis_resultados b
                   WHERE       a.ctl_control_id = prm_codigo
                           AND a.alc_num = 0
                           AND a.alc_lstope = 'U'
                           AND a.alc_alcance_id = b.alc_alcance_id
                           AND b.res_num = 0
                           AND b.res_lstope = 'U'
                  UNION
                  SELECT   0 contravdui,
                           SUM (NVL (b.ret_contravorden, 0))
                           * pkg_reporte.tipocambio (
                                 TO_DATE (prm_fecha, 'dd/mm/yyyy'),
                                 'UFV')
                               contravorden
                    FROM   fis_alcance a, fis_resultados_tramite b
                   WHERE       a.ctl_control_id = prm_codigo
                           AND a.alc_num = 0
                           AND a.alc_lstope = 'U'
                           AND a.alc_alcance_id = b.alc_alcance_id
                           AND b.ret_num = 0
                           AND b.ret_lstope = 'U') tbl;

        OPEN ct FOR
            SELECT   0 sancionomision,
                     NVL (vcontravdui, 0) contravdui,
                     NVL (vcontravorden, 0) contravorden,
                     NVL (vsancioncontrab, 0) sancioncontrabando,
                     NVL (vsanciondefraud, 0) sanciondefraudacion,
                     NVL (vsanciondelito, 0) delito
              FROM   DUAL;



        RETURN ct;
    END;

    FUNCTION dev_tributoomitidofecha (prm_codigo   IN VARCHAR2,
                                      prm_fecha    IN VARCHAR2)
        RETURN cursortype
    IS
        ct              cursortype;
        fecha_reporte   DATE;
    BEGIN
        IF prm_fecha IS NULL
        THEN
            fecha_reporte := TRUNC (SYSDATE);
        ELSE
            fecha_reporte := TO_DATE (prm_fecha, 'dd/mm/yyyy');
        END IF;

        OPEN ct FOR
              SELECT   t.reg_year,
                       t.key_cuo,
                       t.reg_nber,
                       t.fecha_reg,
                       ROUND (SUM (t.to_ga) + SUM (t.ga_dt), 2) dt_ga,
                       ROUND (SUM (t.to_iva) + SUM (t.iva_dt), 2) dt_iva,
                       ROUND (SUM (t.to_ice) + SUM (t.ice_dt), 2) dt_ice,
                       ROUND (SUM (t.to_iehd) + SUM (t.iehd_dt), 2) dt_iehd,
                       ROUND (SUM (t.to_icd) + SUM (t.icd_dt), 2) dt_icd,
                       ROUND (
                             SUM (t.to_ga)
                           + SUM (t.to_iva)
                           + SUM (t.to_ice)
                           + SUM (t.to_iehd)
                           + SUM (t.to_icd)
                           + SUM (t.ga_dt)
                           + SUM (t.iva_dt)
                           + SUM (t.ice_dt)
                           + SUM (t.iehd_dt)
                           + SUM (t.icd_dt),
                           2)
                           adeudo_totalbs,
                       ROUND (
                             SUM (t.to_ga)
                           + SUM (t.to_iva)
                           + SUM (t.to_ice)
                           + SUM (t.to_iehd)
                           + SUM (t.to_icd),
                           2)
                           totot,
                       t.tc_ufvhoy / t.tc_ufvfecvenc facufvact,
                       ROUND (
                           (  SUM (t.to_ga)
                            + SUM (t.to_iva)
                            + SUM (t.to_ice)
                            + SUM (t.to_iehd)
                            + SUM (t.to_icd))
                           * t.tc_ufvhoy
                           / t.tc_ufvfecvenc,
                           2)
                           toactbs,
                       t.fec_notvc,
                       TO_CHAR (
                           pkg_reporte.aumentardiashabiles (
                               pkg_general.devuelve_gerencia (prm_codigo),
                               t.fec_notvc,
                               10),
                           'dd/mm/yyyy')
                           fec_notvc10,
                       t.fec_notrdvc,
                       TRUNC (fecha_reporte)
                       - TRUNC(pkg_reporte.aumentardiashabiles (
                                   pkg_general.devuelve_gerencia (prm_codigo),
                                   t.fec_notvc,
                                   10))
                           dias_notvc,
                       TRUNC (fecha_reporte)
                       - TRUNC (TO_DATE (t.fec_notrdvc, 'dd/mm/yyyy'))
                           dias_notrdvc
                FROM   (SELECT   iu.itm_nber itm,
                                 ia.saditm_hs_cod || ia.saditm_hsprec_cod
                                     nandina_ant,
                                 iu.saditm_hs_cod || iu.saditm_hsprec_cod
                                     nandina_u,
                                 u.sad_reg_year reg_year,
                                 u.key_cuo key_cuo,
                                 u.sad_reg_nber reg_nber,
                                 TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                     fecha_reg,
                                 TO_CHAR (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'dd/mm/yyyy')
                                     fecha_venc,
                                 TO_CHAR (fecha_reporte, 'dd/mm/yyyy')
                                     fecha_calculo,
                                 va.sad_iitminv_valc dec_fob,
                                 va.sad_iitmefr_valc dec_flete,
                                 va.sad_iitmins_valc dec_seguro,
                                 va.sad_iitmotc_valc dec_otros,
                                 ROUND (
                                     va.sad_iitmcif_valn / va.sad_iitminv_rat,
                                     2)
                                     dec_cifusd,
                                 va.sad_iitminv_rat dec_tc,
                                 va.sad_iitmcif_valn dec_cifbs,
                                 gaa.saditm_tax_amount dec_ga,
                                 ivaa.saditm_tax_amount dec_iva,
                                 NVL (icea.saditm_tax_amount, 0) dec_ice,
                                 NVL (iehda.saditm_tax_amount, 0) dec_iehd,
                                 NVL (icda.saditm_tax_amount, 0) dec_icd,
                                 vu.sad_iitminv_valc enc_fob,
                                 vu.sad_iitmefr_valc enc_flete,
                                 vu.sad_iitmins_valc enc_seguro,
                                 vu.sad_iitmotc_valc enc_otros,
                                 ROUND (
                                     vu.sad_iitmcif_valn / vu.sad_iitminv_rat,
                                     2)
                                     enc_cifusd,
                                 vu.sad_iitminv_rat enc_tc,
                                 vu.sad_iitmcif_valn enc_cifbs,
                                 gau.saditm_tax_amount enc_ga,
                                 ivau.saditm_tax_amount enc_iva,
                                 NVL (iceu.saditm_tax_amount, 0) enc_ice,
                                 NVL (iehdu.saditm_tax_amount, 0) enc_iehd,
                                 NVL (icdu.saditm_tax_amount, 0) enc_icd,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'UFV')
                                     tc_ufvfecvenc,
                                 pkg_reporte.tipocambio (TRUNC (fecha_reporte),
                                                         'UFV')
                                     tc_ufvhoy,
                                 gau.saditm_tax_amount - gaa.saditm_tax_amount
                                     to_ga,
                                 ivau.saditm_tax_amount
                                 - ivaa.saditm_tax_amount
                                     to_iva,
                                 NVL (iceu.saditm_tax_amount, 0)
                                 - NVL (icea.saditm_tax_amount, 0)
                                     to_ice,
                                 NVL (iehdu.saditm_tax_amount, 0)
                                 - NVL (iehda.saditm_tax_amount, 0)
                                     to_iehd,
                                 NVL (icdu.saditm_tax_amount, 0)
                                 - NVL (icda.saditm_tax_amount, 0)
                                     to_icd,
                                 TRUNC (fecha_reporte)
                                 - pkg_reporte.fecha_vencimiento (
                                       u.key_cuo,
                                       TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy'))
                                     dias,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'TPR')
                                     tc_tprfecvenc,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     gau.saditm_tax_amount
                                     - gaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     ga_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     ivau.saditm_tax_amount
                                     - ivaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     iva_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iceu.saditm_tax_amount, 0)
                                     - NVL (icea.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     ice_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iehdu.saditm_tax_amount, 0)
                                     - NVL (iehda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     iehd_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (icdu.saditm_tax_amount, 0)
                                     - NVL (icda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     icd_dt,
                                 TO_CHAR (vc.cvc_fecha_notificacion,
                                          'dd/mm/yyyy')
                                     fec_notvc,
                                 TO_CHAR (vc.cvc_fecha_rd, 'dd/mm/yyyy')
                                     fec_notrdvc
                          FROM   ops$asy.sad_gen u,
                                 ops$asy.sad_gen a,
                                 ops$asy.sad_itm iu,
                                 ops$asy.sad_itm ia,
                                 ops$asy.sad_tax gau,
                                 ops$asy.sad_tax gaa,
                                 ops$asy.sad_tax ivau,
                                 ops$asy.sad_tax ivaa,
                                 ops$asy.sad_tax iceu,
                                 ops$asy.sad_tax icea,
                                 ops$asy.sad_tax iehdu,
                                 ops$asy.sad_tax iehda,
                                 ops$asy.sad_tax icdu,
                                 ops$asy.sad_tax icda,
                                 ops$asy.sad_itm_vim vu,
                                 ops$asy.sad_itm_vim va,
                                 fis_alcance f,
                                 fis_notificacion n,
                                 fis_con_viscargo vc
                         WHERE       u.key_year = a.key_year
                                 AND u.key_cuo = a.key_cuo
                                 AND u.key_dec IS NOT NULL
                                 AND u.key_dec = a.key_dec
                                 AND u.key_nber = a.key_nber
                                 AND a.sad_num =
                                        NVL (
                                            (SELECT   MIN (x.sad_pst_num)
                                               FROM   ops$asy.sad_gen x
                                              WHERE   x.key_cuo = u.key_cuo
                                                      AND x.sad_reg_year =
                                                             u.sad_reg_year
                                                      AND x.sad_reg_serial =
                                                             u.sad_reg_serial
                                                      AND x.sad_reg_nber =
                                                             u.sad_reg_nber
                                                      AND x.sad_pst_dat >=
                                                             n.not_fecha_notificacion),
                                            0)
                                 AND u.sad_flw = 1
                                 AND u.sad_num = 0
                                 AND u.lst_ope = 'U'
                                 AND u.key_year = iu.key_year
                                 AND u.key_cuo = iu.key_cuo
                                 AND u.key_dec = iu.key_dec
                                 AND u.key_nber = iu.key_nber
                                 AND u.sad_num = iu.sad_num
                                 AND a.key_year = ia.key_year
                                 AND a.key_cuo = ia.key_cuo
                                 AND a.key_dec = ia.key_dec
                                 AND a.key_nber = ia.key_nber
                                 AND a.sad_num = ia.sad_num
                                 AND iu.key_year = ia.key_year
                                 AND iu.key_cuo = ia.key_cuo
                                 AND iu.key_dec = ia.key_dec
                                 AND iu.key_nber = ia.key_nber
                                 AND iu.itm_nber = ia.itm_nber
                                 --tributo GA
                                 AND iu.key_year = gau.key_year
                                 AND iu.key_cuo = gau.key_cuo
                                 AND iu.key_dec = gau.key_dec
                                 AND iu.key_nber = gau.key_nber
                                 AND iu.itm_nber = gau.itm_nber
                                 AND iu.sad_num = gau.sad_num
                                 AND gau.saditm_tax_code = 'GA'
                                 AND ia.key_year = gaa.key_year
                                 AND ia.key_cuo = gaa.key_cuo
                                 AND ia.key_dec = gaa.key_dec
                                 AND ia.key_nber = gaa.key_nber
                                 AND ia.itm_nber = gaa.itm_nber
                                 AND ia.sad_num = gaa.sad_num
                                 AND gaa.saditm_tax_code = 'GA'
                                 --tributo IVA
                                 AND iu.key_year = ivau.key_year
                                 AND iu.key_cuo = ivau.key_cuo
                                 AND iu.key_dec = ivau.key_dec
                                 AND iu.key_nber = ivau.key_nber
                                 AND iu.itm_nber = ivau.itm_nber
                                 AND iu.sad_num = ivau.sad_num
                                 AND ivau.saditm_tax_code = 'IVA'
                                 AND ia.key_year = ivaa.key_year
                                 AND ia.key_cuo = ivaa.key_cuo
                                 AND ia.key_dec = ivaa.key_dec
                                 AND ia.key_nber = ivaa.key_nber
                                 AND ia.itm_nber = ivaa.itm_nber
                                 AND ia.sad_num = ivaa.sad_num
                                 AND ivaa.saditm_tax_code = 'IVA'
                                 --tributo ICE
                                 AND iu.key_year = iceu.key_year(+)
                                 AND iu.key_cuo = iceu.key_cuo(+)
                                 AND iu.key_dec = iceu.key_dec(+)
                                 AND iu.key_nber = iceu.key_nber(+)
                                 AND iu.itm_nber = iceu.itm_nber(+)
                                 AND iu.sad_num = iceu.sad_num(+)
                                 AND iceu.saditm_tax_code(+) = 'ICE'
                                 AND ia.key_year = icea.key_year(+)
                                 AND ia.key_cuo = icea.key_cuo(+)
                                 AND ia.key_dec = icea.key_dec(+)
                                 AND ia.key_nber = icea.key_nber(+)
                                 AND ia.itm_nber = icea.itm_nber(+)
                                 AND ia.sad_num = icea.sad_num(+)
                                 AND icea.saditm_tax_code(+) = 'ICE'
                                 --tributo IEHD
                                 AND iu.key_year = iehdu.key_year(+)
                                 AND iu.key_cuo = iehdu.key_cuo(+)
                                 AND iu.key_dec = iehdu.key_dec(+)
                                 AND iu.key_nber = iehdu.key_nber(+)
                                 AND iu.itm_nber = iehdu.itm_nber(+)
                                 AND iu.sad_num = iehdu.sad_num(+)
                                 AND iehdu.saditm_tax_code(+) = 'IEHD'
                                 AND ia.key_year = iehda.key_year(+)
                                 AND ia.key_cuo = iehda.key_cuo(+)
                                 AND ia.key_dec = iehda.key_dec(+)
                                 AND ia.key_nber = iehda.key_nber(+)
                                 AND ia.itm_nber = iehda.itm_nber(+)
                                 AND ia.sad_num = iehda.sad_num(+)
                                 AND iehda.saditm_tax_code(+) = 'IEHD'
                                 --tributo ICD
                                 AND iu.key_year = icdu.key_year(+)
                                 AND iu.key_cuo = icdu.key_cuo(+)
                                 AND iu.key_dec = icdu.key_dec(+)
                                 AND iu.key_nber = icdu.key_nber(+)
                                 AND iu.itm_nber = icdu.itm_nber(+)
                                 AND iu.sad_num = icdu.sad_num(+)
                                 AND icdu.saditm_tax_code(+) = 'ICD'
                                 AND ia.key_year = icda.key_year(+)
                                 AND ia.key_cuo = icda.key_cuo(+)
                                 AND ia.key_dec = icda.key_dec(+)
                                 AND ia.key_nber = icda.key_nber(+)
                                 AND ia.itm_nber = icda.itm_nber(+)
                                 AND ia.sad_num = icda.sad_num(+)
                                 AND icda.saditm_tax_code(+) = 'ICD'
                                 --para los valores FOB FLETE SEGURO OTROS CIF
                                 AND iu.key_year = vu.key_year
                                 AND iu.key_cuo = vu.key_cuo
                                 AND iu.key_dec = vu.key_dec
                                 AND iu.key_nber = vu.key_nber
                                 AND iu.itm_nber = vu.itm_nber
                                 AND iu.sad_num = vu.sad_num
                                 AND ia.key_year = va.key_year
                                 AND ia.key_cuo = va.key_cuo
                                 AND ia.key_dec = va.key_dec
                                 AND ia.key_nber = va.key_nber
                                 AND ia.itm_nber = va.itm_nber
                                 AND ia.sad_num = va.sad_num
                                 --para recuperar informacion del control
                                 AND f.alc_tipo_tramite = 'DUI'
                                 AND f.alc_gestion = u.sad_reg_year
                                 AND f.alc_aduana = u.key_cuo
                                 AND u.sad_reg_serial = 'C'
                                 AND f.alc_numero = u.sad_reg_nber
                                 AND f.ctl_control_id = prm_codigo
                                 AND f.alc_num = 0
                                 AND f.alc_lstope = 'U'
                                 AND f.ctl_control_id = n.ctl_control_id
                                 AND n.not_num = 0
                                 AND n.not_lstope = 'U'
                                 AND vc.cvc_num = 0
                                 AND vc.cvc_lstope = 'U'
                                 AND vc.ctl_control_id = f.ctl_control_id
                        UNION
                        SELECT   iu.itm_nber itm,
                                 ia.saditm_hs_cod || ia.saditm_hsprec_cod
                                     nandina_ant,
                                 iu.saditm_hs_cod || iu.saditm_hsprec_cod
                                     nandina_u,
                                 u.sad_reg_year reg_year,
                                 u.key_cuo key_cuo,
                                 u.sad_reg_nber reg_nber,
                                 TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                     fecha_reg,
                                 TO_CHAR (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'dd/mm/yyyy')
                                     fecha_venc,
                                 TO_CHAR (fecha_reporte, 'dd/mm/yyyy')
                                     fecha_calculo,
                                 va.sad_iitminv_valc dec_fob,
                                 va.sad_iitmefr_valc dec_flete,
                                 va.sad_iitmins_valc dec_seguro,
                                 va.sad_iitmotc_valc dec_otros,
                                 ROUND (
                                     va.sad_iitmcif_valn / va.sad_iitminv_rat,
                                     2)
                                     dec_cifusd,
                                 va.sad_iitminv_rat dec_tc,
                                 va.sad_iitmcif_valn dec_cifbs,
                                 gaa.saditm_tax_amount dec_ga,
                                 ivaa.saditm_tax_amount dec_iva,
                                 NVL (icea.saditm_tax_amount, 0) dec_ice,
                                 NVL (iehda.saditm_tax_amount, 0) dec_iehd,
                                 NVL (icda.saditm_tax_amount, 0) dec_icd,
                                 vu.sad_iitminv_valc enc_fob,
                                 vu.sad_iitmefr_valc enc_flete,
                                 vu.sad_iitmins_valc enc_seguro,
                                 vu.sad_iitmotc_valc enc_otros,
                                 ROUND (
                                     vu.sad_iitmcif_valn / vu.sad_iitminv_rat,
                                     2)
                                     enc_cifusd,
                                 vu.sad_iitminv_rat enc_tc,
                                 vu.sad_iitmcif_valn enc_cifbs,
                                 gau.saditm_tax_amount enc_ga,
                                 ivau.saditm_tax_amount enc_iva,
                                 NVL (iceu.saditm_tax_amount, 0) enc_ice,
                                 NVL (iehdu.saditm_tax_amount, 0) enc_iehd,
                                 NVL (icdu.saditm_tax_amount, 0) enc_icd,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'UFV')
                                     tc_ufvfecvenc,
                                 pkg_reporte.tipocambio (TRUNC (fecha_reporte),
                                                         'UFV')
                                     tc_ufvhoy,
                                 gau.saditm_tax_amount - gaa.saditm_tax_amount
                                     to_ga,
                                 ivau.saditm_tax_amount
                                 - ivaa.saditm_tax_amount
                                     to_iva,
                                 NVL (iceu.saditm_tax_amount, 0)
                                 - NVL (icea.saditm_tax_amount, 0)
                                     to_ice,
                                 NVL (iehdu.saditm_tax_amount, 0)
                                 - NVL (iehda.saditm_tax_amount, 0)
                                     to_iehd,
                                 NVL (icdu.saditm_tax_amount, 0)
                                 - NVL (icda.saditm_tax_amount, 0)
                                     to_icd,
                                 TRUNC (fecha_reporte)
                                 - pkg_reporte.fecha_vencimiento (
                                       u.key_cuo,
                                       TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy'))
                                     dias,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'TPR')
                                     tc_tprfecvenc,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     gau.saditm_tax_amount
                                     - gaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     ga_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     ivau.saditm_tax_amount
                                     - ivaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     iva_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iceu.saditm_tax_amount, 0)
                                     - NVL (icea.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     ice_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iehdu.saditm_tax_amount, 0)
                                     - NVL (iehda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     iehd_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (icdu.saditm_tax_amount, 0)
                                     - NVL (icda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     icd_dt,
                                 TO_CHAR (vc.cvc_fecha_notificacion,
                                          'dd/mm/yyyy')
                                     fec_notvc,
                                 TO_CHAR (vc.cvc_fecha_rd, 'dd/mm/yyyy')
                                     fec_notrdvc
                          FROM   ops$asy.sad_gen u,
                                 ops$asy.sad_gen a,
                                 ops$asy.sad_itm iu,
                                 ops$asy.sad_itm ia,
                                 ops$asy.sad_tax gau,
                                 ops$asy.sad_tax gaa,
                                 ops$asy.sad_tax ivau,
                                 ops$asy.sad_tax ivaa,
                                 ops$asy.sad_tax iceu,
                                 ops$asy.sad_tax icea,
                                 ops$asy.sad_tax iehdu,
                                 ops$asy.sad_tax iehda,
                                 ops$asy.sad_tax icdu,
                                 ops$asy.sad_tax icda,
                                 ops$asy.sad_itm_vim vu,
                                 ops$asy.sad_itm_vim va,
                                 fis_alcance f,
                                 fis_notificacion n,
                                 fis_con_viscargo vc
                         WHERE       u.key_year = a.key_year
                                 AND u.key_cuo = a.key_cuo
                                 AND u.key_dec IS NULL
                                 AND a.key_dec IS NULL
                                 AND u.key_nber = a.key_nber
                                 AND a.sad_num =
                                        NVL (
                                            (SELECT   MIN (x.sad_pst_num)
                                               FROM   ops$asy.sad_gen x
                                              WHERE   x.key_cuo = u.key_cuo
                                                      AND x.sad_reg_year =
                                                             u.sad_reg_year
                                                      AND x.sad_reg_serial =
                                                             u.sad_reg_serial
                                                      AND x.sad_reg_nber =
                                                             u.sad_reg_nber
                                                      AND x.sad_pst_dat >=
                                                             n.not_fecha_notificacion),
                                            0)
                                 AND u.sad_flw = 1
                                 AND u.sad_num = 0
                                 AND u.lst_ope = 'U'
                                 AND u.key_year = iu.key_year
                                 AND u.key_cuo = iu.key_cuo
                                 AND iu.key_dec IS NULL
                                 AND u.key_nber = iu.key_nber
                                 AND u.sad_num = iu.sad_num
                                 AND a.key_year = ia.key_year
                                 AND a.key_cuo = ia.key_cuo
                                 AND ia.key_dec IS NULL
                                 AND a.key_nber = ia.key_nber
                                 AND a.sad_num = ia.sad_num
                                 AND iu.key_year = ia.key_year
                                 AND iu.key_cuo = ia.key_cuo
                                 AND iu.key_nber = ia.key_nber
                                 AND iu.itm_nber = ia.itm_nber
                                 --tributo GA
                                 AND iu.key_year = gau.key_year
                                 AND iu.key_cuo = gau.key_cuo
                                 AND gau.key_dec IS NULL
                                 AND iu.key_nber = gau.key_nber
                                 AND iu.itm_nber = gau.itm_nber
                                 AND iu.sad_num = gau.sad_num
                                 AND gau.saditm_tax_code = 'GA'
                                 AND ia.key_year = gaa.key_year
                                 AND ia.key_cuo = gaa.key_cuo
                                 AND gaa.key_dec IS NULL
                                 AND ia.key_nber = gaa.key_nber
                                 AND ia.itm_nber = gaa.itm_nber
                                 AND ia.sad_num = gaa.sad_num
                                 AND gaa.saditm_tax_code = 'GA'
                                 --tributo IVA
                                 AND iu.key_year = ivau.key_year
                                 AND iu.key_cuo = ivau.key_cuo
                                 AND ivau.key_dec IS NULL
                                 AND iu.key_nber = ivau.key_nber
                                 AND iu.itm_nber = ivau.itm_nber
                                 AND iu.sad_num = ivau.sad_num
                                 AND ivau.saditm_tax_code = 'IVA'
                                 AND ia.key_year = ivaa.key_year
                                 AND ia.key_cuo = ivaa.key_cuo
                                 AND ivaa.key_dec IS NULL
                                 AND ia.key_nber = ivaa.key_nber
                                 AND ia.itm_nber = ivaa.itm_nber
                                 AND ia.sad_num = ivaa.sad_num
                                 AND ivaa.saditm_tax_code = 'IVA'
                                 --tributo ICE
                                 AND iu.key_year = iceu.key_year(+)
                                 AND iu.key_cuo = iceu.key_cuo(+)
                                 AND iceu.key_dec(+) IS NULL
                                 AND iu.key_nber = iceu.key_nber(+)
                                 AND iu.itm_nber = iceu.itm_nber(+)
                                 AND iu.sad_num = iceu.sad_num(+)
                                 AND iceu.saditm_tax_code(+) = 'ICE'
                                 AND ia.key_year = icea.key_year(+)
                                 AND ia.key_cuo = icea.key_cuo(+)
                                 AND icea.key_dec(+) IS NULL
                                 AND ia.key_nber = icea.key_nber(+)
                                 AND ia.itm_nber = icea.itm_nber(+)
                                 AND ia.sad_num = icea.sad_num(+)
                                 AND icea.saditm_tax_code(+) = 'ICE'
                                 --tributo IEHD
                                 AND iu.key_year = iehdu.key_year(+)
                                 AND iu.key_cuo = iehdu.key_cuo(+)
                                 AND iehdu.key_dec(+) IS NULL
                                 AND iu.key_nber = iehdu.key_nber(+)
                                 AND iu.itm_nber = iehdu.itm_nber(+)
                                 AND iu.sad_num = iehdu.sad_num(+)
                                 AND iehdu.saditm_tax_code(+) = 'IEHD'
                                 AND ia.key_year = iehda.key_year(+)
                                 AND ia.key_cuo = iehda.key_cuo(+)
                                 AND iehda.key_dec(+) IS NULL
                                 AND ia.key_nber = iehda.key_nber(+)
                                 AND ia.itm_nber = iehda.itm_nber(+)
                                 AND ia.sad_num = iehda.sad_num(+)
                                 AND iehda.saditm_tax_code(+) = 'IEHD'
                                 --tributo ICD
                                 AND iu.key_year = icdu.key_year(+)
                                 AND iu.key_cuo = icdu.key_cuo(+)
                                 AND icdu.key_dec(+) IS NULL
                                 AND iu.key_nber = icdu.key_nber(+)
                                 AND iu.itm_nber = icdu.itm_nber(+)
                                 AND iu.sad_num = icdu.sad_num(+)
                                 AND icdu.saditm_tax_code(+) = 'ICD'
                                 AND ia.key_year = icda.key_year(+)
                                 AND ia.key_cuo = icda.key_cuo(+)
                                 AND icda.key_dec(+) IS NULL
                                 AND ia.key_nber = icda.key_nber(+)
                                 AND ia.itm_nber = icda.itm_nber(+)
                                 AND ia.sad_num = icda.sad_num(+)
                                 AND icda.saditm_tax_code(+) = 'ICD'
                                 --para los valores FOB FLETE SEGURO OTROS CIF
                                 AND iu.key_year = vu.key_year
                                 AND iu.key_cuo = vu.key_cuo
                                 AND vu.key_dec IS NULL
                                 AND iu.key_nber = vu.key_nber
                                 AND iu.itm_nber = vu.itm_nber
                                 AND iu.sad_num = vu.sad_num
                                 AND ia.key_year = va.key_year
                                 AND ia.key_cuo = va.key_cuo
                                 AND va.key_dec IS NULL
                                 AND ia.key_nber = va.key_nber
                                 AND ia.itm_nber = va.itm_nber
                                 AND ia.sad_num = va.sad_num
                                 --para recuperar informacion del control
                                 AND f.alc_tipo_tramite = 'DUI'
                                 AND f.alc_gestion = u.sad_reg_year
                                 AND f.alc_aduana = u.key_cuo
                                 AND u.sad_reg_serial = 'C'
                                 AND f.alc_numero = u.sad_reg_nber
                                 AND f.ctl_control_id = prm_codigo
                                 AND f.alc_num = 0
                                 AND f.alc_lstope = 'U'
                                 AND f.ctl_control_id = n.ctl_control_id
                                 AND n.not_num = 0
                                 AND n.not_lstope = 'U'
                                 AND vc.cvc_num = 0
                                 AND vc.cvc_lstope = 'U'
                                 AND vc.ctl_control_id = f.ctl_control_id) t
            GROUP BY   t.reg_year,
                       t.key_cuo,
                       t.reg_nber,
                       t.fecha_reg,
                       t.fec_notvc,
                       t.fec_notrdvc,
                       t.tc_ufvhoy,
                       t.tc_ufvfecvenc
            ORDER BY   1, 2, 3;

        RETURN ct;
    END;

    FUNCTION tipocambio (fecha IN DATE, tipo IN VARCHAR2)
        RETURN NUMBER
    IS
        v_valor   NUMBER;
    BEGIN
        SELECT   rat_exc
          INTO   v_valor
          FROM   ops$asy.unrattab
         WHERE       lst_ope = 'U'
                 AND cur_cod = tipo
                 AND eea_dov <= fecha
                 AND NVL (eea_eov, fecha + 1) >= fecha;

        RETURN v_valor;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            RETURN 0;
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION devuelve_sanciones (prm_codigo IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT   SUM (res_contrav), SUM (res_contravorden)
              FROM   fis_alcance a, fis_resultados b
             WHERE   a.alc_tipo_tramite = 'DUI'
                     AND res_dui =
                               a.alc_gestion
                            || '/'
                            || a.alc_aduana
                            || '/C-'
                            || a.alc_numero
                     AND a.alc_num = 0
                     AND a.alc_lstope = 'U'
                     AND b.res_num = 0
                     AND b.res_lstope = 'U'
                     AND a.ctl_control_id = prm_codigo;

        RETURN ct;
    END;



    FUNCTION fecha_vencimiento (prm_aduana   IN VARCHAR2,
                                prm_fecha    IN VARCHAR2)
        RETURN DATE
    IS
        v_valor              DATE;
        v_fecharegistro      DATE;
        v_fechavencimiento   DATE;
        v_fechatemp          DATE;
        v_plazo              NUMBER;
        v_i                  NUMBER;
        v_cant               NUMBER;
    BEGIN
        v_plazo := 3;
        v_i := 1;
        v_fechatemp := TO_DATE (prm_fecha, 'dd/mm/yyyy') + 1;

        WHILE v_i <= v_plazo
        LOOP
            SELECT   COUNT ( * )
              INTO   v_cant
              FROM   ops$asy.unholtab
             WHERE       cuo_cod = prm_aduana
                     AND hol_day = v_fechatemp
                     AND lst_ope = 'U';

            IF v_cant = 0
            THEN                                            --Si no es feriado
                v_i := v_i + 1;
            END IF;

            v_fechavencimiento := v_fechatemp;
            v_fechatemp := v_fechatemp + 1;
        END LOOP;

        RETURN v_fechavencimiento;
    END;

    FUNCTION aumentardiashabiles (prm_gerencia   IN VARCHAR2,
                                  prm_fecha      IN VARCHAR2,
                                  prm_dias       IN NUMBER)
        RETURN DATE
    IS
        v_valor              DATE;
        v_fecharegistro      DATE;
        v_fechavencimiento   DATE;
        v_fechatemp          DATE;
        v_plazo              NUMBER;
        v_i                  NUMBER;
        v_cant               NUMBER;
        v_aduana             VARCHAR2 (4);
    BEGIN
        IF prm_fecha IS NULL
        THEN
            RETURN NULL;
        ELSE
            v_plazo := prm_dias;
            v_i := 1;
            v_fechatemp := TO_DATE (prm_fecha, 'dd/mm/yyyy') + 1;

            SELECT   DECODE (prm_gerencia,
                             'GNF', '201',
                             'GRL', '201',
                             'GRO', '401',
                             'GRC', '301',
                             'GRS', '701',
                             'GRT', '601',
                             'GRP', '501',
                             '201')
              INTO   v_aduana
              FROM   DUAL;


            WHILE v_i <= v_plazo
            LOOP
                SELECT   COUNT ( * )
                  INTO   v_cant
                  FROM   ops$asy.unholtab
                 WHERE       cuo_cod = v_aduana
                         AND hol_day = v_fechatemp
                         AND lst_ope = 'U';

                IF v_cant = 0
                THEN                                        --Si no es feriado
                    v_i := v_i + 1;
                END IF;

                v_fechavencimiento := v_fechatemp;
                v_fechatemp := v_fechatemp + 1;
            END LOOP;

            RETURN v_fechavencimiento;
        END IF;
    END;

    FUNCTION c_diligencia1_x (sid IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
            SELECT   b.con_key_year || b.con_key_cuo || b.con_reg_nber AS dma,
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
                     DECODE (a.sad_consignee, NULL, h.sad_con_nam, d.cmp_nam)
                         AS importador,
                     NVL (a.sad_consignee, h.sad_con_zip) AS id_importador,
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
                         AS fecha_dili1
              FROM   ops$asy.sad_gen a,
                     mira.mir_control b,
                     ops$asy.undectab c,
                     ops$asy.uncmptab d,
                     ops$asy.uncuotab e,
                     mira.mir_diligencia1 f,
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
                     AND b.con_fuente = SUBSTR (sid, INSTR (sid, '-') + 1)
                     AND a.key_cuo = e.cuo_cod
                     AND e.lst_ope = 'U'
                     AND NVL (a.sad_consignee, '-') = NVL (d.cmp_cod(+), '-')
                     AND d.lst_ope(+) = 'U'
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
                     AND b.con_fuente = SUBSTR (f.id, INSTR (f.id, '-') + 1)
                     AND f.dil1_num = 0
                     AND a.key_year = h.key_year(+)
                     AND a.key_cuo = h.key_cuo(+)
                     AND NVL (a.key_dec, '-') = NVL (h.key_dec(+), '-')
                     AND a.key_nber = h.key_nber(+)
                     AND a.sad_num = h.sad_num(+);

        RETURN cr;
    END;


    FUNCTION resumen_controles (prm_supervisor   IN VARCHAR2,
                                prm_fecini       IN VARCHAR2,
                                prm_fecfin       IN VARCHAR2,
                                prm_gerencia     IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   c1.fis_codigo_fiscalizador,
                       (SELECT   COUNT (1)
                          FROM   fis_estado a, fis_acceso c, fis_control t
                         WHERE   est_fecsys BETWEEN TO_DATE (prm_fecini,
                                                             'dd/mm/yyyy')
                                                AND  TO_DATE (prm_fecfin,
                                                              'dd/mm/yyyy')
                                 AND a.est_estado = 'REGISTRADO'
                                 AND est_lstope = 'U'
                                 AND a.ctl_control_id = c.ctl_control_id
                                 AND c.fis_lstope = 'U'
                                 AND c.fis_num = 0
                                 AND c.fis_codigo_fiscalizador =
                                        c1.fis_codigo_fiscalizador
                                 AND c.fis_cargo = 'SUPERVISOR'
                                 AND t.ctl_control_id = a.ctl_control_id
                                 AND t.ctl_num = 0
                                 AND t.ctl_lstope = 'U'
                                 AND t.ctl_cod_tipo = 'POSTERIOR')
                           asig_fap,
                       (SELECT   COUNT (1)
                          FROM   fis_estado a,
                                 fis_acceso c,
                                 fis_control t,
                                 fis_conclusion f
                         WHERE   est_fecsys BETWEEN TO_DATE (prm_fecini,
                                                             'dd/mm/yyyy')
                                                AND  TO_DATE (prm_fecfin,
                                                              'dd/mm/yyyy')
                                 AND a.est_estado = 'REGISTRADO'
                                 AND est_lstope = 'U'
                                 AND a.ctl_control_id = c.ctl_control_id
                                 AND c.fis_lstope = 'U'
                                 AND c.fis_num = 0
                                 AND c.fis_codigo_fiscalizador =
                                        c1.fis_codigo_fiscalizador
                                 AND c.fis_cargo = 'SUPERVISOR'
                                 AND t.ctl_control_id = a.ctl_control_id
                                 AND t.ctl_num = 0
                                 AND t.ctl_lstope = 'U'
                                 AND t.ctl_cod_tipo = 'POSTERIOR'
                                 AND f.ctl_control_id = a.ctl_control_id
                                 AND f.con_num = 0
                                 AND f.con_lstope = 'U')
                           con_fap,
                       (SELECT   COUNT (1)
                          FROM   fis_estado a, fis_acceso c, fis_control t
                         WHERE   est_fecsys BETWEEN TO_DATE (prm_fecini,
                                                             'dd/mm/yyyy')
                                                AND  TO_DATE (prm_fecfin,
                                                              'dd/mm/yyyy')
                                 AND a.est_estado = 'REGISTRADO'
                                 AND est_lstope = 'U'
                                 AND a.ctl_control_id = c.ctl_control_id
                                 AND c.fis_lstope = 'U'
                                 AND c.fis_num = 0
                                 AND c.fis_codigo_fiscalizador =
                                        c1.fis_codigo_fiscalizador
                                 AND c.fis_cargo = 'SUPERVISOR'
                                 AND t.ctl_control_id = a.ctl_control_id
                                 AND t.ctl_num = 0
                                 AND t.ctl_lstope = 'U'
                                 AND t.ctl_cod_tipo = 'DIFERIDO')
                           asig_cd,
                       (SELECT   COUNT (1)
                          FROM   fis_estado a,
                                 fis_acceso c,
                                 fis_control t,
                                 fis_conclusion f
                         WHERE   est_fecsys BETWEEN TO_DATE (prm_fecini,
                                                             'dd/mm/yyyy')
                                                AND  TO_DATE (prm_fecfin,
                                                              'dd/mm/yyyy')
                                 AND a.est_estado = 'REGISTRADO'
                                 AND est_lstope = 'U'
                                 AND a.ctl_control_id = c.ctl_control_id
                                 AND c.fis_lstope = 'U'
                                 AND c.fis_num = 0
                                 AND c.fis_codigo_fiscalizador =
                                        c1.fis_codigo_fiscalizador
                                 AND c.fis_cargo = 'SUPERVISOR'
                                 AND t.ctl_control_id = a.ctl_control_id
                                 AND t.ctl_num = 0
                                 AND t.ctl_lstope = 'U'
                                 AND t.ctl_cod_tipo = 'DIFERIDO'
                                 AND f.ctl_control_id = a.ctl_control_id
                                 AND f.con_num = 0
                                 AND f.con_lstope = 'U')
                           con_cd
                FROM   fis_estado a1, fis_acceso c1
               WHERE   a1.est_fecsys BETWEEN TO_DATE (prm_fecini, 'dd/mm/yyyy')
                                         AND  TO_DATE (prm_fecfin,
                                                       'dd/mm/yyyy')
                       AND a1.est_estado = 'REGISTRADO'
                       AND a1.est_lstope = 'U'
                       AND a1.ctl_control_id = c1.ctl_control_id
                       AND c1.fis_lstope = 'U'
                       AND c1.fis_num = 0
                       AND c1.fis_codigo_fiscalizador LIKE prm_supervisor
                       AND c1.fis_cargo = 'SUPERVISOR'
            GROUP BY   c1.fis_codigo_fiscalizador;

        RETURN cr;
    END;

    FUNCTION resumen_controles_tot (prm_supervisor   IN VARCHAR2,
                                    prm_fecini       IN VARCHAR2,
                                    prm_fecfin       IN VARCHAR2,
                                    prm_gerencia     IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
            SELECT   SUM (asig_fap),
                     SUM (con_fap),
                     SUM (asig_cd),
                     SUM (con_cd)
              FROM   (  SELECT   c1.fis_codigo_fiscalizador,
                                 (SELECT   COUNT (1)
                                    FROM   fis_estado a,
                                           fis_acceso c,
                                           fis_control t
                                   WHERE   est_fecsys BETWEEN TO_DATE (
                                                                  prm_fecini,
                                                                  'dd/mm/yyyy')
                                                          AND  TO_DATE (
                                                                   prm_fecfin,
                                                                   'dd/mm/yyyy')
                                           AND a.est_estado = 'REGISTRADO'
                                           AND est_lstope = 'U'
                                           AND a.ctl_control_id =
                                                  c.ctl_control_id
                                           AND c.fis_lstope = 'U'
                                           AND c.fis_num = 0
                                           AND c.fis_codigo_fiscalizador =
                                                  c1.fis_codigo_fiscalizador
                                           AND c.fis_cargo = 'SUPERVISOR'
                                           AND t.ctl_control_id =
                                                  a.ctl_control_id
                                           AND t.ctl_num = 0
                                           AND t.ctl_lstope = 'U'
                                           AND t.ctl_cod_tipo = 'POSTERIOR')
                                     asig_fap,
                                 (SELECT   COUNT (1)
                                    FROM   fis_estado a,
                                           fis_acceso c,
                                           fis_control t,
                                           fis_conclusion f
                                   WHERE   est_fecsys BETWEEN TO_DATE (
                                                                  prm_fecini,
                                                                  'dd/mm/yyyy')
                                                          AND  TO_DATE (
                                                                   prm_fecfin,
                                                                   'dd/mm/yyyy')
                                           AND a.est_estado = 'REGISTRADO'
                                           AND est_lstope = 'U'
                                           AND a.ctl_control_id =
                                                  c.ctl_control_id
                                           AND c.fis_lstope = 'U'
                                           AND c.fis_num = 0
                                           AND c.fis_codigo_fiscalizador =
                                                  c1.fis_codigo_fiscalizador
                                           AND c.fis_cargo = 'SUPERVISOR'
                                           AND t.ctl_control_id =
                                                  a.ctl_control_id
                                           AND t.ctl_num = 0
                                           AND t.ctl_lstope = 'U'
                                           AND t.ctl_cod_tipo = 'POSTERIOR'
                                           AND f.ctl_control_id =
                                                  a.ctl_control_id
                                           AND f.con_num = 0
                                           AND f.con_lstope = 'U')
                                     con_fap,
                                 (SELECT   COUNT (1)
                                    FROM   fis_estado a,
                                           fis_acceso c,
                                           fis_control t
                                   WHERE   est_fecsys BETWEEN TO_DATE (
                                                                  prm_fecini,
                                                                  'dd/mm/yyyy')
                                                          AND  TO_DATE (
                                                                   prm_fecfin,
                                                                   'dd/mm/yyyy')
                                           AND a.est_estado = 'REGISTRADO'
                                           AND est_lstope = 'U'
                                           AND a.ctl_control_id =
                                                  c.ctl_control_id
                                           AND c.fis_lstope = 'U'
                                           AND c.fis_num = 0
                                           AND c.fis_codigo_fiscalizador =
                                                  c1.fis_codigo_fiscalizador
                                           AND c.fis_cargo = 'SUPERVISOR'
                                           AND t.ctl_control_id =
                                                  a.ctl_control_id
                                           AND t.ctl_num = 0
                                           AND t.ctl_lstope = 'U'
                                           AND t.ctl_cod_tipo = 'DIFERIDO')
                                     asig_cd,
                                 (SELECT   COUNT (1)
                                    FROM   fis_estado a,
                                           fis_acceso c,
                                           fis_control t,
                                           fis_conclusion f
                                   WHERE   est_fecsys BETWEEN TO_DATE (
                                                                  prm_fecini,
                                                                  'dd/mm/yyyy')
                                                          AND  TO_DATE (
                                                                   prm_fecfin,
                                                                   'dd/mm/yyyy')
                                           AND a.est_estado = 'REGISTRADO'
                                           AND est_lstope = 'U'
                                           AND a.ctl_control_id =
                                                  c.ctl_control_id
                                           AND c.fis_lstope = 'U'
                                           AND c.fis_num = 0
                                           AND c.fis_codigo_fiscalizador =
                                                  c1.fis_codigo_fiscalizador
                                           AND c.fis_cargo = 'SUPERVISOR'
                                           AND t.ctl_control_id =
                                                  a.ctl_control_id
                                           AND t.ctl_num = 0
                                           AND t.ctl_lstope = 'U'
                                           AND t.ctl_cod_tipo = 'DIFERIDO'
                                           AND f.ctl_control_id =
                                                  a.ctl_control_id
                                           AND f.con_num = 0
                                           AND f.con_lstope = 'U')
                                     con_cd
                          FROM   fis_estado a1, fis_acceso c1
                         WHERE   a1.est_fecsys BETWEEN TO_DATE (prm_fecini,
                                                                'dd/mm/yyyy')
                                                   AND  TO_DATE (prm_fecfin,
                                                                 'dd/mm/yyyy')
                                 AND a1.est_estado = 'REGISTRADO'
                                 AND a1.est_lstope = 'U'
                                 AND a1.ctl_control_id = c1.ctl_control_id
                                 AND c1.fis_lstope = 'U'
                                 AND c1.fis_num = 0
                                 AND c1.fis_codigo_fiscalizador LIKE
                                        prm_supervisor
                                 AND c1.fis_cargo = 'SUPERVISOR'
                      GROUP BY   c1.fis_codigo_fiscalizador) tbl;

        RETURN cr;
    END;

    FUNCTION detalle_controles_sup (prm_fiscalizador   IN VARCHAR2,
                                    prm_fecini         IN VARCHAR2,
                                    prm_fecfin         IN VARCHAR2,
                                    prm_tipo_tramite   IN VARCHAR2,
                                    prm_estado         IN VARCHAR2,
                                    prm_gerencia       IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   *
                FROM   (SELECT   c.fis_codigo_fiscalizador,
                                 t.ctl_cod_tipo,
                                    t.ctl_cod_gestion
                                 || t.ctl_cod_tipo
                                 || t.ctl_cod_gerencia
                                 || t.ctl_cod_numero
                                     control,
                                 TO_CHAR (a.est_fecsys, 'dd/mm/yyyy')
                                     fec_asignacion,
                                 (SELECT   COUNT (1)
                                    FROM   fis_alcance x
                                   WHERE   x.alc_alcance_id = t.ctl_control_id
                                           AND x.alc_num = 0
                                           AND x.alc_lstope = 'U')
                                     cant_duis,
                                 TO_CHAR (n.not_fecha_notificacion,
                                          'dd/mm/yyyy')
                                     fec_notif,
                                 DECODE (
                                     co.con_fecha_doc_con,
                                     NULL,
                                     DECODE (
                                         n.not_fecha_notificacion,
                                         NULL,
                                         DECODE (e.est_estado,
                                                 'CONCLUIDO', 'FINALIZADO',
                                                 e.est_estado),
                                         'NOTIFICADO'),
                                     'CONCLUIDO')
                                     est_estado,
                                 t.ctl_cod_gerencia
                          FROM   fis_estado a,
                                 fis_acceso c,
                                 fis_control t,
                                 fis_notificacion n,
                                 fis_estado e,
                                 fis_conclusion co
                         WHERE   a.est_fecsys BETWEEN TO_DATE (prm_fecini,
                                                               'dd/mm/yyyy')
                                                  AND  TO_DATE (prm_fecfin,
                                                                'dd/mm/yyyy')
                                 AND a.est_estado = 'REGISTRADO'
                                 AND a.est_lstope = 'U'
                                 AND a.ctl_control_id = c.ctl_control_id
                                 AND c.fis_lstope = 'U'
                                 AND a.ctl_control_id = co.ctl_control_id(+)
                                 AND co.con_num(+) = 0
                                 AND co.con_lstope(+) = 'U'
                                 AND c.fis_num = 0
                                 AND c.fis_codigo_fiscalizador LIKE
                                        prm_fiscalizador
                                 AND c.fis_cargo = 'FISCALIZADOR'
                                 AND t.ctl_control_id = a.ctl_control_id
                                 AND t.ctl_num = 0
                                 AND t.ctl_lstope = 'U'
                                 AND (t.ctl_cod_tipo = 'POSTERIOR'
                                      OR t.ctl_cod_tipo = 'DIFERIDO')
                                 AND n.ctl_control_id(+) = a.ctl_control_id
                                 AND n.not_num(+) = 0
                                 AND n.not_lstope(+) = 'U'
                                 AND e.ctl_control_id = a.ctl_control_id
                                 AND e.est_num = 0
                                 AND e.est_lstope = 'U') tbl
               WHERE       tbl.ctl_cod_tipo LIKE prm_tipo_tramite
                       AND tbl.est_estado LIKE prm_estado
                       AND tbl.ctl_cod_gerencia LIKE prm_gerencia
            ORDER BY   1, 2, 3;

        RETURN cr;
    END;

    FUNCTION detalle_cantidad_sup (prm_supervisor   IN VARCHAR2,
                                   prm_fecini       IN VARCHAR2,
                                   prm_fecfin       IN VARCHAR2,
                                   prm_gerencia     IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   c1.fis_codigo_fiscalizador,
                       (SELECT   COUNT (1)
                          FROM   fis_estado a, fis_acceso c, fis_control t
                         WHERE   est_fecsys BETWEEN TO_DATE (prm_fecini,
                                                             'dd/mm/yyyy')
                                                AND  TO_DATE (prm_fecfin,
                                                              'dd/mm/yyyy')
                                 AND a.est_estado = 'REGISTRADO'
                                 AND est_lstope = 'U'
                                 AND a.ctl_control_id = c.ctl_control_id
                                 AND c.fis_lstope = 'U'
                                 AND c.fis_num = 0
                                 AND c.fis_codigo_fiscalizador =
                                        c1.fis_codigo_fiscalizador
                                 AND c.fis_cargo = 'FISCALIZADOR'
                                 AND t.ctl_control_id = a.ctl_control_id
                                 AND t.ctl_num = 0
                                 AND t.ctl_lstope = 'U'
                                 AND t.ctl_cod_tipo = 'POSTERIOR'
                                 AND t.ctl_cod_gerencia = prm_gerencia)
                           asig_fap,
                       (SELECT   COUNT (1)
                          FROM   fis_estado a,
                                 fis_acceso c,
                                 fis_control t,
                                 fis_conclusion f
                         WHERE   est_fecsys BETWEEN TO_DATE (prm_fecini,
                                                             'dd/mm/yyyy')
                                                AND  TO_DATE (prm_fecfin,
                                                              'dd/mm/yyyy')
                                 AND a.est_estado = 'REGISTRADO'
                                 AND est_lstope = 'U'
                                 AND a.ctl_control_id = c.ctl_control_id
                                 AND c.fis_lstope = 'U'
                                 AND c.fis_num = 0
                                 AND c.fis_codigo_fiscalizador =
                                        c1.fis_codigo_fiscalizador
                                 AND c.fis_cargo = 'FISCALIZADOR'
                                 AND t.ctl_control_id = a.ctl_control_id
                                 AND t.ctl_num = 0
                                 AND t.ctl_lstope = 'U'
                                 AND t.ctl_cod_tipo = 'POSTERIOR'
                                 AND f.ctl_control_id = a.ctl_control_id
                                 AND f.con_num = 0
                                 AND f.con_lstope = 'U'
                                 AND t.ctl_cod_gerencia = prm_gerencia)
                           con_fap,
                       (SELECT   COUNT (1)
                          FROM   fis_estado a, fis_acceso c, fis_control t
                         WHERE   est_fecsys BETWEEN TO_DATE (prm_fecini,
                                                             'dd/mm/yyyy')
                                                AND  TO_DATE (prm_fecfin,
                                                              'dd/mm/yyyy')
                                 AND a.est_estado = 'REGISTRADO'
                                 AND est_lstope = 'U'
                                 AND a.ctl_control_id = c.ctl_control_id
                                 AND c.fis_lstope = 'U'
                                 AND c.fis_num = 0
                                 AND c.fis_codigo_fiscalizador =
                                        c1.fis_codigo_fiscalizador
                                 AND c.fis_cargo = 'FISCALIZADOR'
                                 AND t.ctl_control_id = a.ctl_control_id
                                 AND t.ctl_num = 0
                                 AND t.ctl_lstope = 'U'
                                 AND t.ctl_cod_tipo = 'DIFERIDO'
                                 AND t.ctl_cod_gerencia = prm_gerencia)
                           asig_cd,
                       (SELECT   COUNT (1)
                          FROM   fis_estado a,
                                 fis_acceso c,
                                 fis_control t,
                                 fis_conclusion f
                         WHERE   est_fecsys BETWEEN TO_DATE (prm_fecini,
                                                             'dd/mm/yyyy')
                                                AND  TO_DATE (prm_fecfin,
                                                              'dd/mm/yyyy')
                                 AND a.est_estado = 'REGISTRADO'
                                 AND est_lstope = 'U'
                                 AND a.ctl_control_id = c.ctl_control_id
                                 AND c.fis_lstope = 'U'
                                 AND c.fis_num = 0
                                 AND c.fis_codigo_fiscalizador =
                                        c1.fis_codigo_fiscalizador
                                 AND c.fis_cargo = 'FISCALIZADOR'
                                 AND t.ctl_control_id = a.ctl_control_id
                                 AND t.ctl_num = 0
                                 AND t.ctl_lstope = 'U'
                                 AND t.ctl_cod_tipo = 'DIFERIDO'
                                 AND f.ctl_control_id = a.ctl_control_id
                                 AND f.con_num = 0
                                 AND f.con_lstope = 'U'
                                 AND t.ctl_cod_gerencia = prm_gerencia)
                           con_cd
                FROM   fis_estado a1, fis_acceso c1
               WHERE   a1.est_fecsys BETWEEN TO_DATE (prm_fecini, 'dd/mm/yyyy')
                                         AND  TO_DATE (prm_fecfin,
                                                       'dd/mm/yyyy')
                       AND a1.est_estado = 'REGISTRADO'
                       AND a1.est_lstope = 'U'
                       AND a1.ctl_control_id = c1.ctl_control_id
                       AND c1.fis_lstope = 'U'
                       AND c1.fis_num = 0
                       AND c1.fis_codigo_fiscalizador LIKE prm_supervisor
                       AND c1.fis_cargo = 'FISCALIZADOR'
            GROUP BY   c1.fis_codigo_fiscalizador
            ORDER BY   1;

        RETURN cr;
    END;

    FUNCTION detalle_cantidad_sup_tot (prm_supervisor   IN VARCHAR2,
                                       prm_fecini       IN VARCHAR2,
                                       prm_fecfin       IN VARCHAR2,
                                       prm_gerencia     IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
            SELECT   SUM (asig_fap),
                     SUM (con_fap),
                     SUM (asig_cd),
                     SUM (con_cd)
              FROM   (  SELECT   c1.fis_codigo_fiscalizador,
                                 (SELECT   COUNT (1)
                                    FROM   fis_estado a,
                                           fis_acceso c,
                                           fis_control t
                                   WHERE   est_fecsys BETWEEN TO_DATE (
                                                                  prm_fecini,
                                                                  'dd/mm/yyyy')
                                                          AND  TO_DATE (
                                                                   prm_fecfin,
                                                                   'dd/mm/yyyy')
                                           AND a.est_estado = 'REGISTRADO'
                                           AND est_lstope = 'U'
                                           AND a.ctl_control_id =
                                                  c.ctl_control_id
                                           AND c.fis_lstope = 'U'
                                           AND c.fis_num = 0
                                           AND c.fis_codigo_fiscalizador =
                                                  c1.fis_codigo_fiscalizador
                                           AND c.fis_cargo = 'FISCALIZADOR'
                                           AND t.ctl_control_id =
                                                  a.ctl_control_id
                                           AND t.ctl_num = 0
                                           AND t.ctl_lstope = 'U'
                                           AND t.ctl_cod_tipo = 'POSTERIOR')
                                     asig_fap,
                                 (SELECT   COUNT (1)
                                    FROM   fis_estado a,
                                           fis_acceso c,
                                           fis_control t,
                                           fis_conclusion f
                                   WHERE   est_fecsys BETWEEN TO_DATE (
                                                                  prm_fecini,
                                                                  'dd/mm/yyyy')
                                                          AND  TO_DATE (
                                                                   prm_fecfin,
                                                                   'dd/mm/yyyy')
                                           AND a.est_estado = 'REGISTRADO'
                                           AND est_lstope = 'U'
                                           AND a.ctl_control_id =
                                                  c.ctl_control_id
                                           AND c.fis_lstope = 'U'
                                           AND c.fis_num = 0
                                           AND c.fis_codigo_fiscalizador =
                                                  c1.fis_codigo_fiscalizador
                                           AND c.fis_cargo = 'FISCALIZADOR'
                                           AND t.ctl_control_id =
                                                  a.ctl_control_id
                                           AND t.ctl_num = 0
                                           AND t.ctl_lstope = 'U'
                                           AND t.ctl_cod_tipo = 'POSTERIOR'
                                           AND f.ctl_control_id =
                                                  a.ctl_control_id
                                           AND f.con_num = 0
                                           AND f.con_lstope = 'U')
                                     con_fap,
                                 (SELECT   COUNT (1)
                                    FROM   fis_estado a,
                                           fis_acceso c,
                                           fis_control t
                                   WHERE   est_fecsys BETWEEN TO_DATE (
                                                                  prm_fecini,
                                                                  'dd/mm/yyyy')
                                                          AND  TO_DATE (
                                                                   prm_fecfin,
                                                                   'dd/mm/yyyy')
                                           AND a.est_estado = 'REGISTRADO'
                                           AND est_lstope = 'U'
                                           AND a.ctl_control_id =
                                                  c.ctl_control_id
                                           AND c.fis_lstope = 'U'
                                           AND c.fis_num = 0
                                           AND c.fis_codigo_fiscalizador =
                                                  c1.fis_codigo_fiscalizador
                                           AND c.fis_cargo = 'FISCALIZADOR'
                                           AND t.ctl_control_id =
                                                  a.ctl_control_id
                                           AND t.ctl_num = 0
                                           AND t.ctl_lstope = 'U'
                                           AND t.ctl_cod_tipo = 'DIFERIDO')
                                     asig_cd,
                                 (SELECT   COUNT (1)
                                    FROM   fis_estado a,
                                           fis_acceso c,
                                           fis_control t,
                                           fis_conclusion f
                                   WHERE   est_fecsys BETWEEN TO_DATE (
                                                                  prm_fecini,
                                                                  'dd/mm/yyyy')
                                                          AND  TO_DATE (
                                                                   prm_fecfin,
                                                                   'dd/mm/yyyy')
                                           AND a.est_estado = 'REGISTRADO'
                                           AND est_lstope = 'U'
                                           AND a.ctl_control_id =
                                                  c.ctl_control_id
                                           AND c.fis_lstope = 'U'
                                           AND c.fis_num = 0
                                           AND c.fis_codigo_fiscalizador =
                                                  c1.fis_codigo_fiscalizador
                                           AND c.fis_cargo = 'FISCALIZADOR'
                                           AND t.ctl_control_id =
                                                  a.ctl_control_id
                                           AND t.ctl_num = 0
                                           AND t.ctl_lstope = 'U'
                                           AND t.ctl_cod_tipo = 'DIFERIDO'
                                           AND f.ctl_control_id =
                                                  a.ctl_control_id
                                           AND f.con_num = 0
                                           AND f.con_lstope = 'U')
                                     con_cd
                          FROM   fis_estado a1, fis_acceso c1
                         WHERE   a1.est_fecsys BETWEEN TO_DATE (prm_fecini,
                                                                'dd/mm/yyyy')
                                                   AND  TO_DATE (prm_fecfin,
                                                                 'dd/mm/yyyy')
                                 AND a1.est_estado = 'REGISTRADO'
                                 AND a1.est_lstope = 'U'
                                 AND a1.ctl_control_id = c1.ctl_control_id
                                 AND c1.fis_lstope = 'U'
                                 AND c1.fis_num = 0
                                 AND c1.fis_codigo_fiscalizador LIKE
                                        prm_supervisor
                                 AND c1.fis_cargo = 'FISCALIZADOR'
                      GROUP BY   c1.fis_codigo_fiscalizador) tbl;

        RETURN cr;
    END;
END;
/


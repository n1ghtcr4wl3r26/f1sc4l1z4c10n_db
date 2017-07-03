/* Formatted on 6/30/2017 4:43:25 PM (QP5 v5.126) */
SELECT   i.saditm_stat_val af,
         TO_CHAR (g.sad_reg_date, 'dd/mm/yyyy') fec,
        TO_CHAR ( pkg_reporte.fecha_vencimiento (
             g.key_cuo,
             TO_CHAR (g.sad_reg_date, 'dd/mm/yyyy')), 'dd/mm/yyyy')
             fecv,
         pkg_reporte.tipocambio (
             pkg_reporte.fecha_vencimiento (
                 g.key_cuo,
                 TO_CHAR (g.sad_reg_date, 'dd/mm/yyyy')),
             'UFV')
             ufvven,
         pkg_reporte.tipocambio (TO_DATE ('30/06/2017', 'dd/mm/yyyy'), 'UFV')
             ufvhoy,
         i.saditm_stat_val
         * pkg_reporte.tipocambio (TO_DATE ('30/06/2017', 'dd/mm/yyyy'),
                                   'UFV')
         / pkg_reporte.tipocambio (
               pkg_reporte.fecha_vencimiento (
                   g.key_cuo,
                   TO_CHAR (g.sad_reg_date, 'dd/mm/yyyy')),
               'UFV')
             cif
  FROM   fis_alcance a,
         fis_resultados b,
         ops$asy.sad_gen g,
         ops$asy.sad_itm i
 WHERE       a.ctl_control_id = '201754'
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
SELECT   ret_cif_bob af,
         TO_CHAR (alc_fecha, 'dd/mm/yyyy') fec,
         TO_CHAR (alc_fecha, 'dd/mm/yyyy') fecv,
         pkg_reporte.tipocambio (alc_fecha, 'UFV') ufvven,
         pkg_reporte.tipocambio (TO_DATE ('30/06/2017', 'dd/mm/yyyy'), 'UFV')
             ufvhoy,
         ret_cif_bob
         * pkg_reporte.tipocambio (TO_DATE ('30/06/2017', 'dd/mm/yyyy'),
                                   'UFV')
         / pkg_reporte.tipocambio (alc_fecha, 'UFV')
             cif
  FROM   fis_alcance a, fis_resultados_tramite b
 WHERE       a.ctl_control_id = '201754'
         AND a.alc_num = 0
         AND a.alc_lstope = 'U'
         AND a.alc_alcance_id = b.alc_alcance_id
         AND b.ret_num = 0
         AND b.ret_lstope = 'U'
         AND ret_ilicito = 'CONTRABANDO CONTRAVENCIONAL'

SELECT   f1.ctl_cod_gestion gestion,
                   DECODE (f1.ctl_cod_tipo,
                           'DIFERIDO',
                           'CD',
                           'POSTERIOR',
                           'FAP')
                       tipo_control,
                   f1.ctl_cod_gerencia gerencia,
                   f1.ctl_cod_numero numero,
                   DECODE (
                       a1.est_estado,
                       'MEMORIZADO',
                       '-',
                       f1.ctl_cod_gestion
                       || DECODE (f1.ctl_cod_tipo,
                                  'DIFERIDO', 'CD',
                                  'POSTERIOR', 'FP',
                                  'AMPLIATORIA DIFERIDO', 'CD',
                                  'AMPLIATORIA POSTERIOR', 'FP',
                                  '-')
                       || f1.ctl_cod_gerencia
                       || DECODE (
                              f1.ctl_amp_correlativo,
                              NULL,
                              '00',
                              DECODE (LENGTH (f1.ctl_amp_correlativo),
                                      1, '0' || f1.ctl_amp_correlativo,
                                      f1.ctl_amp_correlativo))
                       || DECODE (LENGTH (f1.ctl_cod_numero),
                                  1, '0000' || f1.ctl_cod_numero,
                                  2, '000' || f1.ctl_cod_numero,
                                  3, '00' || f1.ctl_cod_numero,
                                  4, '0' || f1.ctl_cod_numero,
                                  f1.ctl_cod_numero))
                       codigo_control,
                   TO_CHAR (a1.est_fecsys, 'dd/mm/yyyy') fecha_orden,
                   u.key_cuo || ':' || unt.cuo_nam aduana,
                      u.sad_reg_year
                   || '/'
                   || u.key_cuo
                   || '/'
                   || u.sad_reg_serial
                   || '-'
                   || u.sad_reg_nber
                       declaracion,
                   TO_CHAR (u.sad_reg_date, 'dd/mm/yyyy') fecha_registro,
                   ia.itm_nber item,
                   ia.saditm_hs_cod || ia.saditm_hsprec_cod nandina,
                      ia.saditm_goods_desc1
                   || ' '
                   || ia.saditm_goods_desc2
                   || ' '
                   || ia.saditm_goods_desc3
                       descripcion,
                   u.sad_typ_dec || '-' || u.sad_typ_proc patron -- campo 1   (7)
                                                                ,
                   NVL (
                       DECODE (spyc.sad_clr,
                               0, 'CANAL VERDE',
                               2, 'CANAL AMARILLO',
                               3, 'CANAL ROJO',
                               spyc.sad_clr),
                       ' ')
                       canal,
                   NVL (
                       DECODE (spyp.upd_dat,
                               NULL, ' ',
                               TO_CHAR (spyp.upd_dat, 'DD/MM/YYYY'))
                       || ' '
                       || DECODE (spyp.upd_hor, NULL, ' ', spyp.upd_hor),
                       ' ')
                       fecha_pase,
                   NVL (
                       DECODE (u.sad_consignee,
                               NULL, NVL (cns.sad_con_zip, ' '),
                               u.sad_consignee),
                       ' ')
                       nit_importador                              -- campo 8a
                                     ,
                   DECODE (u.sad_consignee,
                           NULL, cns.sad_con_nam,
                           unc.cmp_nam)
                       nombre_importador                     -- campo 8b (19)e
                                        ,
                   NVL (u.key_dec, ' ') nit_declarante            -- campo 14a
                                                      ,
                   dec.dec_nam nombre_declarante             -- campo 14b (30)
                                                ,
                   NVL (prov.sad_exp_add1, ' ') direccion_proveedor -- campo 2c
                                                                   ,
                   prov.sad_exp_nam proveedor                      -- campo 2b
                                             ,
                   NVL (u.sad_loc_goods, ' ') localizacion         -- campo 30
                                                          ,
                   ctyo.cty_dsc pais_origen,
                   NVL (UPPER (ctyproc.cty_dsc), ' ') pais_uproced,
                      SUBSTR (u.sad_lop_cod, 3, 3)
                   || '  '
                   || loc.loc_dsc
                   || ' | '
                   || SUBSTR (u.sad_lop_cod, 1, 2)
                       pto_pais_embarque,
                   NVL (ia.saditm_gross_mass, 0) total_peso_bruto,
                   NVL (ia.saditm_net_mass, 0) total_peso_neto,
                   va.sad_iitminv_valc dec_fob,
                   va.sad_iitmefr_valc dec_flete,
                   va.sad_iitmins_valc dec_seguro,
                   va.sad_iitmotc_valc dec_otros,
                   ROUND (va.sad_iitmcif_valn / va.sad_iitminv_rat, 2)
                       dec_cifusd,
                   va.sad_iitmcif_valn dec_cifbs,
                   gaa.saditm_tax_amount dec_ga,
                   ivaa.saditm_tax_amount dec_iva,
                   NVL (icea.saditm_tax_amount, 0) dec_ice,
                   NVL (iehda.saditm_tax_amount, 0) dec_iehd,
                   NVL (icda.saditm_tax_amount, 0) dec_icd,
                     gaa.saditm_tax_amount
                   + ivaa.saditm_tax_amount
                   + NVL (icea.saditm_tax_amount, 0)
                   + NVL (iehda.saditm_tax_amount, 0)
                   + NVL (icda.saditm_tax_amount, 0)
                       dec_total,
                   vu.sad_iitminv_valc enc_fob,
                   vu.sad_iitmefr_valc enc_flete,
                   vu.sad_iitmins_valc enc_seguro,
                   vu.sad_iitmotc_valc enc_otros,
                   ROUND (vu.sad_iitmcif_valn / vu.sad_iitminv_rat, 2)
                       enc_cifusd,
                   vu.sad_iitmcif_valn enc_cifbs,
                   pkg_reporte.tipocambio (
                       pkg_reporte.fecha_vencimiento (
                           u.key_cuo,
                           TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                       'UFV')
                       tc_ufvfecvenc,
                   pkg_reporte.tipocambio (TRUNC (SYSDATE), 'UFV') tc_ufvhoy,
                   gau.saditm_tax_amount - gaa.saditm_tax_amount to_ga,
                   ivau.saditm_tax_amount - ivaa.saditm_tax_amount to_iva,
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
                   DECODE (
                       con.con_fecha_doc_con,
                       NULL,
                       0,
                       ops$asy.fcalculadeudatributaria (
                           u.sad_reg_date,
                           TRUNC (con.con_fecha_doc_con),
                           u.key_year,
                           u.key_cuo,
                           u.key_dec,
                           u.key_nber,
                           gau.saditm_tax_amount - gaa.saditm_tax_amount,
                           u.sad_top_cod))
                       ga_dt,
                   DECODE (
                       con.con_fecha_doc_con,
                       NULL,
                       0,
                       ops$asy.fcalculadeudatributaria (
                           u.sad_reg_date,
                           TRUNC (con.con_fecha_doc_con),
                           u.key_year,
                           u.key_cuo,
                           u.key_dec,
                           u.key_nber,
                           ivau.saditm_tax_amount - ivaa.saditm_tax_amount,
                           u.sad_top_cod))
                       iva_dt,
                   DECODE (
                       con.con_fecha_doc_con,
                       NULL,
                       0,
                       ops$asy.fcalculadeudatributaria (
                           u.sad_reg_date,
                           TRUNC (con.con_fecha_doc_con),
                           u.key_year,
                           u.key_cuo,
                           u.key_dec,
                           u.key_nber,
                           NVL (iceu.saditm_tax_amount, 0)
                           - NVL (icea.saditm_tax_amount, 0),
                           u.sad_top_cod))
                       ice_dt,
                   DECODE (
                       con.con_fecha_doc_con,
                       NULL,
                       0,
                       ops$asy.fcalculadeudatributaria (
                           u.sad_reg_date,
                           TRUNC (con.con_fecha_doc_con),
                           u.key_year,
                           u.key_cuo,
                           u.key_dec,
                           u.key_nber,
                           NVL (iehdu.saditm_tax_amount, 0)
                           - NVL (iehda.saditm_tax_amount, 0),
                           u.sad_top_cod))
                       iehd_dt,
                   DECODE (
                       con.con_fecha_doc_con,
                       NULL,
                       0,
                       ops$asy.fcalculadeudatributaria (
                           u.sad_reg_date,
                           TRUNC (con.con_fecha_doc_con),
                           u.key_year,
                           u.key_cuo,
                           u.key_dec,
                           u.key_nber,
                           NVL (icdu.saditm_tax_amount, 0)
                           - NVL (icda.saditm_tax_amount, 0),
                           u.sad_top_cod))
                       icd_dt,
                   NVL (TO_CHAR (con.con_fecha_doc_con, 'dd/mm/yyyy'), '-')
                       fec_liq,
                   DECODE (
                       con.con_fecha_doc_con,
                       NULL,
                       0,
                       pkg_reporte.tipocambio (con.con_fecha_doc_con, 'UFV'))
                       ufv_liq,
                   e1.est_estado estado_control,
                   pkg_reporte.tributo_pagado(u.key_year, u.key_cuo, u.key_dec, u.key_nber, to_char(n.not_fecha_notificacion,'dd/mm/yyyy'), 'GA') tp_ga,
                   pkg_reporte.tributo_pagado(u.key_year, u.key_cuo, u.key_dec, u.key_nber, to_char(n.not_fecha_notificacion,'dd/mm/yyyy'), 'IVA') tp_iva,
                   pkg_reporte.tributo_pagado(u.key_year, u.key_cuo, u.key_dec, u.key_nber, to_char(n.not_fecha_notificacion,'dd/mm/yyyy'), 'ICE') tp_ice,
                   pkg_reporte.tributo_pagado(u.key_year, u.key_cuo, u.key_dec, u.key_nber, to_char(n.not_fecha_notificacion,'dd/mm/yyyy'), 'IEHD') tp_iehd,
                   pkg_reporte.tributo_pagado(u.key_year, u.key_cuo, u.key_dec, u.key_nber, to_char(n.not_fecha_notificacion,'dd/mm/yyyy'), 'ICD') tp_icd,
                   pkg_reporte.tributo_pagado_orden(f1.ctl_control_id, 'GA') tp_gao,
                   pkg_reporte.tributo_pagado_orden(f1.ctl_control_id, 'IVA') tp_ivao,
                   pkg_reporte.tributo_pagado_orden(f1.ctl_control_id, 'ICE') tp_iceo,
                   pkg_reporte.tributo_pagado_orden(f1.ctl_control_id, 'IEHD') tp_iehdo,
                   pkg_reporte.tributo_pagado_orden(f1.ctl_control_id, 'ICD') tp_icdo,
                   pkg_reporte.multa_pagada_orden(f1.ctl_control_id,  'OP') tm_op,
                   pkg_reporte.multa_pagada_orden(f1.ctl_control_id,  'CA DUI') tm_cadui,
                   pkg_reporte.multa_pagada_orden(f1.ctl_control_id,  'CAO') tm_cao,
                   pkg_reporte.multa_pagada_orden(f1.ctl_control_id,  'CC') tm_cc,
                   pkg_reporte.multa_pagada_orden(f1.ctl_control_id,  'CD') tm_cd,
                   pkg_reporte.multa_pagada_orden(f1.ctl_control_id,  'DF') tm_df,
                   pkg_reporte.multa_pagada_orden(f1.ctl_control_id,  'CI FP') tm_cifp,
                   pkg_reporte.multa_pagada_orden(f1.ctl_control_id,  'GE FP') tm_gefp
                   
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
                   ops$asy.uncuotab unt,
                   ops$asy.sad_spy spyc,
                   ops$asy.sad_spy spyp,
                   ops$asy.unctytab ctyproc,
                   ops$asy.unctytab ctyo,
                   ops$asy.unloctab loc,
                   ops$asy.sad_occ_exp prov,
                   ops$asy.sad_occ_cns cns,
                   ops$asy.uncmptab unc,
                   ops$asy.undectab dec,
                   fis_estado e1,
                   fis_estado a1,
                   fis_control f1,
                   fis_conclusion con
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
                                        AND x.sad_reg_year = u.sad_reg_year
                                        AND x.sad_reg_serial =
                                               u.sad_reg_serial
                                        AND x.sad_reg_nber = u.sad_reg_nber
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
                   AND unt.cuo_cod = u.key_cuo
                   AND unt.lst_ope = 'U'
                   AND spyc.key_year(+) = u.key_year
                   AND spyc.key_cuo(+) = u.key_cuo
                   AND spyc.key_dec(+) = u.key_dec
                   AND spyc.key_nber(+) = u.key_nber
                   AND spyc.spy_sta(+) = '10'
                   AND spyc.spy_act(+) = '24'
                   AND spyp.key_year(+) = u.key_year
                   AND spyp.key_cuo(+) = u.key_cuo
                   AND spyp.key_dec(+) = u.key_dec
                   AND spyp.key_nber(+) = u.key_nber
                   AND spyp.spy_act(+) = '25'
                   AND ctyproc.cty_cod(+) = u.sad_cty_1dlp
                   AND ctyproc.lst_ope(+) = 'U'
                   AND iu.saditm_cty_origcod = ctyo.cty_cod(+)
                   AND ctyo.lst_ope(+) = 'U'
                   AND loc.loc_cod(+) = u.sad_lop_cod
                   AND loc.lst_ope(+) = 'U'
                   AND u.key_dec = dec.dec_cod
                   AND dec.lst_ope = 'U'
                   AND u.key_year = cns.key_year(+)
                   AND u.key_cuo = cns.key_cuo(+)
                   AND u.key_dec = cns.key_dec(+)
                   AND u.key_nber = cns.key_nber(+)
                   AND u.sad_num = cns.sad_num(+)
                   AND u.sad_consignee = unc.cmp_cod(+)
                   AND unc.lst_ope(+) = 'U'
                   AND u.key_year = prov.key_year(+)
                   AND u.key_cuo = prov.key_cuo(+)
                   AND u.key_dec = prov.key_dec(+)
                   AND u.key_nber = prov.key_nber(+)
                   AND u.sad_num = prov.sad_num(+)
                   --para recuperar informacion del control
                   AND f.alc_tipo_tramite = 'DUI'
                   AND f.alc_gestion = u.sad_reg_year
                   AND f.alc_aduana = u.key_cuo
                   AND u.sad_reg_serial = 'C'
                   AND f.alc_numero = u.sad_reg_nber
                   AND f.ctl_control_id = '201740'
                   AND f.alc_num = 0
                   AND f.alc_lstope = 'U'
                   AND f.ctl_control_id = n.ctl_control_id
                   AND n.not_num = 0
                   AND n.not_lstope = 'U'
                   AND a1.est_estado = 'REGISTRADO'
                   AND a1.est_lstope = 'U'
                   AND a1.ctl_control_id = f1.ctl_control_id
                   AND f1.ctl_num = 0
                   AND f1.ctl_lstope = 'U'
                   AND f1.ctl_control_id = f.ctl_control_id
                   AND e1.est_num = 0
                   AND e1.est_lstope = 'U'
                   AND e1.ctl_control_id = f1.ctl_control_id
                   AND con.ctl_control_id(+) = f1.ctl_control_id
                   AND con.con_num(+) = 0
                   AND con.con_lstope(+) = 'U'

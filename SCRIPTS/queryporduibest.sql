/* Formatted on 1-ago.-2017 22:31:23 (QP5 v5.126) */
  SELECT   gestion,
           tipo_control,
           gerencia,
           numero,
           codigo_control,
           fecha_orden,
           origen_control,
           identidad_doc,
           identidad_nombre,
           fiscalizador,
           fiscalizador_nuevo,
           supervisor,
           supervisor_nuevo,
           fecha_notificacion,
           observacion_notificacion,
           tipo_notificacion,
           usuario_notificacion,
           
           
           
           
           aduana,
           declaracion,
           fecha_registro,
           patron,
           canal,
           fecha_pase,
           nit_importador,
           nombre_importador,
           nit_declarante,
           nombre_declarante,
           direccion_proveedor,
           proveedor,
           localizacion,
           pais_origen,
           pais_uproced,
           pto_pais_embarque,
           SUM (total_peso_bruto) peso_bruto,
           SUM (total_peso_neto) peso_neto,
           total_valor_fob,
           total_flete,
           total_seguro,
           total_otros,
           cifusd,
           cifbs,
           SUM (dec_ga) dec_ga,
           SUM (dec_iva) dec_iva,
           SUM (dec_ice) dec_ice,
           SUM (dec_iehd) dec_iehd,
           SUM (dec_icd) dec_icd,
           SUM (tot_trib) tot_trib,
           SUBSTR (tbl.info_con, 1, INSTR (tbl.info_con, '&') - 1)
               numero_informe,
           SUBSTR (tbl.info_con, INSTR (tbl.info_con,
                                        '&',
                                        1,
                                        1)
                                 + 1,   INSTR (tbl.info_con,
                                               '&',
                                               1,
                                               2)
                                      - INSTR (tbl.info_con,
                                               '&',
                                               1,
                                               1)
                                      - 1)
               fecha_informe,
           SUBSTR (tbl.info_con, INSTR (tbl.info_con,
                                        '&',
                                        1,
                                        2)
                                 + 1,   INSTR (tbl.info_con,
                                               '&',
                                               1,
                                               3)
                                      - INSTR (tbl.info_con,
                                               '&',
                                               1,
                                               2)
                                      - 1)
               gerencia_legal,
           con_tipo_doc_con,
           SUBSTR (tbl.info_con, INSTR (tbl.info_con,
                                        '&',
                                        1,
                                        4)
                                 + 1,   INSTR (tbl.info_con,
                                               '&',
                                               1,
                                               5)
                                      - INSTR (tbl.info_con,
                                               '&',
                                               1,
                                               4)
                                      - 1)
               numero_doc,
           SUBSTR (tbl.info_con, INSTR (tbl.info_con,
                                        '&',
                                        1,
                                        5)
                                 + 1,   INSTR (tbl.info_con,
                                               '&',
                                               1,
                                               6)
                                      - INSTR (tbl.info_con,
                                               '&',
                                               1,
                                               5)
                                      - 1)
               fecha_doc,
           con_usuario usuario_resultados,
           SUBSTR (tbl.info_con, INSTR (tbl.info_con,
                                        '&',
                                        1,
                                        6)
                                 + 1,   INSTR (tbl.info_con,
                                               '&',
                                               1,
                                               7)
                                      - INSTR (tbl.info_con,
                                               '&',
                                               1,
                                               6)
                                      - 1)
               fecha_notif_doc,
           SUBSTR (tbl.info_con, INSTR (tbl.info_con,
                                        '&',
                                        1,
                                        7)
                                 + 1,   INSTR (tbl.info_con,
                                               '&',
                                               1,
                                               8)
                                      - INSTR (tbl.info_con,
                                               '&',
                                               1,
                                               7)
                                      - 1)
               tipo_notif,
           con_usuario usuario_notif_doc,
           SUBSTR (tbl.info_con, INSTR (tbl.info_con,
                                        '&',
                                        1,
                                        8)
                                 + 1,   INSTR (tbl.info_con,
                                               '&',
                                               1,
                                               9)
                                      - INSTR (tbl.info_con,
                                               '&',
                                               1,
                                               8)
                                      - 1)
               fecha_ci_remision,
           SUBSTR (tbl.info_con, INSTR (tbl.info_con,
                                        '&',
                                        1,
                                        9)
                                 + 1,   INSTR (tbl.info_con,
                                               '&',
                                               1,
                                               10)
                                      - INSTR (tbl.info_con,
                                               '&',
                                               1,
                                               9)
                                      - 1)
               ci_remision,
           con_usuario usuario_remision,
           con_fecha_doc_con,
           con_usuario usuario_finalizacion,
           estado_control,
           SUBSTR (tbl.ilicitos, 1, INSTR (tbl.ilicitos, '&') - 1) omision_pago,
           SUBSTR (tbl.ilicitos, INSTR (tbl.ilicitos,
                                        '&',
                                        1,
                                        1)
                                 + 1,   INSTR (tbl.ilicitos,
                                               '&',
                                               1,
                                               2)
                                      - INSTR (tbl.ilicitos,
                                               '&',
                                               1,
                                               1)
                                      - 1)
               contrav_adu,
           SUBSTR (tbl.ilicitos, INSTR (tbl.ilicitos,
                                        '&',
                                        1,
                                        2)
                                 + 1,   INSTR (tbl.ilicitos,
                                               '&',
                                               1,
                                               3)
                                      - INSTR (tbl.ilicitos,
                                               '&',
                                               1,
                                               2)
                                      - 1)
               contrab_contrav,
           SUBSTR (tbl.ilicitos, INSTR (tbl.ilicitos,
                                        '&',
                                        1,
                                        3)
                                 + 1,   INSTR (tbl.ilicitos,
                                               '&',
                                               1,
                                               4)
                                      - INSTR (tbl.ilicitos,
                                               '&',
                                               1,
                                               3)
                                      - 1)
               contrab_delito,
           SUBSTR (tbl.ilicitos, INSTR (tbl.ilicitos,
                                        '&',
                                        1,
                                        4)
                                 + 1,   INSTR (tbl.ilicitos,
                                               '&',
                                               1,
                                               5)
                                      - INSTR (tbl.ilicitos,
                                               '&',
                                               1,
                                               4)
                                      - 1)
               defraudacion,
           SUBSTR (tbl.ilicitos, INSTR (tbl.ilicitos,
                                        '&',
                                        1,
                                        5)
                                 + 1,   INSTR (tbl.ilicitos,
                                               '&',
                                               1,
                                               6)
                                      - INSTR (tbl.ilicitos,
                                               '&',
                                               1,
                                               5)
                                      - 1)
               otros,
           fecha_est_con
    FROM   (SELECT   f1.ctl_cod_gestion gestion,
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
                     f1.ctl_tipo_documento origen_control,
                     DECODE (f1.ctl_tipo_doc_identidad,
                             'NIT', TO_CHAR (f1.ctl_nit),
                             TO_CHAR (f1.ctl_ci))
                         identidad_doc,
                     DECODE (
                         f1.ctl_tipo_doc_identidad,
                         'NIT',
                         UPPER (f1.ctl_razon_social),
                         UPPER(   f1.ctl_nombres
                               || ' '
                               || f1.ctl_appat
                               || ' '
                               || f1.ctl_apmat))
                         identidad_nombre,
                     pkg_reporte.devuelve_fiscalizadores_reg (
                         f1.ctl_control_id)
                         fiscalizador,
                     pkg_reporte.devuelve_fiscalizadores_acc (
                         f1.ctl_control_id)
                         fiscalizador_nuevo,
                     pkg_reporte.devuelve_jefe_reg (f1.ctl_control_id)
                         supervisor,
                     pkg_reporte.devuelve_jefe_acc (f1.ctl_control_id)
                         supervisor_nuevo,
                     TO_CHAR (noti.not_fecha_notificacion, 'dd/mm/yyyy')
                         fecha_notificacion,
                     noti.not_obs_notificacion observacion_notificacion,
                     noti.not_tipo_notificacion tipo_notificacion,
                     pkg_reporte.devuelve_nombre_fun (noti.not_usuario)
                         usuario_notificacion,
                     con.con_tipo_doc_con,
                     con.con_num_doc_con,
                     TO_CHAR (con.con_fecha_doc_con, 'dd/mm/yyyy')
                         con_fecha_doc_con,
                     con.con_usuario,
                     pkg_reporte.devuelve_info_conclusion (
                         f1.ctl_control_id,
                         con.con_tipo_doc_con)
                         info_con,
                     e1.est_estado estado_control,
                     pkg_reporte.devuelve_ilicitos (f1.ctl_control_id) ilicitos,
                     TO_CHAR (
                         noti.not_fecha_notificacion
                         + NVL (in1.inn_plazo_conclusion, 0),
                         'dd/mm/yyyy')
                         fecha_est_con,
                     sad_gen.key_cuo || ':' || unt.cuo_nam aduana,
                        sad_gen.sad_reg_year
                     || '/'
                     || sad_gen.key_cuo
                     || '/'
                     || sad_gen.sad_reg_serial
                     || '-'
                     || sad_gen.sad_reg_nber
                         declaracion,
                     TO_CHAR (sad_gen.sad_reg_date, 'dd/mm/yyyy')
                         fecha_registro,
                     sad_gen.sad_typ_dec || '-' || sad_gen.sad_typ_proc patron-- campo 1   (7)
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
                         DECODE (sad_gen.sad_consignee,
                                 NULL, NVL (cns.sad_con_zip, ' '),
                                 sad_gen.sad_consignee),
                         ' ')
                         nit_importador                            -- campo 8a
                                       ,
                     DECODE (sad_gen.sad_consignee,
                             NULL, cns.sad_con_nam,
                             unc.cmp_nam)
                         nombre_importador                   -- campo 8b (19)e
                                          ,
                     NVL (sad_gen.key_dec, ' ') nit_declarante    -- campo 14a
                                                              ,
                     dec.dec_nam nombre_declarante           -- campo 14b (30)
                                                  ,
                     NVL (prov.sad_exp_add1, ' ') direccion_proveedor-- campo 2c
                     ,
                     prov.sad_exp_nam proveedor                    -- campo 2b
                                               ,
                     NVL (sad_gen.sad_loc_goods, ' ') localizacion -- campo 30
                                                                  ,
                     ' ' pais_origen,
                     NVL (UPPER (ctyproc.cty_dsc), ' ') pais_uproced,
                        SUBSTR (sad_gen.sad_lop_cod, 3, 3)
                     || '  '
                     || loc.loc_dsc
                     || ' | '
                     || SUBSTR (sad_gen.sad_lop_cod, 1, 2)
                         pto_pais_embarque                         -- campo 27
                                          ,
                     NVL (itm.saditm_gross_mass, 0) total_peso_bruto-- campo 6b (84)
                     ,
                     NVL (itm.saditm_net_mass, 0) total_peso_neto-- campo 6b (84)
                     ,
                     sad_gen.sad_tot_invoiced total_valor_fob,
                     -- campo 22b (48)
                     NVL (vim.sad_itotefr_valc, 0) total_flete,
                     NVL (vim.sad_itotins_valc, 0) total_seguro,
                     NVL (vim.sad_itototc_valc, 0) total_otros,
                     NVL (ROUND (vim.sad_icif_valn / vim.sad_itotinv_rat, 2),
                          0)
                         cifusd,
                     NVL (vim.sad_icif_valn, 0) cifbs,
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
                         tot_trib
              FROM   ops$asy.sad_gen,
                     ops$asy.sad_gen_vim vim,
                     ops$asy.sad_occ_exp prov,
                     ops$asy.sad_occ_cns cns,
                     ops$asy.uncmptab unc,
                     ops$asy.undectab dec,
                     ops$asy.sad_itm itm,
                     ops$asy.sad_tax gaa,
                     ops$asy.sad_tax ivaa,
                     ops$asy.sad_tax icea,
                     ops$asy.sad_tax iehda,
                     ops$asy.sad_tax icda,
                     ops$asy.uncuotab unt,
                     ops$asy.sad_spy spyc,
                     ops$asy.sad_spy spyp,
                     ops$asy.unctytab ctyproc,
                     ops$asy.unloctab loc,
                     fis_estado a1,
                     fis_control f1,
                     fis_gerencia ger,
                     fis_notificacion noti,
                     fis_conclusion con,
                     fis_estado e1,
                     fis_info_notificacion in1,
                     fis_alcance alc
             WHERE       sad_gen.key_year = prov.key_year(+)
                     AND sad_gen.key_cuo = prov.key_cuo(+)
                     AND sad_gen.key_dec = prov.key_dec(+)
                     AND sad_gen.key_nber = prov.key_nber(+)
                     AND sad_gen.sad_num = prov.sad_num(+)
                     AND sad_gen.key_year = vim.key_year(+)
                     AND sad_gen.key_cuo = vim.key_cuo(+)
                     AND sad_gen.key_dec = vim.key_dec(+)
                     AND sad_gen.key_nber = vim.key_nber(+)
                     AND sad_gen.sad_num = vim.sad_num(+)
                     AND sad_gen.key_year = itm.key_year
                     AND sad_gen.key_cuo = itm.key_cuo
                     AND sad_gen.key_dec = itm.key_dec
                     AND sad_gen.key_nber = itm.key_nber
                     AND itm.sad_num = '0'
                     AND sad_gen.key_year = cns.key_year(+)
                     AND sad_gen.key_cuo = cns.key_cuo(+)
                     AND sad_gen.key_dec = cns.key_dec(+)
                     AND sad_gen.key_nber = cns.key_nber(+)
                     AND sad_gen.sad_num = cns.sad_num(+)
                     AND sad_gen.sad_consignee = unc.cmp_cod(+)
                     AND unc.lst_ope(+) = 'U'
                     AND sad_gen.key_dec = dec.dec_cod
                     AND dec.lst_ope = 'U'
                     AND sad_gen.lst_ope = 'U'
                     AND sad_gen.sad_num = 0
                     AND sad_gen.sad_flw = 1
                     AND sad_gen.sad_reg_nber IS NOT NULL
                     AND itm.key_year = gaa.key_year
                     AND itm.key_cuo = gaa.key_cuo
                     AND itm.key_dec = gaa.key_dec
                     AND itm.key_nber = gaa.key_nber
                     AND itm.itm_nber = gaa.itm_nber
                     AND itm.sad_num = gaa.sad_num
                     AND gaa.saditm_tax_code = 'GA'
                     --tributo IVA
                     AND itm.key_year = ivaa.key_year
                     AND itm.key_cuo = ivaa.key_cuo
                     AND itm.key_dec = ivaa.key_dec
                     AND itm.key_nber = ivaa.key_nber
                     AND itm.itm_nber = ivaa.itm_nber
                     AND itm.sad_num = ivaa.sad_num
                     AND ivaa.saditm_tax_code = 'IVA'
                     --tributo ICE
                     AND itm.key_year = icea.key_year(+)
                     AND itm.key_cuo = icea.key_cuo(+)
                     AND itm.key_dec = icea.key_dec(+)
                     AND itm.key_nber = icea.key_nber(+)
                     AND itm.itm_nber = icea.itm_nber(+)
                     AND itm.sad_num = icea.sad_num(+)
                     AND icea.saditm_tax_code(+) = 'ICE'
                     --tributo IEHD
                     AND itm.key_year = iehda.key_year(+)
                     AND itm.key_cuo = iehda.key_cuo(+)
                     AND itm.key_dec = iehda.key_dec(+)
                     AND itm.key_nber = iehda.key_nber(+)
                     AND itm.itm_nber = iehda.itm_nber(+)
                     AND itm.sad_num = iehda.sad_num(+)
                     AND iehda.saditm_tax_code(+) = 'IEHD'
                     --tributo ICD
                     AND itm.key_year = icda.key_year(+)
                     AND itm.key_cuo = icda.key_cuo(+)
                     AND itm.key_dec = icda.key_dec(+)
                     AND itm.key_nber = icda.key_nber(+)
                     AND itm.itm_nber = icda.itm_nber(+)
                     AND itm.sad_num = icda.sad_num(+)
                     AND icda.saditm_tax_code(+) = 'ICD'
                     AND unt.cuo_cod = sad_gen.key_cuo
                     AND unt.lst_ope = 'U'
                     AND spyc.key_year(+) = sad_gen.key_year
                     AND spyc.key_cuo(+) = sad_gen.key_cuo
                     AND spyc.key_dec(+) = sad_gen.key_dec
                     AND spyc.key_nber(+) = sad_gen.key_nber
                     AND spyc.spy_sta(+) = '10'
                     AND spyc.spy_act(+) = '24'
                     AND spyp.key_year(+) = sad_gen.key_year
                     AND spyp.key_cuo(+) = sad_gen.key_cuo
                     AND spyp.key_dec(+) = sad_gen.key_dec
                     AND spyp.key_nber(+) = sad_gen.key_nber
                     AND spyp.spy_act(+) = '25'
                     AND ctyproc.cty_cod(+) = sad_gen.sad_cty_1dlp
                     AND ctyproc.lst_ope(+) = 'U'
                     AND loc.loc_cod(+) = sad_gen.sad_lop_cod
                     AND loc.lst_ope(+) = 'U'
                     AND sad_gen.sad_reg_year = alc.alc_gestion
                     AND sad_gen.key_cuo = alc.alc_aduana
                     AND sad_gen.sad_reg_serial = 'C'
                     AND sad_gen.sad_reg_nber = alc.alc_numero
                     AND alc.ctl_control_id = f1.ctl_control_id
                     AND alc.alc_tipo_tramite = 'DUI'
                     AND alc.alc_num = 0
                     AND alc.alc_lstope = 'U'
                     AND a1.est_fecsys BETWEEN TO_DATE ('01/01/2017',
                                                        'dd/mm/yyyy')
                                           AND  TO_DATE ('01/08/2017',
                                                         'dd/mm/yyyy')
                     AND a1.est_estado = 'REGISTRADO'
                     AND a1.est_lstope = 'U'
                     AND a1.ctl_control_id = f1.ctl_control_id
                     AND e1.est_num = 0
                     AND e1.est_lstope = 'U'
                     AND e1.ctl_control_id = f1.ctl_control_id
                     AND in1.inn_num = 0
                     AND in1.inn_lstope = 'U'
                     AND in1.ctl_control_id = f1.ctl_control_id
                     AND ger.ger_codigo = f1.ctl_cod_gerencia
                     AND ger.reg_lstope = 'U'
                     AND f1.ctl_num = 0
                     AND f1.ctl_lstope = 'U'
                     AND f1.ctl_cod_gerencia LIKE 'GRL'
                     AND f1.ctl_cod_tipo IN ('DIFERIDO', 'POSTERIOR')
                     AND noti.ctl_control_id = f1.ctl_control_id
                     AND noti.not_num = 0
                     AND noti.not_lstope = 'U'
                     AND con.ctl_control_id(+) = f1.ctl_control_id
                     AND con.con_num(+) = 0
                     AND con.con_lstope(+) = 'U'
            UNION ALL
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
                     f1.ctl_tipo_documento origen_control,
                     DECODE (f1.ctl_tipo_doc_identidad,
                             'NIT', TO_CHAR (f1.ctl_nit),
                             TO_CHAR (f1.ctl_ci))
                         identidad_doc,
                     DECODE (
                         f1.ctl_tipo_doc_identidad,
                         'NIT',
                         UPPER (f1.ctl_razon_social),
                         UPPER(   f1.ctl_nombres
                               || ' '
                               || f1.ctl_appat
                               || ' '
                               || f1.ctl_apmat))
                         identidad_nombre,
                     pkg_reporte.devuelve_fiscalizadores_reg (
                         f1.ctl_control_id)
                         fiscalizador,
                     pkg_reporte.devuelve_fiscalizadores_acc (
                         f1.ctl_control_id)
                         fiscalizador_nuevo,
                     pkg_reporte.devuelve_jefe_reg (f1.ctl_control_id)
                         supervisor,
                     pkg_reporte.devuelve_jefe_acc (f1.ctl_control_id)
                         supervisor_nuevo,
                     TO_CHAR (noti.not_fecha_notificacion, 'dd/mm/yyyy')
                         fecha_notificacion,
                     noti.not_obs_notificacion observacion_notificacion,
                     noti.not_tipo_notificacion tipo_notificacion,
                     pkg_reporte.devuelve_nombre_fun (noti.not_usuario)
                         usuario_notificacion,
                     con.con_tipo_doc_con,
                     con.con_num_doc_con,
                     TO_CHAR (con.con_fecha_doc_con, 'dd/mm/yyyy')
                         con_fecha_doc_con,
                     con.con_usuario,
                     pkg_reporte.devuelve_info_conclusion (
                         f1.ctl_control_id,
                         con.con_tipo_doc_con)
                         info_con,
                     e1.est_estado estado_control,
                     pkg_reporte.devuelve_ilicitos (f1.ctl_control_id) ilicitos,
                     TO_CHAR (
                         noti.not_fecha_notificacion
                         + NVL (in1.inn_plazo_conclusion, 0),
                         'dd/mm/yyyy')
                         fecha_est_con,
                     sad_gen.key_cuo || ':' || unt.cuo_nam aduana,
                        sad_gen.sad_reg_year
                     || '/'
                     || sad_gen.key_cuo
                     || '/'
                     || sad_gen.sad_reg_serial
                     || '-'
                     || sad_gen.sad_reg_nber
                         declaracion,
                     TO_CHAR (sad_gen.sad_reg_date, 'dd/mm/yyyy')
                         fecha_registro,
                     sad_gen.sad_typ_dec || '-' || sad_gen.sad_typ_proc patron -- campo 1   (7)
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
                         DECODE (sad_gen.sad_consignee,
                                 NULL, NVL (cns.sad_con_zip, ' '),
                                 sad_gen.sad_consignee),
                         ' ')
                         nombre_importador                         -- campo 8a
                                          ,
                     DECODE (sad_gen.sad_consignee,
                             NULL, cns.sad_con_nam,
                             unc.cmp_nam)
                         dir_importador                      -- campo 8b (19)e
                                       ,
                     NVL (sad_gen.key_dec, ' ') nit_declarante    -- campo 14a
                                                              ,
                     occ.sad_dec_nam nombre_declarante,
                     NVL (prov.sad_exp_add1, ' ') direccion_proveedor -- campo 2c
                                                                     ,
                     prov.sad_exp_nam proveedor                    -- campo 2b
                                               ,
                     NVL (sad_gen.sad_loc_goods, ' ') localizacion -- campo 30
                                                                  ,
                     ' ' pais_origen,
                     NVL (UPPER (ctyproc.cty_dsc), ' ') pais_uproced,
                        SUBSTR (sad_gen.sad_lop_cod, 3, 3)
                     || '  '
                     || loc.loc_dsc
                     || ' | '
                     || SUBSTR (sad_gen.sad_lop_cod, 1, 2)
                         pto_pais_embarque                         -- campo 27
                                          ,
                     NVL (itm.saditm_gross_mass, 0) total_peso_bruto -- campo 6b (84)
                                                                    ,
                     NVL (itm.saditm_net_mass, 0) total_peso_neto -- campo 6b (84)
                                                                 ,
                     sad_gen.sad_tot_invoiced total_valor_fob, -- campo 22b (48)
                     NVL (vim.sad_itotefr_valc, 0) total_flete,
                     NVL (vim.sad_itotins_valc, 0) total_seguro,
                     NVL (vim.sad_itototc_valc, 0) total_otros,
                     NVL (ROUND (vim.sad_icif_valn / vim.sad_itotinv_rat, 2),
                          0)
                         cifusd,
                     NVL (vim.sad_icif_valn, 0) cifbs,
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
                         tot_trib
              FROM   ops$asy.sad_gen,
                     ops$asy.sad_gen_vim vim,
                     ops$asy.sad_occ_exp prov,
                     ops$asy.sad_occ_cns cns,
                     ops$asy.uncmptab unc,
                     ops$asy.sad_occ_dec occ,
                     ops$asy.sad_itm itm,
                     ops$asy.sad_tax gaa,
                     ops$asy.sad_tax ivaa,
                     ops$asy.sad_tax icea,
                     ops$asy.sad_tax iehda,
                     ops$asy.sad_tax icda,
                     ops$asy.uncuotab unt,
                     ops$asy.sad_spy spyc,
                     ops$asy.sad_spy spyp,
                     ops$asy.unctytab ctyproc,
                     ops$asy.unloctab loc,
                     fis_estado a1,
                     fis_control f1,
                     fis_gerencia ger,
                     fis_notificacion noti,
                     fis_conclusion con,
                     fis_estado e1,
                     fis_info_notificacion in1,
                     fis_alcance alc
             WHERE       sad_gen.key_year = prov.key_year(+)
                     AND sad_gen.key_cuo = prov.key_cuo(+)
                     AND sad_gen.key_dec IS NULL
                     AND sad_gen.sad_num = 0
                     AND sad_gen.key_year = itm.key_year
                     AND sad_gen.key_cuo = itm.key_cuo
                     AND itm.key_dec IS NULL
                     AND sad_gen.key_nber = itm.key_nber
                     AND itm.sad_num = '0'
                     AND prov.key_dec(+) IS NULL
                     AND sad_gen.key_nber = prov.key_nber(+)
                     AND sad_gen.sad_num = prov.sad_num(+)
                     AND sad_gen.key_year = cns.key_year(+)
                     AND sad_gen.key_cuo = cns.key_cuo(+)
                     AND sad_gen.key_dec IS NULL
                     AND cns.key_dec(+) IS NULL
                     AND sad_gen.key_nber = cns.key_nber(+)
                     AND sad_gen.sad_num = cns.sad_num(+)
                     AND sad_gen.sad_consignee = unc.cmp_cod(+)
                     AND unc.lst_ope(+) = 'U'
                     AND sad_gen.key_year = occ.key_year
                     AND sad_gen.key_cuo = occ.key_cuo
                     AND sad_gen.key_dec IS NULL
                     AND occ.key_dec IS NULL
                     AND sad_gen.key_nber = occ.key_nber
                     AND sad_gen.sad_num = occ.sad_num
                     AND sad_gen.lst_ope = 'U'
                     AND sad_gen.sad_flw = 1
                     AND sad_gen.sad_reg_nber IS NOT NULL
                     AND itm.key_year = gaa.key_year
                     AND itm.key_cuo = gaa.key_cuo
                     AND gaa.key_dec IS NULL
                     AND itm.key_nber = gaa.key_nber
                     AND itm.itm_nber = gaa.itm_nber
                     AND itm.sad_num = gaa.sad_num
                     AND gaa.saditm_tax_code = 'GA'
                     --tributo IVA
                     AND itm.key_year = ivaa.key_year
                     AND itm.key_cuo = ivaa.key_cuo
                     AND ivaa.key_dec IS NULL
                     AND itm.key_nber = ivaa.key_nber
                     AND itm.itm_nber = ivaa.itm_nber
                     AND itm.sad_num = ivaa.sad_num
                     AND ivaa.saditm_tax_code = 'IVA'
                     --tributo ICE
                     AND itm.key_year = icea.key_year(+)
                     AND itm.key_cuo = icea.key_cuo(+)
                     AND icea.key_dec(+) IS NULL
                     AND itm.key_nber = icea.key_nber(+)
                     AND itm.itm_nber = icea.itm_nber(+)
                     AND itm.sad_num = icea.sad_num(+)
                     AND icea.saditm_tax_code(+) = 'ICE'
                     --tributo IEHD
                     AND itm.key_year = iehda.key_year(+)
                     AND itm.key_cuo = iehda.key_cuo(+)
                     AND iehda.key_dec(+) IS NULL
                     AND itm.key_nber = iehda.key_nber(+)
                     AND itm.itm_nber = iehda.itm_nber(+)
                     AND itm.sad_num = iehda.sad_num(+)
                     AND iehda.saditm_tax_code(+) = 'IEHD'
                     --tributo ICD
                     AND itm.key_year = icda.key_year(+)
                     AND itm.key_cuo = icda.key_cuo(+)
                     AND icda.key_dec(+) IS NULL
                     AND itm.key_nber = icda.key_nber(+)
                     AND itm.itm_nber = icda.itm_nber(+)
                     AND itm.sad_num = icda.sad_num(+)
                     AND icda.saditm_tax_code(+) = 'ICD'
                     AND unt.cuo_cod = sad_gen.key_cuo
                     AND unt.lst_ope = 'U'
                     AND spyc.key_year(+) = sad_gen.key_year
                     AND spyc.key_cuo(+) = sad_gen.key_cuo
                     AND spyc.key_dec(+) IS NULL
                     AND spyc.key_nber(+) = sad_gen.key_nber
                     AND spyc.spy_sta(+) = '10'
                     AND spyc.spy_act(+) = '24'
                     AND spyp.key_year(+) = sad_gen.key_year
                     AND spyp.key_cuo(+) = sad_gen.key_cuo
                     AND spyp.key_dec(+) IS NULL
                     AND spyp.key_nber(+) = sad_gen.key_nber
                     AND spyp.spy_act(+) = '25'
                     AND ctyproc.cty_cod(+) = sad_gen.sad_cty_1dlp
                     AND ctyproc.lst_ope(+) = 'U'
                     AND loc.loc_cod(+) = sad_gen.sad_lop_cod
                     AND loc.lst_ope(+) = 'U'
                     AND sad_gen.sad_reg_year = alc.alc_gestion
                     AND sad_gen.key_cuo = alc.alc_aduana
                     AND sad_gen.sad_reg_serial = 'C'
                     AND sad_gen.sad_reg_nber = alc.alc_numero
                     AND alc.ctl_control_id = f1.ctl_control_id
                     AND alc.alc_tipo_tramite = 'DUI'
                     AND alc.alc_num = 0
                     AND alc.alc_lstope = 'U'
                     AND a1.est_fecsys BETWEEN TO_DATE ('01/01/2017',
                                                        'dd/mm/yyyy')
                                           AND  TO_DATE ('01/08/2017',
                                                         'dd/mm/yyyy')
                     AND a1.est_estado = 'REGISTRADO'
                     AND a1.est_lstope = 'U'
                     AND a1.ctl_control_id = f1.ctl_control_id
                     AND e1.est_num = 0
                     AND e1.est_lstope = 'U'
                     AND e1.ctl_control_id = f1.ctl_control_id
                     AND in1.inn_num = 0
                     AND in1.inn_lstope = 'U'
                     AND in1.ctl_control_id = f1.ctl_control_id
                     AND ger.ger_codigo = f1.ctl_cod_gerencia
                     AND ger.reg_lstope = 'U'
                     AND f1.ctl_num = 0
                     AND f1.ctl_lstope = 'U'
                     AND f1.ctl_cod_gerencia LIKE 'GRL'
                     AND f1.ctl_cod_tipo IN ('DIFERIDO', 'POSTERIOR')
                     AND noti.ctl_control_id = f1.ctl_control_id
                     AND noti.not_num = 0
                     AND noti.not_lstope = 'U'
                     AND con.ctl_control_id(+) = f1.ctl_control_id
                     AND con.con_num(+) = 0
                     AND con.con_lstope(+) = 'U') tbl
GROUP BY   gestion,
           tipo_control,
           gerencia,
           numero,
           codigo_control,
           fecha_orden,
           origen_control,
           con_tipo_doc_con,
           identidad_doc,
           identidad_nombre,
           fiscalizador,
           fiscalizador_nuevo,
           supervisor,
           supervisor_nuevo,
           fecha_notificacion,
           observacion_notificacion,
           tipo_notificacion,
           usuario_notificacion,
           info_con,
           con_fecha_doc_con,
           con_usuario,
           estado_control,
           ilicitos,
           fecha_est_con,
           aduana,
           declaracion,
           fecha_registro,
           patron,
           canal,
           fecha_pase,
           nit_importador,
           nombre_importador,
           nit_declarante,
           nombre_declarante,
           direccion_proveedor,
           proveedor,
           localizacion,
           pais_origen,
           pais_uproced,
           pto_pais_embarque,
           total_valor_fob,
           total_flete,
           total_seguro,
           total_otros,
           cifusd,
           cifbs
ORDER BY   1,
           2,
           3,
           4;

/* Formatted on 1-ago.-2017 22:12:18 (QP5 v5.126) */
SELECT   sad_gen.key_cuo || ':' || unt.cuo_nam aduana,
            sad_gen.sad_reg_year
         || '/'
         || sad_gen.key_cuo
         || '/'
         || sad_gen.sad_reg_serial
         || '-'
         || sad_gen.sad_reg_nber
             declaracion,
         TO_CHAR (sad_gen.sad_reg_date, 'dd/mm/yyyy') fecha_registro,
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
             nombre_importador                                     -- campo 8a
                              ,
         DECODE (sad_gen.sad_consignee, NULL, cns.sad_con_nam, unc.cmp_nam)
             dir_importador                                  -- campo 8b (19)e
                           ,
         NVL (sad_gen.key_dec, ' ') nit_declarante                -- campo 14a
                                                  ,
         occ.sad_dec_nam nombre_declarante,
         NVL (prov.sad_exp_add1, ' ') direccion_proveedor          -- campo 2c
                                                         ,
         prov.sad_exp_nam proveedor                                -- campo 2b
                                   ,
         NVL (sad_gen.sad_loc_goods, ' ') localizacion             -- campo 30
                                                      ,
         ' ' pais_origen,
         NVL (UPPER (ctyproc.cty_dsc), ' ') pais_uproced,
            SUBSTR (sad_gen.sad_lop_cod, 3, 3)
         || '  '
         || loc.loc_dsc
         || ' | '
         || SUBSTR (sad_gen.sad_lop_cod, 1, 2)
             pto_pais_embarque                                     -- campo 27
                              ,
         NVL (itm.saditm_gross_mass, 0) total_peso_bruto      -- campo 6b (84)
                                                        ,
         NVL (itm.saditm_net_mass, 0) total_peso_neto         -- campo 6b (84)
                                                     ,
         sad_gen.sad_tot_invoiced total_valor_fob,           -- campo 22b (48)
         NVL (vim.sad_itotefr_valc, 0) total_flete,
         NVL (vim.sad_itotins_valc, 0) total_seguro,
         NVL (vim.sad_itototc_valc, 0) total_otros,
         NVL (ROUND (vim.sad_icif_valn / vim.sad_itotinv_rat, 2), 0) cifusd,
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
         ops$asy.unloctab loc
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
         AND sad_gen.sad_reg_year = '2012'
         AND sad_gen.key_cuo = '201'
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

/* Formatted on 01/08/2017 18:06:29 (QP5 v5.126) */
  SELECT   aduana,
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
           SUM (tot_trib) tot_trib
    FROM   (SELECT   sad_gen.key_cuo || ':'
                     || (SELECT   a.cuo_nam
                           FROM   ops$asy.uncuotab a
                          WHERE   a.cuo_cod = sad_gen.key_cuo
                                  AND a.lst_ope = 'U')
                         aduana,
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
                         (SELECT   DECODE (a.sad_clr,
                                           0, 'CANAL VERDE',
                                           2, 'CANAL AMARILLO',
                                           3, 'CANAL ROJO',
                                           a.sad_clr)
                            FROM   ops$asy.sad_spy a
                           WHERE       a.key_year = sad_gen.key_year
                                   AND a.key_cuo = sad_gen.key_cuo
                                   AND a.key_dec = sad_gen.key_dec
                                   AND a.key_nber = sad_gen.key_nber
                                   AND a.spy_sta = '10'
                                   AND a.spy_act = '24'),
                         ' ')
                         canal,
                     NVL (
                         (SELECT   DECODE (a.upd_dat,
                                           NULL, ' ',
                                           TO_CHAR (a.upd_dat, 'DD/MM/YYYY'))
                                   || ' '
                                   || DECODE (a.upd_hor, NULL, ' ', a.upd_hor)
                            FROM   ops$asy.sad_spy a
                           WHERE       a.key_year = sad_gen.key_year
                                   AND a.key_cuo = sad_gen.key_cuo
                                   AND a.key_dec = sad_gen.key_dec
                                   AND a.key_nber = sad_gen.key_nber
                                   AND a.spy_act = '25'),
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
                     NVL (prov.sad_exp_add1, ' ') direccion_proveedor -- campo 2c
                                                                     ,
                     prov.sad_exp_nam proveedor                    -- campo 2b
                                               ,
                     NVL (sad_gen.sad_loc_goods, ' ') localizacion -- campo 30
                                                                  ,
                     DECODE (
                         (SELECT   COUNT (DISTINCT a.saditm_cty_origcod)
                            FROM   ops$asy.sad_itm a
                           WHERE       a.key_year = sad_gen.key_year
                                   AND a.key_cuo = sad_gen.key_cuo
                                   AND a.key_dec = sad_gen.key_dec
                                   AND a.key_nber = sad_gen.key_nber
                                   AND a.sad_num = sad_gen.sad_num),
                         1,
                         (SELECT   DISTINCT
                                   DECODE (
                                       cty.cty_cod,
                                       'ES',
                                       'ESPANA',
                                       'BL',
                                       'SAN BARTOLOME',
                                       'CF',
                                       'REPUBLICA CENTROAFRICANA',
                                       'CM',
                                       'CAMERUN, REPUBLICA UNIDA DEL',
                                       'IO',
                                       'TERRITORIO BRITANICO DEL OCEANO IND',
                                       'KR',
                                       'COREA (SUR) REPUBLICA DE COREA',
                                       'LA',
                                       'LAOS,REPUBLICA POPULAR DEMOCRATICA',
                                       'MF',
                                       'SAN MARTIN',
                                       'NL',
                                       'PAISES BAJOS',
                                       'PS',
                                       'TERRITORIOS AUTONOMOS DE PALESTINA',
                                       'SS',
                                       'SUDAN DEL SUR',
                                       'TN',
                                       'TUNEZ',
                                       UPPER (cty.cty_dsc))
                            --1, (SELECT DISTINCT convert( upper(cty.cty_dsc) ,'US7ASCII','WE8ISO8859P1')
                            FROM   sad_itm a, ops$asy.unctytab cty
                           WHERE       a.key_year = sad_gen.key_year
                                   AND a.key_cuo = sad_gen.key_cuo
                                   AND a.key_dec = sad_gen.key_dec
                                   AND a.key_nber = sad_gen.key_nber
                                   AND a.sad_num = sad_gen.sad_num
                                   AND a.saditm_cty_origcod = cty.cty_cod(+)
                                   AND cty.lst_ope(+) = 'U'),
                         'VARIOS')
                         pais_origen,
                     NVL (
                         (SELECT   DISTINCT
                                   DECODE (
                                       a.cty_cod,
                                       'ES',
                                       'ESPANA',
                                       'BL',
                                       'SAN BARTOLOME',
                                       'CF',
                                       'REPUBLICA CENTROAFRICANA',
                                       'CM',
                                       'CAMERUN, REPUBLICA UNIDA DEL',
                                       'IO',
                                       'TERRITORIO BRITANICO DEL OCEANO IND',
                                       'KR',
                                       'COREA (SUR) REPUBLICA DE COREA',
                                       'LA',
                                       'LAOS,REPUBLICA POPULAR DEMOCRATICA',
                                       'MF',
                                       'SAN MARTIN',
                                       'NL',
                                       'PAISES BAJOS',
                                       'PS',
                                       'TERRITORIOS AUTONOMOS DE PALESTINA',
                                       'SS',
                                       'SUDAN DEL SUR',
                                       'TN',
                                       'TUNEZ',
                                       UPPER (a.cty_dsc))
                            FROM   ops$asy.unctytab a
                           WHERE   a.cty_cod(+) = sad_gen.sad_cty_1dlp
                                   AND a.lst_ope(+) = 'U'),
                         ' ')
                         pais_uproced,
                     SUBSTR (sad_gen.sad_lop_cod, 3, 3) || '  '
                     || (SELECT   a.loc_dsc
                           FROM   ops$asy.unloctab a
                          WHERE   a.loc_cod = sad_gen.sad_lop_cod
                                  AND a.lst_ope = 'U')
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
                     ops$asy.undectab dec,
                     ops$asy.sad_itm itm,
                     ops$asy.sad_tax gaa,
                     ops$asy.sad_tax ivaa,
                     ops$asy.sad_tax icea,
                     ops$asy.sad_tax iehda,
                     ops$asy.sad_tax icda
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
                     AND sad_gen.sad_reg_year = '2016'
                     AND sad_gen.key_cuo = '201'
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
            UNION
            SELECT   sad_gen.key_cuo || ':'
                     || (SELECT   a.cuo_nam
                           FROM   ops$asy.uncuotab a
                          WHERE   a.cuo_cod = sad_gen.key_cuo
                                  AND a.lst_ope = 'U')
                         aduana,
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
                         (SELECT   DECODE (a.sad_clr,
                                           0, 'CANAL VERDE',
                                           2, 'CANAL AMARILLO',
                                           3, 'CANAL ROJO',
                                           a.sad_clr)
                            FROM   ops$asy.sad_spy a
                           WHERE       a.key_year = sad_gen.key_year
                                   AND a.key_cuo = sad_gen.key_cuo
                                   AND a.key_dec IS NULL
                                   AND sad_gen.key_dec IS NULL
                                   AND a.key_nber = sad_gen.key_nber
                                   AND a.spy_sta = '10'
                                   AND a.spy_act = '24'),
                         ' ')
                         canal,
                     NVL (
                         (SELECT   DECODE (a.upd_dat,
                                           NULL, ' ',
                                           TO_CHAR (a.upd_dat, 'DD/MM/YYYY'))
                                   || ' '
                                   || DECODE (a.upd_hor, NULL, ' ', a.upd_hor)
                            FROM   ops$asy.sad_spy a
                           WHERE       a.key_year = sad_gen.key_year
                                   AND a.key_cuo = sad_gen.key_cuo
                                   AND a.key_dec IS NULL
                                   AND sad_gen.key_dec IS NULL
                                   AND a.key_nber = sad_gen.key_nber
                                   AND a.spy_act = '25'),
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
                     DECODE (
                         (SELECT   COUNT (DISTINCT a.saditm_cty_origcod)
                            FROM   ops$asy.sad_itm a
                           WHERE       a.key_year = sad_gen.key_year
                                   AND a.key_cuo = sad_gen.key_cuo
                                   AND a.key_dec IS NULL
                                   AND sad_gen.key_dec IS NULL
                                   AND a.key_nber = sad_gen.key_nber
                                   AND a.sad_num = sad_gen.sad_num),
                         1,
                         (SELECT   DISTINCT
                                   DECODE (
                                       cty.cty_cod,
                                       'ES',
                                       'ESPANA',
                                       'BL',
                                       'SAN BARTOLOME',
                                       'CF',
                                       'REPUBLICA CENTROAFRICANA',
                                       'CM',
                                       'CAMERUN, REPUBLICA UNIDA DEL',
                                       'IO',
                                       'TERRITORIO BRITANICO DEL OCEANO IND',
                                       'KR',
                                       'COREA (SUR) REPUBLICA DE COREA',
                                       'LA',
                                       'LAOS,REPUBLICA POPULAR DEMOCRATICA',
                                       'MF',
                                       'SAN MARTIN',
                                       'NL',
                                       'PAISES BAJOS',
                                       'PS',
                                       'TERRITORIOS AUTONOMOS DE PALESTINA',
                                       'SS',
                                       'SUDAN DEL SUR',
                                       'TN',
                                       'TUNEZ',
                                       UPPER (cty.cty_dsc))
                            --1, (SELECT DISTINCT convert( upper(cty.cty_dsc) ,'US7ASCII','WE8ISO8859P1')
                            FROM   sad_itm a, ops$asy.unctytab cty
                           WHERE       a.key_year = sad_gen.key_year
                                   AND a.key_cuo = sad_gen.key_cuo
                                   AND a.key_dec IS NULL
                                   AND sad_gen.key_dec IS NULL
                                   AND a.key_nber = sad_gen.key_nber
                                   AND a.sad_num = sad_gen.sad_num
                                   AND a.saditm_cty_origcod = cty.cty_cod(+)
                                   AND cty.lst_ope(+) = 'U'),
                         'VARIOS')
                         pais_origen,
                     NVL (
                         (SELECT   DISTINCT
                                   DECODE (
                                       a.cty_cod,
                                       'ES',
                                       'ESPANA',
                                       'BL',
                                       'SAN BARTOLOME',
                                       'CF',
                                       'REPUBLICA CENTROAFRICANA',
                                       'CM',
                                       'CAMERUN, REPUBLICA UNIDA DEL',
                                       'IO',
                                       'TERRITORIO BRITANICO DEL OCEANO IND',
                                       'KR',
                                       'COREA (SUR) REPUBLICA DE COREA',
                                       'LA',
                                       'LAOS,REPUBLICA POPULAR DEMOCRATICA',
                                       'MF',
                                       'SAN MARTIN',
                                       'NL',
                                       'PAISES BAJOS',
                                       'PS',
                                       'TERRITORIOS AUTONOMOS DE PALESTINA',
                                       'SS',
                                       'SUDAN DEL SUR',
                                       'TN',
                                       'TUNEZ',
                                       UPPER (a.cty_dsc))
                            FROM   ops$asy.unctytab a
                           WHERE   a.cty_cod(+) = sad_gen.sad_cty_1dlp
                                   AND a.lst_ope(+) = 'U'),
                         ' ')
                         pais_uproced,
                     SUBSTR (sad_gen.sad_lop_cod, 3, 3) || '  '
                     || (SELECT   a.loc_dsc
                           FROM   ops$asy.unloctab a
                          WHERE   a.loc_cod = sad_gen.sad_lop_cod
                                  AND a.lst_ope = 'U')
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
                     ops$asy.sad_tax icda
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
                     AND sad_gen.sad_reg_year = '2016'
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
                     AND icda.saditm_tax_code(+) = 'ICD') tbl
GROUP BY   aduana,
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
           cifbs;

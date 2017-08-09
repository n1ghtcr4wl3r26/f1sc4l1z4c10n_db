/* Formatted on 4-ago.-2017 11:09:47 (QP5 v5.126) */

function tributo_pagado_orden ( prm_control in varchar2)
return number
is 
res number(18,2);
fecnot varchar2(10);
begin 


select count(1) into res from fis_notificacion f1 where f1.ctl_control_id = prm_control and f1.not_num = 0 and f1.not_lstope;  

if res > 0 then


select f1.not_fecha_notificacion into fecnot from fis_notificacion f1 where f1.ctl_control_id = prm_control and f1.not_num = 0 and f1.not_lstope;  
 


SELECT   SUM (sad_pco_amount)
  FROM   (SELECT   pay.sad_pco_amount
            FROM   fis_alcance fa,
                   ops$asy.sad_gen g,
                   ops$asy.bo_sad_payment pay,
                   ops$asy.unatitab una
           WHERE       fa.ctl_control_id = '201740'
                   AND fa.alc_tipo_tramite = 'DUI'
                   AND g.sad_reg_year = fa.alc_gestion
                   AND g.key_cuo = fa.alc_aduana
                   AND g.sad_reg_nber = fa.alc_numero
                   AND pay.key_year = g.key_year
                   AND pay.key_cuo = g.key_cuo
                   AND pay.key_dec IS NULL
                   AND pay.key_nber = g.key_nber
                   AND pay.sad_rcpt_date >=
                          TO_DATE (fecnot, 'dd/mm/yyyy')
                   AND una.ati_cod = pay.sad_pco_code
                   AND una.tax_cod = 'GA'
                   AND una.lst_ope = 'U'
          UNION ALL
          SELECT   pay.sad_pco_amount
            FROM   fis_alcance fa,
                   ops$asy.sad_gen g,
                   ops$asy.bo_sad_payment pay,
                   ops$asy.unatitab una
           WHERE       fa.ctl_control_id = '201740'
                   AND fa.alc_tipo_tramite = 'DUI'
                   AND g.sad_reg_year = fa.alc_gestion
                   AND g.key_cuo = fa.alc_aduana
                   AND g.sad_reg_nber = fa.alc_numero
                   AND pay.key_year = g.key_year
                   AND pay.key_cuo = g.key_cuo
                   AND g.key_dec IS NOT NULL
                   AND pay.key_dec = g.key_dec
                   AND pay.key_nber = g.key_nber
                   AND pay.sad_rcpt_date >=
                          TO_DATE (fecnot, 'dd/mm/yyyy')
                   AND una.ati_cod = pay.sad_pco_code
                   AND una.tax_cod = 'GA'
                   AND una.lst_ope = 'U') tbl;
                   
                   end if;
                   
                   return res;
          end; 


/*

 SELECT   SUM (pay.sad_pco_amount) into res
              FROM   ops$asy.bo_sad_payment pay, ops$asy.unatitab una
             WHERE       pay.key_year = prm_key_year
                     AND pay.key_cuo = prm_key_cuo
                     AND pay.key_dec IS NULL
                     AND pay.key_nber = prm_key_nber
                     AND pay.sad_rcpt_date >=
                            TO_DATE (prm_fecha, 'dd/mm/yyyy')
                     AND una.ati_cod = pay.sad_pco_code
                     AND una.tax_cod = prm_tax_cod
                     AND una.lst_ope = 'U';
        ELSE
            SELECT   SUM (pay.sad_pco_amount) into res
              FROM   ops$asy.bo_sad_payment pay, ops$asy.unatitab una
             WHERE       pay.key_year = prm_key_year
                     AND pay.key_cuo = prm_key_cuo
                     AND pay.key_dec = prm_key_dec
                     AND pay.key_nber = prm_key_nber
                     AND pay.sad_rcpt_date >=
                            TO_DATE (prm_fecha, 'dd/mm/yyyy')
                     AND una.ati_cod = pay.sad_pco_code
                     AND una.tax_cod = prm_tax_cod
                     AND una.lst_ope = 'U';*/

--declaracion
SELECT *
  FROM fis_alcance a, fis_alcance_item b
  where a.ctl_control_id = '201754'
  and a.alc_num = 0
  and a.alc_lstope = 'U'
  and a.alc_alcance_id = b.alc_alcance_id
  and b.ali_num = 0
  and b.ali_lstope = 'U'
  
  
  SELECT a.res_dui, a.res_numero_item, a.res_partida, a.res_fob_usd,
         a.res_flete_usd, a.res_seguro_usd, a.res_otros_usd,
         a.res_cif_usd, a.res_cif_bob, a.res_contrav, a.res_ilicito,
         a.res_observacion, a.res_num, a.res_lstope, a.res_usuario,
         a.res_fecsys, a.key_year, a.key_cuo, a.key_dec, a.key_nber,
         a.res_contravorden, a.alc_alcance_id
    FROM fis_resultados a;
  
  
  SELECT a.alc_alcance_id, a.ali_numero_item, a.ali_obs_valor,
         a.ali_obs_partida, a.ali_obs_origen, a.ali_num, a.ali_lstope,
         a.ali_usuario, a.ali_fecsys, a.ali_obs_otro, a.ali_tipo_etapa
    FROM fis_alcance_item a;
  
  
  
  
SELECT sum(b.res_contrav)* pkg_reporte.tipocambio (
                                         TO_date ('14/06/2017', 'dd/mm/yyyy'),
                                     'UFV') contravdui, sum(b.res_contravorden)*  pkg_reporte.tipocambio (
                                         TO_date ('14/06/2017', 'dd/mm/yyyy'),
                                     'UFV') contravorden
  FROM fis_alcance a, fis_resultados b
  where a.ctl_control_id = '201754'
  and a.alc_num = 0
  and a.alc_lstope = 'U'
  and a.alc_alcance_id = b.alc_alcance_id
  and b.res_num = 0
  and b.res_lstope = 'U'  
  
  
  
  
  SELECT 0 contravdui,sum(nvl(b.ret_contravorden,0)) , sum(nvl(b.ret_contravorden,0))*  pkg_reporte.tipocambio (
                                         TO_date ('14/06/2017', 'dd/mm/yyyy'),
                                     'UFV') contravorden
  FROM fis_alcance a, fis_resultados_tramite b
  where a.ctl_control_id = '201754'
  and a.alc_num = 0
  and a.alc_lstope = 'U'
  and a.alc_alcance_id = b.alc_alcance_id
  and b.ret_num = 0
  and b.ret_lstope = 'U'  
  
  
  
  SELECT a.alc_alcance_id, a.ret_mercancia, a.ret_fob_usd,
         a.ret_flete_usd, a.ret_seguro_usd, a.ret_otros_usd,
         a.ret_cif_usd, a.ret_cif_bob, a.ret_cif_ufv, a.ret_num,
         a.ret_lstope, a.ret_usuario, a.ret_fecsys, a.ret_ilicito,
         a.ret_contravorden
    FROM fis_resultados_tramite a
    where a.alc_alcance_id = '2017260'
  
  SELECT *
  FROM fis_alcance a
   where a.ctl_control_id = '201754'

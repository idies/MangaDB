

select exec_query('c5_ssd','select * from mangadapdb.C5TABLE limit 10' );


select explain_line from do_explain('SELECT
  mangadatadb.cube.mangaid                                        ,
  mangadatadb.cube.plate                                          ,
  mangadatadb.ifudesign.name                                      ,
  mangadapdb.cleanspaxelprop5.emline_gflux_ha_6564                ,
  mangadapdb.cleanspaxelprop5.x                                  ,
  mangadapdb.cleanspaxelprop5.y                                   
FROM mangadatadb.cube
  JOIN mangadatadb.ifudesign ON mangadatadb.ifudesign.pk = mangadatadb.cube.ifudesign_pk
  JOIN mangadapdb.file ON mangadatadb.cube.pk = mangadapdb.file.cube_pk
  JOIN mangadapdb.cleanspaxelprop5 ON mangadapdb.file.pk = mangadapdb.cleanspaxelprop5.file_pk
  JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = mangadatadb.cube.pipeline_info_pk
  JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = mangadapdb.file.pipeline_info_pk
WHERE mangadapdb.cleanspaxelprop5.emline_gflux_ha_6564 > 25.0 AND drpalias.pk = 25 AND dapalias.pk = 26');




select quote_literal
set parallel_setup_cost = 0;
set parallel_tuple_cost = 0;


SELECT --orig 335ms q4
  mangadatadb.cube.mangaid                                        AS "cube.mangaid",
  mangadatadb.cube.plate                                          AS "cube.plate",
  concat(mangadatadb.cube.plate, '-', mangadatadb.ifudesign.name) AS "cube.plateifu",
  mangadatadb.ifudesign.name                                      AS "ifu.name",
  mangadapdb.cleanspaxelprop5.emline_gflux_ha_6564                AS emline_gflux_ha_6564,
  mangasampledb.nsa.z                                             AS "nsa.z",
  mangadapdb.cleanspaxelprop5.x                                   AS "spaxelprop.x",
  mangadapdb.cleanspaxelprop5.y                                   AS "spaxelprop.y"
FROM mangadatadb.cube
  JOIN mangadatadb.ifudesign ON mangadatadb.ifudesign.pk = mangadatadb.cube.ifudesign_pk
  JOIN mangadapdb.file ON mangadatadb.cube.pk = mangadapdb.file.cube_pk
  JOIN mangadapdb.cleanspaxelprop5 ON mangadapdb.file.pk = mangadapdb.cleanspaxelprop5.file_pk
  JOIN mangasampledb.manga_target ON mangasampledb.manga_target.pk = mangadatadb.cube.manga_target_pk
  JOIN mangasampledb.manga_target_to_nsa
    ON mangasampledb.manga_target.pk = mangasampledb.manga_target_to_nsa.manga_target_pk
  JOIN mangasampledb.nsa ON mangasampledb.nsa.pk = mangasampledb.manga_target_to_nsa.nsa_pk
  JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = mangadatadb.cube.pipeline_info_pk
  JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = mangadapdb.file.pipeline_info_pk
WHERE mangasampledb.nsa.z < 0.1 AND mangadapdb.cleanspaxelprop5.emline_gflux_ha_6564 > 25.0 AND drpalias.pk = 25 AND
      dapalias.pk = 26;

    
SELECT  --suetest q4
  suetest.cube.mangaid                                        AS "cube.mangaid",
  suetest.cube.plate                                          AS "cube.plate",
  concat(suetest.cube.plate, '-', mangadatadb.ifudesign.name) AS "cube.plateifu",
  mangadatadb.ifudesign.name                                      AS "ifu.name",
  mangadapdb.cleanspaxelprop5.emline_gflux_ha_6564                AS emline_gflux_ha_6564,
  suetest.nsa.z                                             AS "nsa.z",
  mangadapdb.cleanspaxelprop5.x                                   AS "spaxelprop.x",
  mangadapdb.cleanspaxelprop5.y                                   AS "spaxelprop.y"
FROM suetest.cube
  JOIN mangadatadb.ifudesign ON mangadatadb.ifudesign.pk = suetest.cube.ifudesign_pk
  JOIN suetest.file ON suetest.cube.pk = suetest.file.cube_pk
  JOIN mangadapdb.cleanspaxelprop5 ON suetest.file.pk = mangadapdb.cleanspaxelprop5.file_pk
  JOIN suetest.manga_target ON suetest.manga_target.pk = suetest.cube.manga_target_pk
  JOIN suetest.manga_target_to_nsa
    ON suetest.manga_target.pk = suetest.manga_target_to_nsa.manga_target_pk
  JOIN suetest.nsa ON suetest.nsa.pk = suetest.manga_target_to_nsa.nsa_pk
  JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = suetest.cube.pipeline_info_pk
  JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = suetest.file.pipeline_info_pk
WHERE suetest.nsa.z < 0.1 AND mangadapdb.cleanspaxelprop5.emline_gflux_ha_6564 > 25.0 AND drpalias.pk = 25 AND
      dapalias.pk = 26;
     
SELECT  --suetest q4 part
  suetest.cube.mangaid                                        AS "cube.mangaid",
  suetest.cube.plate                                          AS "cube.plate",
  concat(suetest.cube.plate, '-', mangadatadb.ifudesign.name) AS "cube.plateifu",
  mangadatadb.ifudesign.name                                      AS "ifu.name",
  mangadapdb.cleanspaxelprop5.emline_gflux_ha_6564                AS emline_gflux_ha_6564,
  suetest.nsa.z                                             AS "nsa.z",
  mangadapdb.cleanspaxelprop5.x                                   AS "spaxelprop.x",
  mangadapdb.cleanspaxelprop5.y                                   AS "spaxelprop.y"
FROM suetest.cube
  JOIN mangadatadb.ifudesign ON mangadatadb.ifudesign.pk = suetest.cube.ifudesign_pk
  JOIN suetest.file ON suetest.cube.pk = suetest.file.cube_pk
  JOIN mangadapdb.cleanspaxelprop5 ON suetest.file.pk = mangadapdb.cleanspaxelprop5.file_pk
  JOIN suetest.manga_target ON suetest.manga_target.pk = suetest.cube.manga_target_pk
  JOIN suetest.manga_target_to_nsa
    ON suetest.manga_target.pk = suetest.manga_target_to_nsa.manga_target_pk
  JOIN suetest.nsa ON suetest.nsa.pk = suetest.manga_target_to_nsa.nsa_pk
  JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = suetest.cube.pipeline_info_pk
  JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = suetest.file.pipeline_info_pk
WHERE suetest.nsa.z < 0.1 AND mangadapdb.cleanspaxelprop5.emline_gflux_ha_6564 > 25.0 AND drpalias.pk = 25 AND
      dapalias.pk = 26;

     
--q1
SELECT
  mangadatadb.cube.mangaid                                        AS "cube.mangaid",
  mangadatadb.cube.plate                                          AS "cube.plate",
  concat(mangadatadb.cube.plate, '-', mangadatadb.ifudesign.name) AS "cube.plateifu",
  mangadatadb.ifudesign.name                                      AS "ifu.name",
  mangadapdb.cleanspaxelprop5.emline_gflux_ha_6564                AS emline_gflux_ha_6564,
  mangadapdb.cleanspaxelprop5.x                                   AS "spaxelprop.x",
  mangadapdb.cleanspaxelprop5.y                                   AS "spaxelprop.y"
FROM mangadatadb.cube
  JOIN mangadatadb.ifudesign ON mangadatadb.ifudesign.pk = mangadatadb.cube.ifudesign_pk
  JOIN mangadapdb.file ON mangadatadb.cube.pk = mangadapdb.file.cube_pk
  JOIN mangadapdb.cleanspaxelprop5 ON mangadapdb.file.pk = mangadapdb.cleanspaxelprop5.file_pk
  JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = mangadatadb.cube.pipeline_info_pk
  JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = mangadapdb.file.pipeline_info_pk
WHERE mangadapdb.cleanspaxelprop5.emline_gflux_ha_6564 > 25.0 AND drpalias.pk = 25 AND dapalias.pk = 26;
-- 461.431 ms

--q1
SELECT
  suetest.cube.mangaid                                        AS "cube.mangaid",
  suetest.cube.plate                                          AS "cube.plate",
  concat(suetest.cube.plate, '-', mangadatadb.ifudesign.name) AS "cube.plateifu",
  mangadatadb.ifudesign.name                                      AS "ifu.name",
  suetest.cleanspaxelprop5.emline_gflux_ha_6564                AS emline_gflux_ha_6564,
  suetest.cleanspaxelprop5.x                                   AS "spaxelprop.x",
  suetest.cleanspaxelprop5.y                                   AS "spaxelprop.y"
FROM suetest.cube
  JOIN mangadatadb.ifudesign ON mangadatadb.ifudesign.pk = suetest.cube.ifudesign_pk
  JOIN suetest.file ON suetest.cube.pk = suetest.file.cube_pk
  JOIN suetest.cleanspaxelprop5 ON suetest.file.pk = suetest.cleanspaxelprop5.file_pk
  JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = suetest.cube.pipeline_info_pk
  JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = suetest.file.pipeline_info_pk
WHERE suetest.cleanspaxelprop5.emline_gflux_ha_6564 > 25.0 AND drpalias.pk = 25 AND dapalias.pk = 26;
-- 451.710 ms



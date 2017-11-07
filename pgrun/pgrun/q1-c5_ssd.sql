 SELECT
  mangadatadb.cube.mangaid                                        AS "cube.mangaid",
  mangadatadb.cube.plate                                          AS "cube.plate",
  mangadatadb.cube.plate AS "cube.plateifu",
  mangadatadb.ifudesign.name                                      AS "ifu.name",
  mangadapdb.c5_ssd.emline_gflux_ha_6564                AS emline_gflux_ha_6564,
  mangadapdb.c5_ssd.x                                   AS "spaxelprop.x",
  mangadapdb.c5_ssd.y                                   AS "spaxelprop.y"
FROM mangadatadb.cube
  JOIN mangadatadb.ifudesign ON mangadatadb.ifudesign.pk = mangadatadb.cube.ifudesign_pk
  JOIN mangadapdb.file ON mangadatadb.cube.pk = mangadapdb.file.cube_pk
  JOIN mangadapdb.c5_ssd ON mangadapdb.file.pk = mangadapdb.c5_ssd.file_pk
  JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = mangadatadb.cube.pipeline_info_pk
  JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = mangadapdb.file.pipeline_info_pk
WHERE mangadapdb.c5_ssd.emline_gflux_ha_6564 > 25.0 AND drpalias.pk = 25 AND dapalias.pk = 26
;

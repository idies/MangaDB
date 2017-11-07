SELECT
  mangadatadb.cube.mangaid                                        AS "cube.mangaid",
  mangadatadb.cube.plate                                          AS "cube.plate",
  concat(mangadatadb.cube.plate, '-', mangadatadb.ifudesign.name) AS "cube.plateifu",
  mangadatadb.ifudesign.name                                      AS "ifu.name",
  mangadapdb.C5TABLE.emline_gflux_ha_6564                AS emline_gflux_ha_6564,
  mangasampledb.nsa.z                                             AS "nsa.z",
  mangadapdb.C5TABLE.x                                   AS "spaxelprop.x",
  mangadapdb.C5TABLE.y                                   AS "spaxelprop.y"
FROM mangadatadb.cube
  JOIN mangadatadb.ifudesign ON mangadatadb.ifudesign.pk = mangadatadb.cube.ifudesign_pk
  JOIN mangadapdb.file ON mangadatadb.cube.pk = mangadapdb.file.cube_pk
  JOIN mangadapdb.C5TABLE ON mangadapdb.file.pk = mangadapdb.C5TABLE.file_pk
  JOIN mangasampledb.manga_target ON mangasampledb.manga_target.pk = mangadatadb.cube.manga_target_pk
  JOIN mangasampledb.manga_target_to_nsa
    ON mangasampledb.manga_target.pk = mangasampledb.manga_target_to_nsa.manga_target_pk
  JOIN mangasampledb.nsa ON mangasampledb.nsa.pk = mangasampledb.manga_target_to_nsa.nsa_pk
  JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = mangadatadb.cube.pipeline_info_pk
  JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = mangadapdb.file.pipeline_info_pk
WHERE mangasampledb.nsa.z < 0.1 AND mangadapdb.C5TABLE.emline_gflux_ha_6564 > 25.0 AND drpalias.pk = 25 AND
      dapalias.pk = 26;

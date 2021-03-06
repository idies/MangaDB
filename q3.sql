--q3
SELECT
  mangadatadb.cube.mangaid                                        AS "cube.mangaid",
  mangadatadb.cube.plate                                          AS "cube.plate",
  concat(mangadatadb.cube.plate, '-', mangadatadb.ifudesign.name) AS "cube.plateifu",
  mangadatadb.ifudesign.name                                      AS "ifu.name",
  mangadapdb.cleanspaxelprop5.emline_sew_ha_6564                  AS emline_sew_ha_6564,
  mangasampledb.nsa.sersic_n                                      AS "nsa.sersic_n",
  CAST(CASE WHEN (mangasampledb.nsa.sersic_mass > 0.0)
    THEN log(mangasampledb.nsa.sersic_mass)
       WHEN (mangasampledb.nsa.sersic_mass = 0.0)
         THEN 0.0 END AS FLOAT)                                   AS "nsa.sersic_logmass",
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
WHERE CAST(CASE WHEN (mangasampledb.nsa.sersic_mass > 0.0)
  THEN log(mangasampledb.nsa.sersic_mass)
           WHEN (mangasampledb.nsa.sersic_mass = 0.0)
             THEN 0.0 END AS FLOAT) >= 9.5 AND CAST(CASE WHEN (mangasampledb.nsa.sersic_mass > 0.0)
  THEN log(mangasampledb.nsa.sersic_mass)
                                                    WHEN (mangasampledb.nsa.sersic_mass = 0.0)
                                                      THEN 0.0 END AS FLOAT) < 11.0 AND mangasampledb.nsa.sersic_n < 2.0
      AND mangadapdb.cleanspaxelprop5.emline_sew_ha_6564 > 6.0 AND drpalias.pk = 21 AND dapalias.pk = 23;

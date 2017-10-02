\echo q3 normal start
explain analyze
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
      AND mangadapdb.cleanspaxelprop5.emline_sew_ha_6564 > 6.0 AND drpalias.pk = 25 AND dapalias.pk = 26;
      
 \echo q3 normal end
 
 
 \echo q3 flat start
 explain analyze     
SELECT
  c.mangaid,
  c.plate,
  c.plateifu,
  c.name,
  c.emline_sew_ha_6564,
  c.x,
  c.y,
  n.sersic_n,
  cast(CASE WHEN (n.sersic_mass > 0.0)
    THEN log(n.sersic_mass)
       WHEN (n.sersic_mass = 0.0)
         THEN 0.0 END AS FLOAT) AS sersic_logmass
FROM mangadapdb.flattabletest AS c
  JOIN mangasampledb.nsa AS n ON n.pk = c.nsa_pk
WHERE c.drppipe = 25 AND c.dappipe = 26 AND c.emline_sew_ha_6564 > 6.0 AND n.sersic_n < 2.0 AND
      cast(CASE WHEN (n.sersic_mass > 0.0)
        THEN log(n.sersic_mass)
           WHEN (n.sersic_mass = 0.0)
             THEN 0.0 END AS FLOAT) >= 9.5 AND cast(CASE WHEN (n.sersic_mass > 0.0)
  THEN log(n.sersic_mass)
                                                    WHEN (n.sersic_mass = 0.0)
                                                      THEN 0.0 END AS FLOAT) < 11.0;

\echo q3 flat end
explain analyze
SELECT
  mangadatadb.cube.mangaid                                        AS "cube.mangaid",
  mangadatadb.cube.plate                                          AS "cube.plate",
  concat(mangadatadb.cube.plate, '-', mangadatadb.ifudesign.name) AS "cube.plateifu",
  mangadatadb.ifudesign.name                                      AS "ifu.name",
  mangadapdb.c5_cx.emline_sew_ha_6564                  AS emline_sew_ha_6564,
  mangasampledb.nsa.sersic_n                                      AS "nsa.sersic_n",
  CAST(CASE WHEN (mangasampledb.nsa.sersic_mass > 0.0)
    THEN log(mangasampledb.nsa.sersic_mass)
       WHEN (mangasampledb.nsa.sersic_mass = 0.0)
         THEN 0.0 END AS FLOAT)                                   AS "nsa.sersic_logmass",
  mangadapdb.c5_cx.x                                   AS "spaxelprop.x",
  mangadapdb.c5_cx.y                                   AS "spaxelprop.y"
FROM mangadatadb.cube
  JOIN mangadatadb.ifudesign ON mangadatadb.ifudesign.pk = mangadatadb.cube.ifudesign_pk
  JOIN mangadapdb.file ON mangadatadb.cube.pk = mangadapdb.file.cube_pk
  JOIN mangadapdb.c5_cx ON mangadapdb.file.pk = mangadapdb.c5_cx.file_pk
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
      AND mangadapdb.c5_cx.emline_sew_ha_6564 > 6.0 AND drpalias.pk = 25 AND dapalias.pk = 26;
      
 \echo q3 cx end
 
 \echo q3 cstore start
 explain analyze
 SELECT
   mangadatadb.cube.mangaid                                        AS "cube.mangaid",
   mangadatadb.cube.plate                                          AS "cube.plate",
   concat(mangadatadb.cube.plate, '-', mangadatadb.ifudesign.name) AS "cube.plateifu",
   mangadatadb.ifudesign.name                                      AS "ifu.name",
   mangadapdb.c5_cstore.emline_sew_ha_6564                  AS emline_sew_ha_6564,
   mangasampledb.nsa.sersic_n                                      AS "nsa.sersic_n",
   CAST(CASE WHEN (mangasampledb.nsa.sersic_mass > 0.0)
     THEN log(mangasampledb.nsa.sersic_mass)
        WHEN (mangasampledb.nsa.sersic_mass = 0.0)
          THEN 0.0 END AS FLOAT)                                   AS "nsa.sersic_logmass",
   mangadapdb.c5_cstore.x                                   AS "spaxelprop.x",
   mangadapdb.c5_cstore.y                                   AS "spaxelprop.y"
 FROM mangadatadb.cube
   JOIN mangadatadb.ifudesign ON mangadatadb.ifudesign.pk = mangadatadb.cube.ifudesign_pk
   JOIN mangadapdb.file ON mangadatadb.cube.pk = mangadapdb.file.cube_pk
   JOIN mangadapdb.c5_cstore ON mangadapdb.file.pk = mangadapdb.c5_cstore.file_pk
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
      AND mangadapdb.c5_cstore.emline_sew_ha_6564 > 6.0 AND drpalias.pk = 25 AND dapalias.pk = 26;
      
      
 \echo q3 cstore end
 
 


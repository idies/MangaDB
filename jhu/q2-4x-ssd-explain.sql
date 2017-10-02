\echo q2 normal start
explain analyze
SELECT
  anon_1."cube.mangaid",
  anon_1."cube.plate",
  concat(anon_1."cube.plate", '-', anon_1."ifu.name") AS plateifu,
  anon_1."ifu.name"
FROM (SELECT
        mangadatadb.cube.mangaid                                        AS "cube.mangaid",
        mangadatadb.cube.plate                                          AS "cube.plate",
        concat(mangadatadb.cube.plate, '-', mangadatadb.ifudesign.name) AS "cube.plateifu",
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
        JOIN (SELECT
                mangadapdb.c5_ssd.file_pk   AS binfile,
                count(mangadapdb.c5_ssd.pk) AS goodcount
              FROM mangadapdb.c5_ssd
              WHERE mangadapdb.c5_ssd.binid != -1
              GROUP BY mangadapdb.c5_ssd.file_pk) AS bingood
          ON bingood.binfile = mangadapdb.c5_ssd.file_pk
        JOIN (SELECT
                mangadapdb.c5_ssd.file_pk   AS valfile,
                count(mangadapdb.c5_ssd.pk) AS valcount
              FROM mangadapdb.c5_ssd
              WHERE mangadapdb.c5_ssd.emline_gflux_ha_6564 > 5.0
              GROUP BY mangadapdb.c5_ssd.file_pk) AS goodhacount
          ON goodhacount.valfile = mangadapdb.c5_ssd.file_pk
      WHERE drpalias.pk = 25 AND dapalias.pk = 26 AND goodhacount.valcount >= 0.2 * bingood.goodcount) AS anon_1
GROUP BY anon_1."cube.mangaid", anon_1."cube.plate", concat(anon_1."cube.plate", '-', anon_1."ifu.name"),
  anon_1."ifu.name";
  
  \echo q2 normal end

-----------------------------------------------
\echo q2 flat start
explain analyze
SELECT
  a.mangaid,
  a.plate,
  a.plateifu,
  a.name
FROM (SELECT
        mangadapdb.c5_flat_ssd.mangaid,
        mangadapdb.c5_flat_ssd.plate,
        mangadapdb.c5_flat_ssd.plateifu,
        mangadapdb.c5_flat_ssd.name,
        mangadapdb.c5_flat_ssd.emline_gflux_ha_6564,
        mangadapdb.c5_flat_ssd.x,
        mangadapdb.c5_flat_ssd.y
      FROM mangadapdb.c5_flat_ssd
        JOIN (SELECT
                mangadapdb.c5_flat_ssd.file_pk   AS binfile,
                count(mangadapdb.c5_flat_ssd.pk) AS goodcount
              FROM mangadapdb.c5_flat_ssd
              WHERE mangadapdb.c5_flat_ssd.binid != -1
              GROUP BY mangadapdb.c5_flat_ssd.file_pk) AS bingood
          ON bingood.binfile = mangadapdb.c5_flat_ssd.file_pk
        JOIN (SELECT
                mangadapdb.c5_flat_ssd.file_pk   AS valfile,
                count(mangadapdb.c5_flat_ssd.pk) AS valcount
              FROM mangadapdb.c5_flat_ssd
              WHERE mangadapdb.c5_flat_ssd.emline_gflux_ha_6564 > 5.0
              GROUP BY mangadapdb.c5_flat_ssd.file_pk) AS goodhacount
          ON goodhacount.valfile = mangadapdb.c5_flat_ssd.file_pk
      WHERE mangadapdb.c5_flat_ssd.drppipe = 25 AND mangadapdb.c5_flat_ssd.dappipe = 26 AND
            goodhacount.valcount >= 0.2 * bingood.goodcount) AS a
GROUP BY a.mangaid, a.plate, a.plateifu, a.name;

\echo q2 flat end

\echo q2 cx start
explain analyze
SELECT
  anon_1."cube.mangaid",
  anon_1."cube.plate",
  concat(anon_1."cube.plate", '-', anon_1."ifu.name") AS plateifu,
  anon_1."ifu.name"
FROM (SELECT
        mangadatadb.cube.mangaid                                        AS "cube.mangaid",
        mangadatadb.cube.plate                                          AS "cube.plate",
        concat(mangadatadb.cube.plate, '-', mangadatadb.ifudesign.name) AS "cube.plateifu",
        mangadatadb.ifudesign.name                                      AS "ifu.name",
        mangadapdb.c5_cx_ssd.emline_gflux_ha_6564                AS emline_gflux_ha_6564,
        mangadapdb.c5_cx_ssd.x                                   AS "spaxelprop.x",
        mangadapdb.c5_cx_ssd.y                                   AS "spaxelprop.y"
      FROM mangadatadb.cube
        JOIN mangadatadb.ifudesign ON mangadatadb.ifudesign.pk = mangadatadb.cube.ifudesign_pk
        JOIN mangadapdb.file ON mangadatadb.cube.pk = mangadapdb.file.cube_pk
        JOIN mangadapdb.c5_cx_ssd ON mangadapdb.file.pk = mangadapdb.c5_cx_ssd.file_pk
        JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = mangadatadb.cube.pipeline_info_pk
        JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = mangadapdb.file.pipeline_info_pk
        JOIN (SELECT
                mangadapdb.c5_cx_ssd.file_pk   AS binfile,
                count(mangadapdb.c5_cx_ssd.pk) AS goodcount
              FROM mangadapdb.c5_cx_ssd
              WHERE mangadapdb.c5_cx_ssd.binid != -1
              GROUP BY mangadapdb.c5_cx_ssd.file_pk) AS bingood
          ON bingood.binfile = mangadapdb.c5_cx_ssd.file_pk
        JOIN (SELECT
                mangadapdb.c5_cx_ssd.file_pk   AS valfile,
                count(mangadapdb.c5_cx_ssd.pk) AS valcount
              FROM mangadapdb.c5_cx_ssd
              WHERE mangadapdb.c5_cx_ssd.emline_gflux_ha_6564 > 5.0
              GROUP BY mangadapdb.c5_cx_ssd.file_pk) AS goodhacount
          ON goodhacount.valfile = mangadapdb.c5_cx_ssd.file_pk
      WHERE drpalias.pk = 25 AND dapalias.pk = 26 AND goodhacount.valcount >= 0.2 * bingood.goodcount) AS anon_1
GROUP BY anon_1."cube.mangaid", anon_1."cube.plate", concat(anon_1."cube.plate", '-', anon_1."ifu.name"),
  anon_1."ifu.name";
  
  \echo q2 cx end
  
  \echo q2 cstore start
  explain analyze
  SELECT
    anon_1."cube.mangaid",
    anon_1."cube.plate",
    concat(anon_1."cube.plate", '-', anon_1."ifu.name") AS plateifu,
    anon_1."ifu.name"
  FROM (SELECT
          mangadatadb.cube.mangaid                                        AS "cube.mangaid",
          mangadatadb.cube.plate                                          AS "cube.plate",
          concat(mangadatadb.cube.plate, '-', mangadatadb.ifudesign.name) AS "cube.plateifu",
          mangadatadb.ifudesign.name                                      AS "ifu.name",
          mangadapdb.c5_cstore_ssd.emline_gflux_ha_6564                AS emline_gflux_ha_6564,
          mangadapdb.c5_cstore_ssd.x                                   AS "spaxelprop.x",
          mangadapdb.c5_cstore_ssd.y                                   AS "spaxelprop.y"
        FROM mangadatadb.cube
          JOIN mangadatadb.ifudesign ON mangadatadb.ifudesign.pk = mangadatadb.cube.ifudesign_pk
          JOIN mangadapdb.file ON mangadatadb.cube.pk = mangadapdb.file.cube_pk
          JOIN mangadapdb.c5_cstore_ssd ON mangadapdb.file.pk = mangadapdb.c5_cstore_ssd.file_pk
          JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = mangadatadb.cube.pipeline_info_pk
          JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = mangadapdb.file.pipeline_info_pk
          JOIN (SELECT
                  mangadapdb.c5_cstore_ssd.file_pk   AS binfile,
                  count(mangadapdb.c5_cstore_ssd.pk) AS goodcount
                FROM mangadapdb.c5_cstore_ssd
                WHERE mangadapdb.c5_cstore_ssd.binid != -1
                GROUP BY mangadapdb.c5_cstore_ssd.file_pk) AS bingood
            ON bingood.binfile = mangadapdb.c5_cstore_ssd.file_pk
          JOIN (SELECT
                  mangadapdb.c5_cstore_ssd.file_pk   AS valfile,
                  count(mangadapdb.c5_cstore_ssd.pk) AS valcount
                FROM mangadapdb.c5_cstore_ssd
                WHERE mangadapdb.c5_cstore_ssd.emline_gflux_ha_6564 > 5.0
                GROUP BY mangadapdb.c5_cstore_ssd.file_pk) AS goodhacount
            ON goodhacount.valfile = mangadapdb.c5_cstore_ssd.file_pk
        WHERE drpalias.pk = 25 AND dapalias.pk = 26 AND goodhacount.valcount >= 0.2 * bingood.goodcount) AS anon_1
  GROUP BY anon_1."cube.mangaid", anon_1."cube.plate", concat(anon_1."cube.plate", '-', anon_1."ifu.name"),
  anon_1."ifu.name";
  
  \echo q2 cstore end
  
  
  



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
        mangadapdb.cleanspaxelprop5.emline_gflux_ha_6564                AS emline_gflux_ha_6564,
        mangadapdb.cleanspaxelprop5.x                                   AS "spaxelprop.x",
        mangadapdb.cleanspaxelprop5.y                                   AS "spaxelprop.y"
      FROM mangadatadb.cube
        JOIN mangadatadb.ifudesign ON mangadatadb.ifudesign.pk = mangadatadb.cube.ifudesign_pk
        JOIN mangadapdb.file ON mangadatadb.cube.pk = mangadapdb.file.cube_pk
        JOIN mangadapdb.cleanspaxelprop5 ON mangadapdb.file.pk = mangadapdb.cleanspaxelprop5.file_pk
        JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = mangadatadb.cube.pipeline_info_pk
        JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = mangadapdb.file.pipeline_info_pk
        JOIN (SELECT
                mangadapdb.cleanspaxelprop5.file_pk   AS binfile,
                count(mangadapdb.cleanspaxelprop5.pk) AS goodcount
              FROM mangadapdb.cleanspaxelprop5
              WHERE mangadapdb.cleanspaxelprop5.binid != -1
              GROUP BY mangadapdb.cleanspaxelprop5.file_pk) AS bingood
          ON bingood.binfile = mangadapdb.cleanspaxelprop5.file_pk
        JOIN (SELECT
                mangadapdb.cleanspaxelprop5.file_pk   AS valfile,
                count(mangadapdb.cleanspaxelprop5.pk) AS valcount
              FROM mangadapdb.cleanspaxelprop5
              WHERE mangadapdb.cleanspaxelprop5.emline_gflux_ha_6564 > 5.0
              GROUP BY mangadapdb.cleanspaxelprop5.file_pk) AS goodhacount
          ON goodhacount.valfile = mangadapdb.cleanspaxelprop5.file_pk
      WHERE drpalias.pk = 25 AND dapalias.pk = 26 AND goodhacount.valcount >= 0.2 * bingood.goodcount) AS anon_1
GROUP BY anon_1."cube.mangaid", anon_1."cube.plate", concat(anon_1."cube.plate", '-', anon_1."ifu.name"),
  anon_1."ifu.name";

-----------------------------------------------

SELECT
  a.mangaid,
  a.plate,
  a.plateifu,
  a.name
FROM (SELECT
        mangadapdb.flattabletest.mangaid,
        mangadapdb.flattabletest.plate,
        mangadapdb.flattabletest.plateifu,
        mangadapdb.flattabletest.name,
        mangadapdb.flattabletest.emline_gflux_ha_6564,
        mangadapdb.flattabletest.x,
        mangadapdb.flattabletest.y
      FROM mangadapdb.flattabletest
        JOIN (SELECT
                mangadapdb.flattabletest.file_pk   AS binfile,
                count(mangadapdb.flattabletest.pk) AS goodcount
              FROM mangadapdb.flattabletest
              WHERE mangadapdb.flattabletest.binid != -1
              GROUP BY mangadapdb.flattabletest.file_pk) AS bingood
          ON bingood.binfile = mangadapdb.flattabletest.file_pk
        JOIN (SELECT
                mangadapdb.flattabletest.file_pk   AS valfile,
                count(mangadapdb.flattabletest.pk) AS valcount
              FROM mangadapdb.flattabletest
              WHERE mangadapdb.flattabletest.emline_gflux_ha_6564 > 5.0
              GROUP BY mangadapdb.flattabletest.file_pk) AS goodhacount
          ON goodhacount.valfile = mangadapdb.flattabletest.file_pk
      WHERE mangadapdb.flattabletest.drppipe = 25 AND mangadapdb.flattabletest.dappipe = 26 AND
            goodhacount.valcount >= 0.2 * bingood.goodcount) AS a
GROUP BY a.mangaid, a.plate, a.plateifu, a.name;

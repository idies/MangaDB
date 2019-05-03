--q2
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
        mangadapdb.c5_cx.emline_gflux_ha_6564                AS emline_gflux_ha_6564,
        mangadapdb.c5_cx.x                                   AS "spaxelprop.x",
        mangadapdb.c5_cx.y                                   AS "spaxelprop.y"
      FROM mangadatadb.cube
        JOIN mangadatadb.ifudesign ON mangadatadb.ifudesign.pk = mangadatadb.cube.ifudesign_pk
        JOIN mangadapdb.file ON mangadatadb.cube.pk = mangadapdb.file.cube_pk
        JOIN mangadapdb.c5_cx ON mangadapdb.file.pk = mangadapdb.c5_cx.file_pk
        JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = mangadatadb.cube.pipeline_info_pk
        JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = mangadapdb.file.pipeline_info_pk
        JOIN (SELECT
                mangadapdb.c5_cx.file_pk   AS binfile,
                count(mangadapdb.c5_cx.pk) AS goodcount
              FROM mangadapdb.c5_cx
              WHERE mangadapdb.c5_cx.binid != -1
              GROUP BY mangadapdb.c5_cx.file_pk) AS bingood
          ON bingood.binfile = mangadapdb.c5_cx.file_pk
        JOIN (SELECT
                mangadapdb.c5_cx.file_pk   AS valfile,
                count(mangadapdb.c5_cx.pk) AS valcount
              FROM mangadapdb.c5_cx
              WHERE mangadapdb.c5_cx.emline_gflux_ha_6564 > 5.0
              GROUP BY mangadapdb.c5_cx.file_pk) AS goodhacount
          ON goodhacount.valfile = mangadapdb.c5_cx.file_pk
      WHERE drpalias.pk = 25 AND dapalias.pk = 26 AND goodhacount.valcount >= 0.2 * bingood.goodcount) AS anon_1
GROUP BY anon_1."cube.mangaid", anon_1."cube.plate", concat(anon_1."cube.plate", '-', anon_1."ifu.name"),
  anon_1."ifu.name";

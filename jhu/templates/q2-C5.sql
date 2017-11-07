SELECT
  cube.mangaid,
  cube.plate,
  concat(cube.plate, "-", ifu.name) AS plateifu,
  ifu.name
FROM (SELECT
        mangadatadb.cube.mangaid                                       ,
        mangadatadb.cube.plate                                          ,
        concat(mangadatadb.cube.plate, '-', mangadatadb.ifudesign.name) ,
        mangadatadb.ifudesign.name                                      ,
        mangadapdb.C5TABLE.emline_gflux_ha_6564             ,
        mangadapdb.C5TABLE.x                                  ,
        mangadapdb.C5TABLE.y
      FROM mangadatadb.cube
        JOIN mangadatadb.ifudesign ON mangadatadb.ifudesign.pk = mangadatadb.cube.ifudesign_pk
        JOIN mangadapdb.file ON mangadatadb.cube.pk = mangadapdb.file.cube_pk
        JOIN mangadapdb.C5TABLE ON mangadapdb.file.pk = mangadapdb.C5TABLE.file_pk
        JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = mangadatadb.cube.pipeline_info_pk
        JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = mangadapdb.file.pipeline_info_pk
        JOIN (SELECT
                mangadapdb.C5TABLE.file_pk   AS binfile,
                count(mangadapdb.C5TABLE.pk) AS goodcount
              FROM mangadapdb.C5TABLE
              WHERE mangadapdb.C5TABLE.binid != -1
              GROUP BY mangadapdb.C5TABLE.file_pk) AS bingood
          ON bingood.binfile = mangadapdb.C5TABLE.file_pk
        JOIN (SELECT
                mangadapdb.C5TABLE.file_pk   AS valfile,
                count(mangadapdb.C5TABLE.pk) AS valcount
              FROM mangadapdb.C5TABLE
              WHERE mangadapdb.C5TABLE.emline_gflux_ha_6564 > 5.0
              GROUP BY mangadapdb.C5TABLE.file_pk) AS goodhacount
          ON goodhacount.valfile = mangadapdb.C5TABLE.file_pk
      WHERE drpalias.pk = 25 AND dapalias.pk = 26 AND goodhacount.valcount >= 0.2 * bingood.goodcount) AS t1
GROUP BY anon_1."cube.mangaid", anon_1."cube.plate", concat(cube.plate, "-", ifu.name),
  anon_1."ifu.name";
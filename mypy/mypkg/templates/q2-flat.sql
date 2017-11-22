

-----------------------------------------------

SELECT
  a.mangaid,
  a.plate,
  a.plateifu,
  a.name
FROM (SELECT
        mangadapdb.FLAT.mangaid,
        mangadapdb.FLAT.plate,
        mangadapdb.FLAT.plateifu,
        mangadapdb.FLAT.name,
        mangadapdb.FLAT.emline_gflux_ha_6564,
        mangadapdb.FLAT.x,
        mangadapdb.FLAT.y
      FROM mangadapdb.FLAT
        JOIN (SELECT
                mangadapdb.FLAT.file_pk   AS binfile,
                count(mangadapdb.FLAT.pk) AS goodcount
              FROM mangadapdb.FLAT
              WHERE mangadapdb.FLAT.binid != -1
              GROUP BY mangadapdb.FLAT.file_pk) AS bingood
          ON bingood.binfile = mangadapdb.FLAT.file_pk
        JOIN (SELECT
                mangadapdb.FLAT.file_pk   AS valfile,
                count(mangadapdb.FLAT.pk) AS valcount
              FROM mangadapdb.FLAT
              WHERE mangadapdb.FLAT.emline_gflux_ha_6564 > 5.0
              GROUP BY mangadapdb.FLAT.file_pk) AS goodhacount
          ON goodhacount.valfile = mangadapdb.FLAT.file_pk
      WHERE mangadapdb.FLAT.drppipe = 25 AND mangadapdb.FLAT.dappipe = 26 AND
            goodhacount.valcount >= 0.2 * bingood.goodcount) AS a
GROUP BY a.mangaid, a.plate, a.plateifu, a.name;

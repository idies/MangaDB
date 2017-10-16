SELECT
  c.mangaid,
  c.plate,
  c.plateifu,
  c.name,
  c.emline_gflux_ha_6564,
  c.x,
  c.y
FROM mangadapdb.FLAT AS c
WHERE c.drppipe = 25 AND c.dappipe = 26 AND c.emline_gflux_ha_6564 > 25.0;

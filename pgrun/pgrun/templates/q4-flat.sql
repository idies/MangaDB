SELECT
  c.mangaid,
  c.plate,
  c.plateifu,
  c.name,
  c.emline_gflux_ha_6564,
  c.x,
  c.y,
  n.z
FROM mangadapdb.FLAT AS c
  JOIN mangasampledb.nsa AS n ON n.pk = c.nsa_pk
WHERE c.drppipe = 25 AND c.dappipe = 26 AND c.emline_gflux_ha_6564 > 25.0 AND n.z < 0.1;

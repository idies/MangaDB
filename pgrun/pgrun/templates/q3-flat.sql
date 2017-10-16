
SELECT
  c.mangaid,
  c.plate,
  c.plateifu,
  c.name,
  c.emline_sew_ha_6564,
  c.x,
  c.y,
  n.sersic_n,
  n.sersic_mass
FROM mangadapdb.FLAT AS c
  JOIN mangasampledb.nsa AS n ON n.pk = c.nsa_pk
WHERE
  c.drppipe = 25 AND c.dappipe = 26 AND c.emline_sew_ha_6564 > 6.0 AND n.sersic_n < 2.0 AND n.sersic_mass > 3.2e9 AND
  n.sersic_mass < 1e11;

SELECT c.mangaid, c.plate, concat(c.plate, '-', i.name) AS "plateifu", i.name , 
CAST(CASE WHEN (n.sersic_mass > 0.0) THEN log(n.sersic_mass) WHEN (n.sersic_mass = 0.0) THEN 0.0 END AS FLOAT) AS sersic_logmass, 
sp.emline_ew_ha_6564, n.sersic_n, sp.x, sp.y

FROM mangadatadb.cube as c 
JOIN mangadatadb.ifudesign as i ON i.pk = c.ifudesign_pk 
JOIN mangasampledb.manga_target as t ON t.pk = c.manga_target_pk 
JOIN mangasampledb.manga_target_to_nsa as nt ON t.pk = nt.manga_target_pk 
JOIN mangasampledb.nsa as n ON n.pk = nt.nsa_pk 
JOIN mangadapdb.file as f ON c.pk = f.cube_pk 
JOIN mangadapdb.cleanspaxelprop as sp ON f.pk = sp.file_pk 
JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = c.pipeline_info_pk 
JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = f.pipeline_info_pk

WHERE CAST(CASE WHEN (n.sersic_mass > 0.0) THEN log(n.sersic_mass) WHEN (n.sersic_mass = 0.0) THEN 0.0 END AS FLOAT) >= 9.5 
AND CAST(CASE WHEN (n.sersic_mass > 0.0) THEN log(n.sersic_mass) WHEN (n.sersic_mass = 0.0) THEN 0.0 END AS FLOAT) < 11.0 
AND n.sersic_n < 2.0 
AND sp.emline_ew_ha_6564 > 3.0 
AND drpalias.pk = 21 
AND dapalias.pk = 23


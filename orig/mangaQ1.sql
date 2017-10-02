SELECT c.mangaid, c.plate, concat(c.plate, '-', i.name) AS plateifu, i.name, sp.emline_gflux_ha_6564, sp.x, sp.y
FROM mangadatadb.cube as c JOIN mangadatadb.ifudesign as i ON i.pk = c.ifudesign_pk 
JOIN mangadapdb.file as f ON c.pk = f.cube_pk 
JOIN mangadapdb.cleanspaxelprop as sp ON f.pk = sp.file_pk 
JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = c.pipeline_info_pk JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = f.pipeline_info_pk
WHERE sp.emline_gflux_ha_6564 > 25.0 AND drpalias.pk = 21 AND dapalias.pk = 23

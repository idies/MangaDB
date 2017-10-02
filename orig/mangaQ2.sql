SELECT a.mangaid, a.plate, a.plateifu, a.name

FROM 
(
SELECT c.mangaid, c.plate, concat(c.plate, '-', i.name) AS plateifu, i.name, sp.emline_gflux_ha_6564, sp.x, sp.y

FROM mangadatadb.cube as c 
JOIN mangadatadb.ifudesign as i ON i.pk = c.ifudesign_pk 
JOIN mangadapdb.file as f ON c.pk = f.cube_pk 
JOIN mangadapdb.cleanspaxelprop as sp ON f.pk = sp.file_pk 
JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = c.pipeline_info_pk 
JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = f.pipeline_info_pk

JOIN 
(
SELECT sp.file_pk AS binfile, count(sp.pk) AS goodcount
FROM mangadapdb.cleanspaxelprop as sp
WHERE sp.binid != -1 
GROUP BY sp.file_pk
) AS bingood ON bingood.binfile = sp.file_pk 
JOIN 
(
SELECT sp.file_pk AS valfile, count(sp.pk) AS valcount
FROM mangadapdb.cleanspaxelprop as sp
WHERE sp.emline_gflux_ha_6564 > 5.0 GROUP BY sp.file_pk
) AS goodhacount ON goodhacount.valfile = sp.file_pk

WHERE drpalias.pk = 21 AND dapalias.pk = 23 
AND goodhacount.valcount >= 0.2 * bingood.goodcount) AS a 
GROUP BY a.mangaid, a.plate, a.plateifu, a.name


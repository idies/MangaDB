SELECT c.pipeline_info_pk AS drppipe, f.pipeline_info_pk AS dappipe, c.plate, c.mangaid, i.name, CONCAT(c.plate,'-',i.name) AS plateifu, n.pk AS nsa_pk, c5.* 
INTO mangadapdb.flattabletest
FROM mangadatadb.cube AS c
LEFT OUTER
JOIN mangasampledb.manga_target AS m ON m.pk=c.manga_target_pk
JOIN mangasampledb.manga_target_to_nsa AS mt ON mt.manga_target_pk=m.pk
JOIN mangasampledb.nsa AS n ON n.pk=mt.nsa_pk
JOIN mangadatadb.ifudesign AS i ON i.pk=c.ifudesign_pk
JOIN mangadapdb.file AS f ON f.cube_pk=c.pk
JOIN mangadapdb.cleanspaxelprop5 AS c5 ON c5.file_pk = f.pk;
SELECT c.plate, i.name, s.flux, s.ivar, s.mask, w.wavelength
FROM mangadatadb.cube AS c
JOIN mangadatadb.ifudesign AS i ON i.pk=c.ifudesign_pk
JOIN mangadatadb.spaxel AS s ON c.pk=s.cube_pk
JOIN mangadatadb.wavelength AS w ON w.pk=c.wavelength_pk
WHERE c.pipeline_info_pk=25 AND c.plate=7443 AND i.name='12701';
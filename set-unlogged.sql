alter table mangaauxdb.cube_header set unlogged;
alter table mangaauxdb.maskbit set unlogged;
alter table mangaauxdb.maskbit_labels set unlogged;
alter table mangadapdb.binid set unlogged;
alter table mangadapdb.binmode set unlogged;
alter table mangadapdb.bintype set unlogged;
alter table mangadapdb.cleanspaxelprop set unlogged;
alter table mangadapdb.cleanspaxelprop5 set unlogged;
alter table mangadapdb.cleanspaxelprop6 set unlogged;
alter table mangadapdb.cleanspaxelprop7 set unlogged;
alter table mangadapdb.current_default set unlogged;
alter table mangadapdb.dapall set unlogged;
alter table mangadapdb.executionplan set unlogged;
alter table mangadapdb.extname set unlogged;
alter table mangadapdb.exttype set unlogged;
alter table mangadapdb.file set unlogged;
alter table mangadapdb.filetype set unlogged;
alter table mangadapdb.hdu set unlogged;
alter table mangadapdb.hdu_to_extcol set unlogged;
alter table mangadapdb.hdu_to_header_value set unlogged;
alter table mangadapdb.header_keyword set unlogged;
alter table mangadapdb.header_value set unlogged;
alter table mangadapdb.modelcube set unlogged;
alter table mangadapdb.modelspaxel set unlogged;
alter table mangadapdb.redcorr set unlogged;
alter table mangadapdb.spaxelprop set unlogged;
alter table mangadapdb.spaxelprop5 set unlogged;
alter table mangadapdb.spaxelprop6 set unlogged;
alter table mangadapdb.spaxelprop7 set unlogged;
alter table mangadapdb.structure set unlogged;
alter table mangadapdb.template set unlogged;
alter table mangadatadb.cart set unlogged;
alter table mangadatadb.cart_to_cube set unlogged;
alter table mangadatadb.cube set unlogged;
alter table mangadatadb.cube_shape set unlogged;
alter table mangadatadb.fiber_type set unlogged;
alter table mangadatadb.fibers set unlogged;
alter table mangadatadb.fits_header_keyword set unlogged;
alter table mangadatadb.fits_header_value set unlogged;
alter table mangadatadb.ifu_to_block set unlogged;
alter table mangadatadb.ifudesign set unlogged;
alter table mangadatadb.obsinfo set unlogged;
alter table mangadatadb.pipeline_completion_status set unlogged;
alter table mangadatadb.pipeline_info set unlogged;
alter table mangadatadb.pipeline_name set unlogged;
alter table mangadatadb.pipeline_stage set unlogged;
alter table mangadatadb.pipeline_version set unlogged;
alter table mangadatadb.rssfiber set unlogged;
alter table mangadatadb.sample set unlogged;
alter table mangadatadb.slitblock set unlogged;
alter table mangadatadb.spaxel set unlogged;
alter table mangadatadb.target_type set unlogged;
alter table mangadatadb.temprssdiff set unlogged;
alter table mangadatadb.tempspaxeldiff set unlogged;
alter table mangadatadb.test_rssfiber set unlogged;
alter table mangadatadb.test_spaxel set unlogged;
alter table mangadatadb.wavelength set unlogged;
alter table mangadatadb.wcs set unlogged;
alter table mangasampledb.anime set unlogged;
alter table mangasampledb.character set unlogged;
alter table mangasampledb.current_catalogue set unlogged;
alter table mangasampledb.manga_target set unlogged;
alter table mangasampledb.manga_target_to_manga_target set unlogged;
alter table mangasampledb.manga_target_to_nsa set unlogged;
alter table mangasampledb.nsa set unlogged;

alter database manga set search_path to mangasampledb,mangadatadb,mangadapdb,mangaauxdb;

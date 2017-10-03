

create table mangadapdb.c5_ssd tablespace manga_ssd as select * from mangadapdb.cleanspaxelprop5;

alter table mangadapdb.c5_ssd add constraint pk_c5_ssd_file_pk primary key (file_pk);

CREATE	INDEX IX_c5_ssd_specindex_d4000  on mangadapdb.c5_ssd( specindex_d4000 ) WITH (FILLFACTOR=100);
CREATE	INDEX IX_c5_ssd_binid on mangadapdb.c5_ssd(binid)WITH (FILLFACTOR=100);
CREATE	INDEX IX_c5_ssd_emline_gflux_ha_6564  on mangadapdb.c5_ssd( emline_gflux_ha_6564 )WITH (FILLFACTOR=100);
CREATE	INDEX IX_c5_ssd_emline_gflux_hb_4862  on mangadapdb.c5_ssd( emline_gflux_hb_4862 )WITH (FILLFACTOR=100);
CREATE	INDEX IX_c5_ssd_emline_gflux_nii_6585  on mangadapdb.c5_ssd( emline_gflux_nii_6585 )WITH (FILLFACTOR=100);
CREATE	INDEX IX_c5_ssd_emline_gflux_oiid_3728 on mangadapdb.c5_ssd( emline_gflux_oiid_3728 )WITH (FILLFACTOR=100);
CREATE	INDEX IX_c5_ssd_emline_gflux_oiii_5008  on mangadapdb.c5_ssd( emline_gflux_oiii_5008 )WITH (FILLFACTOR=100);
CREATE	INDEX IX_c5_ssd_emline_gflux_sii_6718  on mangadapdb.c5_ssd( emline_gflux_sii_6718 )WITH (FILLFACTOR=100);

CREATE	INDEX IX_c5_ssd_spaxel_index  on mangadapdb.c5_ssd( spaxel_index )WITH (FILLFACTOR=100);
CREATE	INDEX IX_c5_ssd_stellar_vel  on mangadapdb.c5_ssd( stellar_vel )WITH (FILLFACTOR=100);


analyze mangadapdb.c5_ssd;


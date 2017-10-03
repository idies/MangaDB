

create table mangadapdb.c5_cx as select * from mangadapdb.cleanspaxelprop5;

alter table c5_cx add primary key cx_file_pk(file_pk);

--CREATE	INDEX CX_file_pk on mangadapdb.c5_cx ( file_pk ) WITH (FILLFACTOR=100);
alter table mangadapdb.c5_cx cluster on cx_file_pk;

CREATE	INDEX IX_specindex_d4000  on mangadapdb.c5_cx( specindex_d4000 ) WITH (FILLFACTOR=100);
CREATE	INDEX IX_binid on mangadapdb.c5_cx(binid)WITH (FILLFACTOR=100);
CREATE	INDEX IX_emline_gflux_ha_6564  on mangadapdb.c5_cx( emline_gflux_ha_6564 )WITH (FILLFACTOR=100);
CREATE	INDEX IX_emline_gflux_hb_4862  on mangadapdb.c5_cx( emline_gflux_hb_4862 )WITH (FILLFACTOR=100);
CREATE	INDEX IX_emline_gflux_nii_6585  on mangadapdb.c5_cx( emline_gflux_nii_6585 )WITH (FILLFACTOR=100);
CREATE	INDEX IX_emline_gflux_oiid_3728 on mangadapdb.c5_cx( emline_gflux_oiid_3728 )WITH (FILLFACTOR=100);
CREATE	INDEX IX_emline_gflux_oiii_5008  on mangadapdb.c5_cx( emline_gflux_oiii_5008 )WITH (FILLFACTOR=100);
CREATE	INDEX IX_emline_gflux_sii_6718  on mangadapdb.c5_cx( emline_gflux_sii_6718 )WITH (FILLFACTOR=100);

CREATE	INDEX IX_spaxel_index  on mangadapdb.c5_cx( spaxel_index )WITH (FILLFACTOR=100);
CREATE	INDEX IX_stellar_vel  on mangadapdb.c5_cx( stellar_vel )WITH (FILLFACTOR=100);


analyze mangadapdb.c5_cx


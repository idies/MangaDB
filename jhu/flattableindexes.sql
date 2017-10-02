
/*
indexes on columns in flattened table
plate
plateifu
name
drppipe
dappipe
nsa_pk
binid
emline_gflux_ha_6564
emline_sew_ha_6564
*/

alter table mangadapdb.flattabletest add primary key(pk);

create index flat_plate_ix on mangadapdb.flattabletest(plate);
create index flat_plateifu_ix on mangadapdb.flattabletest(plateifu);
create index flat_name_ix on mangadapdb.flattabletest(name);
create index flat_drppipe_ix on mangadapdb.flattabletest(drppipe);
create index flat_dappipe_ix on mangadapdb.flattabletest(dappipe);
create index flat_nsa_pk_ix on mangadapdb.flattabletest(nsa_pk);
create index flat_binid_ix on mangadapdb.flattabletest(binid);
create index flat_emline_gflux_ha_6564_ix on mangadapdb.flattabletest(emline_gflux_ha_6564);
create index flat_emline_sew_ha_6564_ix on mangadapdb.flattabletest(emline_sew_ha_6564);

vacuum analyze mangadapdb.flattabletest





--nsa z sersic mass

/*
c5 indexes

CREATE INDEX clean_file5_pk_idx ON cleanspaxelprop5 (file_pk);
CREATE INDEX clean_spaxel5_index_idx ON cleanspaxelprop5 (spaxel_index);
CREATE INDEX clean_binid5_pk_idx ON cleanspaxelprop5 (binid);
CREATE INDEX clean_stvel5_idx ON cleanspaxelprop5 (stellar_vel);
CREATE INDEX clean_emline5_gflux_oii_idx ON cleanspaxelprop5 (emline_gflux_oiid_3728);
CREATE INDEX clean_emline5_gflux_hb_idx ON cleanspaxelprop5 (emline_gflux_hb_4862);
CREATE INDEX clean_emline5_gflux_oiii_idx ON cleanspaxelprop5 (emline_gflux_oiii_5008);
CREATE INDEX clean_emline5_gflux_ha_idx ON cleanspaxelprop5 (emline_gflux_ha_6564);
CREATE INDEX clean_emline5_gflux_nii_idx ON cleanspaxelprop5 (emline_gflux_nii_6585);
CREATE INDEX clean_emline5_gflux_sii_idx ON cleanspaxelprop5 (emline_gflux_sii_6718);
CREATE INDEX clean_d40005_idx ON cleanspaxelprop5 (specindex_d4000);
*/


create index
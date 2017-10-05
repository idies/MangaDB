

create table mangasampledb.nsa_ssd tablespace manga_ssd as select * from mangasampledb.nsa;

alter table mangasampledb.nsa_ssd add constraint nsa_pk primary key(pk);

CREATE INDEX nsa_ssd_elpetro_mass_idx  on mangasampledb.nsa_ssd( elpetro_mass ) WITH (FILLFACTOR=100);
CREATE INDEX "nsa_ssd_sersic_mass_idx"  on mangasampledb.nsa_ssd( sersic_mass ) WITH (FILLFACTOR=100);
CREATE INDEX "nsa_ssd_z_idx"  on mangasampledb.nsa_ssd( z ) WITH (FILLFACTOR=100);

analyze mangasampledb.nsa_ssd;


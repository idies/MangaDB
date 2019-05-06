

SELECT c.plate, c.ra, c.dec, n.z
FROM mangadatadb.cube AS c
JOIN mangasampledb.manga_target AS m ON c.manga_target_pk=m.pk
JOIN mangasampledb.manga_target_to_nsa AS t ON t.manga_target_pk=m.pk
JOIN mangasampledb.nsa AS n ON n.pk=t.nsa_pk
WHERE c.ra > 180 AND n.z < 0.1;
''


explain analyze
SELECT /*+ parallel */ c.plate, c.ra, c.dec, n.z
FROM suetest.cube_mv AS c
JOIN suetest.manga_target_mv AS m ON c.manga_target_pk=m.pk
JOIN suetest.manga_target_to_nsa_mv AS t ON t.manga_target_pk=m.pk
JOIN suetest.nsa_mv AS n ON n.pk=t.nsa_pk
WHERE c.ra > 180 AND n.z < 0.1;


select schemaname, tablename, indexname, indexdef
from pg_catalog.pg_indexes
where tablename in ('cube', 'manga_target', 'nsa', 'manga_target_to_nsa')

select schemaname, tablename, indexname, indexdef
from pg_catalog.pg_indexes
where schemaname = 'suetest'


select schemaname, tablename, indexname, indexdef
from pg_catalog.pg_indexes
where tablename in ('cleanspaxelprop5', 'file')


select schemaname, tablename, indexname, indexdef
from pg_catalog.pg_indexes
where schemaname = 'suetest'
or tablename in (
	select viewname from pg_catalog.pg_views
	where schemaname = 'suetest'
) order by tablename;


select schemaname, tablename, count(indexname)
from pg_catalog.pg_indexes
where schemaname = 'suetest'
or tablename in (
	select viewname from pg_catalog.pg_views
	where schemaname = 'suetest'
) group by schemaname, tablename 
order by tablename;

select schemaname, tablename, indexname, indexdef
from pg_catalog.pg_indexes
where tablename like 'cube%'
order by tablename, indexname;

CREATE INDEX ifudesign_pk_idx2 ON suetest.cube2 USING btree (ifudesign_pk);
CREATE INDEX cube2_shape_pk_idx2 ON suetest.cube2 USING btree (cube_shape_pk);
CREATE INDEX wavelength_pk_idx1 ON suetest.cube1 USING btree (wavelength_pk);
CREATE INDEX wavelength_pk_idx2 ON suetest.cube2 USING btree (wavelength_pk);




create materialized view suetest.cube_mv 
as select * from suetest.cube1
union all 
select * from suetest.cube2



create materialized view suetest.nsa_mv
as select * from suetest.nsa1
union all
select * from suetest.nsa2


create materialized view suetest.manga_target_to_nsa_mv
as select * from suetest.manga_target_to_nsa1
union all
select * from suetest.manga_target_to_nsa2


create materialized view suetest.manga_target_mv
as select * from suetest.manga_target1
union all
select * from suetest.manga_target2




CREATE INDEX manga_target_pk_idx2 ON suetest.cube2 USING btree (manga_target_pk)
CREATE INDEX manga_target_to_nsa_targetpk_idx2 ON suetest.manga_target_to_nsa2 USING btree (manga_target_pk);
CREATE INDEX manga_target_to_nsa_nsapk_idx2 ON suetest.manga_target_to_nsa2 USING btree (nsa_pk);


CREATE UNIQUE INDEX cube1_pkey ON suetest.cube1 USING btree (pk);
CREATE INDEX wavelength_pk_idx1 ON suetest.cube1 USING btree (wavelength_pk);
CREATE INDEX cube1_shape_pk_idx1 ON suetest.cube1 USING btree (cube_shape_pk);
CREATE INDEX ifudesign_pk_idx1 ON suetest.cube1 USING btree (ifudesign_pk);
-- CREATE INDEX manga_target1_pk_idx1 ON suetest.cube1 USING btree (manga_target_pk);
CREATE INDEX pipelineinfo_pk_idx1 ON suetest.cube1 USING btree (pipeline_info_pk);
CREATE INDEX cube1_q3c_ang2ipix_idx ON suetest.cube1 USING btree (q3c_ang2ipix(ra, "dec"));



CREATE UNIQUE INDEX manga_target1_pkey ON suetest.manga_target1 USING btree (pk);
CREATE UNIQUE INDEX nsa_pkey ON suetest.nsa1 USING btree (pk);
CREATE INDEX nsa_elpetro_ba_idx ON suetest.nsa1 USING btree (elpetro_ba);
CREATE INDEX nsa_elpetro_mass_idx ON suetest.nsa1 USING btree (elpetro_mass);
CREATE INDEX nsa_elpetro_phi_idx ON suetest.nsa1 USING btree (elpetro_phi);
CREATE INDEX nsa_elpetro_th50r_idx ON suetest.nsa1 USING btree (elpetro_th50_r);
CREATE INDEX nsa_elpetro_th90r_idx ON suetest.nsa1 USING btree (elpetro_th90_r);
CREATE INDEX nsa_sersic_mass_idx ON suetest.nsa1 USING btree (sersic_mass);
CREATE INDEX nsa_sersic_n_idx ON suetest.nsa1 USING btree (sersic_n);
CREATE INDEX nsa_z_idx ON suetest.nsa1 USING btree (z);
CREATE UNIQUE INDEX manga_target_to_nsa1_pkey ON suetest.manga_target_to_nsa1 USING btree (pk);
CREATE INDEX manga_target_to_nsa_nsapk_idx1 ON suetest.manga_target_to_nsa1 USING btree (nsa_pk);
CREATE INDEX manga_target_to_nsa_targetpk_idx1 ON suetest.manga_target_to_nsa1 USING btree (manga_target_pk);

-- CREATE UNIQUE INDEX cube_pkey ON suetest.cube USING btree (pk)
CREATE INDEX wavelength_pk_idx2 ON suetest.cube2 USING btree (wavelength_pk);
CREATE INDEX cube_shape_pk_idx2 ON suetest.cube2 USING btree (cube_shape_pk);
CREATE INDEX ifudesign_pk_idx2 ON suetest.cube2 USING btree (ifudesign_pk);
-- CREATE INDEX manga_target_pk_idx2 ON suetest.cube2 USING btree (manga_target_pk);
CREATE INDEX pipelineinfo_pk_idx2 ON suetest.cube2 USING btree (pipeline_info_pk);
CREATE INDEX cube_q3c_ang2ipix_idx2 ON suetest.cube2 USING btree (q3c_ang2ipix(ra, "dec"));

CREATE UNIQUE INDEX manga_target_pkey ON suetest.manga_target USING btree (pk)

CREATE UNIQUE INDEX nsa_pkey ON suetest.nsa USING btree (pk)


CREATE INDEX nsa_elpetro_ba_idx1 ON suetest.nsa1 USING btree (elpetro_ba);
CREATE INDEX nsa_elpetro_mass_idx1 ON suetest.nsa1 USING btree (elpetro_mass);
CREATE INDEX nsa_elpetro_phi_idx1 ON suetest.nsa1 USING btree (elpetro_phi);
CREATE INDEX nsa_elpetro_th50r_idx1 ON suetest.nsa1 USING btree (elpetro_th50_r);
CREATE INDEX nsa_elpetro_th90r_idx1 ON suetest.nsa1 USING btree (elpetro_th90_r);
CREATE INDEX nsa_sersic_mass_idx1 ON suetest.nsa1 USING btree (sersic_mass);
CREATE INDEX nsa_sersic_n_idx1 ON suetest.nsa1 USING btree (sersic_n);
CREATE INDEX nsa_z_idx1 ON suetest.nsa1 USING btree (z);

CREATE INDEX nsa_elpetro_ba_idx2 ON suetest.nsa2 USING btree (elpetro_ba);
CREATE INDEX nsa_elpetro_mass_idx2 ON suetest.nsa2 USING btree (elpetro_mass);
CREATE INDEX nsa_elpetro_phi_idx2 ON suetest.nsa2 USING btree (elpetro_phi);
CREATE INDEX nsa_elpetro_th50r_idx2 ON suetest.nsa2 USING btree (elpetro_th50_r);
CREATE INDEX nsa_elpetro_th90r_idx2 ON suetest.nsa2 USING btree (elpetro_th90_r);
CREATE INDEX nsa_sersic_mass_idx2 ON suetest.nsa2 USING btree (sersic_mass);
CREATE INDEX nsa_sersic_n_idx2 ON suetest.nsa2 USING btree (sersic_n);
CREATE INDEX nsa_z_idx2 ON suetest.nsa2 USING btree (z);

CREATE UNIQUE INDEX manga_target_to_nsa_pkey ON suetest.manga_target_to_nsa USING btree (pk)
CREATE INDEX manga_target_to_nsa_nsapk_idx ON suetest.manga_target_to_nsa USING btree (nsa_pk)
CREATE INDEX manga_target_to_nsa_targetpk_idx ON suetest.manga_target_to_nsa USING btree (manga_target_pk)







CREATE INDEX cube_pk_idx1 ON suetest.file1 USING btree (cube_pk);
CREATE INDEX pipeline_info_pk_idx1 ON suetest.file1 USING btree (pipeline_info_pk);


CREATE INDEX cube_pk_idx2 ON suetest.file2 USING btree (cube_pk);
CREATE INDEX pipeline_info_pk_idx2 ON suetest.file2 USING btree (pipeline_info_pk);





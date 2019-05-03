
-- test query

SELECT c.plate, c.ra, c.dec, n.z
FROM mangadatadb.cube AS c
JOIN mangasampledb.manga_target AS m ON c.manga_target_pk=m.pk
JOIN mangasampledb.manga_target_to_nsa AS t ON t.manga_target_pk=m.pk
JOIN mangasampledb.nsa AS n ON n.pk=t.nsa_pk
WHERE c.ra > 180 AND n.z < 0.1;


SELECT c.plate, c.ra, c.dec, n.z
FROM suetest.cube AS c
JOIN suetest.manga_target AS m ON c.manga_target_pk=m.pk
JOIN suetest.manga_target_to_nsa AS t ON t.manga_target_pk=m.pk
JOIN suetest.nsa AS n ON n.pk=t.nsa_pk
WHERE c.ra > 180 AND n.z < 0.1;

alter table suetest.nsa1 add primary key (pk);
alter table suetest.nsa2 add primary key (pk);


select min(pk), max(pk)
from mangadatadb.cube
-- 100, 28600

select 28600 / 2
 -- 14300
 
 
 -- doing equiv of "range left" partitions
 -- cutpoint falls on the LEFT side of the range <=
 
 create unlogged table suetest.cube1
 as select * from mangadatadb.cube
 where pk <= 14300;
 
  create unlogged table suetest.cube2
 as select * from mangadatadb.cube
 where pk > 14300;
 
 alter table suetest.cube1 add primary key (pk);
 alter table suetest.cube2 add primary key (pk);
 
 
 -- cube, manga_target, manga_target_to_nsa, nsa
 
 select min(pk), max(pk)
 from mangasampledb.manga_target
 
 -- 1, 48056
 
 select 48056 / 2
 -- 24028
 
 create unlogged table suetest.manga_target1
 as select * from mangasampledb.manga_target
 where pk <= 24028;
 
  create unlogged table suetest.manga_target2
 as select * from mangasampledb.manga_target
 where pk > 24028;
 
 alter table suetest.manga_target1 add primary key (pk);
 alter table suetest.manga_target2 add primary key (pk);
 
 
 select min(pk), max(pk)
 from mangasampledb.manga_target_to_nsa
 
 -- 1, 41274
 select 41274/2
 -- 20637
 
  create unlogged table suetest.manga_target_to_nsa1
 as select * from mangasampledb.manga_target_to_nsa
 where pk <= 20637;
 
  create unlogged table suetest.manga_target_to_nsa2
 as select * from mangasampledb.manga_target_to_nsa
 where pk > 20637;
 
alter table suetest.manga_target_to_nsa1 add primary key (pk);
alter table suetest.manga_target_to_nsa2 add primary key (pk);


create view suetest.manga_target_to_nsa
as
select * from suetest.manga_target_to_nsa1
union all
select * from suetest.manga_target_to_nsa2;



create view suetest.manga_target
as
select * from suetest.manga_target1
union all
select * from suetest.manga_target2;


create view suetest.cube
as 
select * from suetest.cube1
union all
select * from suetest.cube2;


--q1
SELECT
  mangadatadb.cube.mangaid                                        AS "cube.mangaid",
  mangadatadb.cube.plate                                          AS "cube.plate",
  concat(mangadatadb.cube.plate, '-', mangadatadb.ifudesign.name) AS "cube.plateifu",
  mangadatadb.ifudesign.name                                      AS "ifu.name",
  mangadapdb.cleanspaxelprop5.emline_gflux_ha_6564                AS emline_gflux_ha_6564,
  mangadapdb.cleanspaxelprop5.x                                   AS "spaxelprop.x",
  mangadapdb.cleanspaxelprop5.y                                   AS "spaxelprop.y"
FROM mangadatadb.cube
  JOIN mangadatadb.ifudesign ON mangadatadb.ifudesign.pk = mangadatadb.cube.ifudesign_pk
  JOIN mangadapdb.file ON mangadatadb.cube.pk = mangadapdb.file.cube_pk
  JOIN mangadapdb.cleanspaxelprop5 ON mangadapdb.file.pk = mangadapdb.cleanspaxelprop5.file_pk
  JOIN mangadatadb.pipeline_info AS drpalias ON drpalias.pk = mangadatadb.cube.pipeline_info_pk
  JOIN mangadatadb.pipeline_info AS dapalias ON dapalias.pk = mangadapdb.file.pipeline_info_pk
WHERE mangadapdb.cleanspaxelprop5.emline_gflux_ha_6564 > 25.0 AND drpalias.pk = 21 AND dapalias.pk = 23;



-- ifudesign (just use mangadatadb)
-- cleanspaxelprop5
-- file 
-- pipeline_info (use mangadatadb)


SELECT min(pk), max(pk) FROM mangadatadb.ifudesign


select * from mangadatadb.ifudesign
select count(*) from mangadatadb.ifudesign

select count(*) from mangadapdb.file

select (max(pk) - min(pk)) / 2
from mangadapdb.file
--59841

create table suetest.file1
as select * from mangadapdb.file
where pk <= 59841

create table suetest.file2
as select * from mangadapdb.file
where pk > 59841

alter table suetest.file1 add primary key(pk);
alter table suetest.file2 add primary key(pk);

create view suetest.file 
as select * from suetest.file1
union all
select * from suetest.file2;


select count(*) from mangadapdb.cleanspaxelprop5


select count(*)from mangadatadb.pipeline_info;

select (max(pk) - min(pk)) / 2
from mangadapdb.cleanspaxelprop5

select reltuples as approximate_row_count from pg_class where relname = 'cleanspaxelprop5';
-- 15 344 372
select * from mangadapdb.cleanspaxelprop5 limit 10;

select min(pk), max(pk)
from mangadapdb.cleanspaxelprop5
-- 39 153 208, 76 722 993

select 76722993-39153208
-- 37 569 785

select 37569786 / 2
-- 18784893

select 39153208 + 18784893
-- midpoint = 57938101

create unlogged table suetest.cleanspaxelprop5_1
as select * from mangadapdb.cleanspaxelprop5
where pk <= 57938101;

create unlogged table suetest.cleanspaxelprop5_2
as select * from mangadapdb.cleanspaxelprop5
where pk > 57938101;

alter table suetest.cleanspaxelprop5_1 add primary key (pk);


alter table suetest.cleanspaxelprop5_2 add primary key (pk);



create view suetest.cleanspaxelprop5 
as select * from suetest.cleanspaxelprop5_1
union all
select * from suetest.cleanspaxelprop5_2


create view suetest.file
as select * from suetest.file1
union all
select * from suetest.file2

CREATE INDEX clean_binid5_pk_idx ON suetest.cleanspaxelprop5_1 USING btree (binid);
CREATE INDEX clean_emline5_gflux_hb_idx ON suetest.cleanspaxelprop5_1 USING btree (emline_gflux_hb_4862);
CREATE INDEX clean_emline5_gflux_ivar_ha_idx ON suetest.cleanspaxelprop5_1 USING btree (emline_gflux_ivar_ha_6564);
CREATE INDEX clean_emline5_gflux_ivar_oi_idx ON suetest.cleanspaxelprop5_1 USING btree (emline_gflux_ivar_oi_6302);
CREATE INDEX clean_emline5_gflux_ivar_oiii_idx ON suetest.cleanspaxelprop5_1 USING btree (emline_gflux_ivar_oiii_5008);
CREATE INDEX clean_emline5_gflux_oi_idx ON suetest.cleanspaxelprop5_1 USING btree (emline_gflux_oi_6302);
CREATE INDEX clean_emline5_gflux_oii_idx ON suetest.cleanspaxelprop5_1 USING btree (emline_gflux_oiid_3728);
CREATE INDEX clean_emline5_gflux_sii_idx ON suetest.cleanspaxelprop5_1 USING btree (emline_gflux_sii_6718);
CREATE INDEX clean_emline5_gflux_siia_idx ON suetest.cleanspaxelprop5_1 USING btree (emline_gflux_sii_6732);
CREATE INDEX clean_spaxel5_index_idx ON suetest.cleanspaxelprop5_1 USING btree (spaxel_index);
CREATE INDEX clean_emline5_gflux_ivar_oiid_idx ON suetest.cleanspaxelprop5_1 USING btree (emline_gflux_ivar_oiid_3728);
CREATE INDEX clean_emline5_gflux_oiii_idx ON suetest.cleanspaxelprop5_1 USING btree (emline_gflux_oiii_5008);
CREATE INDEX clean_emline5_gflux_ivar_siia_idx ON suetest.cleanspaxelprop5_1 USING btree (emline_gflux_ivar_sii_6732);
CREATE INDEX clean_emline5_gflux_ha_idx ON suetest.cleanspaxelprop5_1 USING btree (emline_gflux_ha_6564);
CREATE INDEX clean_emline5_gflux_ivar_nii_idx ON suetest.cleanspaxelprop5_1 USING btree (emline_gflux_ivar_nii_6585);
CREATE INDEX clean_emline5_gflux_nii_idx ON suetest.cleanspaxelprop5_1 USING btree (emline_gflux_nii_6585);
CREATE INDEX clean_stvel5_idx ON suetest.cleanspaxelprop5_1 USING btree (stellar_vel);
CREATE INDEX clean_file5_pk_idx ON suetest.cleanspaxelprop5_1 USING btree (file_pk);
CREATE INDEX clean_d40005_idx ON suetest.cleanspaxelprop5_1 USING btree (specindex_d4000);
CREATE INDEX clean_emline5_gflux_ivar_hb_idx ON suetest.cleanspaxelprop5_1 USING btree (emline_gflux_ivar_hb_4862);
CREATE INDEX clean_emline5_gflux_ivar_sii_idx ON suetest.cleanspaxelprop5_1 USING btree (emline_gflux_ivar_sii_6718);
 


CREATE INDEX c2_clean_binid5_pk_idx ON suetest.cleanspaxelprop5_2 USING btree (binid);
CREATE INDEX c2_clean_emline5_gflux_hb_idx ON suetest.cleanspaxelprop5_2 USING btree (emline_gflux_hb_4862);
CREATE INDEX c2_clean_emline5_gflux_ivar_ha_idx ON suetest.cleanspaxelprop5_2 USING btree (emline_gflux_ivar_ha_6564);
CREATE INDEX c2_clean_emline5_gflux_ivar_oi_idx ON suetest.cleanspaxelprop5_2 USING btree (emline_gflux_ivar_oi_6302);
CREATE INDEX c2_clean_emline5_gflux_ivar_oiii_idx ON suetest.cleanspaxelprop5_2 USING btree (emline_gflux_ivar_oiii_5008);
CREATE INDEX c2_clean_emline5_gflux_oi_idx ON suetest.cleanspaxelprop5_2 USING btree (emline_gflux_oi_6302);
CREATE INDEX c2_clean_emline5_gflux_oii_idx ON suetest.cleanspaxelprop5_2 USING btree (emline_gflux_oiid_3728);
CREATE INDEX c2_clean_emline5_gflux_sii_idx ON suetest.cleanspaxelprop5_2 USING btree (emline_gflux_sii_6718);
CREATE INDEX c2_clean_emline5_gflux_siia_idx ON suetest.cleanspaxelprop5_2 USING btree (emline_gflux_sii_6732);
CREATE INDEX c2_clean_spaxel5_index_idx ON suetest.cleanspaxelprop5_2 USING btree (spaxel_index);
CREATE INDEX c2_clean_emline5_gflux_ivar_oiid_idx ON suetest.cleanspaxelprop5_2 USING btree (emline_gflux_ivar_oiid_3728);
CREATE INDEX c2_clean_emline5_gflux_oiii_idx ON suetest.cleanspaxelprop5_2 USING btree (emline_gflux_oiii_5008);
CREATE INDEX c2_clean_emline5_gflux_ivar_siia_idx ON suetest.cleanspaxelprop5_2 USING btree (emline_gflux_ivar_sii_6732);
CREATE INDEX c2_clean_emline5_gflux_ha_idx ON suetest.cleanspaxelprop5_2 USING btree (emline_gflux_ha_6564);
CREATE INDEX c2_clean_emline5_gflux_ivar_nii_idx ON suetest.cleanspaxelprop5_2 USING btree (emline_gflux_ivar_nii_6585);
CREATE INDEX c2_clean_emline5_gflux_nii_idx ON suetest.cleanspaxelprop5_2 USING btree (emline_gflux_nii_6585);
CREATE INDEX c2_clean_stvel5_idx ON suetest.cleanspaxelprop5_2 USING btree (stellar_vel);
CREATE INDEX c2_clean_file5_pk_idx ON suetest.cleanspaxelprop5_2 USING btree (file_pk);
CREATE INDEX c2_clean_d40005_idx ON suetest.cleanspaxelprop5_2 USING btree (specindex_d4000);
CREATE INDEX c2_clean_emline5_gflux_ivar_hb_idx ON suetest.cleanspaxelprop5_2 USING btree (emline_gflux_ivar_hb_4862);
CREATE INDEX c2_clean_emline5_gflux_ivar_sii_idx ON suetest.cleanspaxelprop5_2 USING btree (emline_gflux_ivar_sii_6718);
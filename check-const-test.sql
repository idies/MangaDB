-- put check constraints on c5_1 and c5_2 file_pk
-- also file1 and file2

select min(file_pk), max(file_pk) from suetest.cleanspaxelprop5_1;
select min(file_pk), max(file_pk) from suetest.cleanspaxelprop5_2; -- 37486	51454


select pk, file_pk, spaxel_index, binid_pk 
from suetest.cleanspaxelprop5 limit 20;



select file_pk, count(file_pk)
from suetest.cleanspaxelprop5
group by file_pk;

select min(pk), max(pk) from suetest.file

select reltuples from pg_class where relname='file'


select * from suetest.file order by pk desc;


select count(pk) from suetest.file
where pk > 59841; -- 35527

select count(pk) from suetest.file
where pk < 59841; -- 53524


alter table suetest.file1 add constraint ck_file1 check  (pk <= 59841);
alter table suetest.file2 add constraint ck_file2 check (pk > 59841);



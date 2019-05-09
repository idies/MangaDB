-- add check constraints to all unions

select min(c1.pk), max(c1.pk), min(c2.pk), max(c2.pk)
from suetest.cube1 c1, suetest.cube2 c2
-- 100	14300	14301	28600

alter table suetest.cube1 add constraint ck_cube1 check (pk between 100 and 14300);
alter table suetest.cube2 add constraint ck_cube2 check (pk between 14301 and 28600);

select min(c1.pk), max(c1.pk), min(c2.pk), max(c2.pk)
from suetest.nsa1 c1, suetest.nsa2 c2
-- 1	20630	20631	41260

alter table suetest.nsa1 add constraint ck_nsa1 check (pk between 1 and 20630);
alter table suetest.nsa2 add constraint ck_nsa2 check (pk between 20631 and 41260);


select min(c1.pk), max(c1.pk), min(c2.pk), max(c2.pk)
from suetest.manga_target1 c1, suetest.manga_target2 c2
-- 1	24028	24029	48056

alter table suetest.manga_target1 add constraint ck_mt1 check (pk between 1 and 24028);
alter table suetest.manga_target2 add constraint ck_mt2 check (pk between 24029 and 48056);

select min(c1.pk), max(c1.pk), min(c2.pk), max(c2.pk)
from suetest.manga_target_to_nsa1 c1, suetest.manga_target_to_nsa2 c2
-- 1	20637	20638	41274

alter table suetest.manga_target_to_nsa1 add constraint ck_mtn1 check (pk between 1 and 20637);
alter table suetest.manga_target_to_nsa2 add constraint ck_mtn2 check (pk between 20638 and 41274);


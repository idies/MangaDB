SELECT
  cp5.*,
  --cube.plate, cube.mangaid,
  -- ifd.name,
  -- concat(cube.plate,'-',ifd.name) as plateifu,
  -- cube.pipeline_info_pk as drppipe,
  --cube.pipeline_info_pk as dapplpe,
  nsa.pk AS nsa_pk
FROM mangadapdb.cleanspaxelprop5 AS cp5
  JOIN mangasampledb.nsa AS nsa
    ON cp5.spaxel_index = nsa.pk
  JOIN
  mangasampledb.manga_target_to_nsa AS m2nsa
    ON m2nsa.nsa_pk = nsa.pk
  JOIN mangasampledb.manga_target mt
    ON mt.pk = m2nsa.manga_target_pk
  JOIN mangadatadb.cube cube
    ON cube.mangaid = mt.mangaid
  JOIN mangadatadb.ifudesign AS ifd
    ON ifd.pk = cube.ifudesign_pk
LIMIT 20;


SELECT
  cp5.pk,
  cp5.file_pk,
  cp5.spaxel_index,
  n.pk,
  n.iauname
FROM mangadapdb.cleanspaxelprop5 cp5
  JOIN mangasampledb.nsa n
    ON cp5.spaxel_index = n.pk
LIMIT 10

SELECT pk,
FROM mangasampledb.nsa
LIMIT 10

SELECT
  nsa.pk,
  cube.mangaid,
  ifd.pk
--, c5.pk, c5.file_pk
FROM mangasampledb.manga_target_to_nsa m2nsa
  JOIN mangasampledb.nsa nsa
    ON m2nsa.nsa_pk = nsa.pk
  --join mangadapdb.cleanspaxelprop5 c5
  -- on c5.spaxel_index = nsa.pk
  JOIN mangasampledb.manga_target mt
    ON m2nsa.manga_target_pk = mt.pk
  JOIN mangadatadb.cube cube
    ON mt.mangaid = cube.mangaid
  JOIN mangadatadb.ifudesign AS ifd
    ON ifd.pk = cube.ifudesign_pk


SELECT *
FROM mangadatadb.cube
WHERE mangaid IN (
  SELECT
    --c5.pk, c5.spaxel_index, nsa.pk,
    mt.mangaid
  --, cube.mangaid, ifd.pk
  FROM mangadapdb.cleanspaxelprop5 c5
    JOIN mangasampledb.nsa nsa
      ON nsa.pk = c5.spaxel_index
    JOIN mangasampledb.manga_target_to_nsa m2nsa
      ON m2nsa.nsa_pk = nsa.pk
    JOIN mangasampledb.manga_target mt
      ON m2nsa.manga_target_pk = mt.pk
  ---good until here
  -- join mangadatadb.cube cube
  -- on mt.mangaid=cube.mangaid
)

SELECT *
FROM mangadatadb.cube
WHERE mangaid = '1-2474'


SELECT
  c.mangaid,
  mt.mangaid
FROM mangadatadb.cube c
  JOIN mangasampledb.manga_target mt
    ON c.mangaid = mt.mangaid


SELECT
  min(spaxel_index),
  max(spaxel_index)
FROM mangadapdb.cleanspaxelprop5
--112, 5512

SELECT
  min(pk),
  max(pk)
FROM mangasampledb.nsa

SELECT
  min(nsa_pk),
  max(nsa_pk)


SELECT count(nsa_pk)
FROM mangasampledb.manga_target_to_nsa

SELECT *
FROM mangasampledb.nsa
WHERE pk BETWEEN 112 AND 5512

------------------------------------------------------------------------------------
-- GOOD QUERY
------------------------------------------------------------------------------------
SELECT

  c.pipeline_info_pk           AS drppipe,
  f.pipeline_info_pk           AS dappipe,
  c.plate,
  c.mangaid,
  i.name,
  concat(c.plate, '-', i.name) AS plateifu,
  n.pk                         AS nsa_pk,
  c5.*

INTO mangadapdb.flattabletest
FROM mangadatadb.cube AS c LEFT OUTER JOIN mangasampledb.manga_target AS m ON m.pk = c.manga_target_pk
  RIGHT OUTER JOIN mangasampledb.manga_target_to_nsa AS mt ON mt.manga_target_pk = m.pk
  RIGHT OUTER JOIN mangasampledb.nsa AS n ON n.pk = mt.nsa_pk
  LEFT OUTER JOIN mangadatadb.ifudesign AS i ON i.pk = c.ifudesign_pk
  LEFT OUTER JOIN mangadapdb.file AS f ON f.cube_pk = c.pk
  RIGHT OUTER JOIN mangadapdb.cleanspaxelprop5 AS c5 ON c5.file_pk = f.pk;

--truncate table mangadapdb.flattabletest;
drop table mangadapdb.flattabletest;


select distinct binid from mangadapdb.flattabletest;


select count(mt.nsa_pk), count(n.pk)
from mangasampledb.manga_target_to_nsa as mt
right outer join mangasampledb.nsa as n
  on mt.nsa_pk = n.pk;


select count(pk) from mangasampledb.nsa;
--641409

select count(nsa_pk)
from mangasampledb.manga_target_to_nsa;
--42467





SELECT
  cp5.*,
  --cube.plate, cube.mangaid,
  -- ifd.name,
  -- concat(cube.plate,'-',ifd.name) as plateifu,
  -- cube.pipeline_info_pk as drppipe,
  --cube.pipeline_info_pk as dapplpe,
  nsa.pk AS nsa_pk
FROM mangadapdb.cleanspaxelprop5 AS cp5
  JOIN mangasampledb.nsa AS nsa
    ON cp5.spaxel_index = nsa.pk
  JOIN
  mangasampledb.manga_target_to_nsa AS m2nsa
    ON m2nsa.nsa_pk = nsa.pk
  JOIN mangasampledb.manga_target mt
    ON mt.pk = m2nsa.manga_target_pk
  JOIN mangadatadb.cube cube
    ON cube.mangaid = mt.mangaid
  JOIN mangadatadb.ifudesign AS ifd
    ON ifd.pk = cube.ifudesign_pk
LIMIT 20;


select count(*) from mangadapdb.cleanspaxelprop5 where binid <> -1

--c5
--15,344,405

select count(*) from mangadapdb.flattabletest;
select count(*) from mangadapdb.cleanspaxelprop5;
--14,960,777


vacuum analyze mangadapdb.flattabletest





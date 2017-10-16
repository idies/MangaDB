select
	c.pipeline_info_pk as drppipe,
	f.pipeline_info_pk as dappipe,
	c.plate,
	c.mangaid,
	i.name,
	concat( c.plate, '-', i.name ) as plateifu,
	n.pk as nsa_pk,
	c5.* into
		mangadapdb.flattabletest
	from
		mangadatadb.cube as c left outer join mangasampledb.manga_target as m on
		m.pk = c.manga_target_pk join mangasampledb.manga_target_to_nsa as mt on
		mt.manga_target_pk = m.pk join mangasampledb.nsa as n on
		n.pk = mt.nsa_pk join mangadatadb.ifudesign as i on
		i.pk = c.ifudesign_pk join mangadapdb.file as f on
		f.cube_pk = c.pk join mangadapdb.c5_ssd as c5 on
		c5.file_pk = f.pk;
		
select count(*) from mangadapdb.flattabletest
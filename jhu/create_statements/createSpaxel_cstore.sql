drop foreign table if exists mangadatadb.spaxel_cstore;

CREATE foreign TABLE mangadatadb.spaxel_cstore (
	pk INTEGER NOT NULL,
	flux double precision[] NULL,
	ivar real[] NULL,
	mask integer[] NULL,
	cube_pk INTEGER NULL DEFAULT NULL,
	x INTEGER NULL DEFAULT NULL,
	y INTEGER NULL DEFAULT NULL
)
server cstore_server
     options(filename '/xfs/postgres_db/cstore/spaxel_cstore.cstore', compression 'pglz');
     
insert into mangadatadb.spaxel_cstore 
select * from mangadatadb.spaxel;

analyze mangadatadb.spaxel_cstore;

     

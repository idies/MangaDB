
from mypkg.database import db
import mypkg.DapModelClasses as dapdb
import mypkg.DataModelClasses as datadb
import mypkg.SampleModelClasses as sampledb
from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship, backref, aliased

import mypkg.DBHelper as sue



from sqlalchemy.orm import aliased
from sqlalchemy import func



import datetime

session = db.Session()

drpalias = aliased(datadb.PipelineInfo, name='drpalias')
dapalias = aliased(datadb.PipelineInfo, name='dapalias')


# Query 1
q1 = session.query(datadb.Cube.mangaid, datadb.Cube.plate, datadb.Cube.plateifu, datadb.IFUDesign.name, dapdb.CleanSpaxelProp5.emline_gflux_ha_6564,
dapdb.CleanSpaxelProp5.x, dapdb.CleanSpaxelProp5.y).join(datadb.IFUDesign,dapdb.File,dapdb.CleanSpaxelProp5).\
filter(dapdb.CleanSpaxelProp5.emline_gflux_ha_6564 > 25).join(drpalias, datadb.Cube.pipelineInfo).\
join(dapalias, dapdb.File.pipelineinfo).filter(drpalias.pk==25).filter(dapalias.pk==26)

start=datetime.datetime.now(); r1 = q1.all(); end=datetime.datetime.now(); td=end-start
print('r1 time', td.total_seconds())
%timeit r1=q1.all()
print('r1 count', len(r1))

# Query 2
# setup first part of query
q2 = session.query(datadb.Cube.mangaid, datadb.Cube.plate, datadb.Cube.plateifu, datadb.IFUDesign.name, dapdb.CleanSpaxelProp5.emline_gflux_ha_6564,
dapdb.CleanSpaxelProp5.x, dapdb.CleanSpaxelProp5.y).join(datadb.IFUDesign,dapdb.File,dapdb.CleanSpaxelProp5).join(drpalias, datadb.Cube.pipelineInfo).\
join(dapalias, dapdb.File.pipelineinfo).filter(drpalias.pk==25).filter(dapalias.pk==26)

# subquery 1 - to count the number of good spaxels
bincount = session.query(dapdb.CleanSpaxelProp5.file_pk.label('binfile'),func.count(dapdb.CleanSpaxelProp5.pk).label('goodcount')).\
filter(dapdb.CleanSpaxelProp5.binid != -1).group_by(dapdb.CleanSpaxelProp5.file_pk).subquery('bingood', with_labels=True)

# subquery 2 - to count the number of spaxels with haflux > 5
valcount = session.query(dapdb.CleanSpaxelProp5.file_pk.label('valfile'),(func.count(dapdb.CleanSpaxelProp5.pk)).label('valcount')).\
filter(dapdb.CleanSpaxelProp.emline_gflux_ha_6564 > 5).group_by(dapdb.CleanSpaxelProp5.file_pk).subquery('goodhacount', with_labels=True)

# main query - to find those galaxies with haflux > 5 in more than 20% of their spaxels
q2 = q2.join(bincount, bincount.c.binfile == dapdb.CleanSpaxelProp5.file_pk).\
join(valcount, valcount.c.valfile == dapdb.CleanSpaxelProp5.file_pk).filter(valcount.c.valcount >= 0.2*bincount.c.goodcount)

# interested in only galaxies so we group the query by galaxy properties
q2 = q2.from_self(datadb.Cube.mangaid, datadb.Cube.plate, datadb.Cube.plateifu, datadb.IFUDesign.name).\
group_by(datadb.Cube.mangaid,datadb.Cube.plate,datadb.Cube.plateifu,datadb.IFUDesign.name)

start=datetime.datetime.now(); r2 = q2.all(); end=datetime.datetime.now(); td=end-start
print('r2 time', td.total_seconds())
%timeit r2=q2.all()
print('r2 count', len(r1))


# Query 3
q3 = session.query(datadb.Cube.mangaid, datadb.Cube.plate, datadb.Cube.plateifu, datadb.IFUDesign.name, dapdb.CleanSpaxelProp5.emline_sew_ha_6564,
sampledb.NSA.sersic_n, sampledb.NSA.sersic_logmass).join(datadb.IFUDesign,dapdb.File,dapdb.CleanSpaxelProp5,sampledb.MangaTarget,
sampledb.MangaTargetToNSA,sampledb.NSA).filter(dapdb.CleanSpaxelProp5.emline_sew_ha_6564 > 6,sampledb.NSA.sersic_n < 2,
sampledb.NSA.sersic_logmass >= 9.5,sampledb.NSA.sersic_logmass < 11).join(drpalias, datadb.Cube.pipelineInfo).\
join(dapalias, dapdb.File.pipelineinfo).filter(drpalias.pk==25).filter(dapalias.pk==26)

start=datetime.datetime.now(); r3 = q3.all(); end=datetime.datetime.now(); td=end-start
print('r3 time', td.total_seconds())
%timeit r3=q3.all()
print('r3 count', len(r3))


# Query 4
q4 = session.query(datadb.Cube.mangaid, datadb.Cube.plate, datadb.Cube.plateifu, datadb.IFUDesign.name,
dapdb.CleanSpaxelProp5.emline_gflux_ha_6564, dapdb.CleanSpaxelProp5.x, dapdb.CleanSpaxelProp5.y, sampledb.NSA.z).\
join(datadb.IFUDesign,dapdb.File,dapdb.CleanSpaxelProp5,sampledb.MangaTarget,sampledb.MangaTargetToNSA,sampledb.NSA).\
filter(dapdb.CleanSpaxelProp5.emline_gflux_ha_6564 > 25,sampledb.NSA.z < 0.1).join(drpalias, datadb.Cube.pipelineInfo).\
join(dapalias, dapdb.File.pipelineinfo).filter(drpalias.pk==25).filter(dapalias.pk==26)

start=datetime.datetime.now(); r4 = q4.all(); end=datetime.datetime.now(); td=end-start
print('r4 time', td.total_seconds())
%timeit r4=q4.all()
print('r4 count', len(r4))
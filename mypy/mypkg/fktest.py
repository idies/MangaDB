from mypkg.database import db
import mypkg.DapModelClasses as dapdb
import mypkg.DataModelClasses as datadb
import mypkg.SampleModelClasses as sampledb
from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship, backref, aliased

import datetime

from mypkg.DBHelper import C5Cstore

session = db.Session()

c = dapdb.CleanSpaxelProp5

drpalias = aliased(datadb.PipelineInfo, name='drpalias')
dapalias = aliased(datadb.PipelineInfo, name='dapalias')

q1 = session.query(datadb.Cube.mangaid, datadb.Cube.plate, datadb.Cube.plateifu, datadb.
                   IFUDesign.name, c.emline_gflux_ha_6564, c.x, c.y)

q1 = q1.join(datadb.IFUDesign, dapdb.File, c).filter(c.emline_gflux_ha_6564 > 25).join(drpalias, datadb.Cube.pipelineInfo).join(dapalias, dapdb.File.pipelineinfo).filter(drpalias.pk == 25).filter(dapalias.pk == 26)

start = datetime.datetime.now();
r1 = q1.all();
end = datetime.datetime.now();
td = end - start;

td.total_seconds()

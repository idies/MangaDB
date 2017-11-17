
from mypkg.database import db
import mypkg.DapModelClasses as dapdb
import mypkg.DataModelClasses as datadb
import mypkg.SampleModelClasses as sampledb
import mypkg.DBHelper as suedb
import psycopg2;
import os;
import time;





from sqlalchemy.orm import aliased
from sqlalchemy import func
import datetime

class DBTester(object):
    c5templates = {
        'q1': 'q1-c5.sql',
        'q2': 'q2-c5.sql',
        'q3': 'q3-c5.sql',
        'q4': 'q4-c5.sql'
    }

    flattemplates = {
        'q1': 'q1-flat.sql',
        'q2': 'q2-flat.sql',
        'q3': 'q3-flat.sql',
        'q4': 'q4-flat.sql'

    }

    c5tables = 'cleanspaxelprop5',  'c5_ssd','c5_cx','c5_cx_ssd', 'c5_cstore', 'c5_cstore_ssd'
    c5source = 'C5TABLE'

    flatsource = 'FLAT'
    flattables = 'flattabletest', 'flat_ssd', 'flat_cstore', 'flat_cstore_ssd'

    conn_string = "host='dsp064' dbname='manga' user='manga' password='20manga17'"

    logname = 'suelog'



    def getCursor(self):
        conn = psycopg2.connect(self.conn_string)
        self.cursor =  conn.cursor()
        return self.cursor;

    def setLogName(self, lname):
        self.logname = lname;

    def getLogName(self):
        return self.logname;

    def generate_query(self, query, templatefile, code, table):
        lines = []
        with open(os.path.join('templates', templatefile)) as tfile:
            for line in tfile:
                line = line.replace(code, table)
                lines.append(line)
        return ''.join(lines)

    def runcmd(self, cmd, cursor):
        start = datetime.datetime.now();
        cursor.execute(str(cmd))
        end = datetime.datetime.now();
        td = end - start;
        records = cursor.fetchall();
        return td.total_seconds(), len(records)

def doAllTests(nRuns):

        doC5Tests(nRuns)
        doFlatTests(nRuns)
        doC5_db(nRuns)
        doFlat_db(nRuns)

def doFlatTests(nRuns):
    session = db.Session();


    flats = [suedb.FlatTableTest, suedb.FlatTableSSD, suedb.FlatTableCstore, suedb.FlatTableCstoreSSD]

    for Flattable in flats:
        doQuery(generateQ1Flat(Flattable, session),'q1',Flattable.__tablename__, nRuns);
        doQuery(generateQ2Flat(Flattable, session), 'q2', Flattable.__tablename__, nRuns);
        doQuery(generateQ3Flat(Flattable, session), 'q3', Flattable.__tablename__, nRuns);
        doQuery(generateQ4Flat(Flattable, session), 'q4', Flattable.__tablename__, nRuns);


def doC5Tests(nRuns):

    session = db.Session();
    c5s = [dapdb.CleanSpaxelProp5, suedb.C5SSD, suedb.C5cx, suedb.C5cxSSD, suedb.C5Cstore, suedb.C5CstoreSSD]

    for C5Table in c5s:
        doQuery(generateQ1(C5Table, session),'q1',C5Table.__tablename__, nRuns);
        doQuery(generateQ2(C5Table, session), 'q2', C5Table.__tablename__, nRuns);
        doQuery(generateQ3(C5Table, session), 'q3', C5Table.__tablename__, nRuns);
        doQuery(generateQ4(C5Table, session), 'q4', C5Table.__tablename__, nRuns);


def doC5_db(nRuns):

    d = DBTester();
    templates = d.c5templates;
    tables = d.c5tables;
    source = d.c5source;

    doDBTests(tables, templates, source, nRuns, d)

    return

def doFlat_db(nRuns):
    d = DBTester();
    templates = d.flattemplates
    tables = d.flattables
    source = d.flatsource

    doDBTests(tables, templates, source, nRuns, d)
    return

def outputResults(results):

    #print
    print('\t'.join(map(str, results)))

    #file
    import time
    #moment = time.strftime("%Y-%b-%d__%H_%M_%S", time.localtime())
    moment = time.strftime("%Y-%b-%d_%H", time.localtime())
    f = open('noCACHE' + moment + '.log', 'a')

    f.write(','.join(map(str, results)))
    f.write('\n')



def doDBTests(tables, templates, source, nRuns, db):
    now = time.time()
    snow = time.strftime("%b_%d_%Y_%H:%M:%S", time.gmtime())
    cursor = db.getCursor()

    for query in sorted(templates):
        for table in tables:
            cmd = db.generate_query(query, templates[query], source, table);
            count = 1
            while count <= nRuns:
                etime, nrec = db.runcmd(cmd, cursor)

                #print results
                results = (snow, query, table, count, etime, nrec)
                outputResults(results)
                count += 1


def doQuery(q, qname, tablename, nRuns):
    snow = time.strftime("%b_%d_%Y_%H:%M:%S", time.gmtime())
    count = 1
    while count <= nRuns:
        start = datetime.datetime.now();
        r1 = q.all();
        end = datetime.datetime.now();
        td = end - start
        #print('r1 time', td.total_seconds())
        #results = (qname, tablename, count, td.total_seconds(), len(r1))
        results = (snow, qname, tablename, td.total_seconds(), len(r1))
        outputResults(results)
        #print('\t'.join(map(str, results)))
        count = count + 1

def doMarvinTests(nRuns):
    from marvin.tools import Query

    p1 = 'emline_gflux_ha_6564 > 25'
    p2 = 'npergood(spaxelprop.emline_gflux_ha_6564 > 5) >= 20'
    p3 ='nsa.sersic_logmass >= 9.5 and nsa.sersic_logmass < 11 and nsa.sersic_n < 2 and emline_sew_ha_6564 > 6'
    p4 ='nsa.z < 0.1 and haflux > 25'

    mq = (p1, p2, p3, p4)

    for p in sorted(mq):
        count = 1
        while count <= nRuns:
            start = datetime.datetime.now();
            q = Query(searchfilter=p)
            r = q.run()
            end = datetime.datetime.now();
            td = end - start
            results = (p, count, td.total_seconds(), r.query_runtime.total_seconds, len(r.results))
            print('\t'.join(map(str, results)))
            count = count + 1

# Query 1
def generateQ1(C5Table, session):

    C5=C5Table

    drpalias = aliased(datadb.PipelineInfo, name='drpalias')
    dapalias = aliased(datadb.PipelineInfo, name='dapalias')

    q1_ = session.query(datadb.Cube.mangaid, datadb.Cube.plate, datadb.Cube.plateifu, datadb.IFUDesign.name,
                       C5.emline_gflux_ha_6564,
                       C5.x, C5.y).join(datadb.IFUDesign, dapdb.File, C5). \
        filter(C5.emline_gflux_ha_6564 > 25).join(drpalias, datadb.Cube.pipelineInfo). \
        join(dapalias, dapdb.File.pipelineinfo).filter(drpalias.pk == 25).filter(dapalias.pk == 26)
    return q1_


def generateQ1Flat(table, session):
    f = table
    q1 = session.query(f.mangaid, f.plate, f.plateifu, f.name, f.emline_gflux_ha_6564, f.x, f.y).filter(f.drppipe == 25,
                                                                                                        f.dappipe == 26,
                                                                                                        f.emline_gflux_ha_6564 > 25.0)
    return q1


    # Query 2
def generateQ2(C5Table, session):
    
    drpalias = aliased(datadb.PipelineInfo, name='drpalias')
    dapalias = aliased(datadb.PipelineInfo, name='dapalias')
    
    C5 = C5Table
    q2 = session.query(datadb.Cube.mangaid, datadb.Cube.plate, datadb.Cube.plateifu, datadb.IFUDesign.name,
                       C5.emline_gflux_ha_6564,
                       C5.x, C5.y).join(datadb.IFUDesign, dapdb.File,
                                        C5).join(drpalias,
                                                 datadb.Cube.pipelineInfo). \
        join(dapalias, dapdb.File.pipelineinfo).filter(drpalias.pk == 25).filter(dapalias.pk == 26)

    # subquery 1 - to count the number of good spaxels
    bincount = session.query(C5.file_pk.label('binfile'),
                             func.count(C5.pk).label('goodcount')). \
        filter(C5.binid != -1).group_by(C5.file_pk).subquery('bingood',
                                                             with_labels=True)

    # subquery 2 - to count the number of spaxels with haflux > 5
    valcount = session.query(C5.file_pk.label('valfile'),
                             (func.count(C5.pk)).label('valcount')). \
        filter(C5.emline_gflux_ha_6564 > 5).group_by(C5.file_pk).subquery(
        'goodhacount', with_labels=True)

    # main query - to find those galaxies with haflux > 5 in more than 20% of their spaxels
    q2 = q2.join(bincount, bincount.c.binfile == C5.file_pk). \
        join(valcount, valcount.c.valfile == C5.file_pk).filter(
        valcount.c.valcount >= 0.2 * bincount.c.goodcount)

    # interested in only galaxies so we group the query by galaxy properties
    q2 = q2.from_self(datadb.Cube.mangaid, datadb.Cube.plate, datadb.Cube.plateifu, datadb.IFUDesign.name). \
        group_by(datadb.Cube.mangaid, datadb.Cube.plate, datadb.Cube.plateifu, datadb.IFUDesign.name)

    return q2

def generateQ2Flat(table, session):
    f = table

    q2 = session.query(f.mangaid, f.plate, f.plateifu, f.name, f.emline_gflux_ha_6564, f.x, f.y).filter(f.drppipe == 25,
                                                                                                        f.dappipe == 26)
    bincount = session.query(f.file_pk.label('binfile'), func.count(f.pk).label('goodcount')).filter(
        f.binid != -1).group_by(f.file_pk).subquery('bingood', with_labels=True)
    valcount = session.query(f.file_pk.label('valfile'), func.count(f.pk).label('valcount')).filter(
        f.emline_gflux_ha_6564 > 5).group_by(f.file_pk).subquery('goodhacount', with_labels=True)
    q2 = q2.join(bincount, bincount.c.binfile == f.file_pk).join(valcount, valcount.c.valfile == f.file_pk).filter(
        valcount.c.valcount >= 0.2 * bincount.c.goodcount)
    q2 = q2.from_self(f.mangaid, f.plate, f.plateifu, f.name).group_by(f.mangaid, f.plate, f.plateifu, f.name)

    return q2


def generateQ3(C5Table, session):

    drpalias = aliased(datadb.PipelineInfo, name='drpalias')
    dapalias = aliased(datadb.PipelineInfo, name='dapalias')

    C5 = C5Table

    q3 = session.query(datadb.Cube.mangaid, datadb.Cube.plate, datadb.Cube.plateifu, datadb.IFUDesign.name,
                       C5.emline_sew_ha_6564,
                       sampledb.NSA.sersic_n, sampledb.NSA.sersic_logmass).join(datadb.IFUDesign, dapdb.File, C5,
                                                                                sampledb.MangaTarget,
                                                                                sampledb.MangaTargetToNSA,
                                                                                sampledb.NSA).filter(
        C5.emline_sew_ha_6564 > 6, sampledb.NSA.sersic_n < 2,
        sampledb.NSA.sersic_logmass >= 9.5, sampledb.NSA.sersic_logmass < 11).join(drpalias, datadb.Cube.pipelineInfo). \
        join(dapalias, dapdb.File.pipelineinfo).filter(drpalias.pk == 25).filter(dapalias.pk == 26)

    return q3

def generateQ3Flat(table, session):
    f = table

    q3 = session.query(f.mangaid, f.plate, f.plateifu, f.name, f.emline_sew_ha_6564, f.x, f.y, sampledb.NSA.sersic_n,
                       sampledb.NSA.sersic_logmass).join(sampledb.NSA, sampledb.NSA.pk == f.nsa_pk).filter(
        f.drppipe == 25, f.dappipe == 26, f.emline_sew_ha_6564 > 6.0, sampledb.NSA.sersic_n < 2,
        sampledb.NSA.sersic_mass > 3.2e9, sampledb.NSA.sersic_mass < 1e11)

    return q3



def generateQ4(C5Table, session):

    drpalias = aliased(datadb.PipelineInfo, name='drpalias')
    dapalias = aliased(datadb.PipelineInfo, name='dapalias')

    C5 = C5Table

    q4 = session.query(datadb.Cube.mangaid, datadb.Cube.plate, datadb.Cube.plateifu, datadb.IFUDesign.name,
                       C5.emline_gflux_ha_6564, C5.x, C5.y, sampledb.NSA.z). \
        join(datadb.IFUDesign, dapdb.File, C5, sampledb.MangaTarget, sampledb.MangaTargetToNSA, sampledb.NSA). \
        filter(C5.emline_gflux_ha_6564 > 25, sampledb.NSA.z < 0.1).join(drpalias, datadb.Cube.pipelineInfo). \
        join(dapalias, dapdb.File.pipelineinfo).filter(drpalias.pk == 25).filter(dapalias.pk == 26)

    return q4

def generateQ4Flat(table, session):
    f = table

    q4 = session.query(f.mangaid, f.plate, f.plateifu, f.name, f.emline_gflux_ha_6564, f.x, f.y, sampledb.NSA.z).join(
        sampledb.NSA, sampledb.NSA.pk == f.nsa_pk).filter(f.drppipe == 25, f.dappipe == 26, f.emline_gflux_ha_6564 > 25,
                                                          sampledb.NSA.z < 0.1)

    return q4










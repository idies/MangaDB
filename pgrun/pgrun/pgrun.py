import os;
import shutil;
import fileinput;
import subprocess;
import time;
import psycopg2;





def time_usage(func):
    def wrapper(*args, **kwargs):
        beg_ts = time.time()
        retval = func(*args, **kwargs)
        end_ts = time.time()
        print ("elapsed time: %f" %(end_ts - beg_ts))
        return retval
    return wrapper

def time_usage2(func):
    def wrapper(*args, **kwargs):
        from timeit import default_timer as timer
        beg_ts = timer()
        retval = func(*args, **kwargs)
        end_ts = timer()
        print ("elapsed time: %f" %(end_ts - beg_ts))
        return retval
    return wrapper


def generate_query(query, templatefile, code, table):
    lines = []
    with open(os.path.join('templates', templatefile)) as tfile:
        for line in tfile:
            line = line.replace(code, table)
            lines.append(line)
    return ''.join(lines)

@time_usage2
def runcmd(cmd):
    #cmd = '/usr/pgsql-9.6/bin/psql -d manga -q  -X -o /dev/null -f  /home/swerner/GitHub/MangaDB/pgrun/pgrun/q1-c5_cstore.sql'
    #cmd = '/usr/pgsql-9.6/bin/psql -d manga -q  -X -o /dev/null -f  /home/swerner/GitHub/MangaDB/pgrun/pgrun/q1-cleanspaxelprop5.sql'
    os.system(cmd)

#@time_usage2
def runcmd_db(cmd,cursor):
    #cmd = '/usr/pgsql-9.6/bin/psql -d manga -q  -X -o /dev/null -f  /home/swerner/GitHub/MangaDB/pgrun/pgrun/q1-c5_cstore.sql'
    #cmd = '/usr/pgsql-9.6/bin/psql -d manga -q  -X -o /dev/null -f  /home/swerner/GitHub/MangaDB/pgrun/pgrun/q1-cleanspaxelprop5.sql'
    from timeit import default_timer as timer
    beg_ts = timer()
    cursor.execute(str(cmd))
    end_ts = timer()
    #print ("elapsed time: %f" % (end_ts - beg_ts))
    tdiff = (end_ts  - beg_ts) * 1000
    records = cursor.fetchall()
    return tdiff, len(records)


def doTest(tables, templates, source, nRuns, cursor):
    # run q1 nRuns times for each table
    now = time.time()
    snow = time.strftime("%b_%d_%Y_%H:%M:%S", time.gmtime())

    
    outfile = str.format('{}_{}.log',source, snow)

    with (open(outfile, 'w')) as outfile:

        for query in sorted(templates):
            for table in tables:
                cmd = generate_query(query, templates[query], source, table)
                count = 1
                while count <= nRuns:
                    #print 'query: %s' % (query)
                    #print 'table: %s' % (table)
                    #print 'run: %s' % (count)
                    etime, nrec = runcmd_db(cmd, cursor)
                    #print 'time: %f' % (etime)
                    #print 'rows: %s' % (nrec)
                    print '-----------------------------'

                    results = (now, query, table, count, etime, nrec)

                    print('\t'.join(map(str, results)))
                    print '-----------------------------'

                    outfile.write('\t'.join(map(str, results)))
                    outfile.write('\n')

                    count += 1
    outfile.close()


def main():
    c5tables = 'cleanspaxelprop5', 'c5_cx', 'c5_ssd', 'c5_cx_ssd', 'c5_cstore', 'c5_cstore_ssd'
    c5source = 'C5TABLE'

    flatsource = 'FLAT'
    flattables = 'flattabletest', 'flat_ssd', 'flat_cstore', 'flat_cstore_ssd'

    qtemplates = {
        'q1': 'q1-c5.sql',
        'q2': 'q2-c5.sql',
        'q3': 'q3-c5.sql',
        'q4': 'q4-c5.sql'
    }

    qflat = {
        'q1': 'q1-flat.sql',
        'q2': 'q2-flat.sql',
        'q3': 'q3-flat.sql',
        'q4': 'q4-flat.sql'

    }
    #setup db conn
    conn_string = "host='dsp064' dbname='manga' user='manga' password='20manga17'"
    conn = psycopg2.connect(conn_string)
    cursor = conn.cursor()

    nRuns = 5  #run each query n times

    #test c5 tables
    doTest(c5tables, qtemplates, c5source, nRuns, cursor)

    doTest(flattables, qflat, flatsource, nRuns, cursor)









if __name__ == '__main__':
    main()


'''
for file in os.listdir('.'):
    if file.endswith('.sql'):
        print file
        cmd = '/usr/pgsql-9.6/bin/psql -d manga -q  -X -o /dev/null -f ' + os.path.realpath(file)
        print cmd
        runcmd(cmd)
        print ('------------------------------')
        
        
        
        
        
    #run q1 nRuns times for each table
    now = time.time()

    outfile = 'log_%f.log' % (now)

    with (open(outfile, 'w')) as outfile:

        for query in sorted(qtemplates):
            for table in c5tables:
                cmd = generate_query(query, qtemplates[query], c5source, table)
                count = 1
                while count <= nRuns:
                    print 'query: %s' % (query)
                    print 'table: %s' % (table)
                    print 'run: %s' % (count)
                    etime, nrec = runcmd_db(cmd, cursor)
                    print 'time: %f' % (etime)
                    print 'rows: %s' % (nrec)
                    print '-----------------------------'

                    results = (now, query, table, count, etime, nrec)

                    print('\t'.join(map(str,results)))
                    print '-----------------------------'

                    outfile.write('\t'.join(map(str,results)))
                    outfile.write('\n')


                    count += 1
    outfile.close()
'''
















'''
for file in os.listdir('templates'):
    for c5table in c5tables:
        lines = []
        outfile = os.path.splitext(file)[0].split('-')[0] + '-' + c5table + os.path.splitext(file)[1]
        #print outfile.name
        with open(os.path.join('templates', file)) as infile:  # open (outfile, 'w') as outfile:
            for line in infile:
                # print c5source
                # print c5table
                # print line
                line = line.replace(c5source, c5table)
                #print line
                lines.append(line)
        with open(outfile, 'w') as outfile:
            for line in lines:
                # print line
                outfile.write(line)
            outfile.close
'''



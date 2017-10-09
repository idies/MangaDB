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

@time_usage2
def runcmd_db(cmd,cursor):
    #cmd = '/usr/pgsql-9.6/bin/psql -d manga -q  -X -o /dev/null -f  /home/swerner/GitHub/MangaDB/pgrun/pgrun/q1-c5_cstore.sql'
    #cmd = '/usr/pgsql-9.6/bin/psql -d manga -q  -X -o /dev/null -f  /home/swerner/GitHub/MangaDB/pgrun/pgrun/q1-cleanspaxelprop5.sql'
    cursor.execute(str(cmd))
    records = cursor.fetchall()
    return len(records)


def main():
    c5tables = 'cleanspaxelprop5', 'c5_cx', 'c5_ssd', 'c5_cx_ssd', 'c5_cstore', 'c5_cstore_ssd'
    c5source = 'C5TABLE'


    qtemplates = {
        'q1' : 'q1-c5.sql',
        'q2' : 'q2-c5.sql',
        'q3' :'q3-c5.sql',
        'q4':'q4-c5.sql'
    }

    nRuns = 3  #run each query n times



    #setup db conn
    conn_string = "host='dsp064' dbname='manga' user='manga' password='20manga17'"
    conn = psycopg2.connect(conn_string)
    cursor = conn.cursor()


    #run q1 nRuns times for each table

    for query in qtemplates:
        for table in c5tables:
            cmd = generate_query(query, qtemplates[query], c5source, table)
            count = 1
            while count <= nRuns:
                print 'query: %s' % (query)
                print 'table: %s' % (table)
                print 'run: %s' % (count)
                nrec = runcmd_db(cmd, cursor)
                print 'rows: %s' % (nrec)
                print '-----------------------------'

                count += 1

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



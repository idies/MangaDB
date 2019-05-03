import os;
import shutil;
import fileinput;
import subprocess;




c5tables = 'cleanspaxelprop5', 'c5_cx', 'c5_ssd', 'c5_cx_ssd', 'c5_cstore', 'c5_cstore_ssd'

c5source = 'C5TABLE'

for file in os.listdir('templates'):
    for c5table in c5tables:
        outfile = os.path.splitext(file)[0] + c5table + os.path.splitext(file)[1]
        with open (file) as infile, open (outfile, 'w') as outfile:
            for line in infile:
                line = line.replace(c5source, c5table)
            outfile.write(line)

            print outfile
        #subprocess.call('psql -d manga -f ' + outfile)


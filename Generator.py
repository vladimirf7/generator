import os
import sys
import yaml

CREATE_TABLE = """CREATE TABLE \"{0}\" (
    \"{0}_id\" SERIAL PRIMARY KEY,
{1}
    \"{0}_created\" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
    \"{0}_updated\" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER)
    );\n\n"""

class Table:
    def __init__(self, name):
        self._name = ''
        self._fields = {}
        self._relations = []

if len(sys.argv) != 3:
    print(
        'Usage: {0} "input.file" "output.file"'
        .format(os.path.basename(__file__)))
    sys.exit()


in_file = sys.argv[1]
out_file = sys.argv[2]
statements = []
tables = []


with open(in_file, 'r') as f:
    doc = yaml.load(f)

for table_name in doc:   
    t = Table(table_name)    
    for fields in doc[table_name]:        
        for field_name in doc[table_name][fields]:
            field_value = doc[table_name][fields][field_name].lower()
            t._fields[field_name] = field_value            
    tables.append(t)

for table in tables:
    stmt = 

with open(out_file, 'w') as f:
    for stmt in statements:
        f.write(stmt)
print('SQL query saved to {0}'.format(os.path.abspath(out_file)))

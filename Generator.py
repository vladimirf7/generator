import os
import sys
import yaml

class Table:
    def __init__(self, name):
        self._name = ''
        self._fields = []
        self._relations = []

if len(sys.argv) != 3:
    print('Usage: {0} "input.file" "output.file"'.format(os.path.basename(__file__)))
    sys.exit()

CREATE_TABLE = """CREATE TABLE \"{0}\" (
    \"{0}_id\" SERIAL PRIMARY KEY,
{1}
    \"{0}_created\" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
    \"{0}_updated\" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER)
    );\n\n"""

in_file = sys.argv[1]
out_file = sys.argv[2]
statements = []

with open(in_file, 'r') as f:
    doc = yaml.load(f)

for table_name in doc:    
    t = Table(table_name)    
    for fields in doc[table_name]:
        addField = []
        for field in doc[table_name][fields]:
            addField.append(
                '\t\"{0}_{1}\" {2}'.format(table_name.lower(),
                field.lower(), doc[table_name][fields][field].lower())
                )
    statements += CREATE_TABLE.format(table_name.lower(), ',\n'.join(addField) + ',')

with open(out_file, 'w') as f:
    for stmt in statements:
        f.write(stmt)
print('SQL query saved to {0}'.format(os.path.abspath(out_file)))

print(CREATE_TABLE.format("part", "hhhhh"))

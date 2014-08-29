import os
import sys
import yaml

if len(sys.argv) != 3:
    print('Usage: {0} "input.file" "output.file"'.format(os.path.basename(__file__)))
    sys.exit()

CREATE_TABLE = 'CREATE TABLE "{0}" ({1});\n\n'
in_file = sys.argv[1]
out_file = sys.argv[2]
statements = []

with open(in_file, 'r') as f:
    doc = yaml.load(f)

for table_name in doc:
    params = '\n\t{0}_id SERIAL,\n'.format(table_name.lower())
    for fields in doc[table_name]:
        for field in doc[table_name][fields]:            
            params += '\t{0}_{1} {2} NOT NULL,\n'.format(table_name.lower(),
                field.lower(), doc[table_name][fields][field].lower())
        params += '\tPRIMARY KEY({0}_id),\n\tUNIQUE({0}_id)'.format(table_name.lower())
    statements.append(CREATE_TABLE.format(table_name.lower(), params))

with open(out_file, 'w') as f:
    for statement in statements:
        f.write(statement)
print('SQL query saved to {0}'.format(os.path.abspath(out_file)))

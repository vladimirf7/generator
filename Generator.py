import os
import sys
import yaml

class Table:
    def __init__(self, name):
        self._name = name
        self._fields = {}
        self._relations = []

CREATE_TABLE = """\
CREATE TABLE \"{0}\" (
    \"{0}_id\" SERIAL PRIMARY KEY,
{1}
    \"{0}_created\" INTEGER NOT NULL DEFAULT cast(extract(epoch from now())\
        AS INTEGER),
    \"{0}_updated\" INTEGER NOT NULL DEFAULT cast(extract(epoch from now())\
        AS INTEGER)
);\n\n"""
CREATE_TRIGGER = """\
CREATE OR REPLACE FUNCTION update_{0}_timestamp()
RETURNS TRIGGER AS $$
BEGIN
   NEW.{0}_updated = cast(extract(epoch from now()) as integer);
   RETURN NEW;
END;
$$ language \'plpgsql\';
CREATE TRIGGER "tr_{0}_updated" BEFORE UPDATE ON \"{0}\" FOR EACH ROW EXECUTE\
    PROCEDURE update_{0}_timestamp();\n\n"""

if len(sys.argv) != 3:
    print(
        'Usage: {0} "input.file" "output.file"'
        .format(os.path.basename(__file__)))
    sys.exit()

in_file = sys.argv[1]
out_file = sys.argv[2]
statements = []
tables = []

def create_objects():
    with open(in_file, 'r') as f:
        doc = yaml.load(f)

    for table_name in doc:
        t = Table(table_name.lower())
        for fields in doc[table_name]:
            for field_name in doc[table_name][fields]:
                field_value = doc[table_name][fields][field_name].lower()
                t._fields[field_name.lower()] = field_value.lower()
        tables.append(t)

def create_sql_tables():
    sql_fields = []

    for table in tables:
        for field_name, field_value in table._fields.items():
            sql_fields.append('\t\"{0}_{1}\" {2}'.format(
                table._name, field_name, field_value, ))
        statements.append(CREATE_TABLE.format(table._name, ',\n'.join(sql_fields) + ','))

def create_sql_trigers():
    for table in tables:
        statements.append(CREATE_TRIGGER.format(table._name))

def save_statements():
    with open(out_file, 'w') as f:
        for stmt in statements:
            f.write(stmt)
    print('SQL query saved to {0}'.format(os.path.abspath(out_file)))

create_objects()
create_sql_tables()
create_sql_trigers()
save_statements()

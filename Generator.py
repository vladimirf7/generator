import sys
import os
import yaml
from table import Table

CREATE_TABLE = """\
CREATE TABLE "{0}" (
    "{0}_id" SERIAL PRIMARY KEY,
    {1},
    "{0}_created" timestamp DEFAULT CURRENT_TIMESTAMP,
    "{0}_updated" timestamp DEFAULT CURRENT_TIMESTAMP
);

"""

CREATE_TRIGGER = """\
CREATE OR REPLACE FUNCTION update_{0}_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.{0}_updated = cast(extract(epoch from now()) as integer);
    RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_{0}_updated" BEFORE UPDATE ON "{0}" FOR EACH ROW \
EXECUTE PROCEDURE update_{0}_timestamp();

"""

class Generator:
    def __init__(self, file_in, file_out):
        self._file_in = file_in
        self._file_out = file_out
        self._statements = []
        self._tables = []

    def create_objects(self):
        with open(self._file_in, 'r') as f:
            doc = yaml.load(f)

        for table_name in doc:
            t = Table(table_name.lower())
            for fields in doc[table_name]:
                for field_name in doc[table_name][fields]:
                    field_value = doc[table_name][fields][field_name].lower()
                    t._fields[field_name.lower()] = field_value.lower()
            self._tables.append(t)

    def create_sql_tables(self):

        for table in self._tables:
            sql_fields = []
            for field_name, field_value in table._fields.items():
                sql_fields.append('"{0}_{1}" {2}'.format(
                    table._name, field_name, field_value, ))
            self._statements.append(CREATE_TABLE.format(
                table._name, ',\n    '.join(sql_fields)))

    def create_sql_trigers(self):
        for table in self._tables:
            self._statements.append(CREATE_TRIGGER.format(table._name))

    def write_file(self):
        with open(self._file_out, 'w') as f:
            for stmt in self._statements:
                f.write(stmt)
        print('SQL query saved to {0}'.format(os.path.abspath(self._file_out)))

    def save_statements(self):
        self.create_objects()
        self.create_sql_tables()
        self.create_sql_trigers()
        self.write_file()

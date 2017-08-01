import pandas as pd
import MySQLdb
import yaml
from contextlib import closing
import math
import os


def load_db_config(filename):
    with open(filename, 'r') as stream:
        return yaml.load(stream)

def load_db_config_env():
    return {
        'host': 'localhost',
        'user': os.getenv('DB_MYSQL_USER', 'root'),
        'password': os.getenv('DB_MYSQL_PASSWORD', '123'),
        'database': os.getenv('DB_MYSQL_DATABASE', 'research_hub'),
        'port': 3306
    }


def get_sheet_names(filename):
    excel = pd.ExcelFile(filename)
    return excel.sheet_names


def get_columns_to_insert(df):
    headers = df.columns.values
    to_insert = []

    for header in headers:
        header_name = header.strip()
        if header_name != "id" and not header_name.startswith("#"):
            to_insert.append(header)

    return to_insert


def build_insert_query(table_name, column_names):
    column_names_str = ",".join(column_names)
    values_str = ",".join(["%s"] * len(column_names))
    return "INSERT INTO {0} ({1}) VALUES ({2})".format(table_name, column_names_str, values_str)


def get_connection(db_config):
    return MySQLdb.connect(**db_config)


if __name__ == "__main__":
    filename = "database.xlsx"
    tables = get_sheet_names(filename)
    db_config = load_db_config_env()

    for table in tables:
        print("Seeding table: {0}".format(table))

        df = pd.read_excel(filename, table)

        # Get data to insert and create query
        columns = get_columns_to_insert(df)
        query = build_insert_query(table, columns)
        rows = [list(row) for row in df[columns].values]

        # Set NaN's to None
        for i, row in enumerate(rows):
            for j, cell in enumerate(row):
                if isinstance(cell, float) and math.isnan(cell):
                    row[j] = None

        rows = [tuple(row) for row in rows]

        # Insert data into database
        with closing(get_connection(db_config)) as con:
            with con as cursor:
                cursor.executemany(query, rows)
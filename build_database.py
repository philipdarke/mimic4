from pathlib import Path
from typing import Final

import duckdb
from duckdb import DuckDBPyConnection

DATA_DIRECTORY: Final = Path("data/mimic-iv-3.0/")

con: DuckDBPyConnection = duckdb.connect(database="mimic4.db")

# Create tables
with open("create.sql", "r") as file:
    sql: str = file.read()
    con.execute(sql)

# Populate tables
for file in DATA_DIRECTORY.glob("*/*.csv.gz"):
    file_split: list[str] = str(file).split("/")
    table: str = file_split[2] + "." + file_split[3].split(".")[0]
    print(f"{file} -> {table}...")
    con.sql(f"INSERT INTO {table} SELECT * FROM read_csv('{file}')")

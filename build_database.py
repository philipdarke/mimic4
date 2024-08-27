from pathlib import Path
from typing import Final

import duckdb

DATA_DIRECTORY: Final = Path("data/mimic-iv-3.0/")

con = duckdb.connect(database="mimic4.db")

# Create tables
with open("create.sql", "r") as file:
    sql = file.read()
    con.execute(sql)

# Populate remaining tables
for file in DATA_DIRECTORY.glob("*/*.csv.gz"):
    file_split = str(file).split("/")
    table = file_split[2] + "." + file_split[3].split(".")[0]
    print(f"{file} -> {table}...")
    con.sql(f"INSERT INTO {table} SELECT * FROM read_csv('{file}')")

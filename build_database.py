from pathlib import Path
from typing import Final

import duckdb
from duckdb import DuckDBPyConnection
import zipfile

DATA_DIRECTORY: Final = Path("data/mimic-iv-3.0/")
SQL_DIRECTORY: Final = Path("sql/")


def extract_zip_file(path: str | Path, destination_path: str | Path) -> None:
    """
    Extract a .zip file to a destination path.

    Args:
        path: Path to the .zip file.
        destination_path: Path to the destination directory.
    """
    with zipfile.ZipFile(path, "r") as zip:
        zip.extractall(destination_path)


def execute_sql(path: Path | str) -> None:
    """
    Execute a .sql file.

    Args:
        path: Path to the .sql file.
    """
    print(f" - {path}...")
    with open(path, "r") as file:
        sql: str = file.read()
        con.execute(sql)


def execute_sqls(
    directory: Path,
    pattern: str = "*.sql",
    first: str | list[str] = [],
    last: str | list[str] = [],
) -> None:
    """
    Execute all .sql files in a directory.

    Args:
        directory: Path to the directory.
        pattern: Pattern to match to find SQL scripts. Default "*.sql".
        first: Optional list of .sql files to execute first.
        last: Optional list of .sql files to execute last.
    """
    first = [first] if isinstance(first, str) else first
    last = [last] if isinstance(last, str) else last
    # "First" tables
    for file in first:
        execute_sql(directory / f"{file}.sql")
    # Remaining tables
    for path in sorted(directory.glob(pattern)):
        if path.stem not in first and path.stem not in last:
            execute_sql(path)
    # "Last" tables
    for file in last:
        execute_sql(directory / f"{file}.sql")


# Open database connection
con: DuckDBPyConnection = duckdb.connect(database="mimic4.db")

# Create tables
print("Creating tables...")
with open("sql/create.sql", "r") as file:
    sql: str = file.read()
    con.execute(sql)

# Extract data
print("Extracting data...")
extract_zip_file("data/mimic-iv-3.0.zip", DATA_DIRECTORY.parent)

# Populate tables
print("Populating tables:")
for path in DATA_DIRECTORY.glob("*/*.csv.gz"):
    path_split: list[str] = str(path).split("/")
    table: str = path_split[2] + "." + path_split[3].split(".")[0]
    print(f" - {path} -> {table}...")
    con.sql(f"INSERT INTO {table} SELECT * FROM read_csv('{path}')")

# Need to add concepts in order of dependencies
print("Adding concepts:")
execute_sqls(SQL_DIRECTORY / "demographics", first="icustay_times")
execute_sqls(SQL_DIRECTORY / "comorbidity")
execute_sqls(SQL_DIRECTORY / "measurement")
execute_sqls(
    SQL_DIRECTORY / "medication",
    last=["vasoactive_agent", "norepinephrine_equivalent_dose"],
)
execute_sqls(SQL_DIRECTORY / "treatment")
execute_sqls(
    SQL_DIRECTORY / "firstday", first=["first_day_vitalsign", "first_day_urine_output"]
)
execute_sqls(SQL_DIRECTORY / "organfailure", first="kdigo_uo")
execute_sqls(SQL_DIRECTORY / "score")
execute_sqls(SQL_DIRECTORY / "sepsis", first="suspicion_of_infection")

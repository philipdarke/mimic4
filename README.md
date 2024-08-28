# mimic4

Adds the MIMIC-IV data set (including all current concepts) to a DuckDB database using Python.

Based on the scripts at https://github.com/MIT-LCP/mimic-code/tree/main/mimic-iv/buildmimic, however note the schema names are not prefaced with `mimiciv_`. No constraints are placed on the tables as the focus is [speed](https://duckdb.org/docs/guides/performance/schema#constraints).

Data is available from https://physionet.org/content/mimiciv/3.0/.

The only Python dependency is [duckdb](https://pypi.org/project/duckdb/). Tested using Python 3.10.12, DuckDB 1.0.0 and MIMIC-IV v3.0.

## Instructions

Create a Python virtual environment and install DuckDB, for example:

```
python3 -m .venv venv
source .venv/bin.activate
pip install duckdb==1.0.0
```

Download and save `mimic-iv-3.0.zip` in the `data/` directory.

Run `python3 build_database.py` to build the database. It is named `mimic4.db` by default and should have the SHA-256 checksum `117ae4ca5efa1075a741fb5ac7129250560965402540b699dea723f85aeeca24`.

## Licence

Made available under the MIT license. The `create.sql` and concept scripts are adapted from the [`mimic-code`](https://github.com/MIT-LCP/mimic-code) repository and subject to the MIT licence:

```
MIT License

Copyright (c) 2019 MIT Laboratory for Computational Physiology

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

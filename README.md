# imply-utils
Utilities around Imply and Druid

## Count the lines in all Parquet files:

```bash
find $PATH -type f -name '*parquet' -exec parquet-tools inspect {} \; 2>/dev/null | perl -ne '/num_rows: (\d+)/ && print "$1 "' >linecounts
```

and then

```bash
cat linecounts | ./sum.sh
```

## Transpose JSON

We have something like

```
{ field1: { id: stuff ... }, field2: { id: stuff ... } ... }
```

and we want

```
{ id: { field1: ..., field2: ...  }
```

call transpose script like so:

```
python3 imply-utils/transpose_json.py < Claim_Anonymized.json| jq -c '.[]' | less 
```

Get a list of all columns that have a bitmap index

```bash
list-indexed-columns.sh
```

Uses the segment dump tool to get the indexed columns for a datasource. Datasource name and segment base directory are variables inside the code.

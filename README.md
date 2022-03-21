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

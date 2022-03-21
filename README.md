# imply-utils
Utilities around Imply and Druid

count the liines in all Parquet files:

```bash
find $PATH -type f -name '*parquet' -exec parquet-tools inspect {} \; 2>/dev/null | perl -ne '/num_rows: (\d+)/ && print "$1 "' >linecounts
```

and then

```bash
#!/bin/bash
read -a nums
for num in "${nums[@]}"; do
    (( sum += num ))
done
echo $sum
```

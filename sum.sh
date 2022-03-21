#!/bin/bash
read -a nums
for num in "${nums[@]}"; do
    (( sum += num ))
done
echo $sum


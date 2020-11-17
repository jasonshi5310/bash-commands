#!/bin/bash
if [ $# != 2 ]; then
    echo "input file and dictionary missing"
    exit 0
fi
if [ -d $1 ]; then
    echo "$1 is not a file"
    exit 0
fi
if [ -d $2 ]; then
    echo "$2 is not a file"
    exit 0
fi

cat $1| grep -o "\b[A-Za-z][A-Za-z][A-Za-z][A-Za-z]\b" > filename_part_5
readarray arr < filename_part_5
rm filename_part_5
dict=$(awk '{print toupper($0)}' $2)
for i in ${arr[@]}
do 
    temp=$(echo "$i" | awk '{print toupper($0)}')
    found=( $(grep -o "$temp" <<< $dict | wc -l))
    if [ $found == 0 ]; then
        echo $i
    fi
done 

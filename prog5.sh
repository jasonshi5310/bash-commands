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

cat $1| grep -o "\b[a-zA-Z][a-zA-Z][A-Za-z][A-Za-z]\b" > filename_part_5
readarray arr < filename_part_5
rm filename_part_5
# echo ${arr[@]}

for i in ${arr[@]}
do 
    found=( $(cat $2 | grep -o "$i" | wc -l))
    # if [ $i == 'forc' ]; then
    # echo $i
    # fi
    if [ $found == 0 ]; then
        echo $i
    fi
done 

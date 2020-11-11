#!/bin/bash
if [ ! -f $1 ] # if data file doesn't exist
then
    echo "$1 not found"
    exit 0
fi
if [ $# != 2 ] # if not exactly 2 input arguments
then
    echo "data file or output file not found"
    exit 0
fi
if [ -f $2 ] # if the output file exist
then
    sed -i d $2 # empty the output file
else
    touch $2
fi

column=`wc -l < $1`
column=`expr $column + 0`
# column=$( expr $column + 0 )
echo "column# : $column"
if [ $column == 0 ]; then
    # echo "haha"
    exit 0 
fi
readarray arr < $1
row=-1
# echo $row
for (( i=0; i < $column; i++ ))
do
    # echo "line number $i"
    # echo "arr: ${arr[$i]}"
    temp=$( echo ${arr[$i]} | grep -o "[:;,]" | wc -l )
    temp=`expr $temp + 0`
    # echo $temp
    # echo "currntly $row"
    if [ $temp -gt $row ]; then
        row=$temp
    fi
    # echo $row
done
# echo $row

# awk -F"\n" "BEGIN{print "count", "lineNum"}{print gsub(/\[,;:\]/) "\t" NR}" $1

# awk -F'\n' 'BEGIN{print "count", "lineNum"}{print gsub(/[,:;]/,"") "\t" NR}' $1

# row=-1
# echo $row
# awk -F'\n' '{$row = gsub(/[,:;]/,"")}' $1
# echo $row

# read the input


# count the column

# count the row

# do a double for loop
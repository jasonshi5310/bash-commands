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
# echo "column# : $column"
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
row=`expr $row + 1 `
# echo $row

touch no_files_have_this_name
cat $1 | sed 's/[,;:]/ /g' > no_files_have_this_name
# cat no_files_have_this_name
readarray arr < no_files_have_this_name
rm no_files_have_this_name
for (( j=0; j < $row; j++ ))
do
    sum=0
    for (( i=0; i < $column; i++ ))
    do
        ith_row=(${arr[$i]})
        # echo ${ith_row[@]}
        row_length=$( echo ${ith_row[@]} | grep -o ' ' | wc -l )
        row_length=`expr $row_length + 0`
        # echo $row_length
        if [ $row_length -lt $j ]; then
            continue
        fi
        jth_column=${ith_row[$j]}
        sum=`expr $sum + $jth_column`
    done
    haha=`expr $j + 1`
    echo "Col $haha: $sum" >> $2
    # cat $2 | sed '$haha/^/'
done

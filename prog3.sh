#!/bin/bash
# echo $1
# if [ ! $1 ]; then 
#     echo "haha" 
# fi
if [ $# == 0 ]; then
    echo "missing data file"
    exit 0
fi
if [ ! -f $1 ]; then
    echo "missing data file"
    exit 0
fi

readarray arr < $1
length=$( echo ${arr[0]} | grep -o "," | wc -l )
length=`expr $length + 0`
lines=$( cat $1 | wc -l )
lines=`expr $lines + 0`
# echo "length $length"
# echo "lines $lines"
argv=("$@")
# for (( i=0 ; i < $length ; i++ ))
# do
#     # echo ${argv[$i]}
#     weight=1
#     if [ ${argv[$i]} ]; then 
#         weight=${argv[$i]}
#     fi
#     echo "weight: $weight"


# done


touch no_files_have_this_name_3
cat $1 | sed 's/,/ /g' > no_files_have_this_name_3
# cat c
readarray arr < no_files_have_this_name_3
rm no_files_have_this_name_3
sum=0
for (( i=1; i < $lines ; i++ ))
do
    weight_sum=0
    row_sum=0
    for (( j=1; j <= $length; j++ ))
    do
        # echo ${argv[$i]}
        weight=1
        # echo ${argv[$j]}
        if [ ${argv[$j]} ]; then 
            weight=${argv[$j]}
        fi
        # echo "weight: $weight"
        weight_sum=`expr $weight_sum + $weight`
        # for (( i=1; i < $lines; i++ ))
        # do
        ith_row=(${arr[$i]})
        # echo ${ith_row[@]}
        # row_length=$( echo ${ith_row[@]} | grep -o ' ' | wc -l )
        # row_length=`expr $row_length + 0`
        # echo $row_length
        jth_column=${ith_row[$j]}
        jth_column=`expr $jth_column \* $weight`
        row_sum=`expr $row_sum + $jth_column`
        # done
        # echo "sum $sum"
    done
    # echo "row sum $row_sum"
    # echo $weight_sum
    row_sum=`expr $row_sum / $weight_sum`
    # echo "weighted row sum $row_sum"
    sum=`expr $row_sum + $sum`
    # echo "sum $sum"
done
# echo $weight_sum
# denominator=`expr $weight_sum \* \( $lines - 1 \)`
sum=`expr $sum / \( $lines - 1 \)`
echo $sum

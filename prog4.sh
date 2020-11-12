#!/bin/bash
if [ $# != 1 ]; then
    echo "score directory missing"
    exit 0
fi
if [ ! -d $1 ]; then
    echo "$1 is not a directory"
    exit 0
fi

for file in $1/*
do
    echo "$file:"
    cat $file | sed 's/,/ /g' > no_files_have_this_name_4
    readarray arr < no_files_have_this_name_4
    rm no_files_have_this_name_4
    points=(${arr[1]})
    # echo $points
    sum=0
    for (( i=1 ; i <= 5 ; i++ ))
    do 
        temp=(${points[$i]})
        # echo $temp
        sum=`expr $sum + $temp`
    done 
    echo $sum
    sum=`expr $sum \* 2`
    if [ $sum -gt 92 ]; then
        echo "A"
    elif [ $sum -gt 79 ]; then
        echo "B"
    elif [ $sum -gt 65 ]; then
        echo "C"
    else
        echo "D"
    fi
done

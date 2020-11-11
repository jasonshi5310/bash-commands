#!/bin/bash
# echo $1
# echo $2
if [ $# != 2 ]
then
    echo "src and dest dirs missing"
    exit 0
fi
if [ ! -d $1 ]
then
    echo "$1 not found"
    exit 0
fi
if [ ! -d $2 ]
then
    mkdir $2
fi

# Copy all the .c file from the src dir that are outside of subdir
# find $1 -maxdepth 1 -type f -name *.c -exec cp {} $2 \;


local count=($( ls -1 $1 | grep -c ".*\.c$" ))

# echo "count: $count"
# ls -1 $s
# ls -1 $s | grep -c ".*\.c$"
if [ $count -gt 2 ]
then
    # echo "greater than 3! $s"
    ls -1 $1 | grep ".*\.c$"
    read -p "For files shown above, do you want to move them? [Y/n] " YN
    if [[ $YN == "y" || $YN == "Y" ]]; then
        find $1 -maxdepth 1 -type f -name *.c -exec mv {} $2 \;
    fi
fi

mv_recursive()
{
    local s=$1
    local d=$2
    local count=($( ls -1 $s | grep -c ".*\.c$" ))
    if [ $count -gt 3 ]
    then
        # echo "greater than 3! $s"
        ls -1 $s | grep ".*\.c$"
        read -p "For files shown above, do you want to move them? [Y/n] " YN
        if [[ $YN == "y" || $YN == "Y" ]]; then
            find $s -maxdepth 1 -type f -name "*.c" -exec mv {} $d \;
        fi
    else
        find $s -maxdepth 1 -type f -name "*.c" -exec mv {} $d \;
    fi
    # find $s -maxdepth 1 -type f -name "*.c" -exec cp {} $d \;
    for dir in $s/*
    do
        if [ -d $s/${dir##*/} ]
        then
            # echo "Create subdir $d/${dir##*/}"
            mkdir $d/${dir##*/}
            mv_recursive $s/${dir##*/} $d/${dir##*/}
        # else
        #     echo $s/${dir##*/}
        fi
    done
    #cd ..
}

# loop through all subdir in the src dir
var=$(pwd)
for dir in $1/*
do
    # echo $dir
    # echo [ -d $dir ]
    if [ -d  $var/$2/${dir##*/} ]
    then 
        # echo "Alreay have $2/${dir##*/}"
        rm -r $var/$2/${dir##*/}
        mkdir $var/$2/${dir##*/}
        mv_recursive $var/$dir $var/$2/${dir##*/}
    elif [ -d $var/$dir ]
    then
        # echo "Here $dir"
        mkdir $var/$2/${dir##*/}
        mv_recursive $var/$dir $var/$2/${dir##*/}
        # find $dir -type f -name *.c -exec cp {} $2/${dir##*/} \;
    fi
done

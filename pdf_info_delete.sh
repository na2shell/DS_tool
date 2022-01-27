#!bin/bash

path=$1

ls -1d | grep pdf | while read line
do
    tempfile=$(mktemp)

    pdftk ${line} dump_data |
        sed -e '' > "$tempfile"
    
    pdftk ${line} update_info ${tempfile} output "${line}.tmp"

    if [ $? -eq 0 ];then
        echo "$line is suc"
        mv "${line}.tmp" ${line}
    fi
done
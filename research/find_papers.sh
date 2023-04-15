#!/bin/bash

dblp_src="https://dblp.org/db/conf/"
conference_list="dac date isca micro aspdac iccad hpca asplos"
mode=0 # 0: search all conferences, 1: search specific conferences
year=2021
key="Light"
conf="isca"

function search_all() {
    echo "Searching all conferences ..."
    for c in ${conference_list}; do
        local link="${dblp_src}${c}/${c}${year}.html"
        curl ${link} 1>html.${c}.${year} 2>/dev/null
    done
    for c in ${conference_list}; do
        echo ${c}
        python3 html_parser.py html.${c}.${year} | grep -i ${key} | grep "^Data"
        rm -rf html.${c}.${year}
    done
}

function search_specific() {
    local year_start=$1
    local year_end=$2
    local conf_dir=$3
    local conf_key=$4
    local key=$5
    local conf_name=$(echo "${conf_dir}" | tr '[:lower:]' '[:upper:]')

    echo "Search ${key} in conference ${conf_dir}, from year ${year_start} to year ${year_end} ..."

    for y in $(seq ${year_start} ${year_end}); do
        local link="${dblp_src}${conf_dir}/${conf_key}${y}.html"
        curl ${link} 1>html.${conf_dir}.${y} 2>/dev/null
        python3 html_parser.py html.${conf_dir}.${y} |
            grep -i ${key} | grep "^Data" |
            awk -F': ' '{print "- "$NF" '"${conf_name}"'-'"${y}"'"}'
    done
    rm -rf html.${conf_dir}.*
}

if [ $# -eq 3 ]; then
    year_args=$(echo $1 | awk -F'-' '{if(NF==2){print $1,$2} else {print $1,$1}}')
    conf_args=$(echo $2 | awk -F'-' '{if(NF==2){print $1,$2} else {print $1,$1}}')
    key=$3
    search_specific $year_args $conf_args $key
elif [ $# -eq 2 ]; then
    year=$1
    key=$2
    search_all
else
    echo "Usage: $0 <year> <key> ::Search all conferences in specific year"
    echo "       $0 <year> <conf> <key> ::Search specific conference in specific year"
    echo "                                 ::Support single year and <start-end> format"
    exit 1
fi


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
    echo "Search specific conferences ..."
    for y in $(seq ${year}); do
        local link="${dblp_src}${conf}/${conf}${y}.html"
        curl ${link} 1>html.${conf}.${y} 2>/dev/null
    done
    for y in $(seq ${year}); do
        python3 html_parser.py html.${conf}.${y} | grep -i ${key} | grep "^Data"
    done
    rm -rf html.${conf}.*
}

if [ $# -eq 3 ]; then
    year=$(echo $1 | awk -F'-' '{if(NF==2){print $1,$2} else {print $1}}')
    conf=$2
    key=$3
    mode=1
elif [ $# -eq 2 ]; then
    year=$1
    key=$2
    mode=0
else
    echo "Usage: $0 <year> <key> ::Search all conferences in specific year"
    echo "       $0 <year> <conf> <key> ::Search specific conference in specific year"
    echo "                                 ::Support single year and <start-end> format"
    exit 1
fi

if [ ${mode} -eq 0 ]; then
    search_all
elif [ ${mode} -eq 1 ]; then
    search_specific
fi


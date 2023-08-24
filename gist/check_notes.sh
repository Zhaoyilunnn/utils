#!/bin/bash

stage=0
mode=0 # 0 for direct communication, 1 for proxychains4
cmd=""

# Usage
# stage = 0: commit and push, 1: push, 2: pull


if [ $# -eq 2 ]; then
    stage=$1;
    mode=$2;
fi

if [ $# -eq 1 ]; then
    stage=$1
fi

if [ $mode -eq 1 ]; then
    cmd=proxychains4
fi

find "." -type d -name ".git" -exec dirname {} \; |
    while read line; do
        cd $line;

        # If stage == 2, sync notes and continue
        if [ ${stage} -eq 2 ]; then
            ${cmd} git pull;
            cd -;
            continue;
        fi

        # Else check if we need update local notes to remote
        flag=$(git status | grep -E -- 'modified|push');
        if [ -z $flag ]; then
            echo "$line Nothing changed";
        else
            if [ ${stage} -eq 0 ]; then
                git commit -am "Update" && ${cmd} git push;
            elif [ ${stage} -eq 1 ]; then
                ${cmd} git push;
            fi
        fi
        cd -;
    done

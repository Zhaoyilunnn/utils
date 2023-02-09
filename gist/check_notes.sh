#!/bin/bash

stage=0

# Usage
# stage = 0: commit and push, 1: push, 2: pull

if [ $# -eq 1 ]; then
    stage=$1
fi

ls -l ./ | awk '{if(NF>3)print $NF}' | grep -v "check_notes" | 
    while read line; do 
        cd $line/*;

        # If stage == 2, sync notes and continue 
        if [ ${stage} -eq 2 ]; then
            proxychains4 git pull;
            cd -;
            continue;
        fi

        # Else check if we need update local notes to remote
        flag=$(git status | grep -E -- 'modified|push');
        if [ -z $flag ]; then
            echo "$line Nothing changed";
        else
            if [ ${stage} -eq 0 ]; then
                git commit -am "Update" && proxychains4 git push; 
            elif [ ${stage} -eq 1 ]; then
                proxychains4 git push;
            fi
        fi
        cd -;
    done

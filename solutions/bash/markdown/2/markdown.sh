#!/usr/bin/env bash
while IFS= read -r line; do
    #bolding
    bolding_required=1
    while (( bolding_required == 1 )); do
    if [[ $line =~ ^(.+)__(.*) ]]; then
        post=${BASH_REMATCH[2]};pre=${BASH_REMATCH[1]}
            if [[ $pre =~ ^(.*)__(.+) ]]; then
                printf -v line "%s<strong>%s</strong>%s"  "${BASH_REMATCH[1]}"  "${BASH_REMATCH[2]}"  "$post"
            fi
    else
        bolding_required=0
    fi
    done
    
    #italics
    italics_required=1
    while (( italics_required == 1 )); do
    if [[ $line =~ ^(.+)_(.*) ]]; then
        post=${BASH_REMATCH[2]};pre=${BASH_REMATCH[1]}
            if [[ $pre =~ ^(.*)_(.+) ]]; then
                printf -v line "%s<em>%s</em>%s"  "${BASH_REMATCH[1]}"  "${BASH_REMATCH[2]}"  "$post"
            fi
    else
        italics_required=0
    fi
    done
    
    #check if line is meant to be in a list
    echo "$line" | grep '^\*' > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
        if [ "$inside_a_list" != true ]; then
            h="$h<ul>"
            inside_a_list=true
         fi
         while [[ $line == *_*?_* ]]; do
            one=${line#*_}
            two=${one#*_}
            if [ ${#two} -lt ${#one} -a ${#one} -lt ${#line} ]; then
                line="${line%%_$one}<em>${one%%_$two}</em>$two"
            fi
        done
        h="$h<li>${line#??}</li>"
    else
        if [ "$inside_a_list" = true ]; then
            h="$h</ul>"
            inside_a_list=false
        fi

        n=`expr "$line" : "#\{1,\}"`
        if [ $n -gt 0 -a 7 -gt $n ]; then
            HEAD=${line:n}
            while [[ $HEAD == " "* ]]; do 
                HEAD=${HEAD# }; 
            done
            h="$h<h$n>$HEAD</h$n>"
        else
            h="$h<p>$line</p>"
        fi
    fi
done < "$1"

if [ "$inside_a_list" = true ]; then
    h="$h</ul>"
fi

echo "$h"

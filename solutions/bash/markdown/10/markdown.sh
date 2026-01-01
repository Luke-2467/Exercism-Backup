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
    
    #List items
    list_regex='^\*'
    
    if [[ "$line" =~ $list_regex ]]; then
        if [ "$inside_a_list" != true ]; then
            output="${output}<ul>"
            inside_a_list=true
         fi
        output="${output}<li>${line#??}</li>"
    else
        #close off list
        if [ "$inside_a_list" = true ]; then
            output="${output}</ul>"
            inside_a_list=false
        fi
        
        #check for headers
        header_level=$(expr "$line" : "#\{1,\}")
        
        #check header level is within bounds
        if (( header_level > 0 && header_level < 7 )); then
            HEADER=${line:header_level}
            while [[ $HEADER == " "* ]]; do 
                HEADER=${HEADER# }; 
            done
            output="${output}<h$header_level>$HEADER</h$header_level>"
        else
            output="${output}<p>$line</p>"
        fi
    fi
done < "$1"

if [ "$inside_a_list" = true ]; then
    output="${output}</ul>"
fi

echo "$output"

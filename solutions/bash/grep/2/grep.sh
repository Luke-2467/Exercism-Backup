#!/usr/bin/env bash

main(){
inputs=("$@")

declare -A flag_indicator

files=()

pattern_found="0"

for input in "${inputs[@]}"; do
    if [[ "${input:0:1}" = "-" && "$pattern_found" = "0" ]]; then
        flag_indicator["$input"]=1
    elif [[ "$pattern_found" = "0" ]]; then
        pattern="$input"
        pattern_found="1"
    else
        files+=("$input")
    fi
done

pattern_length="${#pattern}"

#echo "flags: ${!flag_indicator[@]}"
#echo "patten: $pattern"
#echo "files: ${files[@]}"

number_of_files="${#files[@]}"

for file in "${files[@]}"; do
    line_number=0
    while IFS= read -r line; do
        line_number=$((line_number+1))
        match_line=""
        matching_line=""
        line_start=""
        no_match_line=""
        
        line_length="${#line}"
        if [[ "${flag_indicator["-i"]}" = "1" ]]; then
             pattern=$(echo "$pattern" | tr "[:upper:]" "[:lower:]")
             match_line=$(echo "$line" | tr "[:upper:]" "[:lower:]")
        else 
            match_line="$line"
        fi
        
        if [[ "${flag_indicator["-x"]}" = "1" ]]; then
            if [[ "$match_line" = "$pattern" ]]; then
                matching_line="$line"
            else
                no_match_line="$line"
            fi 
        else
            for ((index=0;index<line_length-pattern_length;index++)); do
                 current_line_segment="${match_line:index:pattern_length}"
                  if [[ "$current_line_segment" = "$pattern" ]]; then
                    matching_line="$line"
                    break
                  elif (( index == line_length-pattern_length-1 )); then
                       no_match_line="$line"
                fi 
            done
        fi

        if [[ "${flag_indicator["-v"]}" = "1" && "$no_match_line" != "" ]]; then
            matched_line="$no_match_line"
        elif [[ "${flag_indicator["-v"]}" != "1" && "$matching_line" != "" ]]; then
            matched_line="$matching_line"
        else 
            continue
        fi

        line_start=""
        
        if [[ "${flag_indicator["-n"]}" = "1" ]]; then
            line_start="${line_number}:"
        fi

        if (( number_of_files > 1 )); then
            line_start="${file}:${line_start}"
        fi

        if [[ "${flag_indicator["-l"]}" = "1" ]]; then
            echo "$file"
            break
        else 
            if [[ "$line_start" != "" ]]; then
                echo "${line_start}${matched_line}"
            else
                echo "$matched_line"
            fi
        fi
    done < "$file"
done
}

main "$@"
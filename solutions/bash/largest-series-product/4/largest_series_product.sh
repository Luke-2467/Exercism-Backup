#!/usr/bin/env bash
max_number() {
    printf "%s\n" "$@" | sort -g | tail -1
}
find_series_product(){
    series="$1"
    string_length="$2"

    product=1
    for (( string_index=0;string_index<string_length;string_index++ )); do
        current_integer=${series:string_index:1}
        product=$((product*current_integer))
    done
    echo "$product"
}

main(){
    string="$1"
    wanted_length="$2"
    length_of_string=${#string}
    
    if (( wanted_length < 0 )); then
        echo "span must not be negative"
        exit 1
    elif (( wanted_length > length_of_string )); then
        echo "span must not exceed string length"
        exit 1
    fi 
    
    case "$string" in 
        ''|*[!0-9]*) 
        echo "input must only contain digits" 
        exit 1 
        ;;
    esac
    
    max_index_before_end_of_string=$((length_of_string-wanted_length))

    current_max=0
    
    for (( start_index=0;start_index<=max_index_before_end_of_string;start_index++ )); do
        current_substring=${string:start_index:wanted_length}
        product="$(find_series_product "$current_substring" "$wanted_length")"
        current_max="$(max_number "$current_max" "$product")"
    done
    echo "$current_max"
}

main "$@"
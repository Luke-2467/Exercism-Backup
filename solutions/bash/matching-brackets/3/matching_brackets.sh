#!/usr/bin/env bash
main(){
string="$1"
only_brackets=$(echo "$string" | tr -dc '\[\]\(\)\{\}')

brackets_to_letters=$(echo "$only_brackets" | tr '[' 's' | tr ']' 'S' | tr '(' 'v' | tr '\)' 'V' | tr '\{' 'c' | tr '\}' 'C')

brackets_length="${#brackets_to_letters}"

bracket_tracking=""

for ((string_index=0;string_index<brackets_length;string_index++)); do

    current_bracket="${brackets_to_letters:"$string_index":1}"
    
    bracket_tracking_length="${#bracket_tracking}"
    
    current="${bracket_tracking:"$bracket_tracking_length"-1:1}"

    needed_closure="${current^^}"
    
    if [ "$current_bracket" == "S" ] || [ "$current_bracket" == "V" ] || [ "$current_bracket" == "C" ]; then
        if [[ "$needed_closure" == "$current_bracket" ]]; then
            bracket_tracking="${bracket_tracking:0:"$bracket_tracking_length"-1}"
        else
            echo false
            exit 0
        fi
    else 
        bracket_tracking="${bracket_tracking}${current_bracket}"
    fi
done

if [[ "$bracket_tracking" = "" ]]; then
    echo true
else 
    echo false
fi

}

main "$@"
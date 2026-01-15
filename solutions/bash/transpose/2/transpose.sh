#!/usr/bin/env bash

repeat(){
    repeat_number="$1"
    repeat_character="$2"
    result=""
	for ((number=1;number<=repeat_number;number++)); do 
        result+="$repeat_character"
    done
    echo "$result"
}

main(){

readarray -t input

number_of_lines="${#input[@]}"

max_length=0

for (( line=number_of_lines-1 ; line >= 0 ; line-- )); do
    current_line="${input[line]}"

    current_line_length="${#current_line}"

    if (( max_length < current_line_length )); then
        max_length="$current_line_length"
    else
        length_difference=$((max_length-current_line_length))
        #append white spaces so lines are equal
        input[line]+="$(repeat "$length_difference" " ")"
    fi
done

result=()

for (( index=0 ; index < max_length ; index++ )); do
    for (( line=0 ; line < number_of_lines ; line++ )); do
        current_line="${input[line]}"
        result[index]="${result[index]}${current_line:index:1}"
    done
done

for (( index=0 ; index < max_length ; index++ )); do
    echo "${result[index]}"
done

}

main "$@"

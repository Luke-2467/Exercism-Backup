#!/usr/bin/env bash

main(){

raw_number="$1"

only_numbers=$(echo "$raw_number" | tr -dc '[0-9]')

length_number="${#only_numbers}"

starting_number="${only_numbers:0:1}"

if (( length_number > 11 )); then
    echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
    exit 1
elif (( length_number < 10 )); then
    echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
    exit 1
elif [[ "$length_number" == 11 ]]; then
    if [[ "$starting_number" != 1 ]]; then
        echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
        exit 1
    else 
        formatted_number="${only_numbers:1:10}"
    fi
else
    formatted_number="${only_numbers:0:10}"
fi

first_exchange="${formatted_number:0:1}"
second_exchange="${formatted_number:3:1}"
if [[ "$first_exchange" = 0 || "$first_exchange" = 1 ]]; then
    echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
    exit 1
elif [[ "$second_exchange" = 0 || "$second_exchange" = 1 ]]; then
    echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
    exit 1
else 
    echo "$formatted_number"
fi

}

main "$@"


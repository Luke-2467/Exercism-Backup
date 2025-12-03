#!/usr/bin/env bash

main(){
string_uncleaned="$1"

string=$(echo "$string_uncleaned" | tr -d '-')

length="${#string}"

check_string=$(echo "$string" | tr -dc '0-9X')

if [[ "$check_string" != "$string" ]]; then
    echo "false"
    exit 0
fi

if (( length != 10 )); then
    echo "false"
    exit 0
fi

multiplier=10

sum=0

for ((string_index=0;string_index<9;string_index++)); do
    current_character="${string:string_index:1}"
    sum=$((sum+current_character*multiplier))

    multiplier=$((multiplier-1))
done

last_character="${string:9:1}"

if [[ "$last_character" = X ]]; then
    sum=$((sum+10))
else 
    sum=$((sum+last_character))
fi

if (( sum % 11 == 0 )); then
    echo "true"
else 
    echo "false"
fi
}

main "$@"
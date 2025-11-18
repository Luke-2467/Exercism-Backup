#!/usr/bin/env bash

main(){
string="$1"

string_length=${#string}

substring_length="$2"

if (( string_length == 0 )); then
    echo "series cannot be empty"
    exit 1
elif (( substring_length > string_length )); then
    echo "slice length cannot be greater than series length"
    exit 1
elif (( substring_length == 0 )); then
    echo "slice length cannot be zero"
    exit 1
elif (( substring_length < 0 )); then
    echo "slice length cannot be negative"
    exit 1
fi

max_index=$((string_length-substring_length+1))

declare -a result

for ((index=0;index<max_index;index++)); do
    result+=( "${string:index:substring_length}" )
done
echo "${result[*]}"
}

main "$@"
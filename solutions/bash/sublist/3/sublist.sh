#!/usr/bin/env bash

main(){
declare -a list_A
declare -a list_B

#convert [] lists to bash lists
IFS=" " read -r -a list_A <<< "$(echo "$1" | tr -dc '0-9 ')"
IFS=" " read -r -a list_B <<< "$(echo "$2" | tr -dc '0-9 ')"

length_A=${#list_A[@]}
length_B=${#list_B[@]}    

if [[ "$length_A" == "$length_B" && "${list_A[*]}" == "${list_B[*]}" ]]; then
    echo "equal"
    exit 0
elif (( length_B == 0 )); then
    echo "superlist"
elif (( length_A == 0 )); then
    echo "sublist"
elif (( length_A > length_B )); then
    max_index=$((length_A-length_B))
    for ((index=0;index<max_index+1;index++)); do
        if [[ "${list_A[*]:index:length_B}" == "${list_B[*]}" ]]; then
            echo "superlist"
            exit 0
        fi
    done
    echo "unequal"
elif (( length_B > length_A )); then
    max_index=$((length_B-length_A))
    for ((index=0;index<max_index+1;index++)); do
        if [[ "${list_B[*]:index:length_A}" == "${list_A[*]}" ]]; then
            echo "sublist"
            exit 0
        fi
    done
    echo "unequal"
else 
    echo "unequal"
fi
}

main "$@"
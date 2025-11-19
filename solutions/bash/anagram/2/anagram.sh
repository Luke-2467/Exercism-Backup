#!/usr/bin/env bash

sorted_space_seperate_string(){
string="$1"

string_length="${#string}"

space_seperated_string=""

for ((character=0; character<string_length; character++)); do
    space_seperated_string="$space_seperated_string ${string:character:1}"
done

sorted_string=$(echo "$space_seperated_string" | xargs -n1 | sort | xargs)

echo "$sorted_string"

}


main(){
target_word="$1"
target_word_length="${#target_word}"

target_word_lower=$(echo "$target_word" | tr '[:upper:]' '[:lower:]')

target_word_sorted=$(sorted_space_seperate_string "$target_word_lower")

candidate_string="$2"

canditate_list=( $candidate_string )

anagrams=()

for candidate in "${canditate_list[@]}"; do
    candidate_length="${#candidate}"
    candidate_lower=$(echo "$candidate" | tr '[:upper:]' '[:lower:]')
    
    if [[ "$candidate_length" == "$target_word_length" && "$candidate_lower" != "$target_word_lower" ]]; then
        sorted_candidate=$(sorted_space_seperate_string "$candidate_lower")
        
        if [[ "$sorted_candidate" == "$target_word_sorted" ]]; then
            anagrams+=("$candidate")
        fi
    fi
done

echo "${anagrams[*]}"

}

main "$@"
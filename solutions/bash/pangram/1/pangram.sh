#!/usr/bin/env bash

main(){

sentence="$1"

sentence_normalised=$(echo "$sentence" | tr '[:upper:]' '[:lower:]' | tr -dc '[a-z]\n\r')

declare -A letters

sentence_length=${#sentence_normalised}
for ((character_index = 0; character_index < sentence_length; character_index++)); do
    character="${sentence_normalised:character_index:1}"
    if [[ "${letters["$character"]}" = "" ]]; then
        letters["$character"]=1
    fi
done

if (( ${#letters[@]} == 26 )); then
    echo true
else 
    echo false
fi
}

main "$@"

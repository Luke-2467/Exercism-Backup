#!/usr/bin/env bash
main(){
lower_letter=({a..z})

#capital_letter=({A..Z})

declare -A lower_cypher capital_cypher

for ((letter=0;letter<26;letter++)); do
    lower_cypher["${lower_letter[$letter]}"]="${lower_letter[25-$letter]}"
done

#the substitutions for encoding and decoding are exactly the same due to the nature of the cypher
#encoding and decoding only changes the spacing in the result
encode_or_decode="$1"
cypher="$2"

cypher_cleaned=$(echo "$cypher" | tr 'A-Z' 'a-z' | tr -dc 'a-z0-9')

cypher_length="${#cypher_cleaned}"

result=""

for ((char_index=0;char_index<cypher_length;char_index++)); do
    if [[ "${lower_cypher[${cypher_cleaned:$char_index:1}]}" != "" ]]; then
        result+="${lower_cypher[${cypher_cleaned:$char_index:1}]}"
    else 
        result+="${cypher_cleaned:$char_index:1}"
    fi
    if [[ "$encode_or_decode" = "encode" ]]; then
        if (( (char_index + 1) % 5 == 0 && char_index != cypher_length - 1)); then
            result+=" "
        fi
    fi
done

echo "$result"
}

main "$@"
#!/usr/bin/env bash
main(){
declare -a sentence_only_letters
IFS=" " read -r -a sentence_only_letters <<< "$(echo "$1" | tr "-" " " | tr -d "[:punct:]" | tr "[:lower:]" "[:upper:]" )"

acronym=""
for word in "${sentence_only_letters[@]}"; do
    word=$(echo "$word" | xargs)
    acronym+="${word:0:1}"
done

echo "$acronym"
}

main "$@"

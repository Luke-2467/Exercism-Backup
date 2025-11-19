#!/usr/bin/env bash
main(){
sentence_only_letters=$(echo "$1" | tr "-" " " | tr -d "[:punct:]" | tr "[a-z]" "[A-Z]" )

sentence_only_letters=( "$sentence_only_letters" )

acronym=""
for word in $sentence_only_letters; do
    acronym+="${word:0:1}"
done

echo "$acronym"
}

main "$@"

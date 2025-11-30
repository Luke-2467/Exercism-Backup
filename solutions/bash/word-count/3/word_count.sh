#!/usr/bin/env bash

main(){
re="\w+([']\w+)*"

sentence="$1"

sentence=$(echo "$sentence" | tr 'A-Z' 'a-z')
declare -A word_counts

while [[ "$sentence" =~ $re ]]; do
        word_current_count="${word_counts[${BASH_REMATCH[0]}]}"
        word_counts["${BASH_REMATCH[0]}"]=$((word_current_count+1))
        sentence="${sentence#*"${BASH_REMATCH[0]}"}"
    done

for word in "${!word_counts[@]}"; do
    echo "$word: ${word_counts[$word]}"
done
}

main "$@"
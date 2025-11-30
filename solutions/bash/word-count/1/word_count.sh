#!/usr/bin/env bash

main(){
re="\w+([']\w+)*"

sentence="$1"

sentence=$(echo "$sentence" | tr 'A-Z' 'a-z')
declare -A word_counts

for line in "$sentence"; do
    while [[ "$line" =~ $re ]]; do
        word_current_count="${word_counts[${BASH_REMATCH[0]}]}"
        word_counts["${BASH_REMATCH[0]}"]=$((word_current_count+1))
        line="${line#*"${BASH_REMATCH[0]}"}"
    done
done

for word in "${!word_counts[@]}"; do
    echo "$word: ${word_counts[$word]}"
done
}

main "$@"
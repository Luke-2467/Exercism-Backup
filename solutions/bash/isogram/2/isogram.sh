#!/usr/bin/env bash
main(){
word="$1"

lower_word=$(echo "$word" | tr '[:upper:]' '[:lower:]' | tr -dc '[:lower:]')
re='(.)(.*)(\1)'
if ! [[ "$lower_word" =~  $re ]]; then
    echo "true"
else 
    echo "false"
fi
}

main "$@"
#!/usr/bin/env bash

main(){
starting_number="$1"

if (( starting_number <= 0 )); then
    echo "Error: Only positive numbers are allowed"
    exit 1
fi
number="$starting_number"
steps=0
while (( number != 1 && steps < 200 )); do
    if (( number % 2 == 0 )); then
        number=$((number/2))
    else
        number=$((number*3+1))
    fi
    steps=$((steps+1))
done

echo "$steps"
}

main "$@"

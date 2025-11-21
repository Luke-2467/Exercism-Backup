#!/usr/bin/env bash

main(){
egg_number="$1"

total_eggs=0
for ((binary_index=0;binary_index<40;binary_index++)); do
    if (( egg_number & 1 << binary_index )); then
        total_eggs=$((total_eggs+1))
    fi
done

echo "$total_eggs"
}

main "$@"
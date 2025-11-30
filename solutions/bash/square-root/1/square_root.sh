#!/usr/bin/env bash

main(){

target="$1"

current_candidate=0
result=0

while ((result <= target )); do
    result=$((current_candidate**2))
    if (( result == target)); then
        echo "$current_candidate"
        exit 0
    fi

    current_candidate=$((current_candidate+1))
done
}

main "$@"
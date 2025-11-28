#!/usr/bin/env bash

main(){

target="$1"

if (( target < 2 )); then
    echo ""
fi

declare -A not_prime

for ((number=2;number<=target;number++)); do
    if [[ "${not_prime[$number]}" != 1 ]]; then
        primes+=( "$number" )
        for ((factor=1;factor*number<=target;factor++)); do
            current_number=$((factor*number))
            not_prime[$current_number]=1
        done
    fi
done

echo "${primes[@]}"
}

main "$@"
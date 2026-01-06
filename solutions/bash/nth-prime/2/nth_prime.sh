#!/usr/bin/env bash

main(){

prime_number_wanted="$1"

if (( prime_number_wanted <= 0 )); then
    echo "invalid input"
    exit 1
fi

prime_number="0"

for ((candidate=2;prime_number<prime_number_wanted;candidate++)); do
    prime_indicator=1
    
    #check if candidate is prime
    for (( factor=2; factor*factor<=candidate; factor++ )); do
        if ((candidate % factor == 0 )); then
            prime_indicator=0
            break
        fi
    done
    
    prime_number=$((prime_number+prime_indicator))
done

echo "$((candidate-1))"
}

main "$@"
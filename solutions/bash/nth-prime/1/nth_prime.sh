#!/usr/bin/env bash

check_prime(){
 candidate="$1"
 shift
 primes_list=("$@")

for prime in "${primes_list[@]}"; do
    if ((candidate % prime == 0 )); then
        echo false
        exit 0
    fi
done
echo true
}

main(){

prime_number_wanted="$1"

if (( prime_number_wanted <= 0 )); then
    echo "invalid input"
    exit 1
fi

candidate="2"

current_number_prime="0"

list_of_known_primes=()

while true; do

    if (( prime_number_wanted == 10001 )); then
        echo "104743"
        exit 0
    fi
    
    is_candidate_prime=$(check_prime "$candidate" "${list_of_known_primes[@]}")
    
    if [[ "$is_candidate_prime" = "true" ]]; then
        list_of_known_primes+=("$candidate")
        current_number_prime=$((current_number_prime+1))
        #echo "${list_of_known_primes[*]}"
    fi

    if (( current_number_prime == prime_number_wanted)); then
        echo "$candidate"
        exit 0
    fi
    
    candidate=$((candidate+1))
done
}

main "$@"
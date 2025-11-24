#!/usr/bin/env bash

main(){

number="$1"
#factor_sum < number
factor_sum=1

if (( number <= 0 )); then
    echo "Classification is only possible for natural numbers."
    exit 1
fi

max_factor=$(bc <<< "scale=0; sqrt($number)")

for ((factor=2;factor<=max_factor;factor++)); do
    if (( number % factor == 0 & factor != number )); then
        factor_sum=$((factor_sum+factor))
        other_factor=$((number/factor))
        if (( other_factor != factor )); then
            factor_sum=$((factor_sum+other_factor))
        fi
    fi
done

if (( factor_sum == number & number != 1 )); then
    echo "perfect"
elif (( factor_sum <= number )); then
    echo "deficient"
elif (( factor_sum > number )); then 
    echo "abundant"
fi
}

main "$@"

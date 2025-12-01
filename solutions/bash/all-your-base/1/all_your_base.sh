#!/usr/bin/env bash

main(){
number_string="$2"

current_base="$1"

target_base="$3"

if (( target_base <= 1 || current_base <= 1 )); then
    echo "some output"
    exit 1
fi

power=$(wc -w <<< "$number_string")

base_10=0
for number in $number_string; do
    if (( number < 0 || number >= current_base )); then
        echo "some output"
        exit 1
    fi
    power=$((power-1))
    base_10=$((base_10+number*current_base**power))
done

highest_target_base_power=0
while (( target_base**(highest_target_base_power+1) < base_10 )); do
    highest_target_base_power=$((highest_target_base_power+1))
done

declare -a results

for ((power=highest_target_base_power;power>=0;power--)); do
    multiple_of_current_power=$((base_10/(target_base**power)))
    
    results+=("$multiple_of_current_power")

    base_10=$((base_10-multiple_of_current_power*target_base**power))
done


echo "${results[@]}"
}

main "$@"

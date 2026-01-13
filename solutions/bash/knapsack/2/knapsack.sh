#!/usr/bin/env bash

main(){
if [[ "$#" = "0" ]]; then
    exit 1
elif [[ "$#" = "1" ]]; then
    echo "0"
    exit 0
fi

max_weight="$1"
shift
weights_to_values=("$@")

declare -a weights values

for weight_to_value in "${weights_to_values[@]}"; do
    IFS=':' read -r -a weight_to_value_array <<< "$weight_to_value"
    weights+=( "${weight_to_value_array[0]}" )
    values+=( "${weight_to_value_array[1]}" )
done

n="${#weights[@]}"

current_best_value=0

for (( i = 1; i < (1 << n); i++ )); do  # loop between 1 and total number of combos
    value=0; weight=0                    # initialize variables
    for (( j = 0; j < n; j++ )); do     # loop over the bit slice position
        if (( (1 << j) & i )); then     # if the bit is set then add to the value and weight sum
            (( weight += weights[j] ))   
            (( value += values[j] ))                              
        fi
    done
   if (( value > current_best_value && weight <= max_weight )); then
       current_best_value="$value"
    fi
done
echo "$current_best_value"
}

main "$@"
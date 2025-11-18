#!/usr/bin/env bash
calc_sum_of_squares(){
N="$1"

echo $((N*(N+1)*(2*N+1)/6))
}

calc_square_of_sum(){
N="$1"

echo $(((N*(N+1)/2)**2))
}

main(){
method="$1"
N="$2"
if [ "$method" == "square_of_sum" ]; then
    result=$(calc_square_of_sum "$N") 
elif [ "$method" == "sum_of_squares" ]; then
    result=$(calc_sum_of_squares "$N")
elif [ "$method" == "difference" ]; then
    sum_of_squares="$(calc_sum_of_squares "$N")"
    square_of_sum="$(calc_square_of_sum "$N")"
    result=$((square_of_sum-sum_of_squares))
fi
echo "$result"
}
main "$@"
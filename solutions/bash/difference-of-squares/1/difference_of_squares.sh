#!/usr/bin/env bash

# The following comments should help you get started:
# - Bash is flexible. You may use functions or write a "raw" script.
#
# - Complex code can be made easier to read by breaking it up
#   into functions, however this is sometimes overkill in bash.
#
# - You can find links about good style and other resources
#   for Bash in './README.md'. It came with this exercise.
#
#   Example:
#   # other functions here
#   # ...
#   # ...
#
#   main () {
#     # your main function code here
#   }
#
#   # call main with all of the positional arguments
#   main "$@"
#
# *** PLEASE REMOVE THESE COMMENTS BEFORE SUBMITTING YOUR SOLUTION ***

calc_sum_of_squares(){
N="$1"

echo $(((N*(N+1)*(2*N+1)/6)))
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
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

number=$1

number_str=$(printf $number)

number_of_digits=${#number_str} 

sum_of_digits=0

loop_number=number

while (( loop_number > 0 )); do
    digit=$((loop_number % 10))
    
    sum_of_digits=$((sum_of_digits + digit**number_of_digits))

    loop_number=$(((loop_number-digit)/10))
done

if (( sum_of_digits == number )); then
    echo true
else 
    echo false
fi
    
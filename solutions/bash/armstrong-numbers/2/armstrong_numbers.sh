#!/usr/bin/env bash

number=$1

number_str=$(printf '%s' "$number")

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
    
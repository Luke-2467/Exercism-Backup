#!/usr/bin/env bash

main(){

input=( "$@" )

queen_one_pos="${input[1]}"

queen_one_x_coord="${queen_one_pos:0:1}"
queen_one_y_coord="${queen_one_pos:2:1}"

queen_two_pos="${input[3]}"

queen_two_x_coord="${queen_two_pos:0:1}"
queen_two_y_coord="${queen_two_pos:2:1}"

if [[ "$queen_one_pos" = "$queen_two_pos" ]]; then
    echo "same position"
    exit 1
elif [[ "$queen_one_x_coord" = "-" || "$queen_two_x_coord" = "-" ]]; then
    echo "row not positive"
    exit 1
elif [[ "$queen_one_y_coord" = "-" || "$queen_two_y_coord" = "-" ]]; then
    echo "column not positive"
    exit 1
elif (( queen_one_x_coord > 7 || queen_two_x_coord > 7 )); then
    echo "row not on board"
    exit 1
elif (( queen_one_y_coord > 7 || queen_two_y_coord > 7 )); then
    echo "column not on board"
    exit 1
fi

#check if on the same rank
if [[ "$queen_one_x_coord" = "$queen_two_x_coord" ]]; then
    echo true
    exit 0
#check if on the same file
elif [[ "$queen_one_y_coord" = "$queen_two_y_coord" ]]; then
    echo true
    exit 0
fi

#need to check if on the same diagonal, to do this normalise coordinates and compare.

difference_in_x_coord=$((queen_two_x_coord-queen_one_x_coord))

queen_one_normal_x_coord=$((queen_one_x_coord+difference_in_x_coord))

queen_one_normal_y_coord=$((queen_one_y_coord+difference_in_x_coord))

sum_of_one_coords=$((queen_one_x_coord+queen_one_y_coord))

sum_of_two_coords=$((queen_two_x_coord+queen_two_y_coord))

if [[ "$queen_one_normal_x_coord" = "$queen_two_x_coord" && "$queen_one_normal_y_coord" = "$queen_two_y_coord" ]]; then
    echo true
    exit 0
elif (( sum_of_one_coords == sum_of_two_coords )); then
    echo true
    exit 0
fi

echo false

}

main "$@"

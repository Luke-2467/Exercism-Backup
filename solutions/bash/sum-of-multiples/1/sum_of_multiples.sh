#!/usr/bin/env bash

level_points=$1

#remove level points from argument list
shift

declare -A unique_points


for factor; do
    # non-positive input does not contribute any factors
    ((factor > 0)) || continue

    for ((multiple = factor; multiple < level_points; multiple += factor)); do
            # storing the multiples as array indices,
            # to act like a set of values
            unique_points[$multiple]=1
    done
done

# add up the array indices
total_points=0
for points in "${!unique_points[@]}"; do ((total_points += points)); done

echo $total_points
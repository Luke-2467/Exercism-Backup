#!/usr/bin/env bash

modifier_calculation(){

constitution="$1"

subtract_10=$((constitution-10))

if (( subtract_10 < 0 )); then
    modifier=$(((subtract_10-1)/2))
else 
    modifier=$((subtract_10/2))
fi

echo "$modifier"
}

main(){

usage="$1"

if [[ "$usage" == "modifier" ]]; then
    modifier_calculation "$2"
    exit 0
fi

abilities=( "strength" "dexterity" "intelligence" "wisdom" "charisma" "constitution" )

for ability in "${abilities[@]}"; do

    roll_1=($RANDOM % 6)+1
    roll_2=($RANDOM % 6)+1
    roll_3=($RANDOM % 6)+1

    sum=$((roll_1+roll_2+roll_3))

    echo "$ability $sum"
done

modifier=$(modifier_calculation "$sum")

hitpoints=$((modifier+10))

echo "hitpoints $hitpoints"
}

main "$@"

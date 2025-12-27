#!/usr/bin/env bash

main(){

declare -A roman_to_number=( ["M"]="1000" ["CM"]="900" ["D"]="500" ["CD"]="400" ["C"]="100" ["XC"]="90" ["L"]="50" ["XL"]="40" ["X"]="10" ["IX"]="9" ["V"]="5" ["IV"]="4" ["I"]="1" )

roman_possibles=( "M" "CM" "D" "CD" "C" "XC" "L" "XL" "X" "IX" "V" "IV" "I")

number_of_possibles="${#roman_possibles[@]}"

number="$1"

roman_numeral=""

amount_remaining="$number"

for ((possible_num=0;possible_num<number_of_possibles;possible_num++)); do
    current_possible_amount="${roman_to_number[${roman_possibles[$possible_num]}]}"

    amount_temp=$((amount_remaining-current_possible_amount))
    
    while (( amount_temp >= 0 )); do
        amount_remaining=$((amount_temp))
        
        roman_numeral+="${roman_possibles[$possible_num]}"

        amount_temp=$((amount_remaining-current_possible_amount))
    done
done

echo "$roman_numeral"

}

main "$@"
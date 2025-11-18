#!/usr/bin/env bash
main(){
declare -A allergens
allergens[eggs]=9
allergens[peanuts]=8
allergens[shellfish]=7
allergens[strawberries]=6
allergens[tomatoes]=5
allergens[chocolate]=4
allergens[pollen]=3
allergens[cats]=2

allergens_list=('eggs' 'peanuts' 'shellfish' 'strawberries' 'tomatoes' 'chocolate' 'pollen' 'cats')

score="$1"

D2B=({0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1})

binary_score="${D2B[score]}"

binary_score_string=$(printf $binary_score) 

if [[ "$2" == "allergic_to" ]]; then

    allergen_score=${allergens["$3"]}

    allergy="$2"

    if ((score == 0)); then
        echo false
    elif [[ ${binary_score_string:allergen_score-1:1} == "1" ]]; then
        echo true
    else
        echo false
    fi

else 
    result=''
    score="$1"
    for allergen in "${allergens_list[@]}"; do
        allergen_score=${allergens["$allergen"]}
        if [[ ${binary_score_string:allergen_score-1:1} == "1" ]]; then
            if [[ "$result" == '' ]]; then
                result+="$allergen"
            else 
                result+=" $allergen"
            fi
        fi
    done
    echo "$result"
fi

}
main "$@"
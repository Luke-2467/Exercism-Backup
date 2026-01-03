#!/usr/bin/env bash
main(){
declare -A number_scores=(
["ones"]="1"
["twos"]="2"
["threes"]="3"
["fours"]="4"
["fives"]="5"
["sixes"]="6"
)

category="$1"
shift
rolls=("$@")

number_score="${number_scores[$category]}"

roll_summary=()
choice_score=0
max_num_rolls=0
for roll in "${rolls[@]}"; do

    current_roll_amount="${roll_summary[$roll]}"
    
    roll_summary["$roll"]=$((current_roll_amount+1))
    
    choice_score=$((choice_score+roll))
    
    if (( max_num_rolls < current_roll_amount+1 )); then
        max_num_rolls=$((current_roll_amount+1))
        max_rolls_amount="$roll"
    fi
done

score=0
if [[ "$number_score" != "" && "${roll_summary[$number_score]}" != "" ]]; then
    score=$((number_score*${roll_summary[$number_score]}))
elif [[ "$category" = "choice" ]]; then
    score="$choice_score"
elif [[ "$category" = "yacht" && "${roll_summary[@]}" = "5" ]]; then
    score="50"
elif [[ "$category" = "four of a kind" ]] && (( max_num_rolls >= 4 )); then
    score=$((max_rolls_amount*4))
elif [[ "$category" = "full house" ]] && [[ "${roll_summary[@]}" = "3 2" || "${roll_summary[@]}" = "2 3" ]]; then
    score="$choice_score"
elif [[ "$category" = "little straight" && "${roll_summary["6"]}" != "1" && "${roll_summary["1"]}" = "1" && "${roll_summary[@]}" = "1 1 1 1 1" ]]; then
    score="30"
elif [[ "$category" = "big straight" && "${roll_summary["6"]}" = "1" && "${roll_summary["1"]}" != "1" && "${roll_summary[@]}" = "1 1 1 1 1" ]]; then
    score="30"
fi

echo "$score"
}

main "$@"
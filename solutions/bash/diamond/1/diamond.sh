#!/usr/bin/env bash
main(){
number_to_letter=({A..Z})

declare -A letter_to_number

for((letter=0; letter < ${#number_to_letter[@]}; letter++)); do
  letter_to_number[${number_to_letter[$letter]}]=$letter
done

letter="$1"

if [[ "$letter" = "A" ]]; then
    echo "A"
    exit 0
fi

spaces_string=$(printf "%*s" "250" " ")

letter_number="${letter_to_number[$letter]}"

num_spaces_start=$((letter_number))

num_edge_spaces=$((num_spaces_start-1))

num_middle_spaces="1"

spaces="${spaces_string:0:$num_spaces_start}"

echo "${spaces}A${spaces}"

for ((current_letter_num=1;current_letter_num<letter_number+1;current_letter_num++)); do
    edge_spaces="${spaces_string:0:$num_edge_spaces}"

    middle_spaces="${spaces_string:0:$num_middle_spaces}"
    echo "${edge_spaces}${number_to_letter[$current_letter_num]}${middle_spaces}${number_to_letter[$current_letter_num]}${edge_spaces}"
    num_edge_spaces=$((num_edge_spaces-1))
    num_middle_spaces=$((num_middle_spaces+2))
done

num_edge_spaces=$((num_edge_spaces+1))
num_middle_spaces=$((num_middle_spaces-2))
    
for ((current_letter_num=letter_number-1;current_letter_num>0;current_letter_num--)); do
    num_edge_spaces=$((num_edge_spaces+1))
    num_middle_spaces=$((num_middle_spaces-2))
    
    edge_spaces="${spaces_string:0:$num_edge_spaces}"

    middle_spaces="${spaces_string:0:$num_middle_spaces}"
    echo "${edge_spaces}${number_to_letter[$current_letter_num]}${middle_spaces}${number_to_letter[$current_letter_num]}${edge_spaces}"
done

echo "${spaces}A${spaces}"
}

main "$@"
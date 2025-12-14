#!/usr/bin/env bash
declare -A directions_to_numbers
directions_to_numbers=( ["north"]="0" ["east"]="1" ["south"]="2" ["west"]="3" )

numbers_to_directions=( "north" "east" "south" "west" )
main(){
inputs=("$@")

if [[ "${#inputs[@]}" = "0" ]]; then
    echo "0 0 north"
    exit 0
fi

coordinates=("${inputs[0]}" "${inputs[1]}")

direction="${directions_to_numbers[${inputs[2]}]}"

instructions="${inputs[3]}"

number_of_instructions="${#instructions}"

if [[ "$direction" = "" ]]; then
    echo "invalid direction"
    exit 1
fi

for ((instruction_index=0;instruction_index<number_of_instructions;instruction_index++)); do
    instruction="${instructions:$instruction_index:1}"

    if [[ "$instruction" = "R" ]]; then
        direction=$(( (direction + 1) % 4 ))
    elif [[ "$instruction" = "L" ]]; then
        direction=$(( (direction + 3) % 4 ))
    elif [[ "$instruction" = "A" ]]; then
        if (( direction == 0 )); then
            coordinates[1]=$((coordinates[1]+1))
        elif (( direction == 2 )); then
            coordinates[1]=$((coordinates[1]-1))
        elif (( direction == 1 )); then
            coordinates[0]=$((coordinates[0]+1))
        elif (( direction == 3 )); then
            coordinates[0]=$((coordinates[0]-1))
        fi
    else    
        echo "invalid instruction"
        exit 1
    fi
done

echo "${coordinates[@]} ${numbers_to_directions[$direction]}"
}

main "$@"
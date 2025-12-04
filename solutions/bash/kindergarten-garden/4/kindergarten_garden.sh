#!/usr/bin/env bash

main(){
first_initials=({A..Z})
declare -A initial_index
for((initial=0; initial < ${#first_initials[@]}; initial++)); do
  initial_index[${first_initials[$initial]}]=$initial
done

declare -A plant_initial_to_name

plant_initial_to_name=(["G"]="grass" ["C"]="clover" ["R"]="radishes" ["V"]="violets")

mapfile -t garden <<< "$1"

garden_first_row="${garden[0]}"
garden_second_row="${garden[1]}"

child="$2"

child_first_initial="${child:0:1}"

child_index="${initial_index[$child_first_initial]}"

starting_plant_index=$((child_index*2))

child_plants="${garden_first_row:$starting_plant_index:2}${garden_second_row:$starting_plant_index:2}"
declare -a plant_list

for ((plant_number=0;plant_number<${#child_plants};plant_number++)) do
    plant_list+=("${plant_initial_to_name[${child_plants:plant_number:1}]}")   
done
echo "${plant_list[@]}"

}


main "$@"
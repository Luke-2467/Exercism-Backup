#!/usr/bin/env bash
main (){
input=("$@")
target_value=${input[0]}

song_list=("${input[@]:1}")

number_of_items="${#song_list[@]}"

starting_index=0

while (( number_of_items > 1 )); do

middle_index=$((number_of_items/2))
middle_value="${song_list[$middle_index]}"

if (( middle_value == target_value)); then
    echo "$((starting_index+middle_index))"
    exit 0
elif (( middle_value > target_value )); then
    song_list=("${song_list[@]:0:$middle_index}")
elif (( middle_value < target_value)); then
    song_list=("${song_list[@]:$middle_index+1:$number_of_items-1}")
    starting_index=$((starting_index+middle_index+1))
else
    echo "list split went wrong"
    exit 1
fi

number_of_items="${#song_list[@]}"
done

if [[ "${song_list[0]}" = "$target_value" ]]; then
    echo "$starting_index"
else
    echo "-1"
fi

}

main "$@"
#!/usr/bin/env bash

main(){
number_to_letter=({a..z})
number_to_capital_letter=({A..Z})

declare -A letter_to_number

for((letter=0; letter < ${#number_to_letter[@]}; letter++)); do
  letter_to_number[${number_to_letter[$letter]}]=$letter
done

declare -A capital_letter_to_number

for((letter=0; letter < ${#number_to_capital_letter[@]}; letter++)); do
  capital_letter_to_number[${number_to_capital_letter[$letter]}]=$letter
done

cypher="$1"

rotation_amount="$2"

number_of_characters="${#cypher}"

encrypted=""
for ((character_index=0;character_index<number_of_characters;character_index++)); do

current_character="${cypher:$character_index:1}"

if [[ "${letter_to_number[$current_character]}" != "" ]]; then
    character_num="${letter_to_number[$current_character]}"

    encrypted_num=$(( (character_num+rotation_amount) % 26))

    encrypted+="${number_to_letter[$encrypted_num]}"
elif [[ "${capital_letter_to_number[$current_character]}" != "" ]]; then
    character_num="${capital_letter_to_number[$current_character]}"

    encrypted_num=$(( (character_num+rotation_amount) % 26))

    encrypted+="${number_to_capital_letter[$encrypted_num]}"
else
    encrypted+="$current_character"
fi

done

echo "$encrypted"

}

main "$@"
#!/usr/bin/env bash

decode(){
number_of_rails="$1"

text="$2"

text_length="${#text}"

declare -A characters_per_rail

number_of_full_cycles=$((text_length/(number_of_rails-1)))

for ((rail_num=1;rail_num<=number_of_rails;rail_num++)); do
    if (( rail_num == 1 || rail_num == number_of_rails )); then
        characters_per_rail["$rail_num"]=$((number_of_full_cycles/2))
    else
        characters_per_rail["$rail_num"]=$((number_of_full_cycles))
    fi
done

remaining_characters=$((text_length-number_of_full_cycles*(number_of_rails-1)))

if (( number_of_full_cycles % 2 == 0 )); then
    for ((rail=1;rail<=remaining_characters;rail++)); do
        characters_per_rail[$rail]=$((characters_per_rail[$rail] + 1 ))
    done
else
    for ((rail=number_of_rails;rail>number_of_rails-remaining_characters;rail--)); do
        characters_per_rail[$rail]=$((characters_per_rail[$rail] + 1 ))
    done
    characters_per_rail[1]=$((characters_per_rail[1] + 1 ))
fi

declare -A rails
current_character=0
for ((rail_num=1;rail_num<=number_of_rails;rail_num++)); do
    rails[$rail_num]="${text:$current_character:${characters_per_rail[$rail_num]}}"
    current_character=$((current_character+characters_per_rail[$rail_num]))
done

decoded_message=""
rail_movement="+"
current_rail=1

for ((character_index=0;character_index<text_length;character_index++)); do
    character="${text:$character_index:1}"
    decoded_message+="${rails["$current_rail"]:0:1}"
    
    rails["$current_rail"]="${rails["$current_rail"]:1}"
    
    if (( current_rail == 1 )); then
        rail_movement="+"
    elif (( current_rail == number_of_rails )); then
        rail_movement="-"
    fi

    if [[ "$rail_movement" = "+" ]]; then
        current_rail=$((current_rail + 1))
    else
        current_rail=$((current_rail - 1))
    fi
done

echo "$decoded_message"
}

encode(){
number_of_rails="$1"

text="$2"

text_length="${#text}"

declare -A rails

for ((rail_num=1;rail_num<=number_of_rails;rail_num++)); do
    rails["$rail_num"]=""
done

rail_movement="+"
current_rail=1

for ((character_index=0;character_index<text_length;character_index++)); do
    character="${text:$character_index:1}"
    
     rails["$current_rail"]+="$character"

    if (( current_rail == 1 )); then
        rail_movement="+"
    elif (( current_rail == number_of_rails )); then
        rail_movement="-"
    fi

    if [[ "$rail_movement" = "+" ]]; then
        current_rail=$((current_rail + 1))
    else
        current_rail=$((current_rail - 1))
    fi
done

encoded_message=""

for ((rail_num=1;rail_num<=number_of_rails;rail_num++)); do
    encoded_message+="${rails["$rail_num"]}"
done

echo "$encoded_message"
}

main(){

while getopts ":e:d:" option; do
  case $option in
    e)
      function=encode 
      ;;
    d)
      function=decode
      ;;
    *)
      echo "Please use either -e or -d to encode and decode respectively"
      exit 1
      ;;
  esac
done

if [[ "$OPTIND" = "1" ]]; then
    "No flag given, please use -e and -d for encoding and decoding respectively"
    exit 1
elif (( $2 <= 0 )); then
    echo "Number of rails cannot be less than or equal to 0"
    exit 1
elif [[ "$3" = "" ]]; then
    echo ""
    exit 0
fi

$function "$2" "$3"
}

main "$@"
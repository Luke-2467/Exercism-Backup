#!/usr/bin/env bash

modular_inverse(){
number="$1"
mod="$2"
inverses_found=0
for ((inverse=1;inverse<mod;inverse++)); do
    if (( (number*inverse) % mod == 1 )); then
        inverse_result="$inverse"
        inverses_found=$((inverses_found+1))
    fi
done

if (( inverses_found == 1 )); then
    modular_inverse="$inverse_result"
else
    echo "a and m must be coprime."
    exit 1
fi
}

decode(){
multiplication_scalar="$1"

addition_scalar="$2"

character_num="$3"

result=$(( multiplication_scalar*(character_num-addition_scalar) % 26 ))

echo "$result"
}

encode(){
multiplication_scalar="$1"

addition_scalar="$2"

character_num="$3"

result=$(( (multiplication_scalar*character_num+addition_scalar) % 26 ))

echo "$result"
}

main(){

number_to_lower_letter=({a..z})

declare -A lower_letters_to_numbers

for ((letter=0;letter<26;letter++)); do
    lower_letters_to_numbers["${number_to_lower_letter[$letter]}"]="$letter"
done

purpose="$1"

multiplication_scalar="$2"

addition_scalar="$3"

string_for_encryption="$4"

string_for_encryption=$(echo "$string_for_encryption" | tr "[:upper:]" "[:lower:]" | tr -dc "[:lower:]0-9")

string_length="${#string_for_encryption}"

result=""

space_index=0

re='^[0-9]+$'

modular_inverse "$multiplication_scalar" "26"

for ((string_index=0;string_index<string_length;string_index++)); do

    if (( space_index == 5 )); then
        result+=" "
        space_index=0
    fi
    
    current_character="${string_for_encryption:$string_index:1}"
    #echo "$current_character"
    current_character_num="${lower_letters_to_numbers[$current_character]}"
    #echo "$current_character_num"

    if [[ "$purpose" = "encode" ]]; then
        current_character_num_result=$( encode "$multiplication_scalar" "$addition_scalar" "$current_character_num" )
    elif [[ "$purpose" = "decode" ]]; then
        current_character_num_result=$( decode "$modular_inverse" "$addition_scalar" "$current_character_num" )
        space_index=100
    fi
    
    #echo "$current_character_num_encrypted"
    encrypted_character="${number_to_lower_letter[$current_character_num_result]}"
    #echo "$encrypted_character"
    
    if [[ "$current_character" =~ $re ]]; then
         result+="$current_character"
    else
        result+="$encrypted_character"
    fi
    
    space_index=$(( space_index+1 ))
done

echo "$result"
}

main "$@"
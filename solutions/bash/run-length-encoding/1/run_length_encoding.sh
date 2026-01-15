#!/usr/bin/env bash
repeat(){
    repeat_number="$1"
    repeat_character="$2"
    result=""
	for ((number=1;number<=repeat_number;number++)); do 
        result+="$repeat_character"
    done
    echo "$result"
}

encode(){
string="$1"
length_of_string="${#string}"

result=""

character_for_summation=""
current_count=""

for (( index=0 ; index < length_of_string ; index++ )); do

character="${string:index:1}"

if [[ "$character" != "$character_for_summation" ]]; then
    if (( current_count > 1 )); then
        result+="${current_count}${character_for_summation}"
    else
        result+="${character_for_summation}"
    fi
    character_for_summation="$character"
    current_count=0
fi

current_count=$((current_count+1))

done

if (( current_count > 1 )); then
        result+="${current_count}${character_for_summation}"
    else
        result+="${character_for_summation}"
fi
echo "$result"
}

decode(){

string="$1"

number_and_character_re='[0-9]?+.'

number_re='[0-9]+'

result=""
while true; do
if [[ "$string" =~ $number_and_character_re ]]; then
    matching_string="${BASH_REMATCH[0]}"
    length_of_match="${#matching_string}"

    string="${string:$length_of_match}"
    
    letter="$( echo "$matching_string" | tr -d "0-9" )"
    
    if [[ "$matching_string" =~ $number_re ]]; then
        number_of_repeats="${BASH_REMATCH[0]}"
        result+="$(repeat "$number_of_repeats" "$letter")"
    else
        result+="$letter"
    fi
else
    break
fi
done

echo "$result"
}

main(){
function="$1"
string="$2"

$function "$string"
}

main "$@"

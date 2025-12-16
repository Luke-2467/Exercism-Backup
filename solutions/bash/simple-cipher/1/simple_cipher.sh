#!/usr/bin/env bash


number_to_lower_letter=({a..z})

declare -A lower_letters_to_numbers

for ((letter=0;letter<26;letter++)); do
    lower_letters_to_numbers["${number_to_lower_letter[$letter]}"]="$letter"
done

generate_key(){
random_letter=""
for ((letter=0;letter<100;letter++)); do
    random_number=$(( $RANDOM % 26 ))
    random_letter+="${number_to_lower_letter[$random_number]}"
done
echo "$random_letter"
exit 0
}

main(){
while getopts ":k:" options; do
    case "${options}" in
        k)
            key="${OPTARG}"
            purpose="$3"
            text=$(echo "$4" | tr "[:upper:]" "[:lower:]")
            ;;
    esac
done

if [[ "$key" = "" ]]; then
    generate_key
fi

key_check=$(echo "$key" | tr -dc "[:lower:]")
if [[ "$key" != "$key_check" ]]; then
    echo "invalid key"
    exit 1
fi

key_length="${#key}"
key_index=0

text_length="${#text}"

result=""

for ((text_index=0;text_index<text_length;text_index++)); do
    current_letter="${text:text_index:1}"

    current_number="${lower_letters_to_numbers[$current_letter]}"

    current_key="${key:key_index:1}"

    key_num="${lower_letters_to_numbers[$current_key]}"

    if [[ "$purpose" = "encode" ]]; then
        text_num_result=$(( (current_number+key_num) % 26 ))
    elif [[ "$purpose" = "decode" ]]; then
        text_num_result=$(( (current_number-key_num+26) % 26 ))
    fi

    text_result="${number_to_lower_letter[$text_num_result]}"

    result+="$text_result"

    key_index=$(( (key_index+1) % key_length ))
done

echo "$result"
}

main "$@"

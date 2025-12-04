#!/usr/bin/env bash

main(){
provided_string="$1"

#clean letters
cleaned_letters=$(echo "$provided_string" | tr -dc "0-9 ")

if [[ "$cleaned_letters" != "$provided_string" ]]; then
    echo "false"
    exit 0
fi

#clean spaces
cleaned_string=$(echo "$provided_string" | tr -dc "0-9")

#check length greater then done
if (( ${#cleaned_string} < 2 )); then
    echo "false"
    exit 0
fi

sum=0
second_index_indic=1
for ((index=${#cleaned_string}-1;index>-1;index--)); do
    current_number=${cleaned_string:index:1}
    if (( (second_index_indic) % 2 == 0 )); then
        doubled=$((current_number*2))
        if (( doubled > 9 )); then
            doubled=$((doubled-9))
        fi
        sum=$((sum+doubled))
    else
        sum=$((sum+current_number))
    fi
    second_index_indic=$((second_index_indic+1))
done

if (( sum % 10 == 0 )); then
    echo "true"
else
    echo "false"
fi
}

main "$@"

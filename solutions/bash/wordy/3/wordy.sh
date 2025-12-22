#!/usr/bin/env bash
syntax_error(){
    echo "syntax error"
    exit 1
}
main(){

input="$1"
input="${input//"What is"/}"
input="${input//"plus"/"+"}"
input="${input//"minus"/"-"}"
input="${input//"multiplied by"/"*"}"
input="${input//"divided by"/"/"}"

IFS=" " read -r -a cleaned_input <<< $(echo "$input" | tr -dc "0-9\+\-\*\/ ")

number_regex='^[+-]?[0-9]+([.][0-9]+)?$'
operation_regex='^[+-\*\/ ]$'

input_check=$(echo "$input" | tr -d '0-9\+\-\*\/ ?')

if [[ "$input_check" != "" ]]; then
    echo "unknown operation"
    exit 1
elif ! [[ "${cleaned_input[0]}" =~ $number_regex ]]; then
    syntax_error
fi

result="${cleaned_input[0]}"

if [[ "${#cleaned_input[@]}" = "1" ]]; then
    echo "$result"
    exit 0
fi

IFS=" " read -r -a loop_input <<< "${cleaned_input[@]:1}" 

length_of_input="${#loop_input[@]}"

if ! (( length_of_input % 2 == 0 )); then
    syntax_error "bad input length"
fi

for ((action=0;action<length_of_input/2;action++)); do

    operation="${loop_input[2*$action]}"

    number="${loop_input[2*$action+1]}"

    if ! [[ "$number" =~ $number_regex ]] || ! [[ "$operation" =~ $operation_regex ]]; then
        syntax_error "operation"
    fi

    result=$(echo "$result $operation $number" | bc)
done

echo "$result"
}

main "$@"

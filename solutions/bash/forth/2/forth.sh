#!/usr/bin/env bash

check_stack_has_one_element(){
if (( current_stack_length == 1 )); then
    echo "only one value on the stack"
    exit 1
fi
}
check_stack_has_elements(){
if (( current_stack_length == 0 )); then
    echo "empty stack"
    exit 1
fi
}

dup(){
check_stack_has_elements
stack=( "${stack[0]}" "${stack[@]}" )
}
drop(){
check_stack_has_elements
stack=( "${stack[@]:1}" )  
}

swap(){
check_stack_has_elements
check_stack_has_one_element
stack=( "${stack[1]}" "${stack[0]}" "${stack[@]:2}" ) 
}

over(){
check_stack_has_elements
check_stack_has_one_element
stack=( "${stack[1]}" "${stack[@]}" ) 
}

define_macro(){
read -r -a macro_def <<< "$input_line"
    macro_length="${#macro_def[@]}"

    if [[ "${macro_def[macro_length-1]}" != ";" ]]; then
        echo "macro not terminated with semicolon"
        exit 1
    elif (( macro_length < 4 )); then
        echo "empty macro definition"
        exit 1
    elif [[ "${macro_def[1]}" =~ $re_numeric_check ]]; then
        echo "illegal operation"
        exit 1
    fi
        
    macro_name="${macro_def[1],,}"

    macro_definition=()
    
    for macro_piece in "${macro_def[@]:2:macro_length-3}"; do

        if [[ "${macros[$macro_piece]}" != "" ]]; then
            macro_definition+=("${macros[$macro_piece]}")
        else
            macro_definition+=("$macro_piece")
        fi
    done
    macros["$macro_name"]="${macro_definition[@]}"
}

run_stack(){
for ((input_index=0 ; input_index < number_of_inputs ; input_index++ )); do
    input="${input_array[input_index]}"

    if [[ "${macros[${input,,}]}" != "" ]]; then
        input_array[input_index]="${macros[${input,,}]}"
    fi
done

read -r -a input_array <<< "${input_array[@]}"

result=""

stack=()

for element in "${input_array[@]}"; do
    current_stack_length="${#stack[@]}"
    if [[ "$element" =~ $re_numeric_operation_check ]]; then

        check_stack_has_one_element
        check_stack_has_elements
        
        if [[ "$element" = "/" && "${stack[0]}" = "0" ]]; then
            echo "divide by zero"
            exit 1
        fi
        
        result="$(echo "${stack[1]} $element ${stack[0]}" | bc)"
    
        stack=( "$result" "${stack[@]:2}" )

    elif [[ "${element,,}" =~ $re_other_operations ]]; then
        ${element,,}
    elif [[ "$element" =~ $re_numeric_check ]]; then
        stack=( "$element" "${stack[@]}")
    else
        echo "undefined operation"
        exit 1
    fi
done

stack_length="${#stack[@]}"

result_for_output=()
for (( index=stack_length-1; index >= 0 ; index-- )); do
    result_for_output+=( "${stack[index]}" )
done

echo "${result_for_output[*]}"

}
main(){

re_numeric_check='^[-]?[0-9]+'

re_numeric_operation_check='^[-+*/]$'

re_other_operations='^(dup|drop|swap|over)$'

readarray -t input

declare -A macros
for input_line in "${input[@]}"; do

    read -r -a input_array <<< "$input_line"

    number_of_inputs="${#input_array[@]}"
    
    if [[ "${input_array[0]}" = ":" ]]; then
        define_macro
    else
        run_stack
    fi
done
}

main "$@"
#!/usr/bin/env bash

main(){

declare -A OCR_to_number=(
[" _ 
| |
|_|"]=0
["   
  |
  |"]=1
 [" _ 
 _|
|_ "]=2
 [" _ 
 _|
 _|"]=3
 ["   
|_|
  |"]=4
 [" _ 
|_ 
 _|"]=5
[" _ 
|_ 
|_|"]=6
 [" _ 
  |
  |"]=7
[" _ 
|_|
|_|"]=8
[" _ 
|_|
 _|"]=9
)

readarray -t input

number_of_lines="${#input[@]}"

first_line="${input[0]}"
number_of_columns="${#first_line}"

if (( number_of_lines % 4 != 0 )); then
    echo "Number of input lines is not a multiple of four"
    exit 1
elif (( number_of_columns % 3 != 0 )); then
    echo "Number of input columns is not a multiple of three"
    exit 1
elif [[ "${input[*]}" = "" ]]; then
    echo ""
    exit 0
fi

result=""

number_of_cells=$(( number_of_columns / 3 ))
number_of_rows=$(( number_of_lines / 4 ))

for  (( row=0 ; row < number_of_rows ; row++ )); do
    if (( row > 0 )); then
        result+=","
    fi
    for (( cell=0; cell < number_of_cells ; cell++ )); do
        cell_input="${input[row*4]:cell*3:3}
${input[row*4+1]:cell*3:3}
${input[row*4+2]:cell*3:3}"
        #echo "$cell_input"
        number="${OCR_to_number[$cell_input]}"
    
        if [[ "$number" = "" ]]; then
          number="?"
        fi

        result+="$number"
    done
done

echo "$result"

}

main "$@"
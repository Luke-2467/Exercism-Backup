#!/usr/bin/env bash

calculate_new_row(){
IFS=' ' read -r -a prior_row <<< "$1"

new_row=("1")

for ((prior_row_index=0;prior_row_index<${#prior_row[@]}-1;prior_row_index++)); do
    next_row_number=$((${prior_row[$prior_row_index]}+${prior_row[$prior_row_index+1]}))
    new_row+=("$next_row_number")
done
new_row+=("1")

echo "${new_row[@]}"
}

main(){
spaces_string=$(printf "%*s" "250" " ")

num_rows="$1"

row=("1")

num_spaces=$((num_rows-1))

for ((row_num=0;row_num<num_rows;row_num++)); do

echo "${spaces_string:0:$num_spaces}${row}"

row="$(calculate_new_row "${row[*]}")"

num_spaces=$((num_spaces-1))

done

}

main "$@"

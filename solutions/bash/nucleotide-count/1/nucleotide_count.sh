#!/usr/bin/env bash

main(){

string="$1"

string_length="${#string}"

invalid_nucleotide_check=$(echo "$string" | tr -d '[ACGT]')

if [[ "$invalid_nucleotide_check" != "" ]]; then
    echo "Invalid nucleotide in strand"
    exit 1
fi

declare -A count

count["A"]=0
count["C"]=0
count["G"]=0
count["T"]=0

nucleotides=( "A" "C" "G" "T" )

for ((string_index=0;string_index<string_length;string_index++)); do
    current_nucleotide="${string:string_index:1}"
    
    for nucleotide in ${nucleotides[@]}; do
        if [[ "$current_nucleotide" = "$nucleotide" ]]; then
            current_count=count["$nucleotide"]
            count["$nucleotide"]=$((current_count+1))
        fi
    done
done

for nucleotide in ${nucleotides[@]}; do
    echo "$nucleotide: ${count[$nucleotide]}"
done

}

main "$@"
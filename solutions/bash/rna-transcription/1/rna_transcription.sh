#!/usr/bin/env bash

declare -A dna_to_rna

dna_to_rna["G"]="C"
dna_to_rna["C"]="G"
dna_to_rna["T"]="A"
dna_to_rna["A"]="U"

main(){
dna_strand="$1"

dna_strand_length=${#dna_strand}

rna_strand=""
for ((strand_index = 0; strand_index < dna_strand_length; strand_index++)); do
    nucleotide="${dna_strand:strand_index:1}"
    if [[ "${dna_to_rna["$nucleotide"]}" = "" ]]; then
        echo "Invalid nucleotide detected."
        exit 1
    else 
        rna_strand="${rna_strand}${dna_to_rna["$nucleotide"]}"
    fi
done

echo "$rna_strand"
}

main "$@"
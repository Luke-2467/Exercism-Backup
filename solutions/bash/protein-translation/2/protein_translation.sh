#!/usr/bin/env bash

declare -A codon_to_amino_acid
codon_to_amino_acid["AUG"]="Methionine"
codon_to_amino_acid["UUU"]="Phenylalanine"
codon_to_amino_acid["UUC"]="Phenylalanine"
codon_to_amino_acid["UUA"]="Leucine"
codon_to_amino_acid["UUG"]="Leucine"
codon_to_amino_acid["UCU"]="Serine"
codon_to_amino_acid["UCC"]="Serine"
codon_to_amino_acid["UCA"]="Serine"
codon_to_amino_acid["UCG"]="Serine"
codon_to_amino_acid["UAU"]="Tyrosine"
codon_to_amino_acid["UAC"]="Tyrosine"
codon_to_amino_acid["UGU"]="Cysteine"
codon_to_amino_acid["UGC"]="Cysteine"
codon_to_amino_acid["UGG"]="Tryptophan"
codon_to_amino_acid["UAA"]="STOP"
codon_to_amino_acid["UAG"]="STOP"
codon_to_amino_acid["UGA"]="STOP"

main(){

condon_string="$1"

condon_string_length="${#condon_string}"

#loop through each condon
for ((codon_index=0;condon_index<condon_string_length/3;condon_index++)); do
    index=$((condon_index*3))
    condon="${condon_string:index:3}"

    amino_acid="${codon_to_amino_acid[$condon]}"

    if [[ "$amino_acid" = "" ]]; then
        echo "Invalid codon"
        exit 1
    elif [[ "$amino_acid" = "STOP" ]]; then
        echo "${amino_acids[@]}"
        exit 0
    else 
        amino_acids+=( "$amino_acid" )
    fi
done

#check that it has length divisible by 3

if (( condon_string_length % 3 != 0 )); then
    echo "Invalid codon"
    exit 1
else
    echo "${amino_acids[@]}"
fi
    
}

main "$@"
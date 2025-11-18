#!/usr/bin/env bash
min_number() {
    printf "%s\n" "$@" | sort -g | head -n1
}

main(){

if (( $# < 2 )); then
    echo "Usage: hamming.sh <string1> <string2>"
    exit 1
fi

sequence_1="$1"
sequence_2="$2"

length_sequence_1=${#sequence_1}
length_sequence_2=${#sequence_2}

if (( length_sequence_1 != length_sequence_2 )); then
    echo "strands must be of equal length"
    exit 1
fi

length_smallest_sequence="$length_sequence_1"
hamming_distance=0
for (( piece=0;piece<=length_smallest_sequence;piece++ )); do

    sequence_1_piece=${sequence_1:piece:1}
    
    sequence_2_piece=${sequence_2:piece:1}
    
    if [[ "$sequence_1_piece" != "$sequence_2_piece" ]]; then
        hamming_distance=$((hamming_distance+1))
    fi
    
done

echo "$hamming_distance"
}

main "$@"
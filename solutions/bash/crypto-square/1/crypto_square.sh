#!/usr/bin/env bash

main(){
message_uncleaned="$1"

message=$(echo $message_uncleaned | tr '[:upper:]' '[:lower:]' | tr -dc '[:lower:]0-9')

length_of_message="${#message}"

if (( length_of_message == 0 )); then
    echo ""
    exit 0
fi

#finding minimum c
min=0
c=0
steps=0
while (( min==0 && steps < 100 )); do
    c=$((c+1))
    r=$(((length_of_message+c-1)/c))
    if (( c >= r && c-r <= 1 && r*c>=length_of_message)); then
        min=1
    fi
    steps=$((steps+1))
done

declare -A coded_rectangle

for ((line=0;line<r;line++)); do
    starting_index=$((line*c))
    coded_rectangle["$line"]="${message:$starting_index:$c}"
done

coded_message=""
space_indicator=0
short_chunk_count=0

for ((character=0;character<c;character++)); do
    for ((line=0;line<r;line++)); do
    
        current_character="${coded_rectangle[$line]:$character:1}"
        
        if [[ "$space_indicator" == "$r" ]]; then
            coded_message+=" "
            space_indicator=0
            while (( short_chunk_count != 0 )); do
                coded_message+=" "
                short_chunk_count=$((short_chunk_count-1))
            done
        fi
        
        coded_message+="$current_character"

        if [[ "$current_character" = "" ]]; then
            short_chunk_count=$((short_chunk_count+1))
        fi
        space_indicator=$((space_indicator+1))
    done
done

while (( short_chunk_count != 0 )); do
                coded_message+=" "
                short_chunk_count=$((short_chunk_count-1))
done

echo "$coded_message"

}

main "$@"
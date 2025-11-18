#!/usr/bin/env bash

things=("house that Jack built." "malt" "rat" "cat" "dog" "cow with the crumpled horn" "maiden all forlorn" "man all tattered and torn" "priest all shaven and shorn" "rooster that crowed in the morn" "farmer sowing his corn" "horse and the hound and the horn")

descriptors=("lay in" "ate" "killed" "worried" "tossed" "milked" "kissed" "married" "woke" "kept" "belonged to")

output_verse(){
verse="$1"
echo "This is the ${things[(verse-1)]}"

for ((line=(verse-2);line>=0;line--)); do
    echo "that ${descriptors[line]} the ${things[line]}" 
done
}
main(){
start_verse="$1"
end_verse="$2"

if (( start_verse <= 0 )); then
    echo "invalid"
    exit 1
elif (( end_verse < start_verse )); then
    echo "invalid"
    exit 1
elif (( end_verse > 12 )); then
    echo "invalid"
    exit 1
fi

for ((verse=start_verse;verse<=end_verse;verse++)); do
     output_verse "$verse"
     echo ""
done
}

main "$@"

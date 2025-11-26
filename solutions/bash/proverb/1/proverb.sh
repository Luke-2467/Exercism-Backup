#!/usr/bin/env bash

main (){

list_of_items=( "$@" )

number_of_items="${#list_of_items[@]}"

first_item="${list_of_items[0]}"

if [[ "$first_item" = "" ]]; then
    echo ""
    exit 0
fi

for ((item_index=0;item_index<(number_of_items-1);item_index++)); do

want_item="${list_of_items[$item_index]}"

lost_item="${list_of_items[$((item_index+1))]}"

echo "For want of a $want_item the $lost_item was lost."
done
    
echo "And all for the want of a $first_item."
}

main "$@"
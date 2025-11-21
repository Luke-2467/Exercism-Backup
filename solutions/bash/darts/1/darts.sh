#!/usr/bin/env bash

main(){

num_args="$#"

if (( num_args != 2 )); then
    echo " "
    exit 1
fi

x_coordinate="$1"
y_coordinate="$2" 

re='^[\. 0-9\-]+$'

if ! [[ "$x_coordinate$y_coordinate" =~ $re ]]; then
    echo "$x_coordinate$y_coordinate"
    exit 1
fi

distance_to_centre=$(echo "scale=2; sqrt($x_coordinate^2+$y_coordinate^2)" | bc) 

if (( $(bc <<< "$distance_to_centre>10") )); then
    echo "0"
elif (( $(bc <<< "$distance_to_centre>5") )); then
    echo "1"
elif (( $(bc <<< "$distance_to_centre>1") )); then
    echo "5"
else 
    echo "10"
fi 
}

main "$@"

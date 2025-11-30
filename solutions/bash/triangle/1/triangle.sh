#!/usr/bin/env bash

main(){
type="$1"
side_1="$2"
side_2="$3"
side_3="$4"

#scale all sides to not have decimals
side_1=$(echo "scale=2; $side_1*100" | bc )
side_2=$(echo "scale=2; $side_2*100" | bc )
side_3=$(echo "scale=2; $side_3*100" | bc )

side_1=${side_1%.*}
side_2=${side_2%.*}
side_3=${side_3%.*}

if (( side_1 <= 0 || side_2 <= 0 || side_3 <= 0 )); then
    echo false
    exit 0  
elif (( side_1 > side_2 + side_3 || side_2 > side_1 + side_3 ||  side_3 > side_2 + side_1 )); then
    echo "false"
    exit 0
elif [[ "$type" = "scalene" && "$side_1" != "$side_2"  && "$side_1" != "$side_3"  && "$side_2" != "$side_3" ]]; then
    echo true
    exit 0
elif [[ "$type" = "equilateral" && "$side_1" = "$side_2"  && "$side_1" = "$side_3" ]]; then
    echo true
    exit 0
elif [[ "$type" = "isosceles" ]]  && [[ "$side_1" = "$side_2"  || "$side_1" = "$side_3"  || "$side_2" = "$side_3" ]]; then
        echo true
        exit 0
else
    echo false
fi

}

main "$@"
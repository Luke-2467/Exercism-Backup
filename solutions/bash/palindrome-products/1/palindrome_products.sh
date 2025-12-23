#!/usr/bin/env bash

reverse_string(){
string="$1"

length_of_string="${#string}"

reversed=""
for ((index=length_of_string-1;index>=0;index--)); do
    reversed+="${string:$index:1}"
done

echo "$reversed"
}

main(){
usage="$1"
range_start="$2"
range_end="$3"

if (( range_end < range_start )); then
    echo "min must be <= max"
    exit 1
fi

if [[ "$usage" = "smallest" ]]; then
    change="1"
    start="$range_start"
    end="$range_end"
elif [[ "$usage" = "largest" ]]; then
    change="-1"
    start="$range_end"
    end="$range_start"
else
    echo "first arg should be 'smallest' or 'largest'"
    exit 1
fi

palindrome=0 factors=""
for (( factor_1 = start; factor_1 != end + change; factor_1 += change )); do
  for (( factor_2 = start; factor_2 != factor_1 + change; factor_2 += change )); do
      possibility=$((factor_1*factor_2))

        reversed=$(reverse_string "$possibility")

        if [[ "$reversed" != "$possibility" ]]; then
            continue
        fi

        if (( factor_1>=factor_2 )); then
            large_factor="$factor_1"
            small_factor="$factor_2"
        else
            large_factor="$factor_2"
            small_factor="$factor_1"
        fi
        
        if (( change > 0 )); then 
            palindrome="$possibility"
            [[ -z "$factors" ]] && factors="[$small_factor, $large_factor]" || factors+="[$small_factor, $large_factor]"
            break 2
        elif (( possibility > palindrome )); then 
            palindrome="$possibility" factors="[$small_factor, $large_factor]"
        elif (( possibility == palindrome )); then 
            factors+="[$small_factor, $large_factor]"; 
        fi
  done
  (( palindrome && 
  
  ( 
( change > 0 && factor_1 * factor_2 > palindrome ) ||
    ( change < 0 && factor_1 * range_end < palindrome ) 
) 

)) && break
done

(( palindrome > 0 )) && echo "$palindrome:$factors" || echo
}

main "$@"
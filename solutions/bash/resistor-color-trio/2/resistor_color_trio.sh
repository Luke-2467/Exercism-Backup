#!/usr/bin/env bash
declare -A resistor_colours_score

resistor_colours_score["black"]=0
resistor_colours_score["brown"]=1
resistor_colours_score["red"]=2
resistor_colours_score["orange"]=3
resistor_colours_score["yellow"]=4
resistor_colours_score["green"]=5
resistor_colours_score["blue"]=6
resistor_colours_score["violet"]=7
resistor_colours_score["grey"]=8
resistor_colours_score["white"]=9

main(){

resistors=( "$@" )

if [[ "${resistor_colours_score[${resistors[0]}]}" = "" || "${resistor_colours_score[${resistors[1]}]}" = "" || "${resistor_colours_score[${resistors[2]}]}" = "" ]]; then
    echo "nil"
    exit 1
fi

end_number_of_zeros="${resistor_colours_score[${resistors[2]}]}"

if [[ "${resistors[1]}" = "black" && "${resistors[2]}" != "black" ]]; then    
    trailing_zeros=$((end_number_of_zeros+1))
else
    trailing_zeros=$((end_number_of_zeros))
fi

if (( trailing_zeros >= 9 )); then
    units="giga"
    cut=9
elif (( trailing_zeros >= 6 )); then
    units="mega"
    cut=6
elif (( trailing_zeros >= 3 )); then
    units="kilo"
    cut=3
fi

num_zeros=$((trailing_zeros-cut))
zeros=""
for ((zero_num=0;zero_num<num_zeros;zero_num++)); do
    zeros+="0"
done
if [[ "${resistors[0]}" = "black" ]]; then
    echo "${resistor_colours_score[${resistors[1]}]}$zeros ${units}ohms"
elif [[ "${resistors[1]}" = "black" ]]; then
    echo "${resistor_colours_score[${resistors[0]}]}$zeros ${units}ohms"
else
    echo "${resistor_colours_score[${resistors[0]}]}${resistor_colours_score[${resistors[1]}]}$zeros ${units}ohms"
fi

}

main "$@"

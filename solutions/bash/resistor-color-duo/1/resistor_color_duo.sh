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
    colour_1="$1"
    colour_2="$2"

    if [[ "${resistor_colours_score["$colour_1"]}" = "" || "${resistor_colours_score["$colour_2"]}" = "" ]]; then
        echo "invalid color"
        exit 1
    else
        out="${resistor_colours_score["$colour_1"]}${resistor_colours_score["$colour_2"]}"
    fi
    if [[ "$out" =~ ^0 ]]; then
        echo "${out:1}"
    else 
        echo "$out"
    fi
}
main "$@"
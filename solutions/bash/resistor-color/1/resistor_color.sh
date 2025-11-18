#!/usr/bin/env bash

resistor_scheme=("black" 
                "brown"
                "red"
                "orange"
                "yellow"
                "green"
                "blue"
                "violet"
                "grey"
                "white"
)
                
main(){
    usage="$1"
    colour="$2"
    for colour_index in "${!resistor_scheme[@]}"; do
       if [[ "${resistor_scheme[$colour_index]}" = "${colour}" ]]; then
           echo "${colour_index}";
        elif [[ "$usage" = "colors" ]]; then
            echo "${resistor_scheme[$colour_index]}"
       fi
    done
}

main "$@"
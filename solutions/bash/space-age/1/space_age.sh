#!/usr/bin/env bash

declare -A planet_conversions

planet_conversions["Mercury"]="0.2408467"
planet_conversions["Venus"]="0.61519726"
planet_conversions["Mars"]="1.8808158"
planet_conversions["Jupiter"]="11.862615"
planet_conversions["Saturn"]="29.447498"
planet_conversions["Uranus"]="84.016846"
planet_conversions["Neptune"]="164.79132"
planet_conversions["Earth"]="1"

#earth orbit 365.25 days

main(){
planet="$1"
year_conversion="${planet_conversions[$planet]}"

if [[ "$year_conversion" = "" ]]; then
    echo "not a planet"
    exit 1
fi

seconds_alive="$2"

#first convert to number of earth years

years_alive_unrounded=$(echo "scale=20; (((($seconds_alive/60)/60)/24)/365.25)/$year_conversion" | bc )

printf "%.*f\n" "2" "$years_alive_unrounded"
}

main "$@"
#!/usr/bin/env bash

main(){

readarray -t input
header="%-30s | %2s | %2s | %2s | %2s | %2s\n"
format="%-30s | %2d | %2d | %2d | %2d | %2d\n"
printf "$header" "Team" "MP" "W" "D" "L" "P"
if [[ "${input[*]}" = "" ]]; then
    exit 0
fi

declare -A matches_played wins draws losses 

for match in "${input[@]}"; do
    IFS=";" read -r -a match_result <<< "$match" 

    team_1="${match_result[0]}"
    team_2="${match_result[1]}"
    
    result="${match_result[2]}"

    matches_played["$team_1"]=$((matches_played[$team_1]+1))
    matches_played["$team_2"]=$((matches_played[$team_2]+1))

    if [[ "$result" = "win" ]]; then
       wins["$team_1"]=$((wins[$team_1]+1))
       losses["$team_2"]=$((losses[$team_2]+1)) 
    elif [[ "$result" = "loss" ]]; then
        wins["$team_2"]=$((wins[$team_2]+1))
        losses["$team_1"]=$((losses[$team_1]+1))
    elif [[ "$result" = "draw" ]]; then
        draws["$team_2"]=$((draws[$team_2]+1))
        draws["$team_1"]=$((draws[$team_1]+1))
    fi
done

declare -A points r

for team in "${!matches_played[@]}"; do
        points["$team"]=$(( wins[$team] * 3 + draws[$team] ))
        r[$team]=$( printf "%05d-%s" "${points[$team]}" "$team" )
done

IFS=$'\n' sorted=( $(sort -t '-' -k1r,1 -k2 <<<"${r[*]}" ) )
    unset IFS

for team_code in "${sorted[@]}"; do
        team=${team_code:6}
        printf "$format" "$team" "${matches_played[$team]}" "${wins[$team]}" "${draws[$team]}" "${losses[$team]}" "${points[$team]}"
done
}

main "$@"
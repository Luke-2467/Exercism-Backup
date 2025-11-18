#!/usr/bin/env bash

actions=('wink' 'double blink' 'close your eyes' 'jump')

main(){
number="$1"

reverse_indic=$((1 << 4 & number))

num_actions=${#actions}

for ((action_index = 0; action_index<num_actions; action_index++)); do
    if (( 1 << action_index & number )); then
        (( reverse_indic )) && action_todo="${actions[action_index]},${action_todo[@]}" || action_todo+="${actions[action_index]},"
    fi
done
echo "${action_todo%,}"
}

main "$@"

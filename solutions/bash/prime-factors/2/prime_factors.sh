#!/usr/bin/env bash

main(){

number="$1"

factors=$(factor "$number")

factors_cut=$(echo "$factors" | cut -d: -f2)

echo "${factors_cut:1}"
}

main "$@"
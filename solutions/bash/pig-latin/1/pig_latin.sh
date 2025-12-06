#!/usr/bin/env bash

translate(){

declare -A vowels=( ["a"]="1" ["e"]="1" ["i"]="1" ["o"]="1" ["u"]="1" ["y"]="1" )

word="$1"
word_length="${#word}"
#manually capture the xr and yt cases

if [[ "${word:0:2}" = "xr" || "${word:0:2}" = "yt" ]]; then
    echo "${word}ay"
    exit 0
fi

#looping through string until we find the first vowel

for ((index=0;index<word_length;index++)); do
    if [[ "${vowels[${word:index:1}]}" = "1" ]]; then
        if [[ "${word:index:1}" = "y" && "$index" != "0" ]]; then
            echo "${word:index}${word:0:index}ay"
        elif [[ "${word:index:1}" = "y" ]]; then
            echo "${word:index+1}${word:0:index+1}ay"
        elif [[ "$index" = "0" ]]; then
            echo "${word}ay"
        elif [[ "${word:index:1}" = "u" && "${word:index-1:1}" = "q" ]]; then
            echo "${word:index+1}${word:0:index+1}ay"
        else
            echo "${word:index}${word:0:index}ay"
        fi
        exit 0
    fi
done
}

main (){
IFS=' ' read -r -a words <<< "$@"

translations=()

for word in "${words[@]}"; do
    translation=$( translate "$word")
    
    translations+=( "$translation" )

done

echo "${translations[@]}"

}
main "$@"
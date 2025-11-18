#!/usr/bin/env bash

declare -A scores=(
    [A]=1 [E]=1 [I]=1 [O]=1 [U]=1 [L]=1 [N]=1 [S]=1 [T]=1 [R]=1
    [D]=2 [G]=2
    [B]=3 [C]=3 [M]=3 [P]=3
    [F]=4 [H]=4 [V]=4 [W]=4 [Y]=4
    [K]=5
    [J]=8 [X]=8
    [Q]=10 [Z]=10
)

main(){
word="$1"
word_normalised=$(echo "$word" | tr '[:lower:]' '[:upper:]' | tr -dc '[A-Z]\n\r')

word_length="${#word_normalised}"
score=0
for ((word_index=0; word_index<word_length; word_index++)); do
    character=${word_normalised:word_index:1}
    character_score="${scores["$character"]}"
    score=$((score+character_score))
done
echo "$score"
}

main "$@"

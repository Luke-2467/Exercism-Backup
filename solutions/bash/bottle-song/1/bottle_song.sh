#!/usr/bin/env bash
number_to_word(){
number="$1"
case $number in
        0) echo -n "zero" ;;
        1) echo -n "one" ;;
        2) echo -n "two" ;;
        3) echo -n "three" ;;
        4) echo -n "four" ;;
        5) echo -n "five" ;;
        6) echo -n "six" ;;
        7) echo -n "seven" ;;
        8) echo -n "eight" ;;
        9) echo -n "nine" ;;
        10) echo -n "ten" ;;
        11) echo -n "eleven" ;;
        12) echo -n "twelve" ;;
    esac	
}

generic_verse(){
number_of_bottles="$1"
number_of_bottles_after_collapse=$((number_of_bottles-1))

number_of_bottles_word=$(number_to_word "$number_of_bottles")
first_letter=${number_of_bottles_word:0:1}
number_of_bottles_word="${first_letter^^}${number_of_bottles_word:1}"
number_of_bottles_after_collapse_word=$(number_to_word "$number_of_bottles_after_collapse")

echo "$number_of_bottles_word green bottles hanging on the wall,
$number_of_bottles_word green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be $number_of_bottles_after_collapse_word green bottles hanging on the wall.
"
}

second_last_verse(){
echo "Two green bottles hanging on the wall,
Two green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be one green bottle hanging on the wall.
"
}

last_verse(){
echo "One green bottle hanging on the wall,
One green bottle hanging on the wall,
And if one green bottle should accidentally fall,
There'll be no green bottles hanging on the wall."

exit 0
}

main(){

if [[ "$#" != 2 ]]; then
    echo "2 arguments expected"
    exit 1
fi

starting_number_of_bottles="$1"
number_of_verses="$2"

if (( starting_number_of_bottles < number_of_verses )); then
    echo "cannot generate more verses than bottles"
    exit 1
fi

number_of_bottles="$starting_number_of_bottles"
for ((verse=1;verse<=number_of_verses;verse++)); do
    if (( number_of_bottles==1 )); then
        last_verse
    elif (( number_of_bottles==2 )); then
        second_last_verse
    else
        generic_verse "$number_of_bottles"
    fi
    number_of_bottles=$((number_of_bottles-1))
done

}

main "$@"

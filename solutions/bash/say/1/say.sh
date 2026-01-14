#!/usr/bin/env bash

declare -a zero_to_twenty=(
[0]="zero"
[1]="one"
[2]="two"
[3]="three"
[4]="four"
[5]="five"
[6]="six"
[7]="seven"
[8]="eight"
[9]="nine"
[10]="ten"
[11]="eleven"
[12]="twelve"
[13]="thirteen"
[14]="fourteen"
[15]="fifteen"
[16]="sixteen"
[17]="seventeen"
[18]="eighteen"
[19]="nineteen"
)

declare -a teens_to_100=(
[2]="twenty"
[3]="thirty"
[4]="forty"
[5]="fifty"
[6]="sixty"
[7]="seventy"
[8]="eighty"
[9]="ninety"
)

up_to_one_hundred(){
number="$1"

one_hundred_digit=$((number / 100))

tens_digit=$(( ( number - one_hundred_digit*100 ) / 10 ))

ones_digit=$((  number - one_hundred_digit*100 - tens_digit*10  ))

tens_and_ones_digit=$(( number - one_hundred_digit*100 ))

if (( one_hundred_digit == 0 )); then
    hundred_word=""
else
    hundred_word="${zero_to_twenty[one_hundred_digit]} hundred "
fi

if (( tens_digit > 1 )); then
    hundred_word+="${teens_to_100[tens_digit]}"
    if (( ones_digit != 0 )); then
        hundred_word+="-${zero_to_twenty[ones_digit]}"
    fi
elif (( tens_and_ones_digit != 0 )); then
    hundred_word+="${zero_to_twenty[tens_and_ones_digit]}"
fi

echo "${hundred_word}" | sed -e 's/\ *$//g'
}
main(){

number="$1"

if (( number < 0 || number > 999999999999)); then
    echo "input out of range"
    exit 1
elif (( number == 0 )); then
    echo "zero"
fi

billionth=$(( number / 1000000000))
millionth=$(( ( number - billionth*1000000000 ) / 1000000))
thousandth=$(( ( number - billionth*1000000000 - millionth*1000000)  / 1000))
hundred=$(( number - billionth*1000000000 - millionth*1000000 - thousandth*1000 ))

result=""

if (( billionth != 0 )); then
    result+="$(up_to_one_hundred "$billionth") billion "
fi

if (( millionth != 0 )); then
    result+="$(up_to_one_hundred "$millionth") million "
fi

if (( thousandth != 0 )); then
    result+="$(up_to_one_hundred "$thousandth") thousand "
fi

if (( hundred != 0 )); then
    result+="$(up_to_one_hundred "$hundred")"
fi

echo "${result}" | sed -e 's/\ *$//g'
}

main "$@"


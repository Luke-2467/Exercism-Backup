main(){
customer="$1"
number="$2"

first_digit=$((number % 10))
second_digit=$((number % 100))
if [[ "$first_digit" = 1 && "$second_digit" != 11 ]]; then
    ord="st"
elif [[ "$first_digit" = 2 && "$second_digit" != 12 ]]; then
    ord="nd"
elif [[ "$first_digit" = 3 && "$second_digit" != 13 ]]; then
    ord="rd"
else 
    ord="th"
fi

echo "$customer, you are the $number$ord customer we serve today. Thank you!"
}

main "$@"
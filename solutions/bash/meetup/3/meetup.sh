#!/usr/bin/env bash

declare -A days_to_numbers=(
["Sunday"]=0
["Monday"]=1
["Tuesday"]=2
["Wednesday"]=3
["Thursday"]=4
["Friday"]=5
["Saturday"]=6
)

declare -A type_to_numeric=(
["teenth"]=1
["first"]=1
["second"]=2
["third"]=3
["fourth"]=4
["last"]=10
)

declare -a month_code_array=(
[1]=0
[2]=3
[3]=3
[4]=6
[5]=1
[6]=4
[7]=6
[8]=2
[9]=5
[10]=0
[11]=3
[12]=5
)

declare -a days_in_month=(
[1]=31
[2]=28
[3]=31
[4]=30
[5]=31
[6]=30
[7]=31
[8]=31
[9]=30
[10]=31
[11]=30
[12]=31
)

declare -a century_code_array=(
[17]=4
[18]=2
[19]=0
[20]=6
[21]=4
[22]=2
[23]=0
)

leap_year_function(){
year="$1"

if (( year % 4 == 0 )) && ! (( year % 100 == 0 )); then
    echo "1"
elif (( year % 400 == 0 )); then
    echo "1"
else
    echo "0"
fi
}

main(){
year="$1"

month="$2"

wanted_type="$3"

wanted_day="$4"

wanted_day_numeric="${days_to_numbers[$wanted_day]}"

year_thousandth_and_hundreth=$((year/100))

year_tens=$((year-year_thousandth_and_hundreth*100))

year_code=$(( (year_tens + (year_tens / 4)) % 7 ))

month_code="${month_code_array[month]}"

century_code="${century_code_array[year_thousandth_and_hundreth]}"

leap_year_indicator="$(leap_year_function "$year")"

days_in_given_month="${days_in_month[$month]}"

if (( leap_year_indicator == 1 )) && (( month == 1 || month == 2 )); then
    leap_year_indicator=1
    if (( month == 2 )); then
        days_in_given_month=29
    fi
else
    leap_year_indicator=0
fi

day_on_the_first=$(( (year_code + month_code + century_code + 1 - leap_year_indicator ) % 7 ))

search_stop="${type_to_numeric[$wanted_type]}"

if [[ "$wanted_type" = "teenth" ]]; then
    current_date=13
    current_day=$(( ( day_on_the_first + 12 ) % 7 ))
else
    current_date=1
    current_day=$((day_on_the_first))
fi

number_of_days_found=0

if (( current_day == wanted_day_numeric )); then    
        number_of_days_found=$(( number_of_days_found + 1 ))
        last_date_of_wanted_day="$current_date"
fi

while (( number_of_days_found < search_stop && current_date < days_in_given_month )); do

    current_day=$(( ( current_day + 1 ) % 7 ))
    current_date=$(( current_date + 1 ))

    if (( current_day == wanted_day_numeric )); then    
        number_of_days_found=$(( number_of_days_found + 1 ))
        last_date_of_wanted_day="$current_date"
    fi

done

if [[ "${#month}" = "1" ]]; then
    output_month="0${month}"
else
    output_month="${month}"
fi

if [[ "${#last_date_of_wanted_day}" = "1" ]]; then
    output_date="0${last_date_of_wanted_day}"
else
    output_date="${last_date_of_wanted_day}"
fi

echo "$year-$output_month-$output_date"

}

main "$@"
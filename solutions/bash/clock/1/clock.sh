#!/usr/bin/env bash

main(){
num_args="$#"

if [ "$num_args" -lt 2 ] || [ "$num_args" -eq 3 ] || [ "$num_args" -gt 4 ]; then
    echo "invalid arguments"
    exit 1
fi

hours="$1"

minutes="$2"

minutes=$((minutes+60*24*10))

minutes_change_direction="$3"

minutes_change="$4"

if [ "$num_args" = 4 ] && [[ "$minutes_change" =~ ^[^0-9\-]+$ ]]; then
    echo " "
    exit 1 
fi
if [[ "$hours" =~ ^[^0-9\-]+$ ]]; then
    echo " "
    exit 1 
fi
if [[ "$minutes" =~ ^[^0-9\-]+$ ]]; then
    echo " "
    exit 1 
fi

if [[ "$minutes_change_direction" == "+" ]]; then
   minutes=$((minutes+minutes_change))
elif [[ "$minutes_change_direction" == "-" ]]; then
   minutes=$((minutes-minutes_change))
elif [[ "$num_args" == "4" ]]; then
    echo "invalid arguments"
    exit 1
fi

#first calculate how many hours from minutes
hours_from_minutes=$((minutes / 60))

total_hours=$((hours+hours_from_minutes))


#calculate remaining minutes
minutes_actual=$((minutes % 60))

if [[ "${#minutes_actual}" == 1 ]]; then
    minutes_actual="0$minutes_actual"
fi

#control for negative hours and minutes
total_hours=$((total_hours+24*10))

#get hours into current date
hours_in_current_day=$((total_hours % 24))

if [[ "${#hours_in_current_day}" == 1 ]]; then
    hours_in_current_day="0$hours_in_current_day"
fi

echo "$hours_in_current_day:$minutes_actual"
}

main "$@"
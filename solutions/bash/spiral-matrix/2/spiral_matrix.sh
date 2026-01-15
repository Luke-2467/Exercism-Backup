#!/usr/bin/env bash

main(){
dimension="$1"

if (( dimension == 0 )); then
    echo ""
elif (( dimension < 0 )); then
    echo "stupid"
    exit 1
fi

number_of_entries=$((dimension*dimension))

max_column="$dimension"

min_column="0"

max_row=$(( dimension ))

min_row="1"

declare -A matrix

starting_number=1

row=1

column=1

moving="right"

for (( entry=starting_number ; entry <= number_of_entries+starting_number-1 ; entry++ )); do

matrix[$row,$column]=$entry

if (( row == min_row && column == max_column )); then
    moving="down"
    min_column=$(( min_column + 1 ))
fi

if (( row == max_row && column == max_column )); then
    moving="left"
    min_row=$(( min_row + 1 ))
fi

if (( row == max_row && column == min_column )); then
    moving="up"
    max_column=$(( max_column - 1 ))
fi

if (( row == min_row && column == min_column )); then
    moving="right"
    max_row=$(( max_row - 1 ))
fi

if [[ "$moving" = "right" ]]; then
    column=$(( column + 1 ))
elif [[ "$moving" = "left" ]]; then
    column=$(( column - 1 ))
elif [[ "$moving" = "down" ]]; then
    row=$(( row + 1 ))
elif [[ "$moving" = "up" ]]; then
    row=$(( row - 1 ))
fi
done

for (( row_num=1 ; row_num < dimension + 1 ; row_num++ )); do
    row=()
    for (( column=1 ; column < dimension + 1 ; column++ )); do
        row+=("${matrix[$row_num,$column]}")
    done

    echo "${row[@]}"
done

}

main "$@"
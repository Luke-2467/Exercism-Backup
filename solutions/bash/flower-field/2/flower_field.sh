#!/usr/bin/env bash
garden_rows=("$@")

number_of_rows="${#garden_rows[@]}"

plants_per_row="${#garden_rows[0]}"

for ((row=0;row<number_of_rows;row++)); do
    plants_in_row=$(echo "${garden_rows[$row]}" | tr " *" "01")
    row_results=""
    for ((plant=0;plant<plants_per_row;plant++)); do
        plant_value="${plants_in_row:$plant:1}"
        if (( plant_value == 1 )); then
            row_results+="*"
            continue
        fi

        if (( row != 0 )); then
            plants_in_row_above=$(echo "${garden_rows[$row-1]}" | tr " *" "01")
        else    
            plants_in_row_above="000"
        fi
        
        if (( row != number_of_rows-1 )); then
            plants_in_row_below=$(echo "${garden_rows[$row+1]}" | tr " *" "01")
        else
            plants_in_row_below="000"
        fi
        
        if (( plant != 0 )); then
            starting_adjacent_index=$((plant-1))
        else
            starting_adjacent_index=$((plant))
        fi
        
        if (( plant != plants_per_row-1 )); then
            ending_adjacent_index=$((plant+1))
        else    
            ending_adjacent_index=$((plant))
        fi
        
        num_adjacent_plants=0
        for ((adjacent_plant=starting_adjacent_index;adjacent_plant<=ending_adjacent_index;adjacent_plant++)); do
            plant_above="${plants_in_row_above:$adjacent_plant:1}"
            num_adjacent_plants=$((num_adjacent_plants+plant_above))
            
            plant_below="${plants_in_row_below:$adjacent_plant:1}"
            num_adjacent_plants=$((num_adjacent_plants+plant_below))
            
            plant_in_row="${plants_in_row:$adjacent_plant:1}"
            num_adjacent_plants=$((num_adjacent_plants+plant_in_row))
        done
        if (( num_adjacent_plants == 0 )); then
            row_results+=" "
        else
            row_results+="$num_adjacent_plants"
        fi
    done
    echo "$row_results"
done

#!/usr/bin/env bash

abs(){ 
    num="$1"
    if (( num < 0 )); then
        num=$((-1*num))
    fi
    echo "$num"
}

simplify_fraction(){
fraction="$1"

IFS='/' read -r -a fraction_array <<< "$fraction" 

numerator="${fraction_array[0]}"

denominator="${fraction_array[1]}"

if (( numerator == 0 )); then
    echo "0/1"
    exit 0
fi

abs_numerator=$(abs "$numerator")

abs_denominator=$(abs "$denominator")

if (( abs_numerator > abs_denominator )); then
    starting_factor="$abs_denominator"
elif (( abs_numerator < abs_denominator )); then
    starting_factor="$abs_numerator"
else 
    echo "1/1"
    exit 0
fi

if (( denominator < 0 )); then
    denominator=$((-1*denominator))
    numerator=$((-1*numerator))
fi

for ((factor=starting_factor;factor>0;factor--)); do
    if (( abs_numerator % factor == 0 )) && (( abs_denominator % factor == 0 )); then
        numerator=$((numerator/factor))
        denominator=$((denominator/factor))
    fi
done

echo "${numerator}/${denominator}"

}

add_fractions(){
IFS='/' read -r -a fraction_1_array <<< "$1" 

IFS='/' read -r -a fraction_2_array <<< "$2" 

numerator_1="${fraction_1_array[0]}"

denominator_1="${fraction_1_array[1]}"

numerator_2="${fraction_2_array[0]}"

denominator_2="${fraction_2_array[1]}"

result_denominator=$((denominator_1*denominator_2))

result_numerator=$((numerator_1*denominator_2+numerator_2*denominator_1))

echo "${result_numerator}/${result_denominator}"

}

subtract_fractions(){
IFS='/' read -r -a fraction_1_array <<< "$1" 

IFS='/' read -r -a fraction_2_array <<< "$2" 

numerator_1="${fraction_1_array[0]}"

denominator_1="${fraction_1_array[1]}"

numerator_2="${fraction_2_array[0]}"

denominator_2="${fraction_2_array[1]}"

result_denominator=$((denominator_1*denominator_2))

result_numerator=$((numerator_1*denominator_2-numerator_2*denominator_1))

echo "${result_numerator}/${result_denominator}"

}

multiply_fractions(){
IFS='/' read -r -a fraction_1_array <<< "$1" 

IFS='/' read -r -a fraction_2_array <<< "$2" 

numerator_1="${fraction_1_array[0]}"

denominator_1="${fraction_1_array[1]}"

numerator_2="${fraction_2_array[0]}"

denominator_2="${fraction_2_array[1]}"

result_denominator=$((denominator_1*denominator_2))

result_numerator=$((numerator_1*numerator_2))

echo "${result_numerator}/${result_denominator}"

}

divide_fractions(){
IFS='/' read -r -a fraction_1_array <<< "$1" 

IFS='/' read -r -a fraction_2_array <<< "$2" 

numerator_1="${fraction_1_array[0]}"

denominator_1="${fraction_1_array[1]}"

numerator_2="${fraction_2_array[0]}"

denominator_2="${fraction_2_array[1]}"

result_denominator=$((denominator_1*numerator_2))

result_numerator=$((denominator_2*numerator_1))

echo "${result_numerator}/${result_denominator}"

}

abs_fraction(){
IFS='/' read -r -a fraction_array <<< "$1" 

numerator="${fraction_array[0]}"

denominator="${fraction_array[1]}"

result_denominator=$(abs "$denominator")

result_numerator=$(abs "$numerator")

echo "${result_numerator}/${result_denominator}"
}

power_fraction(){
IFS='/' read -r -a fraction_array <<< "$1" 

power="$2"

numerator="${fraction_array[0]}"

denominator="${fraction_array[1]}"

if (( power >= 0 )); then
    result_denominator=$((denominator**power))

    result_numerator=$((numerator**power))
else
    power=$((-1*power))
    
    result_denominator=$((numerator**power))

    result_numerator=$((denominator**power))
fi
echo "${result_numerator}/${result_denominator}"
}

real_to_power_of_fraction(){

local IFS="/"; read -r -a powers <<< "$2"
    
    exp="$(power_fraction "$1/1" "${powers[0]}")"
    root=$(echo "e( l($exp)/${powers[1]} )" | bc -l)
    if [[ $root =~ ([0-9]*)\.99999.* ]]; then
        echo "$((BASH_REMATCH[1]+1)).0"
    elif [[ $root =~ ([0-9])\.0* ]]; then
        echo "${BASH_REMATCH[1]}.0"
    elif [[ $root =~ \.[0-9]* ]]; then
        echo "0${root:0:7}"
    fi
}

main(){
operation="$1"
if [[ "$operation" = "rpow" ]]; then
    real_to_power_of_fraction "$2" "$3"
    exit 0
elif [[ "$operation" = "+" ]]; then
    unsimplified_result=$(add_fractions "$2" "$3")
elif [[ "$operation" = "-" ]]; then
    unsimplified_result=$(subtract_fractions "$2" "$3")
elif [[ "$operation" = "*" ]]; then
    unsimplified_result=$(multiply_fractions "$2" "$3")
elif [[ "$operation" = "/" ]]; then
    unsimplified_result=$(divide_fractions "$2" "$3")
elif [[ "$operation" = "abs" ]]; then
    unsimplified_result=$(abs_fraction "$2")
elif [[ "$operation" = "pow" ]]; then
    unsimplified_result=$(power_fraction "$2" "$3")
elif [[ "$operation" = "reduce" ]]; then
    unsimplified_result="$2"
fi

simplify_fraction "$unsimplified_result"

}

main "$@"
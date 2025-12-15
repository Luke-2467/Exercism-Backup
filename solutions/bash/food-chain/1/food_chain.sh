#!/usr/bin/env bash
set -o errexit
set -o nounset
# set -x
getHistory(){
    local bottom
    for (( j=$1; j>=1; j--)); do
        [[ ${animals[$(($j-1))]} == 'spider' ]] && bottom="${animals[$(($j-1))]} that wriggled and jiggled and tickled inside her" ||
            bottom="${animals[$(($j-1))]}"
        echo "She swallowed the ${animals[$(($j))]} to catch the $bottom."
    done
}
getConsequence(){
    [[ $1 == 'horse' ]] && { echo "She's dead, of course!"; return 0; }
    echo "I don't know why she swallowed the fly. Perhaps she'll die."
}
main(){
    (( ${#@}!=2 )) && { echo "2 arguments expected" >&2; exit 1; }
    local -i start=$1
    local -i end=$2
    (( $start > $end )) && { echo "Start must be less than or equal to End" >&2; exit 1; }
    
    declare -a animals=('fly' 'spider' 'bird' 'cat' 'dog' 'goat' 'cow' 'horse')
    declare -A reaction=( ['spider']='It wriggled and jiggled and tickled inside her.'
			  ['bird']='How absurd to swallow a bird!'
			  ['cat']='Imagine that, to swallow a cat!'
			  ['dog']='What a hog, to swallow a dog!'
			  ['goat']='Just opened her throat and swallowed a goat!'
			  ['cow']="I don't know how she swallowed a cow!"
			)
    for (( i=$start-1; i<$end; i++ )); do
        echo "I know an old lady who swallowed a ${animals[$i]}."
        [[ ${reaction[${animals[$i]}]+_} ]] && echo ${reaction[${animals[$i]}]}
        (( $i < ${#animals[@]}-1 )) && getHistory $i
        getConsequence ${animals[$i]} && echo ""
    done
}
main "$@"

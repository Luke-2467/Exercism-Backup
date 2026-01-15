#!/usr/bin/env bash

split() {
    local preorder=( $1 )
    local inorder=( $2 )
    if (( ${#preorder[@]} > 0 )); then 
        root=${preorder[0]}
    else 
        echo {}
        exit 0
    fi
    
    if (( ${#preorder[@]} <= 1 )); then
        echo \{\"v\": \"$root\", \"l\": \{\}, \"r\": \{\}\}
        exit 0
    fi

    #else we have a proper tree
    for (( node_io_index=0; node_io_index<${#inorder[@]}; node_io_index++ )); do 
        if [[ "${inorder[$node_io_index]}" == "$root" ]]; then
            splt=$node_io_index
        fi
    done
    echo "{\"v\": \"$root\", "
    echo \"l\":  $(split "${preorder[*]:1:$((splt))}" "${inorder[*]:0:$((splt))}") ","
    echo \"r\":  $(split "${preorder[*]:$((splt+1))}" "${inorder[*]:$((splt+1))}") "}"
}

main(){
    read -r -a preorder <<< "$1"
    read -r -a inorder <<< "$2"
    
    if [[ "${#preorder[@]}" = "0" && "${#inorder[@]}" = "0" ]]; then
        echo "{}"
        exit 0
    elif [[ "${#preorder[@]}" != "${#inorder[@]}" ]]; then
        echo "traversals must have the same length"
        exit 1
    fi

    declare -A pre_order_unique in_order_unique
    
    length_of_tree="${#preorder[@]}"
    
    for (( element_index=0 ; element_index < length_of_tree ; element_index++ )); do
        pre_order_element="${preorder[element_index]}"
        in_order_element="${inorder[element_index]}"

        if [[ "${pre_order_unique[$pre_order_element]}" != "" || "${in_order_unique[$in_order_element]}" != "" ]]; then
            echo "traversals must contain unique elements"
            exit 1
        else
            pre_order_unique[$pre_order_element]=1
            in_order_unique[$in_order_element]=1
        fi
    done

    for element in "${!pre_order_unique[@]}"; do
        if [[ "${in_order_unique[$element]}" = "" ]]; then
            echo "traversals must have the same elements"
            exit 1
        fi
    done

    
    split "$1" "$2"
}

main "$@"



#!/usr/bin/env bash

two_sum() {
    declare -n list="$1"
    declare -i target="$2"

    declare -A indices
    local i
    for (( i = 0; i < "${#list[@]}"; i++ )); do
	local val="${list[$i]}"
	indices["$val"]="$i"
    done
    for (( i = 0; i < "${#list[@]}"; i++ )); do
	local val="${list[$i]}"
	local diff=$(( target - val ))
	for value in "${indices[@]}"; do
	    if [[ "$diff" == "$value" ]]; then
		if ! [[ "${indices[$diff]}" == "$i" ]]; then
		    echo "$i, ${indices[$diff]}"
		fi
	    fi
	done
    done
}

main() {
    local input=(3 4 5 6)
    two_sum input 7
}

main "$@"

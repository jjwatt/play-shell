#!/usr/bin/env bash

has_duplicate() {
    declare -n arref="$1"
    for i in "${arref[@]}"; do
	for (( j = i+1; j < "${#arref[@]}"; j++ )) do
	    if [[ "${arref[i]}" == "${arref[j]}" ]]; then
		return 0
	    fi
	done
    done
    return 1
}

input1=(1 2 3 3)
input2=(1 2 3 4)

if has_duplicate "input1"; then
    echo "${input1[@]} has a duplicate."
fi
if has_duplicate "input2"; then
    echo "${input2[@]} has a duplicate."
fi

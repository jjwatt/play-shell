#!/usr/bin/env bash

two_sum() {
    declare -n list="$1"
    declare -i target="$2"

    declare -A seen
    for i in "${!list[@]}"; do
	local val="${list[i]}"
	local diff=$(( target - val ))

	if [[ -v "seen[$diff]" ]]; then
	    echo "${seen[$diff]}", "$i"
	    return 0
	fi
	seen["$val"]="$i"
    done
    return 1
}

main() {
    local input=(3 4 5 6)
    echo "input: (${input[*]})"
    echo "output: $(two_sum input 7)"
    local input=(4 5 6)
    echo "input: (${input[*]})"
    echo "output: $(two_sum input 10)"
    local input=(5 5)
    echo "input: (${input[*]})"
    echo "output: $(two_sum input 10)"
}

main "$@"

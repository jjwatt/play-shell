#!/usr/bin/env bash

sum_multiples_3_or_5_below_1000() {
    local limit=1000
    local sum=0

    for (( i=1; i<limit; i++ )); do
	if (( i % 3 == 0 || i % 5 == 0 )); then
	    (( sum += i ))
	fi
    done
    printf "%s\n" "$sum"
}

sum_multiples_below() {
    local k="$1"
    local limit="$2"
    # Calculeate p, the number of multiples below the limit.
    local pexpr="($limit - 1) / $k"
    #local p=$(( limit - 1 / k ))
    p="$(bc <<< "$pexpr")"
    # Apply the formula, k*(p*(p+1)/2).
    printf "%s\n" "$k * $p * ($p + 1) / 2"
}

main() {
    sum_multiples_3_or_5_below_1000
    local sum3
    sum3="$(sum_multiples_below 3 1000)"
    local sum5
    sum5="$(sum_multiples_below 5 1000)"
    local sum15
    sum15="$(sum_multiples_below 15 1000)"

    echo "$sum3 + $sum5 - $sum15" | bc
}

main "$@"

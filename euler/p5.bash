#!/usr/bin/env bash

# A function to calculate the Greatest Common Divisor (GCD)
# of two numbers using the Euclidean algorithm.
gcd() {
    local a="$1"
    local b="$2"
    local temp
    while (( b != 0 )); do
	temp="$b"
	b=$(( a % b ))
	a="$temp"
    done
    echo "$a"
}

# A function to calculate the Least Common Multiple (LCM)
# of two numbers.
lcm() {
    local a="$1"
    local b="$2"
    # Formula: lcm(a, b) = (a * b) / gcd(a, b)
    printf "%s\n" $(( a * b / $(gcd "$a" "$b") ))
}

main() {
    local result=1
    local i
    for i in {1..20}; do
	result="$(lcm "$result" "$i")"
    done
    echo "The smallest positive number divisible by all numbers 1 to 20 is: $result"
}

main "$@"



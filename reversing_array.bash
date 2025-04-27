
anreverse() {
    eval set $1 "\"\${$1[@]}\""
    eval unset $1
    while [ $# -gt 1 ]; do
        eval "$1=(\"$2\" \"\${$1[@]}\")"
        set $1 "${@:3}"
    done
}

# @fn ramey_reverse
# @brief Chris Ramey's reverse from bash examples
# usage: reverse arrayname
ramey_reverse()
{
    local -a R
    local -i i
    local rlen temp

    # make r a copy of the array whose name is passed as an arg
    eval R=\( \"\$\{$1\[@\]\}\" \)

    # reverse R
    rlen=${#R[@]}

    for ((i=0; i < rlen/2; i++ ))
    do
	temp=${R[i]}
	R[i]=${R[rlen-i-1]}
	R[rlen-i-1]=$temp
    done

    # and assign R back to array whose name is passed as an arg
    eval $1=\( \"\$\{R\[@\]\}\" \)
}

# @fn jes_reverse
# @brief My simplification of Chris Ramey's reverse from bash examples
# @detail Usage: jes_reverse arrayname
jes_reverse() {
    local -n arr="$1"
    local -i i
    local arr_len temp

    # Get arr_len
    arr_len="${#arr[@]}"

    # Reverse array by swapping first half with second half.
    for ((i=0; i < arr_len/2; i++ )); do
	temp="${arr[i]}"
	arr[i]="${arr[arr_len-i-1]}"
	arr[arr_len-i-1]="$temp"
    done
}

main() {
    my_array=( "apple" "banana" "cherry" "date" )
    echo "Original array: ${my_array[*]}"
    anreverse my_array
    echo "Reversed array: ${my_array[*]}"
    my_array2=("apple" "banana" "cherry" "date" )
    echo "Original array: ${my_array2[*]}"
    ramey_reverse my_array2
    echo "Reversed with Ramey Reverse: ${my_array2[*]}"
    jes_reverse my_array2
    echo "Reversed with Jwatt Reverse: ${my_array2[*]}"
}
main "$@"


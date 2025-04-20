
anreverse() {
    eval set $1 "\"\${$1[@]}\""
    eval unset $1
    while [ $# -gt 1 ]; do
        eval "$1=(\"$2\" \"\${$1[@]}\")"
        set $1 "${@:3}"
    done
}

main() {
    my_array=( "apple" "banana" "cherry" "date" )
    echo "Original array: ${my_array[@]}"
    anreverse my_array
    echo "Reversed array: ${my_array[@]}"
}
main "$@"

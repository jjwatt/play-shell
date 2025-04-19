
use_sort_cmd() {
    local ar=("${@}")
    IFS=$'\n' local sorted_array=($(sort <<<"${ar[*]}"))
    unset IFS
    echo "${sorted_array[@]}"
}

main() {
    arr1=("banana" "apple" "cherry" "date")
    use_sort_cmd "${arr1[@]}"
}

main "$@"

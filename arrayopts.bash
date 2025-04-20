#!/usr/bin/env bash
# From bash repo 'examples' dir

#:docstring apush:
# Usage: apush arrayname val1 {val2 {...}}
#
# Appends VAL1 and any remaining arguments to the end of the array
# ARRAYNAME as new elements.
#:end docstring:
apush()
{
    eval "$1=(\"\${$1[@]}\" \"\${@:2}\")"
}

#:docstring apop:
# Usage: apop arrayname {n}
#
# Removes the last element from ARRAYNAME.
# Optional argument N means remove the last N elements.
#:end docstring:
apop()
{
    eval "$1=(\"\${$1[@]:0:\${#$1[@]}-${2-1}}\")"
}

#:docstring aunshift:
# Usage: aunshift arrayname val1 {val2 {...}}
#
# Prepends VAL1 and any remaining arguments to the beginning of the array
# ARRAYNAME as new elements.  The new elements will appear in the same order
# as given to this function, rather than inserting them one at a time.
#
# For example:
#
#	foo=(a b c)
#	aunshift foo 1 2 3
#       => foo is now (1 2 3 a b c)
# but
#
#	foo=(a b c)
#	aunshift foo 1
#       aunshift foo 2
#       aunshift foo 3
#       => foo is now (3 2 1 a b c)
#
#:end docstring:
aunshift()
{
    eval "$1=(\"\${@:2}\" \"\${$1[@]}\")"
}


main() {
    arr1=("apple" "banana" "cherry" "date")
    apush arr1 "elephant" "zebra"
    echo "${arr1[*]}"
    apop arr1 2
    echo "${arr1[*]}"
    echo "${arr1[@]:0:${#arr1[@]}-2}"
}

main "$@"

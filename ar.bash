## @file myarray_ops.bash
## @brief My own interpretation of different operations on bash arrays
##
## @detail Some of these are based on examples in the bash repo, but
## they're bash 4.3+ because they use namerefs and other newer
## features of bash.
##

## @fn ar:shift()
## @brief Like shift, but for arrays
ar::shift() {
    local -n arr="$1"
    local -i n
    case $# in
	1)	n=1 ;;
	2)	n=$2 ;;
	*)	echo "$FUNCNAME: usage: $FUNCNAME array [count]" >&2
		return 2;;
    esac
    local arr_len="${#arr[@]}"
    # If shift count is more than array length, return empty array
    if (( n > arr_len )); then
	arr=()
	return 0
    fi
    arr=("${arr[@]:"$n"}")
}


## @fn ar::push()
## @brief Appends remaining arguments to array name
## @param arrayname The name of the array to push onto
## @param rest val1 [val2 {...} ] Values to push onto the array
ar::push() {
    local -n arr="$1"
    shift
    arr+=("$@")
}


## @fn ar::pop()
## @brief Removes and returns the last element of an array
## @param arrayname The name of the array to pop from
ar::pop() {
    local -n arr="$1"
    local -i arr_len="${#arr[@]}"
    if (( arr_len <= 0 )); then
	echo "" >&2
	return 0
    fi
    local -i i=$((arr_len - 1))
    local poppped="${arr[i]}"
    arr=("${arr[@]:0:$i}")
    echo "$popped"
}

## @fn ar::reverse()
## @brief Reverse array stored in arr in-place
## @detail My simplification of Chris Ramey's reverse from bash examples
## For bash 4.3+, uses namerefs
## Usage: ar::reverse arrayname
ar::reverse() {
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

# @fn array_to_string
# @brief Turn an array into a string with seperator
# @param vname_of_array The variable name of the array
# @param vname_of_string The variable name of the string
# @param separator The optional separator to use. Defaults to IFS
ar::array_to_string() {
    (( ($# < 2) || ($# > 3) )) && {
	"$FUNCNAME: usage: $FUNCNAME arrayname stringname [seperator]"
	return 2
    }
    local array=$1 string=$2
    (($#==3)) && [[ $3 = ? ]] && local IFS="${3}${IFS}"
    
    eval $string="\"\${$array[*]}\""
    return 0
}

# @fn string_to_array
# @brief Turn a string into an array with a specified delimiter
# @param vname_of_string The variable name of the string
# @param vname_of_array The variable name of the array
# @param delimiter The optional delimiter to use. Defaults to space.
ar::string_to_array() {
    (( ($# < 2) || ($# > 3) )) && {
	echo "$FUNCNAME: usage: $FUNCNAME arrayname stringname [delimiter]"
	return 2
    }
    local string="$1" array="$2"
    (($#==3)) && [[ $3 = ? ]] && local IFS="${3}"

    eval read -ra "$array" <<< "${!string}"
    return 0
}


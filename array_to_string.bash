#!/usr/bin/env bash

# @file array_to_string.bash
# @brief from bash examples in the bash repo

# @fn array_to_string
# @brief Turn an array into a string with seperator
# @param vname_of_array The variable name of the array
# @param vname_of_string The variable name of the string
# @param separator The optional separator to use. Defaults to IFS
array_to_string() {
    (( ($# < 2) || ($# > 3) )) && {
	"$FUNCNAME: usage: $FUNCNAME arrayname stringname [seperator]"
	return 2
    }
    local array=$1 string=$2
    (($#==3)) && [[ $3 = ? ]] && local IFS="${3}${IFS}"
    
    eval $string="\"\${$array[*]}\""
    return 0
}

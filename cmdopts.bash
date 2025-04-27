#!/usr/bin/env bash
## Manual argument parsing

die() {
    printf '%s\n' "$1" >&2
    exit 1
}

file=
verbose=0

while :; do
    case "$1" in
	-h|-\?|--help)
	    show_help
	    exit
	    ;;
	-f|--file)
	    if [[ $2 ]]; then
		file="$2"
		shift
	    else
		die 'ERROR: "--file" requires a non-empty option argument'
	    fi
	    ;;
	    *)
	      break
    esac
    shift
done


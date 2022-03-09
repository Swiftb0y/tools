#!/usr/bin/env bash

# enable recursive glob pattern (**/*)
shopt -s globstar

usage() {
        echo "Usage: $0 [-r] [-i in_format] [-o out_format] [dir]"
	echo "r: no recurse directories"
	echo "i: audio extension of the input files"
	echo "o: audio extension of the output files"
        echo "dir: working directory from where to start matching"
        exit 1;
}

SCAN_DIR="$(pwd)"
RECURSE="**/"
I_FORMAT="wav"
O_FORMAT="flac"

while getopts "i:o:r" opts; do
    case "${opts}" in
        r)
            RECURSE=""
            ;;
        i)
            I_FORMAT=${OPTARG}
            ;;
        o) 
            O_FORMAT=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# get last arg after positional args
if [[ -n $1 ]]; then SCAN_DIR="$1"; fi
# normalize path
SCAN_DIR="$(realpath "${SCAN_DIR}")/"

# build scan path glob for iteration
GLOB="${SCAN_DIR}${RECURSE}*.${I_FORMAT}"

#https://stackoverflow.com/questions/5784661/how-do-you-convert-an-entire-directory-with-ffmpeg

for i in $GLOB; do
  name=${i%.*}
  echo "$name"
  (ffmpeg -hide_banner -i "$i" "${name}.${O_FORMAT}" && mv "$i" /tmp/) > /dev/null & 
done

wait

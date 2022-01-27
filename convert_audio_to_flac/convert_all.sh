#!/usr/bin/env bash


if [ $# -lt "1" ]; then
        echo "Usage:  $0 <format>"
	echo "format: audio extension of the input files"
        exit 1;
fi

#https://stackoverflow.com/questions/5784661/how-do-you-convert-an-entire-directory-with-ffmpeg

format=$1

for i in *."$format"; do
  name=${i%.*}
  echo "$name"
  (ffmpeg -hide_banner -i "$i" "${name}.flac" && mv "$i" /tmp/) &
done

wait

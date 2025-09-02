#!/usr/bin/env sh

# Check for ffmpeg.
if ! type -f ffmpeg; then
  exit 1
fi

input=$1
output="${input%.*}.m4a"

echo converting $input to $output.

# NOTE: Lower crf increases compression.
ffmpeg -i "$input" -c:a aac -b:a 192k "$output"

exit $?

#!/usr/bin/env sh

# Check for ffmpeg.
if ! type -f ffmpeg; then
  exit 1
fi

input=$1
output="${input%.*}.mp4"

echo converting $input to $output.

# NOTE: Lower crf increases compression.
ffmpeg -i $input -codec copy -vcodec libx265 -crf 36 -an $output

exit $?

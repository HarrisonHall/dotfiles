#!/usr/bin/env sh

page=$1
output=$2

# Use monolith.
if type -f monolith; then
  echo YYY $page $output
  monolith \
    --no-js \
    --user-agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36" \
    --output $output \
    $page
  exit $?
fi

# Use wget.
if type -f wget; then
  wget \
    --recursive \
    --level=5 \
    --convert-links \
    --page-requisites \
    --wait=1 \
    --random-wait \
    --timestamping \
    --no-parent \
    $page
  exit $?
fi

exit 1

#!/usr/bin/env sh
# Install yt-dlp with `uv tool install yt-dlp` and update with `yt-dlp -U`.

playlist_url=$1
output=$2

#    --format 'vcodec=av01/bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' \
#    --format 140 \
#    --format 'bestaudio[ext=m4a]' \

# Use yt-dlp.
if type -f yt-dlp; then
  yt-dlp \
    --extract-audio \
    --format 'vcodec=av01/bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' \
    --audio-quality 0 \
    --output '%(title)s.%(ext)s' \
    --ignore-errors \
    --embed-subs \
    --all-subs \
    --sub-langs all,-live_chat \
    --compat-options no-live-chat \
    --convert-subs srt \
    --convert-thumbnails jpg \
    --embed-thumbnail \
    --add-metadata \
    --xattrs \
    --prefer-free-formats \
    --geo-bypass \
    --no-mark-watched \
    --console-title \
    --no-warnings \
    --sponsorblock-remove all \
    --compat-options embed-thumbnail-atomicparsley \
    --paths $output \
    $playlist_url
  exit $?
fi

exit 1

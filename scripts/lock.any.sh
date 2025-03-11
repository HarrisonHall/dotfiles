#!/usr/bin/env sh

# Pause tasks.
if type -f mpc; then
  mpc -q pause
fi
if type -f amixer; then
  amixer set Master mute
fi

# Lock, via swaylock.
if type -f swaylock; then
  swaylock -f
  exit 0
fi

exit 1

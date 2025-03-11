#!/usr/bin/env sh

# Shutdown on Alpine.
if type -f /sbin/poweroff; then
  if type -f doas; then
    doas /sbin/poweroff
    exit 0
  fi
fi

# Shutdown with shutdown.
if type -f shutdown; then
  shutdown 0
  exit 0
fi

# Shutdown with systemctl.
if type -f systemctl; then
  systemctl poweroff
  exit 0
fi

exit 1

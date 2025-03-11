#!/usr/bin/env sh

# Reboot on Alpine.
if type -f /sbin/reboot; then
  if type -f doas; then
    doas /sbin/reboot
    exit 0
  fi
fi

# Reboot with reboot.
if type -f reboot; then
  reboot
  exit 0
fi

# Reboot with systemctl.
if type -f systemctl; then
  systemctl reboot
  exit 0
fi

exit 1

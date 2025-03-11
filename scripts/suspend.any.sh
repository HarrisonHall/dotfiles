#!/usr/bin/env sh

# Lock.
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
$SCRIPTPATH/lock.any.sh

# Suspend on Alpine.
if type -f /usr/sbin/pm-suspend; then
  if type -f doas; then
    doas /usr/sbin/pm-suspend
    exit 0
  fi
fi

# Suspend with systemd.
if type -f systemctl; then
  systemctl suspend
  exit 0
fi

exit 1

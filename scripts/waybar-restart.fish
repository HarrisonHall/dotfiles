#!/usr/bin/env fish

# Restart via systemctl.
systemctl --user status waybar 2&>/dev/null
if test $status -eq 0
    systemctl --user restart waybar
    exit 0
end

# Restart via pkill.
pgrep waybar 2&>/dev/null
if test $status -eq 0
    pkill -SIGUSR2 waybar 2&>/dev/null
    exit 0
end

echo here3
exit 1

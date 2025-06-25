#!/usr/bin/env fish

set -x EDITOR hx
set -x TERM wezterm
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8


set -x XDG_VTNR (basename "$(tty)" | sed 's/tty//')
if [ -z "$WAYLAND_DISPLAY" ];
    if [ "$XDG_VTNR" -eq 1 ];
        /usr/libexec/pipewire-launcher &
        exec dbus-run-session sway
    end
end

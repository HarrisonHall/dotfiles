# config.nu

# Set base variables.
$env.EDITOR = "hx"
$env.config.buffer_editor = "hx"
$env.SHELL = (which nu)

# Path configuration.
use std/util "path add"
path add "/bin"
path add "/usr/bin"
path add "/sbin"
path add "/usr/sbin"

# Library.
# $env.

# Do not track (https://consoledonottrack.com/)
$env.DO_NOT_TRACK = 1

# Set fetching aliases.
alias fetch = macchina
alias fetch-min = nitch
alias fetch-max = fastfetch
alias neofetch = fastfetch
alias screenfetch = fastfetch

# Alias ls.
alias ll = eza -la --icons=auto --group-directories-first

# Hook zoxide:
# TODO

# Hook starship:
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

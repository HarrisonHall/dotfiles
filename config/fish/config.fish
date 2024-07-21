if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    # Colors
    eval (dircolors -c ~/.config/dircolors/.dircolors)
    set -x GLAMOUR_STYLE ~/.config/glamour/styles/catppuccin-macchiato.json
    # Shortcut
    alias ll "eza -la --icons=auto --group-directories-first --classify"
    # Man paging
    set -x MANROFFOPT -c
    set -x MANPAGER "sh -c 'col -bx | bat -l man --color=always -p'"
end

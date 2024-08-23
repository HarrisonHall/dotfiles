if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    # Colors
    eval (dircolors -c ~/.config/dircolors/.dircolors)
    set -x GLAMOUR_STYLE ~/.config/glamour/styles/catppuccin-macchiato.json
    # Shortcuts
    alias ll "eza -la --icons=auto --group-directories-first --classify"
    alias ls "eza --icons=auto --group-directories-first"
    # Man paging
    set -x MANROFFOPT -c
    set -x MANPAGER "sh -c 'col -bx | bat -l man --color=always -p'"
    # Path
    set PATH $PATH ~/.cargo/bin
    # Other setup
    ## Starship
    set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
    type -f starship 2&>/dev/null && starship init fish | source
    ## Zoxide
    type -f zoxide 2&>/dev/null && zoxide init fish | source
end

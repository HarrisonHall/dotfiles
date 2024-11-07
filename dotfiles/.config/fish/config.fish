if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    # Colors
    eval (dircolors -c ~/.config/dircolors/.dircolors)
    set -x GLAMOUR_STYLE ~/.config/glamour/styles/catppuccin-macchiato.json
    # Shortcuts
    alias ll "eza -la --icons=auto --group-directories-first --classify"
    alias ls "eza --icons=auto --group-directories-first"
    alias fetch macchina
    alias fetch-min nitch
    alias fetch-max fastfetch
    alias neofetch fastfetch
    alias screenfetch fastfetch
    # Man paging
    set -x MANROFFOPT -c
    set -x MANPAGER "sh -c 'col -bx | bat -l man --color=always -p'"
    # Path
    set PATH $PATH ~/.cargo/bin
    # Other setup
    # Direnv
    type -f direnv 2&>/dev/null && direnv hook fish | source
    ## FZF
    set -x FZF_DEFAULT_OPTS "\
        --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
        --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
        --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
        --color=selected-bg:#494d64 \
        --multi"
    ## Starship
    set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
    type -f starship 2&>/dev/null && starship init fish | source
    ## Zoxide
    type -f zoxide 2&>/dev/null && zoxide init fish | source
    alias cd z
end

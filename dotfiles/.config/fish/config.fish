#!/usr/bin/env fish

# Set base variables.
set -x EDITOR hx
set -x SHELL (which fish)

# Path configuration.
fish_add_path --path /bin
fish_add_path --path /usr/bin
fish_add_path --path /sbin
fish_add_path --path /usr/sbin
fish_add_path --path "$HOME/workspace/software/bin/$(uname -m)"
fish_add_path --path "$HOME/.local/bin"
fish_add_path --path "$HOME/.config/dotfiles/scripts"
fish_add_path --path "$HOME/.cargo/bin"
fish_add_path --path "$HOME/.nix-profile/bin"

set -x LD_LIBRARY_PATH \
    $NIX_LD_LIBRARY_PATH \
    $LD_LIBRARY_PATH

# Do not track (https://consoledonottrack.com/).
set -x DO_NOT_TRACK 1

# Shell setup.
if status is-interactive
    # Disable fish greeting.
    set fish_greeting

    # Enable mise.
    # This is done at the beginning as it affects path.
    type -f mise 2&>/dev/null && mise activate fish | source
    type -f mise 2&>/dev/null && type -f usage 2&>/dev/null && mise completions fish | source

    # Set colors.
    type -f dircolors 2&>/dev/null && eval (dircolors -c ~/.config/dircolors/.dircolors)
    set -x GLAMOUR_STYLE ~/.config/glamour/styles/catppuccin-mocha.json

    # Set pagers.
    set -x PAGER bat
    set -x DELTA_PAGER "bat -p"

    ## Set fetching aliases.
    alias fetch macchina
    alias fetch-min nitch
    alias fetch-max fastfetch
    alias neofetch fastfetch
    alias screenfetch fastfetch

    ## Configure FZF.
    set -Ux FZF_DEFAULT_OPTS "\
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
        --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
        --color=selected-bg:#45475a \
        --multi"

    ## Alias ls.
    type -f eza 2&>/dev/null && alias ll "eza -la --icons=auto --group-directories-first --classify"
    type -f eza 2&>/dev/null && alias ls "eza --icons=auto --group-directories-first"

    ## Configure nix.
    alias nix-shell "nix-shell --command \"fish\""
    alias nix-dev "nix develop --command \"fish\""
    type -f $HOME/.nix-profile/etc/profile.d/nix.fish 2&>/dev/null && source $HOME/.nix-profile/etc/profile.d/nix.fish

    ## Configure man.
    set -x MANROFFOPT -c
    set -x MANPAGER "sh -c 'col -bx | bat -l man --color=always -p'"
    set -x MANPATH \
        /usr/share/man \
        $(realpath "$HOME/.local/share/man") \
        /run/current-system/sw/share/man \
        /etc/profiles/per-user/$USER/share/man
    type -f busybox 2&>/dev/null && set -e MANPAGER

    ## Alias slipstream.
    alias slipr "slipstream -c ~/.config/slipstream/slipreader.toml read"

    ## Configure SSH.
    set _ssh (which ssh 2>/dev/null)
    set _mosh (which mosh 2>/dev/null)
    function ssh --wraps ssh -d "SSH with tmux"
        if test -n "$_mosh"
            echo "Using `mosh $argv`"
            $_mosh $argv -- /bin/sh -c 'tmux new-session -A -s main'
        else
            echo "Using `ssh $argv`"
            $_ssh $argv -t -- /bin/sh -c 'tmux new-session -A -s main'
        end
    end
    alias mosh ssh
    alias ssh-vanilla $_ssh

    ## Hook atuin.
    type -f atuin 2&>/dev/null && atuin init fish | source

    # Hook direnv.
    type -f direnv 2&>/dev/null && direnv hook fish | source

    ## Hook starship.
    set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
    type -f starship 2&>/dev/null && starship init fish | source

    ## Configure taskwarrior.
    set -x TASKRC ~/.config/taskwarrior/.taskrc
    set -x TASKDATA ~/workspace/notes/todo/tasks

    ## Configure tmuxp.
    set -x TMUXP_CONFIGDIR ~/.config/tmux/layouts/tmuxp

    ## Configure rust.
    set -x RUST_BACKTRACE 1

    ## Configure python.
    set -x PYTHONSTARTUP "$HOME/.config/python/interactive_startup.py"

    ## Hook uv.
    type -f uv 2&>/dev/null && uv generate-shell-completion fish | source
    type -f uv 2&>/dev/null && uvx --generate-shell-completion fish | source

    ## Hook zoxide.
    type -f zoxide 2&>/dev/null && zoxide init fish | source
    type -f zoxide 2&>/dev/null && alias cd z

    ## Other misc. aliases.
    type -f bat 2&>/dev/null && alias cat bat
    type -f btm 2&>/dev/null && alias top btm && alias htop btm
end

# Start DE, if applicable.
set -x XDG_VTNR (basename "$(tty)" | sed 's/tty//')
if begin
        [ -z "$WAYLAND_DISPLAY" ]; and [ "$XDG_VTNR" -eq 1 ]
    end

    # Alpine:
    if uname -a | grep -i alpine
        if begin
                command -v sway 2&>/dev/null
            end
            set -x MUSL_LOCPATH /usr/share/i18n/locales/musl
            set -x LC_ALL C.UTF-8
            set -x LANG C.UTF-8

            # Pipewire setup.
            /usr/libexec/pipewire-launcher 2&>/dev/null &

            # Run sway.
            exec dbus-run-session sway
        end

    end
end

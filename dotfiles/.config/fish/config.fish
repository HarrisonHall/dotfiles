#!/usr/bin/env fish

# Base variables.
set -x EDITOR hx
set -x TERM wezterm
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

# Shell setup.
if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    # Colors
    type -f dircolors 2&>/dev/null && eval (dircolors -c ~/.config/dircolors/.dircolors)
    set -x GLAMOUR_STYLE ~/.config/glamour/styles/catppuccin-mocha.json
    # Paging
    set -x PAGER bat
    set -x DELTA_PAGER "bat -p"
    # Path
    set PATH /sbin /usr/sbin "$HOME/workspace/software/bin/$(uname -m)" $PATH ~/.cargo/bin
    # Shortcuts and other setup
    # Direnv
    type -f direnv 2&>/dev/null && direnv hook fish | source
    ## Fetching
    alias fetch macchina
    alias fetch-min nitch
    alias fetch-max fastfetch
    alias neofetch fastfetch
    alias screenfetch fastfetch
    ## FZF
    set -Ux FZF_DEFAULT_OPTS "\
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
        --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
        --color=selected-bg:#45475a \
        --multi"
    ## ls
    type -f eza 2&>/dev/null && alias ll "eza -la --icons=auto --group-directories-first --classify"
    type -f eza 2&>/dev/null && alias ls "eza --icons=auto --group-directories-first"
    ## Nix
    alias nix-shell "nix-shell --command \"fish\""
    type -f $HOME/.nix-profile/etc/profile.d/nix.fish 2&>/dev/null && source $HOME/.nix-profile/etc/profile.d/nix.fish
    ## Man
    set -x MANROFFOPT -c
    set -x MANPAGER "sh -c 'col -bx | bat -l man --color=always -p'"
    set -x MANPATH $(realpath "$HOME/.local/share/man") /run/current-system/sw/share/man /etc/profiles/per-user/harrison/share/man "$MANPATH"
    # set -x MANPATH
    ## SSH
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
    alias ssh-vanilla _ssh
    ## Starship
    set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
    type -f starship 2&>/dev/null && starship init fish | source
    ## Sudo
    # type -f doas 2&>/dev/null && alias sudo doas
    ## Taskwarrior
    set -x TASKRC ~/.config/taskwarrior/.taskrc
    set -x TASKDATA ~/workspace/notes/todo/tasks
    ## Rust
    set -x RUST_BACKTRACE 1
    ## uv
    type -f uv 2&>/dev/null && uv generate-shell-completion fish | source
    type -f uv 2&>/dev/null && uvx --generate-shell-completion fish | source
    ## Zoxide
    type -f zoxide 2&>/dev/null && zoxide init fish | source
    type -f zoxide 2&>/dev/null && alias cd z
    # Etc.
    ## Do not track https://consoledonottrack.com/
    set -x DO_NOT_TRACK 1
end

# Start DE, if applicable.
set -x XDG_VTNR (basename "$(tty)" | sed 's/tty//')
if begin
        [ -z "$WAYLAND_DISPLAY" ]; and [ "$XDG_VTNR" -eq 1 ]
    end
    if begin
            command -v sway 2&>/dev/null
        end
        /usr/libexec/pipewire-launcher 2&>/dev/null &
        exec dbus-run-session sway
    end
end

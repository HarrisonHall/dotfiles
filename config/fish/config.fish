if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    eval (dircolors -c ~/.config/configw/.config/dircolors/.dircolors)
    alias ll "eza -la --icons=auto"
end

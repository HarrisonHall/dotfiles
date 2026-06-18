function dotfiles --description="cd to dotfiles"
    set dot_dir (realpath ~/.config/dotfiles)
    cd -- "$dot_dir"
    return 0
end

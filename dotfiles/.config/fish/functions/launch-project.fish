function launch-project --description="Open a project directory in a new tmux session"
    set -x PROJECT_DIR $argv[1]
    set -x PROJECT (echo (basename $PROJECT_DIR) | sed 's/\./-/g')
    # FUTURE: -d will create session in background without following.
    # tmux move-window -s . -t $PROJECT # Move current window to session
    # tmux switch -t $PROJECT  # Move to new session
    tmuxp load \
        --yes \
        --progress-format minimal \
        ~/.config/tmux/layouts/tmuxp/project.yaml

    return 0
end

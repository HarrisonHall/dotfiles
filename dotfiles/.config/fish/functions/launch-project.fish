function launch-project --description="Open a project in a new tmux session"
    set -x PROJECT_DIR $argv[1]
    set -x PROJECT (echo (basename $PROJECT_DIR) | sed 's/\./-/g')
    tmuxp load -y ~/.config/tmux/layouts/tmuxp/project.yaml

    return 0
end

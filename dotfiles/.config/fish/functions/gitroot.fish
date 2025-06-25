function gitroot --description="cd to the git root"
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo "Not in git directory."
        return 1
    end
    set git_root (git rev-parse --show-toplevel)
    cd -- "$git_root"
    return 0
end

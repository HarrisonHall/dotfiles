function launch-env-clear --description="Launch a shell with the local environment file."
    if test -f "./shell.nix"
        nix-shell
        clear
        return 0
    end
    if test -f "./flake.nix"
        nix-dev
        clear
        return 0
    end

    clear
    return 0
end

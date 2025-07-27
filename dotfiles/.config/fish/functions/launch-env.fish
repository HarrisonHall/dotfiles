function launch-env --description="Launch a shell with the local environment file."
    if test -f "./shell.nix"
        nix-shell
        return 0
    end
    if test -f "./flake.nix"
        nix-dev
        return 0
    end

    return 0
end

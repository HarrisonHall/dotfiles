# dotfiles installation helpers

DOTFILES := `git rev-parse --show-toplevel`
GC_DURATION := "30d"

# List all
[private]
default:
    just --list

# Install config
install: hier-build-base symlinks-link hier-build-extra
    #!/usr/bin/env sh
    echo {{DOTFILES}}
    sudo nixos-rebuild switch -I nixos-config="{{DOTFILES}}/nix/configuration.nix" -j 4
    if [ $? -eq 0 ]; then
        sudo nix-collect-garbage --delete-older-than {{GC_DURATION}}
        sudo nix-store --gc
        # sudo nixos-rebuild boot
    fi

# Install config for shell
install-shell: hier-build-base symlinks-link
    #!/usr/bin/env sh
    nix profile install -f {{DOTFILES}}/nix/shell.nix \
        --extra-experimental-features nix-command
    if [ $? -eq 0 ]; then
        nix-env --delete-generations {{GC_DURATION}}
        nix-store --gc
    fi

# Build base directories
hier-build-base:
    just directory-ensure-mk ~/.config
    just directory-ensure-mk ~/downloads
    just directory-ensure-mk ~/media
    just directory-ensure-mk ~/media/music
    just directory-ensure-mk ~/media/wallpapers
    just directory-ensure-mk ~/workspace

# Build extra directories
hier-build-extra:
    xdg-user-dirs-update
    just directory-ensure-rm ~/Desktop
    just directory-ensure-rm ~/Documents
    just directory-ensure-rm ~/Downloads
    just directory-ensure-rm ~/Music
    just directory-ensure-rm ~/Pictures
    just directory-ensure-rm ~/Public
    just directory-ensure-rm ~/Templates
    just directory-ensure-rm ~/Videos

# Ensure directory exists
directory-ensure-mk dir:
    #!/usr/bin/env sh
    test -d {{dir}} || mkdir {{dir}}

# Ensure directory doesn't exist
directory-ensure-rm dir:
    #!/usr/bin/env sh
    rmdir {{dir}} 2> /dev/null || true

# Link symlinks
symlinks-link:
    #!/usr/bin/env sh
    ln -s -T {{DOTFILES}} ~/.config/dotfiles 2> /dev/null
    stow --restow --target ~/. dotfiles
    true

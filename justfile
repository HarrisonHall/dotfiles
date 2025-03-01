# dotfiles installation helpers

DOTFILES := `git rev-parse --show-toplevel`
GC_DURATION := "30d"
UPDATE := "false"
SUDO := `command -v doas 2&>/dev/null && echo "doas" || echo "bash"`

# List all
[private]
default:
    @just --list

# Install config
install update=UPDATE: hier-build-base symlinks-link hier-build-extra
    #!/usr/bin/env fish
    if {{update}}
        nix-channel --update
        {{SUDO}} nix-channel --update
    end
    {{SUDO}} nixos-rebuild switch -I nixos-config="{{DOTFILES}}/pkgs/nix/configuration.nixos.nix" -j 4
    if test $status -eq 0
        {{SUDO}} nix-collect-garbage --delete-older-than {{GC_DURATION}}
        {{SUDO}} nix-store --gc
        # {{SUDO}} nixos-rebuild boot
    end
    just post-install

# Install config for shell
install-shell update=UPDATE: hier-build-base symlinks-link hier-build-extra
    #!/usr/bin/env fish
    if {{update}}
        nix-channel --update
        {{SUDO}} nix-channel --update
    end
    nix profile install -f {{DOTFILES}}/pkgs/nix/configuration.profile.nix \
        --extra-experimental-features nix-command
    if test $status -eq 0
        nix-env --delete-generations {{GC_DURATION}}
        nix-store --gc
    end
    just post-install

# Build base directories
hier-build-base:
    @just directory-ensure-mk ~/.config
    @just directory-ensure-mk ~/.local
    @just directory-ensure-mk ~/.local/share/applications
    @just directory-ensure-mk ~/downloads
    @just directory-ensure-mk ~/media
    @just directory-ensure-mk ~/media/art
    @just directory-ensure-mk ~/media/music
    @just directory-ensure-mk ~/media/wallpapers
    @just directory-ensure-mk ~/workspace
    @just directory-ensure-mk ~/workspace/bin
    @just directory-ensure-mk ~/workspace/dev
    @just directory-ensure-mk ~/workspace/dev/games
    @just directory-ensure-mk ~/workspace/games
    @just directory-ensure-mk ~/workspace/software
    @just directory-ensure-mk ~/workspace/storage

# Build extra directories
hier-build-extra:
    xdg-user-dirs-update
    @just directory-ensure-rm ~/Desktop
    @just directory-ensure-rm ~/Documents
    @just directory-ensure-rm ~/Downloads
    @just directory-ensure-rm ~/Music
    @just directory-ensure-rm ~/Pictures
    @just directory-ensure-rm ~/Public
    @just directory-ensure-rm ~/Templates
    @just directory-ensure-rm ~/Videos

# Ensure directory exists
directory-ensure-mk dir:
    #!/usr/bin/env fish
    test -d {{dir}} || mkdir -p {{dir}}

# Ensure directory doesn't exist
directory-ensure-rm dir:
    #!/usr/bin/env fish
    rmdir {{dir}} 2> /dev/null || true

# Link symlinks
symlinks-link:
    #!/usr/bin/env fish
    ln -s -T {{DOTFILES}} ~/.config/dotfiles 2> /dev/null
    pushd ~/.config/dotfiles
    stow --adopt --restow --target ~/. dotfiles
    set stowed $status
    popd
    exit $stowed

[private]
post-install:
    # Update bat.
    bat cache --build
    # Update fonts.
    fc-cache -fv

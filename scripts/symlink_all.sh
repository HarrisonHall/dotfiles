#!/usr/bin/env sh

## Args
dotfiles=$1

## Symlink dotfiles
ln -s -T "${dotfiles}" ~/.config/dotfiles >/dev/null 2>&1
 
## Symlink .config
for configuration in $(find "${dotfiles}" -maxdepth 2 -path "*/config/*"); do
    ln -s -T $configuration ~/.config/$(basename $configuration) >/dev/null 2>&1
done

## Symlink .local/share
pushd $dotfiles
ln -s -T "${dotfiles}/share/fcitx5" ~/.local/share/fcitx5 >/dev/null 2>&1
for app in $(find "${dotfiles}/share" -maxdepth 2 -path "*/applications/*"); do
    ln -s -T $app ~/.local/share/applications/$(basename $app) >/dev/null 2>&1
done
popd

## Bat setup
bat cache --build

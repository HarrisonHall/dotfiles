#!/usr/bin/env sh

## Args
configw=$1

## Symlink configw
ln -s -T "${configw}" ~/.config/configw >/dev/null 2>&1
 
## Symlink .config
for configuration in $(find "${configw}" -maxdepth 2 -path "*/config/*"); do
    ln -s -T $configuration ~/.config/$(basename $configuration) >/dev/null 2>&1
done

## Symlink .local/share
pushd $configw
ln -s -T "${configw}/share/fcitx5" ~/.local/share/fcitx5 >/dev/null 2>&1
for app in $(find "${configw}/share" -maxdepth 2 -path "*/applications/*"); do
    ln -s -T $app ~/.local/share/applications/$(basename $app) >/dev/null 2>&1
done
popd

## Bat setup
bat cache --build

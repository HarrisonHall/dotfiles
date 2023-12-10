#!/usr/bin/env sh

## Args
configw=$1

## Symlink configw
ln -s -T "${configw}" ~/.config/configw >/dev/null 2>&1
 
## Symlink .config
for configuration in $(find "${configw}" -maxdepth 2 -path "*/.config/*"); do
    ln -s -T $configuration ~/.config/$(basename $configuration) >/dev/null 2>&1
done

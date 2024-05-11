#!/usr/bin/env sh

ensure_dir() {
    dir=$1
    test -d $dir || mkdir $dir
}

ensure_rm() {
    dir=$1
    rmdir $dir 2> /dev/null
}

ensure_dir ~/downloads
ensure_dir ~/media
ensure_dir ~/media/music
ensure_dir ~/workspace

xdg-user-dirs-update

ensure_rm ~/Desktop
ensure_rm ~/Documents
ensure_rm ~/Downloads
ensure_rm ~/Music
ensure_rm ~/Pictures
ensure_rm ~/Public
ensure_rm ~/Templates
ensure_rm ~/Videos

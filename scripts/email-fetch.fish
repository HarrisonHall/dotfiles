#!/usr/bin/env fish

mkdir -p ~/.cache/mail/feeds.hachha
mbsync -c ~/.config/mbsync/.mbsyncrc -a

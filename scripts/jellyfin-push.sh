#!/usr/bin/env sh

repo=$1
playlist=$2
JELLYFIN=/mnt/backup/jellyfin/media

set -x
set -e

# scp -r $repo home-server:$FINAL
rsync -r $repo --mkpath home-server:$JELLYFIN/$playlist/.

exit $?

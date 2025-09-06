#!/usr/bin/env sh

repo=$1
playlist=$2
JELLYFIN=/mnt/backup/jellyfin/media

set -x
set -e

# scp -r $repo home-server:$FINAL
# rsync --mkpath -auL -r $repo home-server:$JELLYFIN/$playlist/.
rsync -auL -r $repo home-server:$JELLYFIN/$playlist/.

exit $?

#!/usr/bin/env fish

set repo (string trim $argv[1] -c "/")
set playlist $argv[2]
set JELLYFIN /mnt/backup/jellyfin/media

rsync -auL -r $repo home-server:$JELLYFIN/.

exit $status

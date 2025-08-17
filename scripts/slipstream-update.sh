#!/usr/bin/env sh

LOCAL=~/.config/slipstream/slipstream.toml
FINAL=workspace/dev/slipknot/slipstream.toml
COMMAND=workspace/dev/slipknot/run.sh

set -x
set -e

scp $LOCAL web-server:$FINAL || exit 1
ssh web-server -t $COMMAND

exit $?

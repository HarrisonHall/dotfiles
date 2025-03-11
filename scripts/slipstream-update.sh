#!/usr/bin/env sh

LOCAL=~/.config/slipstream/slipstream.toml
FINAL=workspace/dev/slipknot/slipstream.toml
COMMAND=workspace/dev/slipknot/run.sh

set -x
set -e

scp $LOCAL web-server:$FINAL
ssh web-server -t $COMMAND

exit $?

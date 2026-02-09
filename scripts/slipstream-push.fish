#!/usr/bin/env fish

set repo ~/workspace/dev/slipstream

# Copy config.
scp ~/.config/slipstream/slipstream.toml root@web-server:.
scp "$repo/target/x86_64-unknown-linux-gnu/release/slipstream" root@web-server:.

exit $status

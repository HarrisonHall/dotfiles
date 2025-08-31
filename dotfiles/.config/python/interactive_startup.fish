#!/usr/bin/env fish

set -x PYTHON_STARTUP ~/.config/python/interactive_startup.py
ghostty -e "echo $PATH && sleep 20"
exit $status

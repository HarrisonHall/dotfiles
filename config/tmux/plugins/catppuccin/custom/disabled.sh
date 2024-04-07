#!/bin/sh

show_disabled() { # This function name must match the module name!
  local index icon color text module

  index=$1 # This variable is used internally by the module loader in order to know the position of this module

  disabled_option=$(tmux show-options | grep -i "@suspended" | cut -d" " -f2)
  if [ "$disabled_option" = "true" ];
  then
    icon=""
    color="$( get_tmux_option "@catppuccin_disabled_color" "$thm_red" )"
    text="$(  get_tmux_option "@catppuccin_disabled_text"  "F12" )"
  else
    icon=""
    color="$( get_tmux_option "@catppuccin_disabled_color" "$thm_blue" )"
    text="$(  get_tmux_option "@catppuccin_disabled_text"  "F12" )"
  fi

  module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
}

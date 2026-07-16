show_uptime() {
  local index icon color text module

  index=$1
  icon="$(get_tmux_option "@status_uptime_icon" "󰔟")"
  color="$(get_tmux_option "@status_uptime_color" "$thm_green")"
  text="$(get_tmux_option "@status_uptime_text" "#(uptime | sed 's/^[^,]*up *//; s/, *[[:digit:]]* users.*//; s/ day.*, */d /; s/:/h /; s/ min//; s/$/m/')")"

  module=$(build_status_module "$index" "$icon" "$color" "$text")

  echo "$module"
}

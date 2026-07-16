# Requires https://github.com/arl/gitmux

show_gitmux() {
  local index icon color text module

  index=$1
  icon="$(get_tmux_option "@status_gitmux_icon"  "󰊢")"
  color="$(get_tmux_option "@status_gitmux_color" "$thm_green")"
  text="$(get_tmux_option "@status_gitmux_text"  "#(gitmux \"#{pane_current_path}\")")"

  module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
}

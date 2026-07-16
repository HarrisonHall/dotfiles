# Requires https://github.com/xamut/tmux-weather.

show_weather() {
  local index icon color text module

  index=$1
  icon="$(get_tmux_option "@status_weather_icon" "")"
  color="$(get_tmux_option "@status_weather_color" "$thm_yellow")"
  text="$(get_tmux_option "@status_weather_text" "#{weather}")"

  module=$(build_status_module "$index" "$icon" "$color" "$text")

  echo "$module"
}

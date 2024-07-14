#!/usr/bin/env bash

## Author  : Harrison Hall
## Applets : Help

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

NL="&#x0a;"  # Manual newline

# Rofi uses pango markup

ICON="?"

apps="<b>Applications:</b>\t\t [Super]+S"
all_apps="<b>All Applications:</b> [Super]+[Shift]+S"
terminal="<b>Terminal:</b> [Super]+[Shift]+T"
move_focus="<b>Move Focus:</b> [Super]+(h|j|k|l)"
swap_window="<b>Swap Window:</b> [Super]+[Shift]+(h|j|k|l)"
move_window="<b>Move Window:</b> [Super]+[Shift]+{number}"
resize_window="<b>Resize Window:</b> [Super]+Q"
scratchpad="<b>Scratchpad:</b> [Super]+[Shift]+-"
close_window="<b>Close Window:</b> [Super]+[Shift]+W"
float_window="<b>Close Window:</b> [Super]+F"
fullscreen="<b>Fullscreen:</b> [Super]+M"
screenshot="<b>Screenshot:</b> [PrtScrn], (s|?)"
lock="<b>Lock:</b> [Super]+L"
powermenu="<b>Power Menu:</b> [Super]+[Shift]+Q"
help="<b>Help:</b> [Super]+?"

# Theme Elements
prompt="Help"
# mesg="${applications}${NL}Foo"
mesg=$(cat <<EOF 
<tt>\
$apps
$all_apps
$terminal
$move_focus
$swap_window
$move_window
$resize_window
$scratchpad
$close_window
$float_window
$fullscreen
$screenshot
$powermenu
$help \
</tt> 
EOF
)

list_col='0'
list_row='0'
win_width='450px'

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "textbox-prompt-colon {str: \"$ICON\";}" \
		-theme-str "element {padding: 0px 0px;}" \
		-theme-str "listview {columns: 0; lines: 0; spacing: 0px;}" \
		-theme-str "message {padding: 20px;}" \
		-theme-str "prompt {padding: 10px;}" \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		${active} ${urgent} \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	rofi_cmd
}

# Execute
run_rofi

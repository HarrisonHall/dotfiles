# Status

This theme is a reskin of the old official Catppuccin tmux plugin.

## Configuration options

All flavors support certain levels of customization that match our [Catppuccin
Style Guide][style-guide]. To add these customizations, add any of the following
options to your Tmux configuration.

### Window

### Set the window separator

```sh
set -g @status_window_separator ""
```

#### Set the window left separator:

```sh
set -g @status_window_left_separator "█"
```

#### Set the window middle separator:

```sh
set -g @status_window_middle_separator "█"
```

#### Set the window right separator:

```sh
set -g @status_window_right_separator "█"
```

#### Position the number:

```sh
set -g @status_window_number_position "left"
```

Values:

- left - the number will be on the left part of the window
- right - the number will be on the right part of the window

#### Enable window status:

```sh
set -g @status_window_status_enable "yes"
```

Values:

- yes - this will enable the window status part
- no - this will disable the window status part

#### Enable window status icons instead of text:

```sh
set -g @status_window_status_icon_enable "yes"
```

Values:

- yes - this will replace the windows status text with icons
- no - this will keep the windows status in text format

#### Override windows status icons

```sh
set -g @status_icon_window_last "󰖰 "
set -g @status_icon_window_current "󰖯 "
set -g @status_icon_window_zoom "󰁌 "
set -g @status_icon_window_mark "󰃀 "
set -g @status_icon_window_silent "󰂛 "
set -g @status_icon_window_activity "󱅫 "
set -g @status_icon_window_bell "󰂞 "
```

### Window default

#### Set the window default color fill:

```sh
set -g @status_window_default_fill "number"
```

Values:

- number - only the number of the window part will have color
- all - the entire window part will have the same color
- none - the entire window part will have no color

#### Override the window default colors:

```sh
set -g @status_window_default_color "color" # text color
set -g @status_window_default_background "color"
```

Values:

- color - a hexadecimal color value

#### Override the window default text:

```sh
set -g @status_window_default_text "#{b:pane_current_path}" # use "#W" for application instead of directory
```

### Window current

#### Set the window current color fill:

```sh
set -g @status_window_current_fill "number"
```

Values:

- number - only the number of the window part will have color
- all - the entire window part will have the same color
- none - the entire window part will have no color

#### Override the window current colors:

```sh
set -g @status_window_current_color "color" # text color
set -g @status_window_current_background "color"
```

Values:

- color - a hexadecimal color value

#### Override the window current text:

```sh
set -g @status_window_current_text "#{b:pane_current_path}" # use "#W" for application instead of directory
```

#### Set the current directory format

```sh
set -g @status_window_current_format_directory_text "#{b:pane_current_path}"
```

Use this to override the way the current directory is displayed.

#### Set the directory format

```sh
set -g @status_window_format_directory_text "#{b:pane_current_path}"
```

Use this to override the way the directory is displayed.

### Pane

#### Set the pane border style:

```sh
set -g @status_pane_border_style "fg=blue" # Use a value compatible with the standard tmux 'pane-border-style'
```

#### Set the pane active border style:

```sh
set -g @status_pane_active_border_style "fg=red" # Use a value compatible with the standard tmux 'pane-border-active-style'
```

### Status

#### Set the default status bar visibility

```sh
set -g @status_status_default "off" # defaults to "on"

```

#### Override the default status background color

```sh
set -g @status_status_background "theme"
```

This will overwrite the status bar background:

- "theme" will use the color from the selected theme
- "default" will make the status bar transparent
- use hex color codes for other colors

Note: you need to restart tmux for this to take effect:

```sh
tmux kill-server & tmux
```

#### Set the status module left separator:

```sh
set -g @status_status_left_separator ""
```

#### Set the status module right separator:

```sh
set -g @status_status_right_separator "█"
```

#### Set the status connect separator:

```sh
set -g @status_status_connect_separator "yes"
```

Values:

- yes - the background color of the separator will not blend in with the
  background color of tmux
- no - the background color of the separator will blend in with the background
  color of tmux

#### Set the status module color fill:

```sh
set -g @status_status_fill "icon"
```

Values:

- icon - only the icon of the module will have color
- all - the entire module will have the same color

#### Set the status module justify value:

```sh
set -g @status_status_justify "left"
```

Values:

- left
- centre - puts the window list in the relative centre of the available free
  space
- right
- absolute-centre - uses the centre of the entire horizontal space

### Pane

```sh
tmux_orange="#fab387"
set -g @status_pane_status_enabled "yes"
set -g @status_pane_border_status "top"
set -g @status_pane_left_separator ""
set -g @status_pane_right_separator ""
set -g @status_pane_middle_separator "█ "
set -g @status_pane_number_position "left"
set -g @status_pane_default_fill "number"
set -g @status_pane_default_text "#{b:pane_current_path}"
set -g @status_pane_border_style "fg=$tmux_orange"
set -g @status_pane_active_border_style "fg=$tmux_orange"
set -g @status_pane_color "$tmux_orange"
set -g @status_pane_background_color "$tmux_orange"
```

#### Set the module list

```sh
set -g @status_status_modules_right "application session"
set -g @status_status_modules_left ""
```

Provide a list of modules and the order in which you want them to appear in the
status.

Available modules:

- application - display the current window running application
- directory - display the basename of the current window path
- session - display the number of tmux sessions running
- user - display the username
- host - display the hostname
- date_time - display the date and time
- uptime - display the uptime
- [battery](#battery-module) - display the battery

### Customizing modules

Every module (except the module "session") supports the following overrides:

#### Override the specific module icon

```sh
set -g @status_[module_name]_icon "icon"
```

#### Override the specific module color

```sh
set -g @status_[module_name]_color "color"
```

#### Override the specific module text

```sh
set -g @status_[module_name]_text "text"
```

#### Removing a specific module option

```sh
set -g @status_[module_name]_[option] "null"
```

This is for the situation where you want to remove the icon from a module. Ex:

```sh
set -g @status_date_time_icon "null"
```

### Battery module

#### Requirements

This module depends on
[tmux-battery](https://github.com/tmux-plugins/tmux-battery/tree/master).

#### Install

The preferred way to install tmux-battery is using
[TPM](https://github.com/tmux-plugins/tpm).

#### Configure

Load tmux-battery after you load catppuccin.

```sh
set -g @plugin 'catppuccin/tmux'
...
set -g @plugin 'tmux-plugins/tmux-battery'
```

Add the battery module to the status modules list.

```sh
set -g @status_status_modules_right "... battery ..."
```

### CPU module

#### Requirements

This module depends on
[tmux-cpu](https://github.com/tmux-plugins/tmux-cpu/tree/master).

#### Install

The preferred way to install tmux-cpu is using
[TPM](https://github.com/tmux-plugins/tpm).

#### Configure

Load tmux-cpu after you load catppuccin.

```sh
set -g @plugin 'catppuccin/tmux'
...
set -g @plugin 'tmux-plugins/tmux-cpu'
```

Add the cpu module to the status modules list.

```sh
set -g @status_status_modules_right "... cpu ..."
```

### Weather modules

#### tmux-weather

##### Requirements

This module depends on [tmux-weather](https://github.com/xamut/tmux-weather).

##### Install

The preferred way to install tmux-weather is using
[TPM](https://github.com/tmux-plugins/tpm).

##### Configure

Load tmux-weather after you load catppuccin.

```sh
set -g @plugin 'catppuccin/tmux'
...
set -g @plugin 'xamut/tmux-weather'
```

Add the weather module to the status modules list.

```sh
set -g @status_status_modules_right "... weather ..."
```

#### tmux-clima

##### Requirements

This module depends on [tmux-clima](https://github.com/vascomfnunes/tmux-clima).

##### Install

The preferred way to install tmux-clima is using
[TPM](https://github.com/tmux-plugins/tpm).

##### Configure

Load tmux-clima after you load catppuccin.

```sh
set -g @plugin 'catppuccin/tmux'
...
set -g @plugin 'vascomfnunes/tmux-clima'
```

Add the weather module to the status modules list.

```sh
set -g @status_status_modules_right "... clima ..."
```

### Load module

#### Requirements

This module depends on [tmux-loadavg](https://github.com/jamesoff/tmux-loadavg).

#### Install

The preferred way to install tmux-loadavg is using
[TPM](https://github.com/tmux-plugins/tpm).

#### Configure

Load tmux-loadavg after you load catppuccin.

```sh
set -g @plugin 'catppuccin/tmux'
...
set -g @plugin 'jamesoff/tmux-loadavg'
```

Add the load module to the status modules list.

```sh
set -g @status_status_modules_right "... load ..."
```

### Gitmux module

#### Requirements

This module depends on [gitmux](https://github.com/arl/gitmux).

#### Install

To install gitmux, follow the instructions in the
[gitmux documentation](https://github.com/arl/gitmux/blob/main/README.md#installing).

#### Configure

Add the gitmux module to the status modules list.

```sh
set -g @status_status_modules_right "... gitmux ..."
```

To customize the gitmux module, you can follow the instrucctions in the
[gitmux documentation](https://github.com/arl/gitmux/blob/main/README.md#customizing)
and add this line in your tmux configuration:

```sh
set -g @status_gitmux_text "#(gitmux -cfg $HOME/.gitmux.conf \"#{pane_current_path}\")"
```

## Create a custom module

It is possible to add a new custom module or overwrite any of the existing
modules.

For further details, see the documentation in
[custom/README.md](custom/README.md)

Any file added to the custom folder will be preserved when updating catppuccin.

## Configuration Examples

Below are provided a few configurations as examples or starting points.

Note: When switching between configurations run:

```sh
tmux kill-server
```

To kill the tmux server and clear all global variables.

### Config 1

![Default](./assets/config1.png)

```sh
set -g @status_window_right_separator "█ "
set -g @status_window_number_position "right"
set -g @status_window_middle_separator " | "

set -g @status_window_default_fill "none"

set -g @status_window_current_fill "all"

set -g @status_status_modules_right "application session user host date_time"
set -g @status_status_left_separator "█"
set -g @status_status_right_separator "█"

set -g @status_date_time_text "%Y-%m-%d %H:%M:%S"
```

### Config 2

![Default](./assets/config2.png)

```sh
set -g @status_window_left_separator "█"
set -g @status_window_right_separator "█ "
set -g @status_window_number_position "right"
set -g @status_window_middle_separator "  █"

set -g @status_window_default_fill "number"

set -g @status_window_current_fill "number"
set -g @status_window_current_text "#{pane_current_path}"

set -g @status_status_modules_right "application session date_time"
set -g @status_status_left_separator  ""
set -g @status_status_right_separator " "
set -g @status_status_fill "all"
set -g @status_status_connect_separator "yes"
```

### Config 3

![Default](./assets/config3.png)

```sh
set -g @status_window_left_separator ""
set -g @status_window_right_separator " "
set -g @status_window_middle_separator " █"
set -g @status_window_number_position "right"

set -g @status_window_default_fill "number"
set -g @status_window_default_text "#W"

set -g @status_window_current_fill "number"
set -g @status_window_current_text "#W"

set -g @status_status_modules_right "directory user host session"
set -g @status_status_left_separator  " "
set -g @status_status_right_separator ""
set -g @status_status_fill "icon"
set -g @status_status_connect_separator "no"

set -g @status_directory_text "#{pane_current_path}"
```

[style-guide]:
  https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md

## 💝 Thanks to

- [Pocco81](https://github.com/catppuccin)
- [vinnyA3](https://github.com/vinnyA3)
- [rogeruiz](https://github.com/rogeruiz)

&nbsp;

<p align="center"><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" /></p>
<p align="center">Copyright &copy; 2021-present <a href="https://github.com/catppuccin" target="_blank">Catppuccin Org</a>
<p align="center"><a href="https://github.com/catppuccin/catppuccin/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=d9e0ee&colorA=363a4f&colorB=b7bdf8"/></a></p>

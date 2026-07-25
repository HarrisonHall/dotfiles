# https://github.com/refr4g/onyx/blob/master/fish/conf.d/oxocarbon.fish
# ══════════════════════════════════════════════════════════════
#  Oxocarbon (IBM Carbon) — fish syntax palette
#  Colors only. Bindings/aliases live in config.fish, prompt in
#  functions/fish_prompt.fish. To change themes, swap this file.
#  Reload after edits:  exec fish
#
#  Design rule: each token type gets ONE distinct hue so the line
#  reads with contrast. Purple is reserved for identity + keywords.
# ══════════════════════════════════════════════════════════════

# ── palette ───────────────────────────────────────────────────
set -l bg 161616 # near-black
set -l fg f2f4f8 # off-white
set -l blue 00b2ff # blue
set -l cyan 82cfff # light cyan
set -l azure 33b1ff # sky blue
set -l teal 3ddbd9 # teal
set -l green 42be65 # green
set -l pink ee5396 # pink
set -l purple be95ff # purple (identity + keywords)
set -l magenta ff7eb6 # magenta
set -l red fa4d56 # red (errors)
set -l comment 525252 # gray
set -l sel 262626 # selection background

# ── core syntax — one hue per token type ──────────────────────
set -g fish_color_normal $fg
set -g fish_color_command $blue # the command / executable (periwinkle blue)
set -g fish_color_keyword $purple # if / for / function / and / or
set -g fish_color_param $teal # arguments / paths
set -g fish_color_option $pink # --flags
set -g fish_color_quote $green # "strings" (green reads naturally here)
set -g fish_color_redirection $magenta # > >> |
set -g fish_color_end $magenta # ; & terminators
set -g fish_color_operator $magenta # * ~ math ops
set -g fish_color_escape $teal # \n \t escapes
set -g fish_color_comment $comment # # comments
set -g fish_color_error $red --bold # syntax errors
set -g fish_color_autosuggestion $comment # ghost suggestions
set -g fish_color_valid_path --underline

# ── prompt / context (custom prompt overrides most of these) ──
set -g fish_color_cwd $teal
set -g fish_color_cwd_root $red
set -g fish_color_user $purple
set -g fish_color_host $purple
set -g fish_color_host_remote $teal
set -g fish_color_status $red

# ── matching / selection ──────────────────────────────────────
set -g fish_color_match $magenta
set -g fish_color_selection $fg --bold --background=$sel
set -g fish_color_search_match --bold --background=$sel
set -g fish_color_history_current --bold
set -g fish_color_cancel $red

# ── completion pager ──────────────────────────────────────────
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $blue --bold
set -g fish_pager_color_completion $fg
set -g fish_pager_color_description $purple
set -g fish_pager_color_selected_background --background=$sel

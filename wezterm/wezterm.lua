local wezterm = require "wezterm"

return {
  font_size = 10,
  font = wezterm.font "JetBrains Mono NL",

  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,

  color_scheme = "Catppuccin Frappe",
  window_decorations = "RESIZE",
}

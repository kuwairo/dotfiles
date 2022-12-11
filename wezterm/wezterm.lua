local wezterm = require "wezterm"

return {
  font_size = 10,
  font = wezterm.font "JetBrains Mono",

  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,

  color_scheme = "nightfox",
  window_decorations = "RESIZE",
}

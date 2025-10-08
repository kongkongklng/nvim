return function(wezterm, config)
  config.initial_cols = 120
  config.initial_rows = 28
  config.window_decorations = "RESIZE"
  config.use_fancy_tab_bar = false
  config.tab_max_width = 25
  config.hide_tab_bar_if_only_one_tab = false
  config.font_size = 12
  config.color_scheme = 'Catppuccin Mocha'
  config.font = wezterm.font('JetBrains Mono', { weight = 'Bold', italic = true })
  config.default_prog = { 'C:\\Users\\Mayn\\AppData\\Local\\Programs\\nu\\bin\\nu.exe' }
  config.window_padding = { top = 0 }

  wezterm.on("gui-startup", function(cmd)
    local screen = wezterm.gui.screens().active
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {})

    -- 先设置窗口内容尺寸
    local inner_width = screen.width * 0.5
    local inner_height = screen.height * 0.5
    window:gui_window():set_inner_size(inner_width, inner_height)

    -- 获取窗口实际外框尺寸
    local outer_width, outer_height = window:gui_window():get_outer_size()

    -- 计算居中坐标
    local x = (screen.width - outer_width) / 2
    local y = (screen.height - outer_height) / 2
    window:gui_window():set_outer_position(x, y)
  end)
end

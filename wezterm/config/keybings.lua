return function(wezterm, config)
  local act = wezterm.action

  config.keys = {
    { key = 'Enter',      mods = 'CTRL',  action = act.ToggleFullScreen },
    { key = 'Enter',      mods = 'ALT',   action = act.DisableDefaultAssignment },
    { key = 't',          mods = 'ALT',   action = act.SpawnTab("DefaultDomain") },
    { key = 'm',          mods = 'ALT',   action = act.ShowTabNavigator },
    { key = 'w',          mods = 'ALT',   action = act.CloseCurrentPane { confirm = true } },
    { key = 'n',          mods = 'SUPER', action = act.SpawnWindow },
    { key = 'd',          mods = 'ALT',   action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = 'D',          mods = 'ALT',   action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = 'h',          mods = 'ALT',   action = act.ActivatePaneDirection("Left") },
    { key = 'j',          mods = 'ALT',   action = act.ActivatePaneDirection("Down") },
    { key = 'k',          mods = 'ALT',   action = act.ActivatePaneDirection("Up") },
    { key = 'l',          mods = 'ALT',   action = act.ActivatePaneDirection("Right") },
    { key = 'LeftArrow',  mods = 'ALT',   action = act.AdjustPaneSize { "Left", 5 } },
    { key = 'DownArrow',  mods = 'ALT',   action = act.AdjustPaneSize { "Down", 5 } },
    { key = 'UpArrow',    mods = 'ALT',   action = act.AdjustPaneSize { "Up", 5 } },
    { key = 'RightArrow', mods = 'ALT',   action = act.AdjustPaneSize { "Right", 5 } },
    { key = 'L',          mods = 'ALT',   action = act.ActivateTabRelative(1) },
    { key = 'H',          mods = 'ALT',   action = act.ActivateTabRelative(-1) },

    -- 新增快捷键
    { key = 't', mods = 'CTRL',  action = act.SpawnTab("DefaultDomain") }, -- Ctrl+T 新建 tab
    { key = 'w', mods = 'CTRL',  action = act.CloseCurrentTab { confirm = true } }, -- Ctrl+W 关闭 tab
    { key = 'Tab', mods = 'SHIFT', action = act.ActivateTabRelative(-1) }, -- Shift+Tab 切换 tab
    { key = 't', mods = 'ALT',   action = act.SpawnWindow }, -- Alt+T 新建窗口

    -- Ctrl+B: 分屏（限制最多 3 个 pane）
    {
      key = 'b',
      mods = 'CTRL',
      action = wezterm.action_callback(function(window, pane)
        local tab = window:active_tab()
        local panes = tab:panes()

        if #panes == 1 then
          -- 第一次：左右分屏
          window:perform_action(
            wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
            pane
          )
        elseif #panes == 2 then
          -- 第二次：右边 Pane 再上下分屏
          local right_pane = panes[2] -- 第二个是右边的
          window:perform_action(
            wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
            right_pane
          )
        else
          window:toast_notification("WezTerm", "最多 3 个终端 Pane (+ 布局)", nil, 3000)
        end
      end),
    },

    -- Ctrl+N: 在多个 Pane 之间切换
    { key = 'n', mods = 'CTRL', action = act.ActivatePaneDirection("Next") },
  }

  -- 鼠标绑定：左键复制，右键粘贴
  config.mouse_bindings = {
    {
      event = { Down = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = act.SelectTextAtMouseCursor("Cell"),
    },
    {
      event = { Drag = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = act.ExtendSelectionToMouseCursor("Cell"),
    },
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = act.CompleteSelection("ClipboardAndPrimarySelection"),
    },
    {
      event = { Down = { streak = 1, button = "Right" } },
      mods = "NONE",
      action = act.PasteFrom("Clipboard"),
    },
  }
end

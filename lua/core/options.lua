local opt = vim.opt

-- 行号
opt.relativenumber = true
opt.number = true

-- 缩进
opt.tabstop = 4        -- 制表符显示为4个空格宽
opt.shiftwidth = 4     -- 用于自动缩进的宽度
opt.expandtab = false  -- 使用制表符进行缩进
opt.autoindent = true

-- 防止包裹
opt.wrap = false

-- 光标行
opt.cursorline = false

-- 启用鼠标
opt.mouse:append("a")

-- 系统剪贴板
opt.clipboard:append("unnamedplus")

-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true

-- 外观
opt.termguicolors = true
opt.signcolumn = "yes"

-- 设置主题
vim.cmd[[colorscheme nord]]

vim.defer_fn(function()
  vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = "#85EEA7" })
  vim.api.nvim_set_hl(0, "iCursor", { fg = "#000000", bg = "#85EEA7" })
  vim.api.nvim_set_hl(0, "TermCursor", { fg = "#000000", bg = "#85EEA7" })
  vim.api.nvim_set_hl(0, "TermCursorNC", { fg = "#000000", bg = "#85EEA7" })
end, 10)

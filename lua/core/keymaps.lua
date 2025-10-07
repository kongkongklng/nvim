vim.g.mapleader = " "

local keymap = vim.keymap

-- ---------- 插入模式 ---------- ---
keymap.set("i", "jk", "<ESC>")

-- ---------- 视觉模式 ---------- ---
-- 单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ---------- 正常模式 ---------- ---
-- 窗口
keymap.set("n", "<leader>sv", "<C-w>v") -- 水平新增窗口 
keymap.set("n", "<leader>sh", "<C-w>s") -- 垂直新增窗口

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
keymap.set("n", "<leader>o", ":NvimTreeToggle<CR>")

-- 切换buffer
keymap.set("n", "<S-L>", ":bnext<CR>")
keymap.set("n", "<S-H>", ":bprevious<CR>")
keymap.set("n", "<leader>x", ":bdelete<CR>")

-- 快速重载配置
keymap.set("n", "<leader>so", ":source $MYVIMRC<CR>", { desc = "Reload Neovim config" })

-- 注释：将 Ctrl+/ 映射为切换注释（兼容终端通常识别为 Ctrl-_）
-- 正常模式：切换当前行注释
keymap.set(
  "n",
  "<C-_>",
  function()
    require("Comment.api").toggle.linewise.current()
  end,
  { noremap = true, silent = true, desc = "Toggle comment (linewise)" }
)
-- 某些终端会产生 <C-/>，双映射以增强兼容性
keymap.set(
  "n",
  "<C-/>",
  function()
    require("Comment.api").toggle.linewise.current()
  end,
  { noremap = true, silent = true, desc = "Toggle comment (linewise)" }
)

-- 可视/选择模式：对选区切换注释（使用 x 模式以保留选区）
keymap.set(
  "x",
  "<C-_>",
  function()
    require("Comment.api").toggle.linewise(vim.fn.visualmode())
  end,
  { noremap = true, silent = true, desc = "Toggle comment (visual)" }
)
keymap.set(
  "x",
  "<C-/>",
  function()
    require("Comment.api").toggle.linewise(vim.fn.visualmode())
  end,
  { noremap = true, silent = true, desc = "Toggle comment (visual)" }
)

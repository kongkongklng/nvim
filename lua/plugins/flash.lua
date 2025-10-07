local ok, flash = pcall(require, "flash")
if not ok then
  return
end

flash.setup({
  modes = {
    search = {
      enabled = true,
      highlight = { backdrop = false },
    },
  },
})

vim.keymap.set({ "n", "o", "x" }, "s", flash.jump, { desc = "Flash 搜索跳转" })
vim.keymap.set({ "n", "o", "x" }, "S", flash.treesitter, { desc = "Flash 语法节点跳转" })
vim.keymap.set({ "o" }, "r", flash.remote, { desc = "Flash 远程动作" })
vim.keymap.set({ "o", "x" }, "R", flash.treesitter_search, { desc = "Flash 范围搜索" })
vim.keymap.set({ "n", "o", "x" }, "<c-s>", flash.toggle, { desc = "Toggle Flash 搜索" })




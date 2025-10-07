local ok, yazi = pcall(require, "yazi")
if not ok then
  return
end

yazi.setup()

vim.keymap.set("n", "<leader>fy", "<cmd>Yazi<CR>", { desc = "打开 Yazi 文件管理器" })
vim.keymap.set("n", "-", "<cmd>Yazi<CR>", { desc = "在当前目录使用 Yazi" })




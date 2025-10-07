local ok, code_runner = pcall(require, "code_runner")
if not ok then
  return
end

code_runner.setup({
  mode = "float",
  startinsert = true,
  focus = false,
  float = {
    border = "rounded",
  },
  filetype = {
    python = "python $fileName",
    javascript = "node $fileName",
    typescript = "deno run $fileName",
    lua = "lua $fileName",
    go = "go run $fileName",
    rust = "cargo run",
    sh = "bash $fileName",
    c = "gcc $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
    cpp = "g++ $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
  },
})

vim.keymap.set("n", "<leader>rr", ":RunCode<CR>", { desc = "运行当前文件" })
vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", { desc = "运行当前文件 (旧命令)" })
vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { desc = "运行项目命令" })
vim.keymap.set("n", "<leader>rt", ":RunClose<CR>", { desc = "关闭运行终端" })
vim.keymap.set("n", "<C-F5>", ":RunCode<CR>", { desc = "Ctrl+F5 运行当前文件" })


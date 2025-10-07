local toggleterm = require("toggleterm")

toggleterm.setup {
        size = 20,
        start_in_insert = true,
        open_mapping = [[<A-p>]],
        shell = '"C:\\Program Files\\nu\\bin\\nu.exe"',
        direction = 'float',
        hide_numbers = true,
        shade_filetypes = {},
        shading_factor = 2,
        persist_size = true,
        insert_mappings = true,
        terminal_mappings = true,
        close_on_exit = true,
        winbar = 'Terminal',
}

local Terminal = require("toggleterm.terminal").Terminal

local lazygit_term = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        close_on_exit = false,
})

vim.keymap.set("n", "<leader>gg", function()
        lazygit_term:toggle()
end, { desc = "Toggle Lazygit" })

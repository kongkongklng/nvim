-- 定义 LSP 客户端的通用配置
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "pyright", -- Python LSP 服务器
        -- "lua_ls" 
    },
    automatic_installation = true,
})

-- Python LSP
require('lspconfig').pyright.setup({
    capabilities = capabilities,
    cmd = { "cmd.exe", "/c", [[C:\Users\kongklng\AppData\Local\nvim-data\mason\bin\pyright-langserver.cmd]], "--stdio" },
    settings = {
        pyright = {
            disableLanguageServices = false,
            disableOrganizeImports = false,
        },
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
            },
        },
    },
})

return {
    { "williamboman/mason.nvim", config = true },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            local mason_lspconfig = require("mason-lspconfig")

            local handlers = {
                function (server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,
            }

            mason_lspconfig.setup {
                handlers = handlers,
                ensure_installed = {
                    "lua_ls", "rust_analyzer@nightly", "clangd", "tsserver"
                },
            }
            mason_lspconfig.setup_handlers(handlers)
        end,
    },
}

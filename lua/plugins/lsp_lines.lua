return {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    lazy = false,
    keys = {
        {
            "<leader>l",
            function() require("lsp_lines").toggle() end,
            desc = "Toggle lsp_lines",
            mode = { "n" },
        }
    },
    config = function()
        -- Disable virtual_text since it's redundant due to lsp_lines.
        vim.diagnostic.config({ virtual_text = false })
        require("lsp_lines").setup()
    end,
}

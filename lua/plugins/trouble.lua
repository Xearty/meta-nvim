return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        {
            height = 10, -- height of the trouble list when position is top or bottom
            -- mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
            -- padding = true, -- add an extra new line on top of the list
            cycle_results = false,       -- cycle item list when reaching beginning or end of list
            auto_close = true,           -- automatically close the list when you have no diagnostics
            use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
        }
    },
    keys = {
        {
            "<leader>xx",
            function() require("trouble").toggle() end,
            desc = "Toggles trouble",
            mode = { "n" },
        },
    },
}

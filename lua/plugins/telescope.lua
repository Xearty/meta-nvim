return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    tag = '0.1.5',
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        "desdic/telescope-rooter.nvim",
    },
    keys = {
        {
            "<leader>ff",
            function() require("telescope.builtin").find_files() end,
            desc = "Find files",
        },
        {
            "<leader>fc",
            function() require("telescope.builtin").current_buffer_fuzzy_find() end,
            desc = "Fuzzy search in current buffer",
        },
        {
            "<leader>fb",
            function() require("telescope.builtin").git_branches() end,
            desc = "Find git branches",
        },
        {
            "<leader>fg",
            function() require("telescope.builtin").live_grep() end,
            desc = "Live grep",
        },
        {
            "<leader>fs",
            function() require("telescope.builtin").grep_string() end,
            desc = "Grep string under cursor",
        },
        {
            "<leader>fq",
            function() require("telescope.builtin").quickfix() end,
            desc = "Items in quickfix list",
        },
        {
            "<leader>fd",
            function() require("telescope.builtin").diagnostics() end,
            desc = "LSP diagnostics",
        },
        {
            "<leader>fic",
            function() require("telescope.builtin").lsp_incoming_calls() end,
            desc = "LSP incoming calls",
        },
        {
            "<leader>foc",
            function() require("telescope.builtin").lsp_outgoing_calls() end,
            desc = "LSP outgoing calls",
        },
        {
            "gr",
            function() require("telescope.builtin").lsp_references() end,
            desc = "LSP references for word under cursor",
        },
        {
            "gd",
            function() require("telescope.builtin").lsp_definitions() end,
            desc = "LSP definitions",
        },
        {
            "<C-LeftMouse",
            function() require("telescope.builtin").lsp_definitions() end,
            desc = "LSP definitions",
        },
        {
            "gi",
            function() require("telescope.builtin").lsp_implementations() end,
            desc = "LSP implementations",
        },
        {
            "<leader>fcc",
            function() require("telescope.builtin").git_commits() end,
            desc = "Find git commits",
        },
        {
            "<leader>fcb",
            function() require("telescope.builtin").git_bcommits() end,
            desc = "Find git commits in current branch",
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        telescope.setup {
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-u>"] = false,
                    },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                rooter = {
                    enable = true,
                    patterns = { ".git" },
                    debug = false,
                }
            },
        }
        telescope.load_extension("fzf")
        telescope.load_extension("rooter")
        telescope.load_extension("notify") -- needed for noice.nvim
    end,
}

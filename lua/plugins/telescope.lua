return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        {
            "<leader>gb",
            function()
                require("telescope.builtin").git_branches()
            end,
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
            }
        }
        -- telescope.load_extension("notify") -- needed for noice.nvim
    end,
}

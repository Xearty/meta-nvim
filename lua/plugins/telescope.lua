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
        local actions = require("telescope.actions")
        require("telescope").setup{
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-u>"] = false,
                    },
                },
            }
        }
    end,
}

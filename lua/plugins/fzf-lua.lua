return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {
            "<leader>f",
            function()
                require("fzf-lua").files()
            end,
            desc = "Fuzzy search files",
            mode = { "n" },
        },
        {
            "<leader>r",
            function()
                require("fzf-lua").live_grep()
            end,
            desc = "Grep in current directory",
            mode = { "n" },
        },
    },
}

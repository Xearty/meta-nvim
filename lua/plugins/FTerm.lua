return {
    "numToStr/FTerm.nvim",
    keys = {
        {
            "<C-t>",
            function()
                require('FTerm').toggle()
            end,
            desc = "Toggles a floating terminal window",
            mode = { "n", "t" },
        }
    },
    config = true,
}

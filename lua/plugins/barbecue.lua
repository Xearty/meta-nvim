return {
    "utilyre/barbecue.nvim",
    version = "*",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    after = "nvim-web-devicons",       -- keep this if you're using NvChad
    config = function()
        require("barbecue").setup()
    end,
}

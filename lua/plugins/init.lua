if vim.fn.has("nvim-0.9.0") == 0 then
    vim.api.nvim_echo({
        { "meta-nvim requires Neovim >= 0.9.0\n", "ErrorMsg" },
        { "Press any key to exit",                "MoreMsg" },
    }, true, {})
    vim.fn.getchar()
    vim.cmd([[quit]])
    return {}
end

return {
    { "numToStr/Comment.nvim",     config = true },
    { "kylechui/nvim-surround",    version = "*",                                             config = true },
    { "RRethy/vim-illuminate",     config = function() require("illuminate").configure {} end },
    { "windwp/nvim-autopairs",     config = true },
    { "numToStr/FTerm.nvim",       config = true },
    { "rainbowhxch/beacon.nvim" },
    { "jghauser/mkdir.nvim" },
    { "gbprod/stay-in-place.nvim", config = true },
    { "nacro90/numb.nvim",         config = true },
    { "nmac427/guess-indent.nvim", config = true },
}

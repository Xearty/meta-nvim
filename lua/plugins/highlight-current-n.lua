return {
    "rktjmp/highlight-current-n.nvim",
    config = function()
        local function _1_()
            local hcn = require("highlight_current_n")
            local feedkeys = vim.api.nvim_feedkeys
            local _2_ = vim.v.searchforward
            if (_2_ == 0) then
                return hcn.N()
            elseif (_2_ == 1) then
                return hcn.n()
            else
                return nil
            end
        end
        vim.keymap.set("n", "n", _1_)

        local function _4_()
            local hcn = require("highlight_current_n")
            local feedkeys = vim.api.nvim_feedkeys
            local _5_ = vim.v.searchforward
            if (_5_ == 0) then
                return hcn.n()
            elseif (_5_ == 1) then
                return hcn.N()
            else
                return nil
            end
        end
        vim.keymap.set("n", "N", _4_)

        vim.cmd [[
        nmap * *N

        " Some QOL autocommands
        augroup ClearSearchHL
        autocmd!
        " You may only want to see hlsearch /while/ searching, you can automatically
        " toggle hlsearch with the following autocommands
        autocmd CmdlineEnter /,\? set hlsearch
        autocmd CmdlineLeave /,\? set nohlsearch
        " this will apply similar n|N highlighting to the first search result
        " careful with escaping ? in lua, you may need \\?
        autocmd CmdlineLeave /,\? lua require('highlight_current_n')['/,?']()
        augroup END
        ]]
    end
}

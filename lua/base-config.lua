vim.cmd [[syntax on]]

vim.g.mapleader = ' '
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.completeslash = 'slash'

vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.incsearch = true
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.titlestring = '%t'
vim.o.title = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.hidden = true
vim.o.wrap = false
vim.o.scrolloff = 6
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.signcolumn = 'yes'
vim.o.foldenable = false
vim.o.mousemodel = 'extend'
vim.o.cursorline = true
vim.o.pumblend = 20

vim.o.background = 'dark'

vim.cmd [[
    nnoremap <silent> } :<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>
    nnoremap <silent> { :<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>
]]

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', {})
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', {})
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', {})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', {})

vim.cmd [[
    " trigger `autoread` when files changes on disk
    set autoread
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
    " notification after file change
    autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
]]

vim.cmd [[nnoremap <leader>c :cd %:p:h<CR>]]

local augroup = vim.api.nvim_create_augroup
local general_group = augroup('GeneralGroup', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = general_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- highlight the line number for diagnostics and don't display any text
vim.cmd [[
    sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticSignError
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticSignWarn
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticSignInfo
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticSignHint
]]

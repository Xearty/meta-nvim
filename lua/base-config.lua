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
vim.o.titlestring= '%t'
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

vim.o.background = 'dark'
vim.cmd [[colorscheme rose-pine-main]]

vim.cmd [[
    nnoremap <silent> } :<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>
    nnoremap <silent> { :<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>
]]

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', {})
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', {})
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', {})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', {})

-- vim.keymap.set('n', 'n', '(v:searchforward ? "n" : "N")', { expr = true })
-- vim.keymap.set('n', 'N', '(v:searchforward ? "N" : "n")', { expr = true })

vim.cmd [[
    " trigger `autoread` when files changes on disk
    set autoread
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
    " notification after file change
    autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
]]

vim.cmd [[nnoremap <leader>c :cd %:p:h<CR>]]
vim.cmd [[
    " set
    autocmd TermEnter term://*toggleterm#*
    \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

    " By applying the mappings this way you can pass a count to your
    " mapping to open a specific window.
    " For example: 2<C-t> will open terminal 2
    nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
    inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
]]

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

autocmd({"BufWritePre"}, {
    group = general_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})


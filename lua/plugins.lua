vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use({ 'rose-pine/neovim', as = 'rose-pine' })

  use {'nyoom-engineering/oxocarbon.nvim'}
  use "rebelot/kanagawa.nvim"

  use {
    "NeogitOrg/neogit", requires = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional
    },
    config = function()
      local neogit = require('neogit')
      neogit.setup {}
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_install = require('nvim-treesitter.install')
      ts_install.update({ with_sync = true }) ts_install.prefer_git = true
    end,
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'c', 'cpp', 'lua', 'glsl', 'vim', 'rust', 'haskell', 'typescript', 'javascript' },
        sync_install = false,
        auto_install = false,
        ignore_install = { },
        highlight = {
          enable = true,
          --[[
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          --]]
          additional_vim_regex_highlighting = false,
        },
      })
    end
  }

  use {
    'nvim-tree/nvim-tree.lua',
    config = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      local api = require "nvim-tree.api"
      vim.keymap.set('n', '<leader>e', api.tree.toggle)

      local function nvim_tree_on_attach(bufnr)

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
        vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
      end

      -- OR setup with some options
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
        on_attach = nvim_tree_on_attach,
      })
    end
  }

  use { "ibhagwan/fzf-lua",
  -- optional for icon support
  requires = { "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.keymap.set("n", "<leader>f", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
    vim.keymap.set("n", "<leader>r", "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })
  end
}

use 'alaviss/nim.nvim'

use {"akinsho/toggleterm.nvim",
tag = '*',
config = function()
  require("toggleterm").setup()
end
    }

    use "lukas-reineke/indent-blankline.nvim"

    --[[
    use {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end
    }
    ]]--

    --[[
    use {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup()
      end
    }
    --]]

    use {
      "neovim/nvim-lspconfig",
      config = function()
        -- Setup language servers.
        local lspconfig = require('lspconfig')
        lspconfig.zls.setup {}
        lspconfig.pyright.setup {}
        lspconfig.tsserver.setup {}
        lspconfig.rust_analyzer.setup {
          -- Server-specific settings. See `:help lspconfig-setup`
          settings = {
            ['rust-analyzer'] = {},
          },
        }
        lspconfig.clangd.setup {}

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<space>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format()
              end,
            })
          end,
        })
      end
    }

    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
      },
      config = function()
        -- Set up nvim-cmp.
        local cmp = require'cmp'

        cmp.setup({
          snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
              -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
              -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
              -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
          },
          window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' }, -- For vsnip users.
            -- { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
          }, {
            { name = 'buffer' },
          })
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
          sources = cmp.config.sources({
            { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
          }, {
            { name = 'buffer' },
          })
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          })
        })

        -- Set up lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
        require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
          capabilities = capabilities
        }
      end
    }

    use 'rockerBOO/boo-colorscheme-nvim'
    use 'LunarVim/templeos.nvim'
    use 'baliestri/aura-theme'
    use 'ramojus/mellifluous.nvim'

    use {
      'windwp/nvim-autopairs',
      config = function() require('nvim-autopairs').setup {} end
    }

    use {
      "utilyre/sentiment.nvim",
      tag = "*",
      config = function()
        require("sentiment").setup({
          -- config
        })
      end,
    }

    use {
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

    use {
      "kylechui/nvim-surround",
      tag = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function()
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
      end
    }

    use {
      "RRethy/vim-illuminate",
      config = function()
        require('illuminate').configure {}
      end
    }

    use {
      "X3eRo0/dired.nvim",
      requires = "MunifTanjim/nui.nvim",
      config = function()
        require("dired").setup {
          path_separator = "/",
          show_banner = false,
          show_hidden = true,
          show_dot_dirs = true,
          show_colors = true,
        }
      end
    }

    use {
      "folke/noice.nvim",
      requires = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      config = function()
        require("noice").setup({
          lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true,
            },
          },
          -- you can enable a preset for easier configuration
          presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
          },
        })
      end
    }

    use {
      "IndianBoy42/tree-sitter-just",
      config = function()
        require("nvim-treesitter.parsers").get_parser_configs().just = {
          install_info = {
            url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
            files = { "src/parser.c", "src/scanner.cc" },
            branch = "main",
            -- use_makefile = true -- this may be necessary on MacOS (try if you see compiler errors)
          },
          maintainers = { "@IndianBoy42" },
        }
      end
    }
  end)

-- Plugins.
--
-- Don't load this file until after "packer.lua" is loaded, as that file
-- bootstraps packer to load plugins.

require("packer").startup({
  function(use)
    use "wbthomason/packer.nvim"
    use "fatih/vim-go"
    use "tpope/vim-commentary"
    use "Raimondi/delimitMate"
    use {
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("gitsigns").setup()
      end
    }
    use "arcticicestudio/nord-vim"
    use "catppuccin/vim"
    use "itchyny/lightline.vim"
    use "itchyny/vim-gitbranch"

    use "dbinagi/nomodoro"
    -- Seems like TreeSitter isn't compatible with the version of Neovim that
    -- I'm stuck on, so disable it for now.
    --
    -- use {
    --   "nvim-treesitter/nvim-treesitter",
    --   { run = ":TSUpdate" },
    -- }
    use {
      "nvim-telescope/telescope.nvim",
      requires = { {"nvim-lua/plenary.nvim"} }
    }
    -- use { "neoclide/coc.nvim", branch = "release" }
    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {                                      -- Optional
          'williamboman/mason.nvim',
          run = function()
            pcall(vim.cmd, 'MasonUpdate')
          end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
      }
    }
  end
})

-- Configure Telescope.
--
-- Normal file pickers.
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fv", "<cmd>lua require('telescope.builtin').git_files()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", {noremap = true})
-- LSP file pickers.
vim.api.nvim_set_keymap("n", "<leader>fld", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", {noremap = true})

-- Configure vim-go
vim.g.go_fmt_command = "goimports" -- Run GoImports on save.
vim.g.go_auto_type_info = 1        -- Show type info for symbol under cursor.
vim.g.go_fmt_fail_silently = 1     -- Don't open the quickfix window.

-- Configure LSP zero.
--
--
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})

  vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>', {buffer = true})
end)

-- When you don't have mason.nvim installed
-- You'll need to list the servers installed in your system
lsp.setup_servers({'gopls'})

lsp.ensure_installed({'tailwindcss'})

-- Setup Tailwind LSP.
require('lspconfig').tailwindcss.setup{}

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

-- Enable "supertab" for Neovim.
--
-- Make sure you setup `cmp` after lsp-zero
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  }
})

-- Load Nomodoro with a default config.
require('nomodoro').setup({})

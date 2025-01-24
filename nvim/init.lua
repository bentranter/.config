-- Packer
--
-- Bootstraps Packer if it's not installed.
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- If the install path is empty, clone the Packer repo into it, then attempt
-- to add packer itself via the packadd install command.
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.api.nvim_command("packadd packer.nvim")
end

vim.g.mapleader = " " -- Space is the mapleader.
vim.keymap.set("n", "<leader>fe", vim.cmd.Ex) -- Type Space-p-v to open netrw.
vim.keymap.set("n", "<leader><Space>", ":noh<CR>") -- Hit space twice to clear search highlighting.

-- General configuration.
vim.o.termguicolors = true     -- Use 256 colours.
vim.o.autoread = true          -- Automatically re-read changed files without confirmation prompt.
vim.o.errorbells = false       -- No beeps.
vim.o.number = true            -- Show line numbers
vim.o.showcmd = true           -- Show me what I'm typing
vim.o.swapfile = false         -- Don't use swapfile
vim.o.backup = false           -- Don't create annoying backup files
vim.o.splitright = true        -- Split vertical windows right to the current windows
vim.o.splitbelow = true        -- Split horizontal windows below to the current windows
vim.o.autowrite = true         -- Automatically save before :next, :make etc.
vim.o.hidden = true
vim.o.fileformats = "unix,dos,mac" -- Prefer Unix over Windows over OS 9 formats
vim.o.showmatch = false            -- Do not show matching brackets by flickering
vim.o.showmode = false             -- We show the mode with airline or lightline
vim.o.ignorecase = true            -- Search case insensitive...
vim.o.smartcase = true             -- ... but not it begins with upper case
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.shortmess = vim.o.shortmess .. "c" -- Show fewer autocomplete messages.
vim.o.cursorcolumn = false         -- Speed up syntax highlighting
vim.o.cursorline = false
vim.o.updatetime = 750
vim.o.wrap = true                  -- Turn on line wrapping.
vim.o.scrolloff = 5                -- Show 5 lines of context around the cursor.
vim.o.title = true                 -- Set the window title...
vim.o.titlestring = "%<%F%=%l/%L - nvim" -- ... to this.
vim.o.backspace = "indent,eol,start" -- Make backspacing work.
vim.o.pumheight = 10                 -- Completion window max size.
vim.o.signcolumn = "yes"           -- Keep this open since gitgutter puts stuff there.
vim.o.spelllang = "en_ca"
vim.o.clipboard = "unnamedplus"
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = false

vim.cmd "syntax on"
vim.cmd "set cursorline"
vim.cmd "set relativenumber"
vim.cmd "filetype plugin indent on"
vim.cmd "colorscheme oceanicnext"

vim.g.lightline = {
  active = {
    left = {{"mode", "paste"}, {"gitbranch", "readonly", "filename", "modified"}},
  },
  component_function = {
    gitbranch = "gitbranch#name",
    filetype = "NomoStatusLine"
  },
  colorscheme = "nord",
}

vim.api.nvim_exec([[
augroup FileMappings
 autocmd!

  autocmd FileType html,css,js,json,lua,viml,vim,ruby,eruby,erb,crystal,cr,ecr setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType c,cpp,cc,h setlocal noexpandtab tabstop=4 shiftwidth=4

  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  autocmd FileType qf wincmd J

  autocmd BufWritePre * :%s/\s\+$//e
augroup END
]], true)

-- Plugins.
--
-- Don't load this file until after "packer.lua" is loaded, as that file
-- bootstraps packer to load plugins.

require("packer").startup({
  function(use)
    use "wbthomason/packer.nvim"
    use "folke/tokyonight.nvim"
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
    use {
      "catppuccin/vim",
      config = function()
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
        }
      end
    }
    use "itchyny/lightline.vim"
    use "itchyny/vim-gitbranch"
    use {
      "nvim-treesitter/nvim-treesitter",
      { run = ":TSUpdate" },
      config = function ()
        require'nvim-treesitter.configs'.setup {
          ensure_installed = {
            'go',
            'lua',
            'markdown',
            'javascript'
          },
          indent = { enable = true },
          highlight = { enable = true },
          autopairs = { enable = true },
        }
      end
    }
    use {
      "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup { check_ts = true } end
    }
    use {
      "nvim-telescope/telescope.nvim",
      requires = { {"nvim-lua/plenary.nvim"} }
    }
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
    use {
      'romgrk/barbar.nvim',
      requires = {
        'lewis6991/gitsigns.nvim',
        'nvim-tree/nvim-web-devicons'
      }
    }
  end
})

-- Configure Telescope.
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fv", "<cmd>lua require('telescope.builtin').git_files()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fs", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fd", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", {noremap = true})

-- Configure Barbar.
vim.api.nvim_set_keymap("n", "<leader>bn", "<cmd>BufferNext<CR>", {noremap=true,silent=true})
vim.api.nvim_set_keymap("n", "<leader>bp", "<cmd>BufferPrevious<CR>", {noremap=true,silent=true})
vim.api.nvim_set_keymap("n", "<leader>b1", "<cmd>BufferGoto 1<CR>", {noremap=true,silent=true})
vim.api.nvim_set_keymap("n", "<leader>b2", "<cmd>BufferGoto 2<CR>", {noremap=true,silent=true})
vim.api.nvim_set_keymap("n", "<leader>b3", "<cmd>BufferGoto 3<CR>", {noremap=true,silent=true})
vim.api.nvim_set_keymap("n", "<leader>b4", "<cmd>BufferGoto 4<CR>", {noremap=true,silent=true})
vim.api.nvim_set_keymap("n", "<leader>b5", "<cmd>BufferGoto 5<CR>", {noremap=true,silent=true})
vim.api.nvim_set_keymap("n", "<leader>b6", "<cmd>BufferGoto 6<CR>", {noremap=true,silent=true})
vim.api.nvim_set_keymap("n", "<leader>b7", "<cmd>BufferGoto 7<CR>", {noremap=true,silent=true})
vim.api.nvim_set_keymap("n", "<leader>b8", "<cmd>BufferGoto 8<CR>", {noremap=true,silent=true})
vim.api.nvim_set_keymap("n", "<leader>b9", "<cmd>BufferGoto 9<CR>", {noremap=true,silent=true})
vim.api.nvim_set_keymap("n", "<leader>b0", "<cmd>BufferLast<CR>", {noremap=true,silent=true})

-- Configure vim-go
vim.g.go_fmt_command = "goimports"   -- Run GoImports on save.
vim.g.go_auto_type_info = 0          -- Handled by nvim-lsp.
vim.g.go_fmt_fail_silently = 1       -- Don't open the quickfix window.
vim.g.go_gopls_enabled = 0           -- Handled by nvim-lsp.
vim.g.go_code_completion_enabled = 0 -- Handled by nvim-lsp.
vim.g.go_list_type = 'quickfix'

-- Configure LSP zero.
--
--
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({buffer = bufnr})
  vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>', {buffer = true})
  vim.keymap.set('n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>", {buffer = true})
end)

-- When you don't have mason.nvim installed
-- You'll need to list the servers installed in your system
lsp.setup_servers({'gopls', 'tsserver'})
lsp.ensure_installed({'tailwindcss', 'tsserver'})

-- Setup Tailwind LSP.
require('lspconfig').tailwindcss.setup{}

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

local capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup TSServer.
require('lspconfig').tsserver.setup({
  capabilities = capabilities,
  settings = {
    completions = {
      completeFunctionCalls = true
    }
  }
})

-- Setup gopls LSP.
require("lspconfig").gopls.setup({
  capabilities = capabilities,
  flags = { debounce_text_changes = 200 },
  settings = {
    gopls = {
      usePlaceholders = true,
      gofumpt = true,
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      experimentalPostfixCompletions = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-node_modules" },
      semanticTokens = false, -- This is insanely slow.
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

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
    ['<CR>'] = cmp.mapping.confirm({select = true})
  }
})

-- Experiments below.
-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn = "yes"

-- <Space> gtf runs GoTestFunc.
vim.keymap.set("n", "<leader>gtf", ":GoTestFunc<CR>")
-- <Space> gen jumps to the next LSP error ("go error next").
vim.api.nvim_set_keymap("n", "<leader>gen", "<cmd>lua vim.diagnostic.goto_next()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>gep", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {noremap = true})
-- Center the cursor on the screen when navigating up and down.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

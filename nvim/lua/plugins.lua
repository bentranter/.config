-- Plugins.
--
-- Don't load this file until after "packer.lua" is loaded, as that file
-- bootstraps packer to load plugins.

require("packer").startup({
  function(use)
    use "wbthomason/packer.nvim"
    use "fatih/vim-go"
    use {
      "kyazdani42/nvim-tree.lua",
      requires = { "kyazdani42/nvim-web-devicons", opt = true }
    }
    use {
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("gitsigns").setup()
      end
    }
    use "neovim/nvim-lspconfig"
    use "nvim-lua/completion-nvim"
  end
})


-- Configure nvim-tree
--
-- Hide some of the icons.
vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 0,
  folder_arrows = 1
}
vim.g.nvim_tree_icons = {
  folder = {
    arrow_open = "▾",
    arrow_closed = "▸",
    default = "▸",
    open = "▾",
    empty = "▸",
    empty_open = "▾",
    symlink = "▸",
    symlink_open = "▾"
  },
  git = {
    unstaged = "·",
    staged = "+",
    unmerged = "?",
    renamed = "→",
    untracked = "*",
    deleted = "×",
    ignored = "◌"
  }
}
vim.g.nvim_tree_indent_markers = 1 -- Show icons beside folders.
vim.g.nvim_tree_auto_open = 1      -- Open the tree from "vim ."
vim.g.nvim_tree_auto_close = 1     -- Close the tree when it's the last window.
vim.g.nvim_tree_width = 22         -- Make the tree narrower.

-- Toggle nvim-tree with C-n in normal mode.
vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { silent = true, noremap = true })


-- Configure vim-go
vim.g.go_fmt_command = "goimports" -- Run GoImports on save.
vim.g.go_auto_type_info = 1        -- Show type info for symbol under cursor.
vim.g.go_fmt_fail_silently = 1     -- Don't open the quickfix window.
vim.g.go_def_mode = "godef"        -- Override because gopls breaks sometimes.

-- LSP config.
local nvim_lsp = require("lspconfig")
local on_attach = function(_, bufnr)
  require("completion").on_attach()
end

local servers = { "gopls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach
  }
end

vim.cmd [[
  " Recommended autocompletion settings for completion-nvim.
  " Use <Tab> and <S-Tab> to navigate through popup menu
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

  " Avoid showing message extra message when using completion
  set shortmess+=c
]]

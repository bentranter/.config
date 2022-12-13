-- Plugins.
--
-- Don't load this file until after "packer.lua" is loaded, as that file
-- bootstraps packer to load plugins.

require("packer").startup({
  function(use)
    use "wbthomason/packer.nvim"
    use "fatih/vim-go"
    use "tpope/vim-commentary"
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
    use "arcticicestudio/nord-vim"
    use "itchyny/lightline.vim"
    use "itchyny/vim-gitbranch"
    use "tmsvg/pear-tree"

    use "nvim-treesitter/nvim-treesitter"
    use {
      "nvim-telescope/telescope.nvim",
      requires = { {"nvim-lua/plenary.nvim"} }
    }
    -- Snippet support for autocompletion.
    use {
      "hrsh7th/cmp-vsnip",
      requires = { "hrsh7th/vim-vsnip" }
    }
    use {
      "hrsh7th/nvim-cmp",
      requires = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer" }
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
  },
  hijack_directories = {
    enable = true,
    auto_open = true
  }
}
vim.g.nvim_tree_indent_markers = 1 -- Show icons beside folders.
vim.g.nvim_tree_width = 22         -- Make the tree narrower.

-- Toggle nvim-tree with C-n in normal mode.
vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { silent = true, noremap = true })


-- Configure vim-go
vim.g.go_fmt_command = "goimports" -- Run GoImports on save.
vim.g.go_auto_type_info = 1        -- Show type info for symbol under cursor.
vim.g.go_fmt_fail_silently = 1     -- Don't open the quickfix window.


-- Setup autocompletion and snippet insertion.
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),

    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp_signature_help' },
  }, {
    { name = 'path' },
  }, {
    { name = 'nvim_lsp' },
  }, {
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

-- LSP config.
require("lspconfig")["gopls"].setup {
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
}
require("lspconfig")["solargraph"].setup{}
require("lspconfig")["tailwindcss"].setup{}

-- LSP remappings.
vim.api.nvim_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true})

vim.cmd [[
  " Recommended autocompletion settings for completion-nvim.
  " Use <Tab> and <S-Tab> to navigate through popup menu
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
]]

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, {
    -- Use a sharp border with `FloatBorder` highlights
    border = "single",
  })

-- Enable border for signature
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "single",
  }
)

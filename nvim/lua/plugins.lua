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
    use { "neoclide/coc.nvim", branch = "release" }
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

-- TODO Consider switching to https://github.com/fatih/dotfiles/blob/main/init.lua.

vim.g.mapleader = " " -- Space is the mapleader.
vim.keymap.set("n", "<leader>fe", vim.cmd.Ex) -- Type Space-p-v to open netrw.
vim.keymap.set("n", "<leader><Space>", ":noh<CR>") -- Hit space twice to clear search highlighting.

require("config")
require("pack")
require("plugins")

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


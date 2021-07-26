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
vim.o.completeopt= "menuone,noinsert,noselect"
vim.o.cursorcolumn = false         -- Speed up syntax highlighting
vim.o.cursorline = false
vim.o.updatetime = 400
vim.o.wrap = true                  -- Turn on line wrapping.
vim.o.scrolloff = 5                -- Show 5 lines of context around the cursor.
vim.o.title = true                 -- Set the window title...
vim.o.titlestring = "%<%F%=%l/%L - nvim" -- ... to this.
vim.o.backspace = "indent,eol,start" -- Make backspacing work.
vim.o.pumheight = 10                 -- Completion window max size.
vim.o.signcolumn = "yes"             -- Keep this open since gitgutter puts stuff there.
vim.o.spelllang = "en_ca"
vim.o.clipboard = "unnamedplus"

vim.cmd "syntax on"
vim.cmd "set cursorline"
vim.cmd "filetype indent on"
vim.cmd("colorscheme nord")

vim.g.lightline = {
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

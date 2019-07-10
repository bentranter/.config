" Terminal friendly config for neovim and vim8.

" Use modern Vim.
set nocompatible

" Ensure utf-8 encoding as some plugins depend on it.
set encoding=utf-8

" Download vim-plug if it isn't installed.
if has('nvim')
  if empty(glob("~/.config/nvim/autoload/plug.vim"))
    silent! execute '!curl --create-dirs -fsSLo ~/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * silent! PlugInstall --sync | source $MYVIMRC
  endif
else
  if empty(glob("~/.vim/autoload/plug.vim"))
    silent! execute '!curl --create-dirs -fsSLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * silent! PlugInstall --sync | source $MYVIMRC
  endif
endif

" Create directories for Vim plug-ins.
call plug#begin('~/.vim/plugged')
  if has("nvim")
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  Plug 'airblade/vim-gitgutter'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'morhetz/gruvbox'
  Plug 'Raimondi/delimitMate'
  Plug 'scrooloose/nerdtree'
  Plug 'tpope/vim-commentary'
  Plug 'w0rp/ale'
call plug#end()

" General Vim configuration.
syntax on
filetype indent on

set autoread                 " Automatically re-read changed files without confirmation prompt.
set noerrorbells             " No beeps.
set number                   " Show line numbers
set showcmd                  " Show me what I'm typing
set noswapfile               " Don't use swapfile
set nobackup                 " Don't create annoying backup files
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows
set autowrite                " Automatically save before :next, :make etc.
set hidden
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set noshowmatch              " Do not show matching brackets by flickering
set noshowmode               " We show the mode with airline or lightline
set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case
set completeopt=menu,menuone
set nocursorcolumn           " speed up syntax highlighting
set nocursorline
set updatetime=400
set wrap                     " Turn on line wrapping.
set scrolloff=5              " Show 5 lines of context around the cursor.
set title                    " Set the window title
set backspace=indent,eol,start " Make backspacing work.

" Global settings.
set spelllang=en_ca
set clipboard^=unnamed
set clipboard^=unnamedplus
colorscheme gruvbox
set pumheight=10   " Completion window max size.
set signcolumn=yes " Keep this open since gitgutter puts stuff there.

" Global plugin settings.
let g:deoplete#enable_at_startup=1 " Always use deoplete.
call deoplete#custom#option('omni_patterns', {
\ 'go': '[^. *\t]\.\w*',
\}) " Make deoplete use gopls.
let g:delimitMate_expand_cr=1
let g:delimitMate_expand_space=1
let g:delimitMate_smart_quotes=1
let g:delimitMate_expand_inside_quotes=0
let g:delimitMate_smart_matchpairs='^\%(\w\|\$\)'
let g:go_fmt_command = "goimports" " Run GoImports on save.
let g:go_auto_type_info = 1        " Show type info for symbol under cursor.
let NERDTreeShowHidden = 1         " Show dotfiles in NERDTree.

" Remappings.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
map <C-n> :NERDTreeToggle<CR>
" Don't show stupid q: window.
map q: :q

" Autocommands, most for setting indentation defaults.
augroup file_mappings
  autocmd!

  " Filetypes where we indent by two spaces
  autocmd FileType html,css,js,json,viml,vim,ruby,eruby,erb setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType c,cpp,cc,h setlocal noexpandtab tabstop=4 shiftwidth=4

  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  autocmd FileType qf wincmd J " put quickfix window always to the bottom
  " Remove white space on save. Doesn't save cursor position
  autocmd BufWritePre * :%s/\s\+$//e

  " Close Vim if NERDTree is the only remaining buffer.
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END


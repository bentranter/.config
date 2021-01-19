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
  Plug 'airblade/vim-gitgutter'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'mhartington/oceanic-next'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neomake/neomake'
  Plug 'Raimondi/delimitMate'
  Plug 'vim-crystal/vim-crystal'
  Plug 'preservim/nerdtree'
  Plug 'tpope/vim-commentary'
  Plug 'ziglang/zig.vim'
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

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

colorscheme OceanicNext
set pumheight=10   " Completion window max size.
set signcolumn=yes " Keep this open since gitgutter puts stuff there.

" Global plugin settings.
let g:delimitMate_expand_cr=1
let g:delimitMate_expand_space=1
let g:delimitMate_smart_quotes=1
let g:delimitMate_expand_inside_quotes=0
let g:delimitMate_smart_matchpairs='^\%(\w\|\$\)'

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Use K to show documentation in preview window.
"
" This is for COC.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

let g:go_fmt_command = "goimports" " Run GoImports on save.
let g:go_auto_type_info = 1        " Show type info for symbol under cursor.
let g:go_fmt_fail_silently = 1     " Don't open the quickfix window.
let g:go_def_mode='godef'          " Override because gopls breaks sometimes.

let NERDTreeShowHidden = 1         " Show dotfiles in NERDTree.

" Remappings.
"
" Use TAB for autocompletion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
map <C-n> :NERDTreeToggle<CR>
" Don't show stupid q: window.
map q: :q
" Clear search highlighting after hitting escape.
nnoremap <esc> :noh<return><esc>

" Today inserts the current date.
function Today()
  put =strftime('%Y-%m-%d')
endfunction
command Today call Today()

" Autocommands, most for setting indentation defaults.
augroup file_mappings
  autocmd!

  " Filetypes where we indent by two spaces
  autocmd FileType html,css,js,json,viml,vim,ruby,eruby,erb,crystal,cr,ecr setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType c,cpp,cc,h setlocal noexpandtab tabstop=4 shiftwidth=4

  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  autocmd FileType qf wincmd J " put quickfix window always to the bottom
  " Remove white space on save. Doesn't save cursor position
  autocmd BufWritePre * :%s/\s\+$//e

  " Close Vim if NERDTree is the only remaining buffer.
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  " Run Neomake on save.
  autocmd! BufWritePost * Neomake
augroup END


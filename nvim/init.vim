" Terminal friendly config for neovim.

" Use modern Vim.
set nocompatible

" Ensure utf-8 encoding as some plugins depend on it.
set encoding=utf-8

" Download vim-plug if it isn't installed.
if empty(glob(stdpath('data'), '/vim-plug'))
  silent! execute '!curl --create-dirs -fsSLo ~/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * silent! PlugInstall --sync | source $MYVIMRC
endif

" Create directories for Vim plugins.
call plug#begin(stdpath('data'), '/vim-plug')

Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mhartington/oceanic-next'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'Raimondi/delimitMate'
Plug 'vim-crystal/vim-crystal'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'

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

" LSP/Lua setup.
:lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(_, bufnr)
    require('completion').on_attach()
  end
  local servers = {'gopls'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end
EOF

" Recommended autocompletion settings for completion-nvim.
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

let g:go_fmt_command = "goimports" " Run GoImports on save.
let g:go_auto_type_info = 1        " Show type info for symbol under cursor.
let g:go_fmt_fail_silently = 1     " Don't open the quickfix window.
let g:go_def_mode='godef'          " Override because gopls breaks sometimes.

let NERDTreeShowHidden = 1         " Show dotfiles in NERDTree.

" Remappings.

" Open NERDTree with ctrl-n.
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
augroup END


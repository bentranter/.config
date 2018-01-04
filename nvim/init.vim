" Plugins
call plug#begin('~/.config/nvim/autoload')
Plug 'arcticicestudio/nord-vim'
Plug 'Raimondi/delimitMate'
Plug 'alvan/vim-closetag'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-buftabline'
Plug 'neomake/neomake'
call plug#end()

set noerrorbells             " No beeps
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
set laststatus=2             " Always show a status line.
set wrap                     " Turn on line wrapping.
set scrolloff=3              " Show 3 lines of context around the cursor.
set title                    " Set the window title
set background=dark          " Dark alert

" Use tab for autocompletion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

set pumheight=10             " Completion window max size

" vim-gitgutter
let g:gitgutter_sign_column_always = 1

"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard^=unnamed
set clipboard^=unnamedplus

set lazyredraw          " Wait to redraw

augroup file_mappings
    autocmd!
    autocmd FileType html,css,js,json,viml setlocal expandtab shiftwidth=2 tabstop=2
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
    autocmd FileType c setlocal noexpandtab tabstop=4 shiftwidth=4

    autocmd FileType qf wincmd J " put quickfix window always to the bottom
augroup END

" http://stackoverflow.com/questions/99161/how-do-you-make-vim-unhighlight-what-you-searched-for
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Highlight col 80
set colorcolumn=80

" Theme
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
set t_Co=256
colorscheme nord

" Plugins
let g:deoplete#enable_at_startup = 1

" Go Settings
let g:go_auto_type_info = 1

" Do stuff on save
if has("autocmd")
  " Remove white space on save. Doesn't save cursor position
  autocmd BufWritePre * :%s/\s\+$//e

  " Run Neomake
  autocmd! BufWritePost * Neomake
endif

"
" Configure delimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_smart_quotes = 1
let g:delimitMate_expand_inside_quotes = 0
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'

imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"

" Show the current mode in the status line, maybe one day I'll use emojis
" instead
let g:currentmode={
    \ 'n'  : '--NORMAL-- ',
    \ 'no' : '--N·OPERATOR PENDING-- ',
    \ 'v'  : '--VISUAL-- ',
    \ 'V'  : '--V·LINE-- ',
    \ '^V' : '--V·BLOCK-- ',
    \ 's'  : '--SELECT-- ',
    \ 'S'  : '--S·LINE-- ',
    \ '^S' : '--S·BLOCK-- ',
    \ 'i'  : '--INSERT-- ',
    \ 'R'  : '--REPLACE-- ',
    \ 'Rv' : '--V·REPLACE-- ',
    \ 'c'  : '--COMMAND-- ',
    \ 'cv' : 'Vim Ex ',
    \ 'ce' : 'Ex ',
    \ 'r'  : 'Prompt ',
    \ 'rm' : 'More ',
    \ 'r?' : 'Confirm ',
    \ '!'  : 'Shell ',
    \ 't'  : 'Terminal '
    \}

" Statusline config. See
" https://github.com/christoomey/dotfiles/blob/master/vim/rcfiles/statusline
set statusline=
set stl=%*                       " Normal status line highlight
set stl+=\ %{g:currentmode[mode()]}
set stl+=%t
set stl+=%m

set stl+=%=                      " Right align from here on
set stl+=\ %y                    " Filetype
set stl+=\ \ Col:%c              " Column number
set stl+=\ \ Line:%l/%L          " Line # / total lines

" general
set history=500
filetype plugin on
filetype indent on
set autoread
set splitbelow
set splitright
set so=7
set number
set wildmenu
set ruler
set cmdheight=1
set hid
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=2
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set foldcolumn=1

" colors and fonts
syntax enable
set t_Co=256
set encoding=utf8
set ffs=unix,dos,mac

hi Search ctermbg=green
hi Search ctermfg=black
hi VertSplit cterm=none gui=none

" files
set nobackup
set nowb
set noswapfile

" text
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set ai
set si
set wrap

" movement
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" status line
set laststatus=2

" load plugins
call plug#begin('~/.local/share/nvim/plugged')

" vim airline
Plug 'vim-airline/vim-airline'

" vim airline themes
Plug 'vim-airline/vim-airline-themes'

" vim gruvbox colorscheme
Plug 'morhetz/gruvbox'

" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

" set theme
let g:airline_theme='base16_gruvbox_dark_hard'
let g:airline_powerline_fonts = 1
colorscheme gruvbox
set background=dark

" turn on autocompletion
" let g:deoplete#enable_at_startup = 1

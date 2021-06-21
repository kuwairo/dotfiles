call plug#begin()
Plug 'cocopon/iceberg.vim'
Plug 'itchyny/lightline.vim'
Plug 'fatih/vim-go'
call plug#end()

set noshowmode

let g:lightline = {
    \ 'colorscheme': 'iceberg',
    \ }

inoremap jj <esc>

set termguicolors
set encoding=utf8
colorscheme iceberg

set ruler
set number
set relativenumber

filetype plugin on
filetype indent on

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4 

set ai
set si

set hlsearch
set incsearch

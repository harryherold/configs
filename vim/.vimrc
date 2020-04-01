" ~/.vimrc for configure the vim-terminal-editor

set nocompatible
set autoindent
set shiftwidth=1
set showcmd
set showmode
set showmatch
set ruler
set nojoinspaces
set cpo+=$
set whichwrap=""
set modelines=0
set number
set grepprg=grep\ -nH\ $*
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set encoding=utf-8

colorscheme xoria256

let g:tex_flavor="latex"

filetyp plugin on
filetyp indent on
syntax enable

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"
" alternatively, pass a path where Vundle should install plugins
call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-fugitive'

set clipboard=unnamed

let python_highlight_all=1
syntax on
" Plugin 'Valloric/YouCompleteMe'
" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
"
" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


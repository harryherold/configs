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
set tabstop=2
set expandtab

colorscheme xoria256

let g:tex_flavor="latex"

filetyp plugin on
filetyp indent on
syntax enable


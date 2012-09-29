set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave xterm

" backup/swap dir
set nobackup
set dir=$VIM\swap

" invoke pathogen
filetype plugin indent on
call pathogen#infect()

" default indentation
set sw=4 et

" make mapping
noremap <C-F9> :w <CR> :make <CR> :cw <CR>

" Gundo
noremap <F5> :GundoToggle <CR>

" coffeescript
function My_coffee()
    hi link coffeeSemicolonError NONE
    hi link coffeeSpaceError NONE
    setl foldmethod=indent nofoldenable
    setl shiftwidth=2 expandtab
    noremap <C-F10> :CoffeeRun <CR>
    noremap <F10> :CoffeeCompile vert <CR>
endfunction
au BufNewFile,BufReadPost *.coffee call My_coffee()

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave xterm

" language & font
set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set guifont=Consolas:h10

" backup/swap dir
set nobackup
set dir=$VIM\swap

" invoke pathogen
filetype plugin indent on
call pathogen#infect()

" default settings
set sw=4 et nu

" make mapping
noremap <C-F9> :w <CR> :make <CR> :cw <CR>

" Gundo
noremap <F5> :GundoToggle <CR>
" Taglist
nnoremap <silent> <F6> :TlistToggle<CR>

" coffeescript
function My_coffee()
    hi link coffeeSemicolonError NONE
    hi link coffeeSpaceError NONE
    setl foldmethod=indent nofoldenable
    setl shiftwidth=2 expandtab
    noremap <F10> :CoffeeRun <CR>
    noremap <C-F10> :CoffeeCompile vert <CR>
endfunction
au BufNewFile,BufReadPost *.coffee call My_coffee()

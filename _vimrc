set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave xterm

" encoding, UI language
set enc=utf8
set langmenu=en_US.utf8
let $LANG = 'en_US.utf8'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" look 'n feel
set guifont=Consolas:h10
color wombat

" backup/swap dir
set nobackup
set dir=$VIM\swap

" invoke pathogen
filetype plugin indent on
call pathogen#infect()

" default indentation
set ai sw=4 sts=4 et nu fdc=1

" make mapping
noremap <C-F9> :w <CR> :make <CR> :cw <CR>

" Gundo
noremap <F5> :GundoToggle <CR>
" Taglist
nnoremap <silent> <F4> :TlistToggle<CR>

" coffeescript
function My_coffee()
    hi link coffeeSemicolonError NONE
    hi link coffeeSpaceError NONE
    setl foldmethod=indent nofoldenable
    setl shiftwidth=2 expandtab
    noremap <F10> :CoffeeRun <CR>
    noremap <C-F10> :CoffeeCompile vert <CR>
    noremap <F8> :!node --debug-brk %<.js <CR>
endfunction
au BufNewFile,BufReadPost *.coffee call My_coffee()

" json: json highlighting + js indentation
function My_json()
    set ft=javascript
    set ft=json
endfunction
au BufNewFile,BufRead *.json call My_json()

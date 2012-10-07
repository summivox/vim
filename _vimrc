set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave xterm


"" invoke pathogen
"filetype plugin indent on
"call pathogen#infect()

" Bootstrap Vundle
filetype off
set rtp+=$VIM/vimfiles/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'

" Packages
Bundle 'Lokaltog/vim-powerline'
Bundle 'Shougo/vim-shell'
Bundle 'tpope/vim-fugitive'

Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'sjl/gundo.vim'
Bundle 'vim-scripts/taglist.vim'

Bundle 'ervandew/supertab'
Bundle 'tsaleh/vim-matchit'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdcommenter'

Bundle 'scrooloose/syntastic'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'vim-scripts/JSON.vim'
Bundle 'othree/html5.vim'
Bundle 'vim-scripts/jade.vim'

" Bootstrap Complete
filetype plugin indent on


" backup/swap dir
set nobackup
set dir=$VIM\swap

" encoding, language, UI
set enc=utf8
set langmenu=en_US.utf8
let $LANG = 'en_US.utf8'
set guioptions=gmlrt
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" look 'n feel
set guifont=Consolas:h10
"color wombat
color pyte

" Powerline
set laststatus=2
set guifont=Consolas_for_Powerline_FixedD:h10,Consolas:h10
let g:Powerline_symbols = 'fancy'

" default indentation
set ai sw=4 sts=4 et nu fdc=1


" Hotkey Mapping

" make
noremap <C-F9> :w <CR> :make <CR> :cw <CR>
" Gundo
noremap <F5> :GundoToggle <CR>
" Taglist
nnoremap <silent> <F4> :TlistToggle<CR>
" IndentGuide
nmap <F3> <Leader>ig


" Filetype

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

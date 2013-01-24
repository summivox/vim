set nocompatible tabpagemax=50
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave xterm
filetype off

"" invoke pathogen
"filetype plugin indent on
"call pathogen#infect()

" Non-vundle stuff

" golang plugin
set rtp+=$GOROOT/misc/vim


" Bootstrap Vundle
set rtp+=$VIM/vimfiles/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'

" Packages
Bundle 'Lokaltog/vim-powerline'
"Bundle 'Shougo/vim-shell'
Bundle 'tpope/vim-fugitive'

Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'sjl/gundo.vim'
Bundle 'vim-scripts/taglist.vim'

"Bundle 'ervandew/supertab'
Bundle 'tsaleh/vim-matchit'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdcommenter'

Bundle 'scrooloose/syntastic'
Bundle 'pangloss/vim-javascript'
"Bundle 'kchmck/vim-coffee-script'
Bundle 'smilekzs/vim-coffee-script'
Bundle 'vim-scripts/JSON.vim'
Bundle 'othree/html5.vim'
Bundle 'vim-scripts/jade.vim'
Bundle 'tpope/vim-markdown'

" Bootstrap Complete
filetype plugin indent on


" backup/swap dir
set nobackup
set dir=$VIM\swap

" encoding, language, UI
set enc=utf8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
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

" TOhtml
let g:html_use_css=0
let g:html_no_pre=1

" modeline (especially for iced-coffee-script generated js)
set modelines=100

" default indentation
set ai sw=4 sts=4 et nu fdc=1

" completeopt: always popup
set completeopt=menuone,preview


" global maps

" make
noremap <C-F9> :w <CR> :make <CR> :cw <CR>
" Gundo
noremap <F5> :GundoToggle <CR>
" Taglist
nnoremap <silent> <F4> :TlistToggle<CR>
" IndentGuide
nmap <F3> <Leader>ig
" TOhtml
nnoremap <F12> :TOhtml <CR>
vnoremap <F12> :TOhtml <CR>


" Filetype

" coffeescript
function My_coffee()
    "hi link coffeeSemicolonError NONE
    hi link coffeeSpaceError NONE
    setl fdm=indent nofoldenable
    setl sw=2 sts=2 expandtab
    nnoremap <buffer> <F10> :CoffeeRun <CR>
    nnoremap <buffer> <C-F10> :CoffeeCompile vert <CR>
    nnoremap <buffer> <F8> :!node --debug-brk %<.js <CR>
endfunction
au Filetype coffee call My_coffee()
function My_iced()
    call My_coffee()

    " inline iced-coffee-script runtime
    nnoremap <F9> :w <CR> :make -I inline <CR> :cw <CR>
endfunction
au Filetype iced call My_iced()



" json: json highlighting + js indentation
function My_json()
    set ft=javascript
    set ft=json
endfunction
au BufNewFile,BufRead *.json call My_json()

" go
function My_go_fmt()
    !copy "%" "%.gofmt" && gofmt "%.gofmt" > "%" && rm "%.gofmt"
endfunction
function My_go()
    setl sw=4 sts=4 ts=4 noet
    nnoremap <buffer> <F10> :w <CR> :!go run "%" <CR>
    nnoremap <buffer> <F12> :call My_go_fmt() <CR>
endfunction
au Filetype go call My_go()

" nex
function My_nex()
    nnoremap <buffer> <C-F9> :w <CR> :!nex -s <"%" >"%.go" <CR>
    nnoremap <buffer> <C-S-F9> :w <CR> :!nex <"%" >"%.go" <CR>
endfunction

" python
function My_python()
    setl sw=4 sts=4 ts=4 noet
    nnoremap <buffer> <F10> :w <CR> :!python "%" <CR>
endfunction
au Filetype python call My_python()

au BufNewFile,BufReadPost *.nex call My_nex()

" arduino is just cpp
au BufNewFile,BufReadPost *.ino setl ft=cpp

" markdown
function My_markdown()
    setl linebreak
endfunction
au Filetype markdown call My_markdown()

" verilog
function My_verilog()
    setl sw=2 sts=2 et

    " highlight macro invocations differently from constants
    syn match verilogMacro "\v(`(define\s+)?)@<=[A-Z][A-Z0-9_]+>"
    hi def link verilogMacro Macro
endfunction
au Filetype verilog call My_verilog()

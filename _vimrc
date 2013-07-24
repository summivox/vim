let mapleader = ","
set nocompatible tabpagemax=50
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave xterm
filetype off


""""""""""""""""""""""""""""""""""""""""
" Bundle Manager / Runtime-Path-Based

" golang plugin
set rtp+=$GOROOT/misc/vim

" powerline
"set rtp+=$HOME/.vim/bundle/powerline/powerline/bindings/vim
" Bootstrap Vundle
set rtp+=$VIM/vimfiles/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'

" Packages
Bundle 'Lokaltog/vim-powerline'
"Bundle 'Lokaltog/powerline'
"Bundle 'Shougo/vim-shell'
Bundle 'tpope/vim-fugitive'

Bundle 'nathanaelkane/vim-indent-guides'
"Bundle 'Yggdroot/indentLine'
Bundle 'sjl/gundo.vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'myusuf3/numbers.vim'

"Bundle 'ervandew/supertab'
Bundle 'tsaleh/vim-matchit'
Bundle 'tpope/vim-surround'
Bundle 'yueyoum/vim-linemovement'
Bundle 'scrooloose/nerdcommenter'

Bundle 'scrooloose/syntastic'
Bundle 'pangloss/vim-javascript'
"Bundle 'kchmck/vim-coffee-script'
Bundle 'smilekzs/vim-coffee-script'
Bundle 'vim-scripts/JSON.vim'
Bundle 'othree/html5.vim'
Bundle 'vim-scripts/jade.vim'
Bundle 'tpope/vim-markdown'
Bundle 'smilekzs/vim-pawn'
Bundle 'lukerandall/haskellmode-vim'
Bundle 'wlangstroth/vim-racket'
Bundle 'hail2u/vim-css3-syntax'

" Bootstrap Complete
filetype plugin indent on


""""""""""""""""""""""""""""""""""""""""
" generic stuff

" backup/swap dir
set nobackup
set dir=$VIM\swap

" encoding, language, UI
set enc=utf8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set langmenu=en_US.utf8
let $LANG = 'en_US.utf8'
set guioptions=gmlrt
set wildmenu
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" look 'n feel
set guifont=Consolas:h10
color pyte

" modeline: help with generated code
set modelines=100

" default indentation
set autoindent shiftwidth=4 softtabstop=4 tabstop=4 expandtab number foldcolumn=1


""""""""""""""""""""""""""""""""""""""""
" plugin settings

" Powerline
set laststatus=2
set guifont=Consolas_for_Powerline_FixedD:h10,Consolas:h10
let g:Powerline_symbols = 'fancy'

" TOhtml
let g:html_use_css=0
let g:html_no_pre=1

" completeopt: always popup
set completeopt=menuone,preview


""""""""""""""""""""""""""""""""""""""""
" global maps

" from 吴育昕 (http://www.renren.com/g/370311990)
nnoremap ; :

" make
noremap <C-F9> :w <CR>:make <CR>:cw <CR>

" Gundo
noremap <F5> :GundoToggle <CR>

" Taglist
nnoremap <silent> <F4> :TlistToggle<CR>

" indent guide
nmap <F3> <Leader>ig
"nmap <F3> :IndentLinesToggle<CR>
"let g:indentLine_char="┆"

" Number
nnoremap <F6> :NumbersToggle<CR>

" TOhtml
nnoremap <F12> :TOhtml <CR>
vnoremap <F12> :TOhtml <CR>

" nohlsearch
nnoremap <ESC><ESC> :noh <CR>

" compromise: ct
nnoremap <c-A> ggVG
nnoremap <a-a> <c-a>
nnoremap <a-x> <c-x>

" Y is y$
nnoremap Y y$

" clipboard yank/put
nmap <leader>y "+y
nmap <leader>Y "+Y
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>y "+y
vmap <leader>Y "+Y
vmap <leader>p "+p
vmap <leader>P "+P

" convert last search expression into substitution
nmap <expr> <leader>/ ':%s/' . @/ . '/'

" quick ReFactoring: replace keyword under cursor
nmap <special> <leader>rf "+yiw:%s/\<<c-v>\>//g<left><left>
vmap <special> <leader>rf "+y:%s/<c-v>//g<left><left>

" Delete Trailing space in all lines
nnoremap <silent> <leader>dt :%s/\s\+$/<CR>:noh<CR>

" Quick diff on/off
nnoremap <leader>wt :windo difft<cr>
nnoremap <leader>wo :windo diffo<cr>
nnoremap <leader>vds :vert diffsplit<space>

" section delimiter comment
nnoremap <special> <leader>c/ o<cr><cr><esc><up>12i/<esc>o


""""""""""""""""""""""""""""""""""""""""
" Filetype Customization

" cpp

" auto header guard
function! My_cpp_hg_name()
    let @" = "_" . toupper(substitute(expand('%:t'), "\\.", "_", "g")) . "_"
endfunction
function! My_cpp_hg()
    call My_cpp_hg_name()
    normal ggO#ifndef 
    normal po#define 
    normal pGo#endif//
    normal pgg
endfunction

" switch cpp<=>hpp
function! My_cpp_switch()
    let l:ext = expand('%:e')
    if l:ext == "cpp"
        vs %<.hpp
    elseif l:ext == "hpp"
        vs %<.cpp
    endif
    redraw
endfunction

function! My_cpp()
    setl sw=4 sts=4 ts=4 et

    nnoremap <buffer> <special> <leader>hg :call My_cpp_hg()<cr>
    nnoremap <buffer> <C-S-Tab> :call My_cpp_switch()<cr>
endfunction
au Filetype cpp call My_cpp()

" javascript
function! My_javascript()
    setl sw=2 sts=2 ts=2 et
    nnoremap <buffer> <F10> :!node "%" <CR>
    nnoremap <buffer> <F8> :!start node --debug-brk "%" <CR>
endfunction
au Filetype javascript call My_javascript()

" coffeescript
function! My_coffee()
    "hi link coffeeSemicolonError NONE
    hi link coffeeSpaceError NONE
    setl fdm=indent nofoldenable
    setl sw=2 sts=2 et
    nnoremap <buffer> <F10> :CoffeeRun <CR>
    nnoremap <buffer> <C-F10> :CoffeeCompile vert <CR>
    nnoremap <buffer> <F8> :!start node --debug-brk "%<.js" <CR>
endfunction
au Filetype coffee call My_coffee()
function! My_iced()
    call My_coffee()

    " inline iced-coffee-script runtime
    nnoremap <buffer> <F9> :w <CR>:make -I inline <CR>:cw <CR>
endfunction
au Filetype iced call My_iced()

" json: json highlighting + js indentation
function! My_json()
    set ft=javascript
    set ft=json
endfunction
au BufNewFile,BufRead *.json call My_json()

" go
function! Lastdir(path)
    let l:i1 = strridx(a:path, "/")
    let l:i2 = strridx(a:path, "\\")
    let l:i = (l:i1!=-1)?(l:i1):(l:i2)
    return strpart(a:path, l:i+1)
endfunction
function! GoDebug()
    let l:fn = Lastdir(getcwd()) . ".exe"
    let l:cmd = "!start gdb64 \"" . fn . "\""
    exec l:cmd
endfunction
function! My_go()
    setl sw=4 sts=4 ts=4 noet
    let &mp="go build -gcflags \"-N -l\" . "
    nnoremap <buffer> <F10> :w<CR>:!go run "%" <CR>
    nnoremap <buffer> <F8> :call GoDebug()<CR>
    nnoremap <buffer> <F11> m`:%!gofmt<CR>``
endfunction
au Filetype go call My_go()

" nex
function! My_nex()
    nnoremap <buffer> <C-F9> :w <CR>:!nex -s <"%" >"%.go" <CR>
    nnoremap <buffer> <C-S-F9> :w <CR>:!nex <"%" >"%.go" <CR>
endfunction

" python
function! My_python()
    setl sw=4 sts=4 ts=4 noet
    nnoremap <buffer> <F10> :w <CR>:!python "%" <CR>
endfunction
au Filetype python call My_python()

au BufNewFile,BufReadPost *.nex call My_nex()

" arduino is just cpp
au BufNewFile,BufReadPost *.ino setl ft=cpp

" markdown
function! My_markdown()
    setl linebreak
    let &mp="marked \"%\" -o \"%<.html\" "
    nnoremap <buffer> <leader><cr> gqap
endfunction
au Filetype markdown call My_markdown()

" verilog
function! My_verilog()
    setl sw=2 sts=2 et

    " highlight macro invocations differently from constants
    syn match verilogMacro "\v(`((define|ifn?def|undef)\s+)?)@<=[A-Z0-9_]+>"
    hi def link verilogMacro Macro

    " TODO: make a wire/reg/... bus
    " noremap <buffer> <special> <leader>vw ^/\\<wire\\|reg\\|input\\|output\\|inout\\|tri(\\d\\|and\\|or\\|reg\\|)\\>/<cr>ta<space>[-1:0]<esc>hhhhi
endfunction
au BufNewFile,BufReadPost *.vh setl ft=verilog
au Filetype verilog call My_verilog()

" vhdl
function! My_vhdl()
    setl sw=2 sts=2 et
endfunction
au Filetype vhdl call My_vhdl()

" pawn
function! My_pawn()
    setl sw=4 sts=4 ts=4 et
    setl cin
    let &mp="pawncc -O3 \"%\" "
    map <buffer> <F10> :!pawnrun "%<.amx" <CR>
endfunction
au BufNewFile,BufReadPost *.p setl ft=sourcepawn
au BufNewFile,BufReadPost *.inc setl ft=sourcepawn

au Filetype pawn call My_pawn()
au Filetype sourcepawn call My_pawn()

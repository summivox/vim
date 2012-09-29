set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave xterm

set nobackup
set dir=$VIM\swap

filetype plugin indent on
call pathogen#infect('../plugin')

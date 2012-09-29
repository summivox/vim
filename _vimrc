set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave xterm

set nobackup
set dir=$VIM\swap

call pathogen#infect('plugin')

set shell=bash
" execute pathogen#infect()
set ai si
"set ts=4 sts=4 sw=4 noet
set ts=2 sts=2 sw=2 et
syntax enable
set ruler
nnoremap H <C-w>h
nnoremap L <C-w>l
nnoremap J <C-w>j
"nnoremap K <C-w>k
set incsearch
nnoremap z zz

" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
if exists("g:did_load_filetypes")
  filetype off
  filetype plugin indent off
endif
" set runtimepath+=$GOROOT/misc/vim " replace $GOROOT with the output of: go env GOROOT
filetype plugin indent on
syntax on

function! Auto_complete_string()
  if pumvisible()
    return "\<C-n>"
  else
    return "\<C-x>\<C-o>"
  end
endfunction

inoremap <expr> <Nul> Auto_complete_string()
inoremap <expr> <C-Space> Auto_complete_string()

let g:go_fmt_commands = 0
set nocompatible              " be iMproved, required
filetype off                  " required


" VUNDLE SETUP
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'
Plugin 'kien/ctrlp.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'pangloss/vim-javascript'
Plugin 'junegunn/goyo.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/seoul256.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" VUNDLE SETUP END

set rtp+=/Users/jameskozianski/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim/
set laststatus=2


inoremap jk <esc>
let mapleader = "\\"
let localleader = "\\"

nnoremap <leader>ve :vs $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>
nnoremap <leader>w :w<CR>
nnoremap w :w<CR>
map <leader>n :noh<CR>
" imap <esc> <nop>


augroup go
  autocmd!
  " Use 4 space tabs for go
  autocmd FileType go setlocal noet sts=4 sw=4 ts=4
  " autocmd FileType go nnoremap { :wa<CR>:GoRun<CR>
  " autocmd FileType go nnoremap } 
augroup END
colors seoul256
set bg=dark
" source /Users/jameskozianski/dev/6.824/6.824/src/code.google.com/p/go.tools/cmd/oracle/oracle.vim
nnoremap <leader>s :Gstatus<CR>
set noswapfile

nnoremap E :E<CR>

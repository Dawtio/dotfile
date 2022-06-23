set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-surround'
Plugin 'ryanoasis/vim-devicons'
Plugin 'zivyangll/git-blame.vim'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'stephpy/vim-yaml'
Plugin 'kyoz/purify', { 'rtp': 'vim' }

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Config
set number
set ruler
set mouse=a
set encoding=UTF-8

" Theme
syntax enable
syntax on
set termguicolors
colorscheme purify

let g:lightline = {
      \ 'colorscheme': 'purify',
      \ }


" Shortcuts
map <C-g> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

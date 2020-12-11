set nocompatible              " be iMproved, required
filetype off                  " required

" vim-plugin
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'zxqfl/tabnine-vim'
Plug 'vim-syntastic/syntastic'
call plug#end()
" Reload .vimrc and :PlugInstall to install plugins.

" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Ctrl+n to toggle nerdtree
map <C-n> :NERDTreeToggle<CR>

syntax enable
set number
set hlsearch
set nostartofline

" Enable backspace
set backspace=indent,eol,start

" Enable move line up or down shortcut
nnoremap <C-Up> :m .+1<CR>==
nnoremap <C-Down> :m .-2<CR>==
inoremap <C-Up> <Esc>:m .+1<CR>==gi
inoremap <C-Down> <Esc>:m .-2<CR>==gi
vnoremap <C-Up> :m '>+1<CR>gv=gv
vnoremap <C-Down> :m '<-2<CR>gv=gv

" Save and load folding
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave ?* mkview
  autocmd BufWinEnter ?* silent loadview
augroup END

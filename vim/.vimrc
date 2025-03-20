" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')
" Color Themes ----------------------------
Plug 'gosukiwi/vim-atom-dark' " Atom Dark Theme: atom-dark-256
Plug 'tomasr/molokai'         " TextMate monokai theme: molokai

Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'airblade/vim-gitgutter'
call plug#end()

set laststatus=2  " Required by LightLine
set noshowmode    " Remove duplicated -- INSERT -- text

set t_Co=256
syntax on
colo molokai

set encoding=UTF-8

set number        " Always show line numbers

set expandtab     " TAB Use spaces instead of tabs
set tabstop=2     " TAB number of space char that will be inserted when tab is pressed
set shiftwidth=2  " TAB how many columns text is indented with the reindent operations (<<,>>)

set ignorecase    " ignore case when searching
set hlsearch      " Highlight things that we find with the search
set incsearch     " Focus on the search result as I type

set showmatch     " set show matching parenthesis
set mat=2         " How many tenths of a second to blink when matching brackets

set nobackup
set noswapfile

" Show > :set list
set listchars=eol:¶,tab:»-,trail:·,extends:>,precedes:<,space:␣

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

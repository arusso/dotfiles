" 
" ~/.vimrc
"

"" General Options

" Enable filetype plugins
filetype plugin on
filetype indent on

" Enable syntax highlighting
syntax on

" Don't backup files
set nobackup

" Auto read any changes made to files outside of vim
set autoread

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"" Interface
colorscheme desert
set background=dark

"line numbers
set number

" Smart indentation (ie. spaces not tabs)
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" control highlighting
set hlsearch
nmap <space> :noh<cr>

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
set tabstop=2
set shiftwidth=2
set expandtab

" control highlighting
set hlsearch
nmap <space> :noh<cr>

set modeline
set modelines=4

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

execute pathogen#infect()

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

let syntastic_puppet_lint_arguments='--no-class_inherits_from_params_class --no-80chars-check'

execute pathogen#infect()

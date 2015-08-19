"
" ~/.vimrc
"
set nocompatible
filetype off

" setup vundle
set rtp+=~/.vim/bundle/vundle
call vundle#begin()

" vundle likes to manage vundle
Plugin 'gmarik/vundle'

" gist support
"Plugin 'mattn/webapi-vim'
"Plugin 'mattn/gist-vim'

Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'

Plugin 'tpope/vim-fugitive'
Plugin 'mv/mv-vim-puppet'
Plugin 'arusso/vim-colorschemes'
Plugin 'tpope/vim-bundler'
Plugin 'plasticboy/vim-markdown'
"Plugin 'airblade/vim-gitgutter'

call vundle#end()

"let syntastic_puppet_lint_arguments='--no-class_inherits_from_params_class --no-80chars-check'
let g:syntastic_puppet_puppetlint_args='--no-class_inherits_from_params_class --no-80chars-check'

" use frontmatter syntax highlighting
let g:vim_markdown_frontmatter=1

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

" highlight our 81st character
highlight OverLength ctermbg=yellow ctermfg=black guibg=#592929
call matchadd('OverLength', '\%81v.')

" highlight the 141st character
highlight OverLength140 ctermbg=red ctermfg=black guibg=#592929
call matchadd('OverLength140', '\%141v.')

" highlight trailing spaces
highlight TrailingSpace ctermbg=red ctermfg=black guibg=#592929
call matchadd('TrailingSpace', '\s\+$')

" allow us to hit ; in normal mode as an alternative to shift-: to enter
" commands
nnoremap ; :

" setup some leaders for common commands
let mapleader = '-'

" clear out all trailing whitespace
nnoremap <leader>w :%s/\s\+$//g<return>
" replace unquoted modes in puppet
nnoremap <leader>fixmode :%s/\(=>\s\+\)\([0-9]\+\)\s*\(,\?\)$/\1'\2'\3/g<return>

" incremental search
set incsearch

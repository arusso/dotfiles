"
" ~/.vimrc
"
set nocompatible
filetype off

" used to detect our platform
let s:uname = system("echo -n \"$(uname)\"")

" setup vundle
"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" vundle likes to manage vundle
Plugin 'VundleVim/Vundle.vim'

" general vim enhancements
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'plasticboy/vim-markdown'
Plugin 'godlygeek/tabular'
Plugin 'arusso/vim-colorschemes'

" plugins for external tools
Plugin 'tpope/vim-fugitive'
Plugin 'arusso/vim-puppet'
Plugin 'tpope/vim-bundler'
Plugin 'pearofducks/ansible-vim'

" plugins for languages
Plugin 'fatih/vim-go'

" platform specific plugins
if s:uname == "Darwin"
  Plugin 'rizzatti/dash.vim'
endif

call vundle#end()

let g:syntastic_puppet_puppetlint_args='--no-class_inherits_from_params_class --no-80chars-check'

" use frontmatter syntax highlighting
let g:vim_markdown_frontmatter=1

" disable vim-markdown folding behavior
let g:vim_markdown_folding_disabled = 1

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
call matchadd('OverLength', '\%81v.', -1)

" highlight the 141st character
highlight OverLength140 ctermbg=red ctermfg=black guibg=#592929
call matchadd('OverLength140', '\%141v.', -1)

" highlight trailing spaces
highlight TrailingSpace ctermbg=red ctermfg=black guibg=#592929
call matchadd('TrailingSpace', '\s\+$', -1)

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

autocmd BufNewFile,BufRead *.go  set syntax=go

" ignore warnings for older VIM versions /w vim-go
let g:go_version_warning = 0

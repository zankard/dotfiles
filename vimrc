set nocompatible              " be improved, required
filetype off                  " required

let shouldInstallPlugin=0
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    let shouldInstallPlugin=1
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-rails'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
Plugin 'mattn/emmet-vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'pangloss/vim-javascript'
Plugin 'jistr/vim-nerdtree-tabs'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

if shouldInstallPlugin == 1
    echo "Installing Plugins"
    echo ""
    :PluginInstall
endif

" Enable syntax highlight
syntax enable

" let g:solarized_termcolors=256
let g:solarized_termtrans=1
set background=dark
colorscheme solarized

map <C-n> :NERDTreeTabsToggle<CR>
" Better comamand completion
set wildmenu

" Show partial commands in the last line of screen
set showcmd

" Show the matching bracket
set showmatch
set matchpairs=(:),{:},[:]

" highlight cursor line
set cursorline

set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

set backspace=indent,eol,start

" When opening a new line and no filetype-specifc indenting is enabled, keep
" the same indent as the line you're currently on.
set autoindent

" Redraw at center of window
nmap <space> zz

set nostartofline

set ruler

set laststatus=2

set cmdheight=1

" Display line numbers on the left
set number

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set softtabstop=2
set expandtab
" change tab size by file type
autocmd BufRead,BufNewFile *.html.erb nested setlocal filetype=eruby.html
autocmd FileType ruby,eruby,javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2

fun! PostErbSetup()
    let b:surround_{char2nr('=')} = "<%= \r %>"
    let b:surround_{char2nr('-')} = "<% \r %>"
endf

autocmd FileType eruby call PostErbSetup()

set list!
set listchars=tab:>\ ,trail:.,nbsp:+ " Show the leading whitespace

set noeb vb

" Make navigating windows easier
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :redraw!<CR> :wincmd l<CR>
nnoremap <silent> <C-\> :wincmd p<CR>

" Split window
set splitbelow
set splitright

" Enable emmet for some types only
let g:user_emmet_install_global=0
autocmd FileType html,css,eruby EmmetInstall
let g:user_emmet_leader_key='<tab>'

" Tagbar key mapping
nmap <F8> :TagbarToggle<CR>

" Vertical split line
set encoding=utf8
set fillchars+=vert:\│ " Use `│ (U+2502)' as tmux's split char
hi VertSplit ctermbg=NONE guibg=NONE

" Integrate vim-airline with powerline fonts
let g:airline_powerline_fonts=1
" let g:airline#extensions#tagbar#enabled=1
let g:airline#extensions#virtualenv#enabled = 1

function! NerdFiletype()
  if &filetype =~ 'javascript'
    return ' ' " \ue74e
  elseif &filetype =~ 'vim'
    return ' '
  elseif &filetype =~ 'html'
    return ' '
  elseif &filetype =~ 'java'
    return ' ' " \ue738
  elseif &filetype =~ 'python'
    return ' ' " \ue73c
  elseif &filetype =~ 'ruby'
    return ' ' " \ue791
  else
    return &filetype
  endif
endfunction
call airline#parts#define_function('nerdfiletype', 'NerdFiletype')
"call airline#parts#define_accent('nerdfiletype', 'red')

function! AirlineInit()
  let g:airline_section_x = airline#section#create(['tagbar', 'nerdfiletype'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" Change cursor style in different mode
" use orange curosr in insert mode
if &term =~ "^xterm"
  let &t_SI = "\<Esc>]12;orange\x7"
  let &t_SI .= "\<Esc>[4 q"
endif

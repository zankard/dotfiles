" environment variables
let &t_ut=''
let g:is_nvim = has('nvim')
let g:is_vim8 = v:version >= 800 ? 1 : 0
let g:is_kitty = exists('$KITTY_WINDOW_ID')
let g:is_tmux = exists('$TMUX')

set nocompatible              " be improved, required

let g:python_host_prog  = '/usr/bin/python2'
let g:python3_host_prog = '/usr/local/Caskroom/miniconda/base/bin/python'
let g:loaded_python_provider = 0

let g:ale_sign_highlight_linenrs = 1
let g:ale_disable_lsp = 1
let g:ale_linters = { 'java': [], 'go': [] }

" Configure polyglot
let g:polyglot_disabled = ['csv', 'bzl']

" auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC | q
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
if (g:is_nvim)
  call plug#begin(stdpath('data') . '/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
" Plug 'majutsushi/tagbar'
" Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'
Plug 'zankard/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/vim-easy-align'
Plug 'triglav/vim-visual-increment'
" Plug 'will133/vim-dirdiff'
Plug 'dense-analysis/ale'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
" more elegant than builtin
Plug 'sheerun/vim-polyglot'
Plug 'metakirby5/codi.vim'
Plug 'liuchengxu/vim-which-key'
" Plug 'kevinhwang91/rnvimr'
Plug 'junegunn/goyo.vim'
Plug 'mbbill/undotree'
Plug 'airblade/vim-rooter'
Plug 'liuchengxu/vista.vim'
Plug 'jpalardy/vim-slime', { 'for': ['julia', 'javascript', 'markdown'] }
Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-dispatch'
" Plug '~/Documents/GitHub/vim-dispatch'
Plug 'jebaum/vim-tmuxify'
" Plug 'powerman/vim-plugin-ansiesc'
Plug 'brooth/far.vim'
Plug 'szw/vim-maximizer'
Plug 'voldikss/vim-floaterm'
Plug 'jdhao/better-escape.vim'
if (g:is_tmux)
  Plug 'christoomey/vim-tmux-navigator'
endif
if (g:is_kitty)
  Plug 'knubie/vim-kitty-navigator', {'do': 'cp ./*.py ~/.config/kitty/'}
endif
if (g:is_nvim)
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install'  }
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'
endif

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Enable syntax highlight
syntax enable

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors") && (has($TMUX) || has("nvim")))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" set background=dark
" colorscheme solarized

if (!has("nvim"))
  let g:dracula_colorterm = 0
  let g:dracula_italic = 0
endif
colorscheme dracula

" Better comamand completion
set wildmenu
" Show partial commands in the last line of screen
set showcmd
" Show the matching bracket
set showmatch
set matchpairs=(:),{:},[:],<:>
" highlight cursor line
" set cursorline
set hlsearch
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
set backspace=indent,eol,start
" When opening a new line and no filetype-specifc indenting is enabled, keep
" the same indent as the line you're currently on.
set autoindent
" set smartindent
set nostartofline
set ruler
set laststatus=2
set cmdheight=1
" Display line numbers on the left
" set number
" turn hybrid line numbers on
" set number relativenumber
" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set softtabstop=2
set expandtab
set tabstop=2
set list!
set listchars=tab:>\ ,trail:·,nbsp:+ " Show the leading whitespace
set noeb vb
set t_vb=
set pastetoggle=<F2>
" Split window
set splitbelow
set splitright
set encoding=utf8
set fillchars+=vert:\│ " Use `│ (U+2502)' as tmux's split char
" wildignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip    " MacOSX/Linux
set matchtime=3
set sm                   " show matching braces, somewhat annoying...
set noshowmode           " hide the default mode  text (e.g. -- INSERT -- below the status line)
" set colorcolumn=90
set mouse=a
" force the signcolumn to disapper
set scl=no
set completeopt=menuone,noinsert,noselect
set iskeyword+=-                            " treat dash separated words as a word text object"
set nobackup                                " This is recommended by coc
set nowritebackup                           " This is recommended by coc
set updatetime=300                          " Faster completion
set clipboard=unnamedplus                   " Copy paste between vim and everythin else
set shortmess+=c                            " Avoid showing message extra message when using completion
set timeoutlen=300                          " By default timeoutlen is 1000 ms
set ttimeoutlen=30

if (!g:is_nvim)
  set signcolumn=number
endif

if has('persistent_undo')
  set undodir=$HOME/.vim/undodir              " Persistent undo history in a central folder
  set undofile                                " Maintain undo history between sessions
endif


" define , as the mapleader key
let mapleader=" "
hi clear VertSplit
hi VertSplit ctermbg=NONE guibg=NONE cterm=NONE

" color theme highlight
hi! link Pmenu DraculaBgDarker

" Enable emmet for some types only
let g:user_emmet_install_global = 0
autocmd FileType html,css,typescriptreact EmmetInstall
" let g:user_emmet_leader_key='C-Y'

let g:jsx_ext_required = 0 " Allow JSX in normal JS files"

" Make navigating windows easier
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
if has('nvim')
  nmap <BS> <C-W>h
endif
noremap <C-L> <C-W>l
" With arrow key
noremap <C-Down> <C-W>j
noremap <C-Up> <C-W>k
noremap <C-Left> <C-W>h
noremap <C-Right> <C-W>l

" Redraw at center of window
nmap <space> zz

"map <C-n> :NERDTreeTabsToggle<CR>
map <C-n> :NERDTreeToggle<CR>

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<c-e>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME."/.vim/mysnippets"]

" Allow overrides via ~/.vim/vimrc.local
if filereadable(expand("~/.vim/vimrc.local"))
  source ~/.vim/vimrc.local
endif

" if has('nvim')
  " let g:deoplete#enable_at_startup = 1
  " let g:deoplete#file#enable_buffer_path = 1
  " if !exists('g:deoplete#omni#input_patterns')
    " let g:deoplete#omni#input_patterns = {}
  " endif
  " autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
  " deoplete tab-complete
  " inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
  " ,<Tab> for regular tab
  " inoremap <Leader><Tab> <Space><Space>
  " tern
"   autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDefTab<CR>
  " autocmd FileType javascript nnoremap <silent> <buffer> gd :TernDoc<CR>
" endif

" omnifuncs
" augroup omnifuncs
  " autocmd!
  " autocmd FileType python set omnifunc=python3complete#Complete
  " autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  " autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  " autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" augroup end

" Tern settings
" let g:tern_show_argument_hints = 'on_hold'
" let g:tern_show_signature_in_pum = 1
" let g:tern_map_keys = 1
" let g:tern_map_prefix = '<leader>'
" let g:tern_request_timeout = 5
" inoremap <leader>tt :TernType
" inoremap <leader>tR :TernRename
" autocmd FileType javascript setlocal omnifunc=tern#Complete

" vim-tmux-navigator
" Disable tmux navigator when zomming the vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" Configure vim-devicons
let g:webdevicons_enable_ctrlp = 0
let g:webdevicons_enable_airline_tabline = 1
" specify OS to decide an icon for unix fileformat
let g:WebDevIconsOS = 'Darwin'

" Configure ale
let g:ale_set_signs = 1
hi! link ALEErrorSignLineNr SpellBad
" diable yaml linter

" Configure Codi
hi! link CodiVirtualText Comment
let g:codi#virtual_text_prefix = "❯ "

" Configure ranger
" Make Ranger replace netrw and be the file explorer
let g:rnvimr_ex_enable = 1
let g:rnvimr_draw_border = 1
" Make Ranger to be hidden after picking a file
let g:rnvimr_pick_enable = 1
" Make Neovim to wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_bw_enable = 1
" Set up only two columns in miller mode and draw border with both
let g:rnvimr_ranger_cmd = 'python /usr/local/bin/ranger --cmd="set column_ratios 1,1"
            \ --cmd="set draw_borders both"'
let g:rnvimr_presets = [{'width': 0.800, 'height': 0.800}]
let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}

" Configure Goyo
" width
let g:goyo_width = 90
" height
let g:goyo_height = '90%'

" Configure which key
let g:which_key_use_floating_win = 0
let g:which_key_sep = '→'
" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler
" change the colors
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" lua <<EOF
" require'nvim_lsp'.tsserver.setup{
  " on_attach=require'completion'.on_attach;
" }
" require'nvim_lsp'.vuels.setup{
  " on_attach=require'completion'.on_attach;
" }
" vim.lsp.callbacks["textDocument/publishDiagnostics"] = function() end
" EOF

function! s:setnumber()
  if &buftype == 'terminal'
    return
  endif
  if !&modifiable
    return
  endif
  if &ft != 'nerdtree' || g:NERDTreeShowLineNumbers
    set number relativenumber
  endif
endfunction

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * call s:setnumber()
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" Disable continuation comments in vim file
autocmd FileType vim set formatoptions-=cro

" configure vista.vim
let g:vista_fzf_preview = ['right:40%']
" let g:vista_default_executive = 'ctags'
let g:vista_update_on_text_changed = 1

let g:vista_executive_for = {
  \ 'javascript': 'coc',
  \ 'typescript': 'coc',
  \ 'vue': 'coc',
  \ 'scss': 'coc'
  \ }
let g:vista_blink = [2, 50]
" disable statusline by default
let g:vista_disable_statusline = exists('g:loaded_airline') || exists('g:loaded_lightline')

let g:vista#renderer#enable_icon = 1
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
let g:vista_sidebar_position='vertical botright'

if (g:is_nvim)
  augroup terminalgroup
    au!
    au TermOpen * setlocal nonumber norelativenumber
    au TermOpen * startinsert
    au BufEnter,BufWinEnter,WinEnter,FocusGained term://* startinsert
    au BufLeave term://* stopinsert
  augroup end
endif

" go configuration
let g:go_def_mapping_enabled = 0
let g:go_gopls_enabled = 0
let g:go_highlight_functions = 1
let g:go_fmt_autosave = 0
" let g:go_debug_log_output = 'rpc'
" let g:go_highlight_debug = 1
let g:go_debug_windows = {
      \ 'vars':       'leftabove 30vnew',
      \ 'stack':      'leftabove 20new',
      \ 'out':        'botright 5new',
      \ }
" let g:go_debug = ['debugger-state', 'debugger-commands']
let g:go_debug = []

command! -nargs=0 GoDebugClearSign       call go#debug#ClearBreakPointSign()

autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
if (g:is_nvim)
  sign define godebugbreakpoint numhl=ErrorMsg
endif

" rooter
let g:rooter_manual_only = 1

" startify
let g:startify_change_to_dir = 0

source $HOME/.vim/lib/helper.vim
source $HOME/.vim/plug-config/airline.vim
source $HOME/.vim/plug-config/coc.vim
source $HOME/.vim/plug-config/fzf.vim
source $HOME/.vim/plug-config/nerdtree.vim
source $HOME/.vim/plug-config/dispatch-job.vim
source $HOME/.vim/plug-config/startify.vim
source $HOME/.vim/key-mappings.vim

" markdown
let g:vim_markdown_conceal=1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_conceal_code_blocks = 0

" Align GitHub-flavored Markdown tables
augroup markdownconfig
  au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
  au FileType markdown setlocal conceallevel=2
  au FileType markdown setlocal spell spelllang=en_us,cjk
augroup end

" far configuration
au FileType far setlocal lazyredraw   " improve scrolling performance when navigating through large results
let g:far#file_mask_favorites=['%:p', '**/*.*', '**/*.js', '**/*.py', '**/*.java', '**/*.groovy', '**/*.css', '**/*.html', '**/*.vim', '**/*.cpp', '**/*.c', '**/*.h']
if (g:is_nvim)
  let g:far#source = 'rgnvim'
else
  let g:far#source = 'rg'
endif

" floaterm
let g:floaterm_title = ''
let g:floaterm_width = 0.8
let g:floaterm_borderchars = ['─', '│', '─', '│', '╭', '╮', '╯', '╰']
let g:floaterm_gitcommit = 'vsplit'
if (g:is_nvim)
  " Set floaterm window background to gray once the cursor moves out from it
  hi FloatermNC guibg=gray
endif
command! NNN FloatermNew nnn

if (g:is_nvim)
  luafile $HOME/.config/nvim/lua/plug-colorizer.lua
  luafile $HOME/.config/nvim/lua/treesitter.lua
  luafile $HOME/.config/nvim/lua/nvimtree.lua
endif

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<CR>

" In general mode, <TAB/S-TAB> go to next/previous in buffer list
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :previous<CR>

" Alternate way to save
nnoremap <C-s> :w<CR>

" tcsh style editing keys in command line
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>

" map <Esc> to exit terminal-mode
" tnoremap <Esc> <C-\><C-n>
if (g:is_tmux)
  tnoremap <C-h> <C-\><C-n> :TmuxNavigateLeft<CR>
  tnoremap <C-l> <C-\><C-n> :TmuxNavigateRight<CR>
  tnoremap <C-k> <C-\><C-n> :TmuxNavigateUp<CR>
  tnoremap <C-j> <C-\><C-n> :TmuxNavigateDown<CR>
endif

" Configure completion
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map = {}
let g:which_key_map['h'] = [ 'Startify'                           , 'home' ]
let g:which_key_map['f'] = [ ':Files'                             , 'files' ]
let g:which_key_map['n'] = [ ':let @/ = ""'                       , 'no highlight' ]
let g:which_key_map['q'] = [ 'q'                                  , 'quit' ]
let g:which_key_map['o'] = [ ':Vista!!'                           , 'outline' ]
let g:which_key_map['r'] = [ ':RnvimrToggle'                      , 'ranger' ]
let g:which_key_map['s'] = [ ':Rg'                                , 'search' ]
let g:which_key_map['u'] = [ ':UndotreeToggle'                    , 'undo tree' ]
let g:which_key_map['z'] = [ 'Goyo'                               , 'zen' ]

let g:which_key_map[' '] = [ ':Buffers'                               , 'buffers' ]

" a is for actions
let g:which_key_map.a = {
      \ 'name' : '+actions',
      \ 'a' : [':CocAction'                 , 'coc action'],
      \ 'c' : [':ColorizerToggle'           , 'colorizer'],
      \ 'l' : [':SlimeSendCurrentLine'      , 'slime send current line'],
      \ 'm' : [':MarkdownPreview'           , 'markdown preview'],
      \ 'M' : [':MarkdownPreviewStop'       , 'markdown preview stop'],
      \ 'n' : [':set nonumber!'             , 'line-numbers'],
      \ 'r' : [':set norelativenumber!'     , 'relative line nums'],
      \ 's' : [':let @/ = ""'               , 'remove search highlight'],
      \ 't' : [':FloatermToggle'            , 'terminal'],
      \ 'v' : [':Codi'                      , 'virtual repl on'],
      \ 'V' : [':Codi!'                     , 'virtual repl off'],
      \ 'w' : [':StripWhitespace'           , 'strip whitespace'],
      \ }

" b is for buffer
let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ '1' : ['b1'        , 'buffer 1'],
      \ '2' : ['b2'        , 'buffer 2'],
      \ 'd' : [':Bdelete'  , 'delete-buffer'],
      \ 'f' : ['bfirst'    , 'first-buffer'],
      \ 'h' : ['Startify'  , 'home-buffer'],
      \ 'l' : ['blast'     , 'last-buffer'],
      \ 'n' : ['bnext'     , 'next-buffer'],
      \ 'p' : ['bprevious' , 'previous-buffer'],
      \ '?' : ['Buffers'   , 'fzf-buffer'],
      \ }

" c is for code
let g:which_key_map.c = {
      \ 'name' : '+code',
      \ 'F' : ['Fold'                     , 'fold'],
      \ 'f' : ['<Plug>(coc-fix-current)'  , 'fix'],
      \ 'j' : ['ALENext'                  , 'next diag'],
      \ 'k' : ['ALEPrevious'              , 'previous diag'],
      \ 'o' : [':Vista!!'                 , 'outline'],
      \ 'O' : [':CocList outline'         , 'outline'],
      \ 'r' : ['<Plug>(coc-rename)'       , 'rename'],
      \ }

let g:which_key_map.d = {
      \ 'name' : '+dispatch',
      \ 'c' : ['<Plug>SlimeSendCell'      , 'slime send cell'],
      \ 'C' : [':call ReplClear()'        , 'clear repl'],
      \ 'l' : [':SlimeSendCurrentLine'      , 'slime send current line'],
      \ }


" g is for git
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'a' : [':Git add .'                        , 'add all'],
      \ 'A' : [':Git add %'                        , 'add current'],
      \ 'b' : [':Git blame'                        , 'blame'],
      \ 'B' : [':GBrowse'                          , 'browse'],
      \ 'c' : [':Git commit'                       , 'commit'],
      \ 'd' : [':Git diff'                         , 'diff'],
      \ 'D' : [':Gdiffsplit'                       , 'diff split'],
      \ 'g' : [':GGrep'                            , 'git grep'],
      \ 'G' : [':Gstatus'                          , 'status'],
      \ 'h' : [':GitGutterLineHighlightsToggle'    , 'highlight hunks'],
      \ 'H' : ['<Plug>(GitGutterPreviewHunk)'      , 'preview hunk'],
      \ 'j' : ['<Plug>(GitGutterNextHunk)'         , 'next hunk'],
      \ 'k' : ['<Plug>(GitGutterPrevHunk)'         , 'prev hunk'],
      \ 'l' : [':Git log'                          , 'log'],
      \ 'm' : ['<Plug>(git-messenger)'             , 'message'],
      \ 'p' : [':Git push'                         , 'push'],
      \ 'P' : [':Git pull'                         , 'pull'],
      \ 'r' : [':GRemove'                          , 'remove'],
      \ 's' : ['<Plug>(GitGutterStageHunk)'        , 'stage hunk'],
      \ 'S' : [':!git status'                      , 'status'],
      \ 't' : [':GitGutterSignsToggle'             , 'toggle signs'],
      \ 'u' : ['<Plug>(GitGutterUndoHunk)'         , 'undo hunk'],
      \ 'v' : [':GV'                               , 'view commits'],
      \ 'V' : [':GV!'                              , 'view buffer commits'],
      \ }

" s is for search
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '/' : [':History/'              , 'history'],
      \ ';' : [':Commands'              , 'commands'],
      \ 'a' : [':Ag'                    , 'text Ag'],
      \ 'b' : [':BLines'                , 'current buffer'],
      \ 'B' : [':Buffers'               , 'open buffers'],
      \ 'c' : [':Commits'               , 'commits'],
      \ 'C' : [':BCommits'              , 'buffer commits'],
      \ 'f' : [':Files'                 , 'files'],
      \ 'g' : [':GFiles'                , 'git files'],
      \ 'G' : [':GFiles?'               , 'modified git files'],
      \ 'h' : [':History'               , 'file history'],
      \ 'H' : [':History:'              , 'command history'],
      \ 'l' : [':Lines'                 , 'lines'] ,
      \ 'm' : [':Marks'                 , 'marks'] ,
      \ 'M' : [':Maps'                  , 'normal maps'] ,
      \ 's' : [':CocList snippets'      , 'snippets'],
      \ 'S' : [':Colors'                , 'color schemes'],
      \ 'r' : [':Rg'                    , 'text Rg'],
      \ 'w' : [':Windows'               , 'search windows'],
      \ 'y' : [':Filetypes'             , 'file types'],
      \ 'z' : [':FZF'                   , 'FZF'],
      \ }

let g:which_key_map['t'] = {
      \ 'name' : '+test',
      \ 'f' : [':TestFile' , 'Test file'],
      \ }

let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window'],
      \ 'd' : ['<C-W>c'     , 'delete-window'],
      \ '-' : ['<C-W>s'     , 'split-window-below'],
      \ '|' : ['<C-W>v'     , 'split-window-right'],
      \ '=' : ['<C-W>='     , 'resize-window-equal'],
      \ '?' : ['Windows'    , 'fzf windows'],
      \ }

let g:which_key_map.1 = 'which_key_ignore'
let g:which_key_map.2 = 'which_key_ignore'
let g:which_key_map.3 = 'which_key_ignore'
let g:which_key_map.4 = 'which_key_ignore'
let g:which_key_map.5 = 'which_key_ignore'
let g:which_key_map.6 = 'which_key_ignore'
let g:which_key_map.7 = 'which_key_ignore'
let g:which_key_map.8 = 'which_key_ignore'
let g:which_key_map.9 = 'which_key_ignore'


" let g:which_key_map[' '] = 'which_key_ignore'

call which_key#register('<Space>', "g:which_key_map")

vnoremap <silent> <space>/ :call Comment()<CR>
nnoremap <silent> <space>/ :call Comment()<CR>

nnoremap <C-c> <silent> <C-c>
nmap <C-c>c <Plug>SlimeSendCell
nmap <C-c>d :SlimeSendCurrentLine<CR>

nnoremap <silent> <F12> :FloatermToggle<CR>
tnoremap <silent> <F12> <C-\><C-n>:FloatermToggle<CR>

" nvim-tree key-bindings
nnoremap <C-n> :NvimTreeToggle<CR>

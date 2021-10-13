" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_tags_command = 'ctags -R'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

if (g:is_nvim)
  let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.6, 'yoffset':0.3,'xoffset': 0.5, 'highlight': 'Comment' } }
endif

" Always enable preview window on the right with 60% width
"   - Preview window on the right with 60% width
"   - CTRL-_ will toggle preview window.
let g:fzf_preview_window = ['right:60%', 'ctrl-_']

" nnoremap <leader>b    :Buffers<CR>
" nnoremap <leader>g    :GFiles<CR>
" nnoremap <leader>r    :Rg <C-R><C-W><CR>

let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"

" Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)

" Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

let s:TYPE = {'dict': type({}), 'funcref': type(function('call')), 'string': type(''), 'list': type([])}

function! s:p(bang, ...)
  if ((a:bang && &columns < 80) || &columns < 120)
    return { 'options': ['--preview-window', 'hidden'] }
  endif
  let preview_args = get(g:, 'fzf_preview_window')
  if empty(preview_args)
    return { 'options': ['--preview-window', 'hidden'] }
  endif
  " For backward-compatiblity
  if type(preview_args) == type('')
    let preview_args = [preview_args]
  endif

  return call('fzf#vim#with_preview', extend(copy(a:000), preview_args))
endfunction

function! s:wrap(name, opts, bang)
  " fzf#wrap does not append --expect if sink or sink* is found
  let opts = copy(a:opts)
  let options = ''
  if has_key(opts, 'options')
    let options = type(opts.options) == s:TYPE.list ? join(opts.options) : opts.options
  endif
  if options !~ '--expect' && has_key(opts, 'sink*')
    let Sink = remove(opts, 'sink*')
    let wrapped = fzf#wrap(a:name, opts, a:bang)
    let wrapped['sink*'] = Sink
  else
    let wrapped = fzf#wrap(a:name, opts, a:bang)
  endif
  return wrapped
endfunction

function! s:fzf(name, opts, extra)
  let [extra, bang] = [{}, 0]
  if len(a:extra) <= 1
    let first = get(a:extra, 0, 0)
    if type(first) == s:TYPE.dict
      let extra = first
    else
      let bang = first
    endif
  elseif len(a:extra) == 2
    let [extra, bang] = a:extra
  else
    throw 'invalid number of arguments'
  endif

  let merged = extend(copy(a:opts), extra)
  return fzf#run(s:wrap(a:name, merged, bang))
endfunction

" Mru history
function! s:mru_files()
  let recent_files = fzf#vim#_recent_files()
  return filter(recent_files, 'helper#is_file_in_cwd(v:val)')
endfunction

function! s:mru_history(arg, extra, bang)
  let bang = a:bang || a:arg[len(a:arg)-1] == '!'
  return s:fzf('mru', {
  \ 'source':  s:mru_files(),
  \ 'options': ['-m', '--header-lines', !empty(expand('%')), '--prompt', 'Hist> ']
  \}, [a:extra, bang])
endfunction

command! -bang -nargs=* MRUHistory call s:mru_history(<q-args>, s:p(<bang>0), <bang>0)

nnoremap <C-p> :MRUHistory<CR>

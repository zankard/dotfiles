" Vim filetype plugin file
" Language:     JavaScript

setlocal suffixesadd=.js,.vue,.scss,.ts
setlocal isfname+=@-@

" setlocal includeexpr=substitute(v:fname,'^\\~\/','./','')

if (g:is_nvim)
  lua << EOF
  require('js-resolve').resolve()
EOF
endif

function! ReplClear()
  if !exists('*slime#send')
    return
  endif
  call slime#send(".clear\x0d")
  call helper#tmux_command('send-keys' . ' -t "{right-of}" C-l')
endfunction

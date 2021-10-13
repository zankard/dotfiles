setlocal suffixesadd=.js,.vue,.scss,.ts
setlocal isfname+=@-@

" setlocal includeexpr=substitute(v:fname,'^\\~\/','./','')

if (g:is_nvim)
  lua << EOF
  require('js-resolve').resolve()
EOF
endif

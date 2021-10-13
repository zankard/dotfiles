" vim-dispatch height
let g:dispatch_quickfix_height = 20

" make test commands execute using vimux
let test#strategy = "dispatch"

let g:tmuxify_custom_command = 'tmux popup'

function! CmdTransform(cmd) abort
  " if a:cmd =~ "^gradle.*"
    " return substitute(a:cmd, '^gradle\(\s\+\)\(.*\)', './gradlew\1\2', "")
  " endif
  return a:cmd
endfunction

let g:test#custom_transformations = {'cmdtransform': function('CmdTransform')}
" let g:test#transformation = 'cmdtransform'

" Java configuration
let test#java#runner = 'gradletest'
let test#java#gradletest#executable = './gradlew test'

" Go Configuration
let test#go#runner = 'ginkgo'

"**********************************************************
" slime configuration
"**********************************************************
let g:slime_target = 'tmux'
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_dont_ask_default = 1

let g:SlimeBlocksVerbose = 0

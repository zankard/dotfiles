function! Comment()
  if exists('g:loaded_commentary')
    if (mode() == "n" )
      execute "Commentary"
    else
      execute "'<,'>Commentary"
    endif
  endif
endfunction

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

function! s:goyo_enter()
  silent !$HOME/.local/utils/isfullscreen.swift Alacritty
  let l:shell_error = v:shell_error

  if l:shell_error
    let g:goyo_pre_fullscreen = 0
  else
    let g:goyo_pre_fullscreen = 1
  endif

  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    if g:goyo_pre_fullscreen == 0
      silent !$HOME/.local/utils/alacritty-fullscreen.swift
    endif
  endif
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    if g:goyo_pre_fullscreen == 0
      silent !$HOME/.local/utils/alacritty-fullscreen.swift
    endif
  endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

function! helper#is_file_in_cwd(file)
  " the file starts with cwd
  return match(fnamemodify(resolve(a:file), ":p"), '\V' . getcwd() . '/') == 0
endfunction

function! helper#tmux_command(args)
  let l:socket = "default"
  " For an absolute path to the socket, use tmux -S.
  " For a relative path to the socket in tmux's temporary directory, use tmux -L.
  " Case sensitivity does not matter here, but let's follow good practice.
  " TODO: Make this cross-platform. Windows supports tmux as of mid-2016.
  let l:socket_option = l:socket[0] ==? "/" ? "-S" : "-L"
  return system("tmux " . l:socket_option . " " . shellescape(l:socket) . " " . a:args)
endfunction

" Activate
function SlimeOverride_EscapeText_javascript(text)
  if len(split(a:text, "\n")) > 1
    return [".editor", "\n", a:text, "// end of editor mode\n", "\x04"]
  endif
  return a:text
endfunction

function ReplClear_javascript()
  if !exists('g:loaded_slime') || v:version < 700
    return
  endif
  call slime#send(".clear\x0d")
  call helper#tmux_command('send-keys' . ' -t "{right-of}" C-l')
endfunction

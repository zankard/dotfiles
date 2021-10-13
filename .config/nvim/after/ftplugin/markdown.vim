function! s:escape_text(text, ft)
  let custom_escape = "_EscapeText_" . substitute(a:ft, "[.]", "_", "g")
  if exists("*SlimeOverride" . custom_escape)
    return call("SlimeOverride" . custom_escape, [a:text])
  elseif exists("*" . custom_escape)
    return call(custom_escape, [a:text])
  end
  return a:text
endfunction

let b:slime_cell_delimiter = '```'
" Activate
function! _EscapeText_markdown(text)
  let n = search('```', 'bcnW')
  if (n > 0)
    let l = getline(n)
    let arr = matchlist(l, '```\(.\+\)$')
    if (len(arr) >= 2)
      return s:escape_text(a:text, arr[1])
    endif
  endif
  return a:text
endfunction

function! ReplClear()
  let n = search('```', 'bcnW')
  if (n > 0)
    let l = getline(n)
    let arr = matchlist(l, '```\(.\+\)$')
    if (len(arr) >= 2)
      let clearFunc = "ReplClear_" . substitute(arr[1], "[.]", "_", "g")
      if exists("*" . clearFunc)
        return call(clearFunc, [])
      endif
    endif
  endif
endfunction

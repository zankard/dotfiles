let g:airline_powerline_fonts = 1
let g:airline_theme = 'dracula'
let g:airline#extensions#branch#use_vcscommand = 0

let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#show_close_button = 0

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

let g:airline#extensions#tabline#show_tabs = 1
" the minimum number of tabs needed to show the tabline.
let g:airline#extensions#tabline#tab_min_count = 0
let g:airline#extensions#tabline#tabs_label = ' '
let g:airline#extensions#tabline#tab_nr_type = 1
" let g:airline#extensions#tabline#show_tab_nr = 0
" let g:airline#extensions#tabline#tabnr_formatter = ''

let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#buffers_label= '﬘'

" Just show the file name
let g:airline#extensions#tabline#fnamemod = ':t'

" configure the minimum number of buffers needed to show the tabline
let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:airline#extensions#tabline#buffer_min_count = 0

let g:airline_filetype_overrides = {}
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#coc#enabled = 1
let airline#extensions#vista#enabled = 1
" let g:airline#extensions#tagbar#enabled=1

let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" call airline#parts#define_function('nerdfiletype', 'NerdFiletype')
" call airline#parts#define_accent('nerdfiletype', 'red')

function! AirlineInit()
  let g:airline_section_x = airline#section#create_right(['vista'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

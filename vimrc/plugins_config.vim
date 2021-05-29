" Initialize colorizer
lua require'colorizer'.setup()
au WinEnter,BufEnter * :ColorizerAttachToBuffer
au WinLeave,BufLeave * :ColorizerDetachFromBuffer

nmap ] <Plug>(GitGutterNextHunk)
nmap [ <Plug>(GitGutterPrevHunk)
"Colorizer
let g:colorizer_maxlines = 1000

" Git GitGutter
set updatetime=100
autocmd VimEnter * GitGutterEnable
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
highlight SignColumn guibg=NONE ctermbg=NONE

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Fzf
" Search for file names
map <C-f> <Esc><Esc>:Files<CR>
" Search for word in same file
nnoremap <leader>f :BLines<CR>
" Search for word in whole project direcotry
nnoremap <C-p> :Rg!<Cr>
" Search in files that are added in git
noremap <C-G> :GFiles<CR>
noremap <C-space> :Buffers<CR>

" Hide terminal status line for fzf
if has('nvim') && !exists('g:fzf_layout')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" vim-grepper
let g:grepper={}
let g:grepper.tools=["rg"]

xmap gr <plug>(GrepperOperator)

" vim-sneak
let g:sneak#label = 1
map f <Plug>Sneak_s
map F <Plug>Sneak_S

" For vim-doge
let g:doge_doc_standard_python = 'numpy'

"netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_localrmdir='rm -r'
nnoremap <silent>sf :<C-u>Ex<CR>

" After searching for text, press this mapping to do a project wide find and
" replace. It's similar to <leader>r except this one applies to all matches
" across all files instead of just the current file.
nnoremap <C-R>
  \ :let @s='\<'.expand('<cword>').'\>'<CR>
  \ :Grepper -cword -noprompt<CR>
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" The same as above except it works with a visual selection.
xmap <Leader>R
    \ "sy
    \ gvgr
    \ :cfdo %s/<C-r>s//g \| update
     \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pyright', 
  \ 'coc-sql',
  \ 'coc-json', 
  \ 'coc-omnisharp',
  \ ]

" Git messenger
let g:git_messenger_no_default_mappings=v:true
nmap <Leader>g <Plug>(git-messenger)

let g:python3_host_prog='/usr/bin/python3'

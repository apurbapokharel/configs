" Leader
noremap <Space> <Nop>
let mapleader=" "

syntax on
set mouse=n
set termguicolors
set number
set relativenumber
set autoread
set splitbelow
set splitright
set path+=**                        " add cwd and 1 level of nesting to path
set hidden                          " switching from unsaved buffer without '!'
set ignorecase                      " ignore case in search
set incsearch                       " incremental search highlighting
set cursorline
set smartcase                       " case-sensitive only with capital letters
set noruler                         " do not show ruler
set list lcs=tab:‣\ ,trail:•        " customize invisibles
set splitbelow                      " split below instead of above
set splitright                      " split after instead of before
set nobackup                        " do not keep backups
set noswapfile                      " no more swapfiles
set clipboard=unnamedplus           "   copy into osx clipboard by default
set encoding=utf-8                  " utf-8 files
set expandtab                       " softtabs, always (convert tabs to spaces)
set tabstop=2                       " tabsize 2 spaces (by default)
set shiftwidth=0                    " use 'tabstop' value for 'shiftwidth'
set softtabstop=2                   " tabsize 2 spaces (by default)
set laststatus=2                    " always show statusline
set backspace=2                     " restore backspace
set belloff=all                     " do not show error bells
set synmaxcol=1000                  " do not highlight long lines
set timeoutlen=250                  " keycode delay
set title                           " Show the filename in the window titlebar
" Autocompletion mednu settings
set completeopt=longest,menuone,noselect
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nnoremap <C-a> :source ~/configs/init.vim<CR> 

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

nnoremap <leader>v :vsp \| :Explore <Cr>
nnoremap <leader>s :sp \| :Explore <Cr>

inoremap jj <ESC>

" Alternate way to quit
nnoremap <C-Q> :wq!<CR>

" Quit buffer
nnoremap <A-c> :bp <BAR> bd #<CR>
nnoremap <A-x> :bp <CR>


map <C-z> :u<CR>
inoremap <C-z> <Esc><Esc> :u<BAR>:startinsert <CR>

set wildignore+=.git,.DS_Store,node_modules
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50

" Toggle underline when in insert mode
autocmd WinLeave,BufLeave * setlocal nocursorline
autocmd WinEnter,BufEnter * setlocal cursorline
autocmd InsertEnter,InsertLeave * set cul!
map <leader>c :set cul!<CR>

" when pairing some braces or quotes, put cursor between them
inoremap <>   <><Left>
inoremap ()   ()<Left>
inoremap {}   {}<Left>
inoremap []   []<Left>
inoremap ""   ""<Left>
inoremap ''   ''<Left>
inoremap ``   ``<Left>

" Replace the text from the top of register
vmap r "_dP
" Good old CTRL+s for saving
nnoremap <C-s> :write<Cr>
vnoremap <C-s> <C-c>:write<Cr>
inoremap <C-s> <Esc>:write<Cr>
onoremap <C-s> <Esc>:write<Cr>

" use tab and shift tab to indent and de-indent code
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv
inoremap <S-Tab> <C-d>

" use qq to record, q to stop, Q to play a macro
nnoremap Q @q
vnoremap Q :normal @q

" Copy pasta with ctrv in insert mode
inoremap <c-v> <esc>:set paste<cr>a<c-r>=getreg('+')<cr><esc>:set nopaste<cr>mi`[=`]`ia

" Automatically remove whitespace on save
autocmd BufWritePre *.py %s/\s\+$//e

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>
" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent> a* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> a* "sy:let @/=@s<CR>cgn

" highlight trailing whitespace
highlight TrailingWhitespace ctermfg=0 guifg=Black ctermbg=8 guibg=#41535B

" Persistent undo
" guard for distributions lacking the persistent_undo feature.
if has('persistent_undo')
  " define a path to store persistent_undo files.
  let target_path = expand('~/.config/vim-persisted-undo/')

  " create the directory and any parent directories
  " if the location does not exist.
  if !isdirectory(target_path)
      call system('mkdir -p ' . target_path)
  endif

  " point Vim to the defined undo directory.
  let &undodir = target_path

  " finally, enable undo persistence.
  set undofile
endif

"function! s:set_transparent_bg()
"  hi Normal guibg=NONE ctermbg=NONE " transparent bg
"endfunction

" Make vim transparent backgroud, similar to terminal
" autocmd vimenter * call <SID>set_transparent_bg()

" For sql files
let g:omni_sql_no_default_maps = 1

" Open file in line where you left off
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Highlight column when line exceeds 81 length
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Make active window obvious by dimming inactive buffer and windows
hi def Dim guifg=#888888

function! s:DimInactiveWindow()
    syntax region Dim start='' end='$$$end$$$'
endfunction

function! s:UndimActiveWindow()
    ownsyntax
endfunction

autocmd WinEnter * call s:UndimActiveWindow()
autocmd BufEnter * call s:UndimActiveWindow()
autocmd WinLeave * call s:DimInactiveWindow()

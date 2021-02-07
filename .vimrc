call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary' 
Plug 'machakann/vim-sandwich'
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'zxqfl/tabnine-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'|
          \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'zefei/vim-wintabs'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
Plug 'junegunn/goyo.vim'
Plug 'justinmk/vim-sneak'
call plug#end()

colorscheme nord

" Leader
noremap <Space> <Nop> 
let mapleader=" "

set mouse=n
syntax on
set relativenumber
set number
set lazyredraw                   " less redrawing during macro execution etc
set autoread
set path+=**                     " add cwd and 1 level of nesting to path
set hidden                       " switching from unsaved buffer without '!'
set ignorecase                   " ignore case in search
set incsearch                    " incremental search highlighting
set smartcase                    " case-sensitive only with capital letters
set noruler                      " do not show ruler
set list lcs=tab:‣\ ,trail:•     " customize invisibles
set cursorline                   " highlight cursor line
set splitbelow                   " split below instead of above
set splitright                   " split after instead of before
set nobackup                     " do not keep backups
set noswapfile                   " no more swapfiles
set clipboard=unnamedplus       " copy into osx clipboard by default
set encoding=utf-8               " utf-8 files
set expandtab                    " softtabs, always (convert tabs to spaces)
set tabstop=2                    " tabsize 2 spaces (by default)
set shiftwidth=0                 " use 'tabstop' value for 'shiftwidth'
set softtabstop=2                " tabsize 2 spaces (by default)
set laststatus=2                 " always show statusline
set backspace=2                  " restore backspace
set nowrap                       " do not wrap text at `textwidth`
set belloff=all                  " do not show error bells
set synmaxcol=1000               " do not highlight long lines
set timeoutlen=250               " keycode delay
set title                        " Show the filename in the window titlebar
set showcmd                      " Show the (partial) command as it’s being typed
set wildignore+=.git,.DS_Store,node_modules
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50

vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

map <C-z> :u<CR>
inoremap <C-z> <Esc><Esc> :u<BAR>:startinsert <CR>

" Movement between splits
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>

" Movement when in insert mode
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Easy navigation for in normal mode
noremap K     {
noremap J     }
noremap H     ^
noremap L     $

" when pairing some braces or quotes, put cursor between them
inoremap <>   <><Left>
inoremap ()   ()<Left>
inoremap {}   {}<Left>
inoremap []   []<Left>
inoremap ""   ""<Left>
inoremap ''   ''<Left>
inoremap ``   ``<Left>

" Buffers
set hidden
nnoremap  <Esc>l :bp<CR>
nnoremap  <Esc>h :bn<CR> 
nnoremap 	<ESC>c :bp <BAR> bd #<CR>
nnoremap <leader>1 :b1<CR>
nnoremap <leader>2 :b2<CR>
nnoremap <leader>3 :b3<CR>
nnoremap <leader>4 :b4<CR>
nnoremap <leader>5 :b5<CR>
nnoremap <leader>6 :b6<CR>
nnoremap <leader>7 :b7<CR>
nnoremap <leader>8 :b8<CR>

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

" Moving lines up and down like with alt in vscode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" highlight trailing whitespace
highlight TrailingWhitespace ctermfg=0 guifg=Black ctermbg=8 guibg=#41535B

" hide ghost tilde characters after end of file
highlight EndOfBuffer guibg=NONE ctermbg=NONE guifg=Black ctermfg=0

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

function! s:set_transparent_bg()
hi Normal guibg=NONE ctermbg=NONE " transparent bg
endfunction

" Make vim transparent backgroud, similar to terminal
autocmd vimenter * call <SID>set_transparent_bg()


" Plugins setting and keybindings
" Goyo
let g:goyo_width=120
nnoremap <leader>g :Goyo<CR>
autocmd! User GoyoLeave nested call <SID>set_transparent_bg()

" Git GitGutter
set updatetime=100
autocmd VimEnter * GitGutterEnable
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
highlight SignColumn guibg=NONE ctermbg=NONE

" NerdTree
autocmd VimEnter * NERDTree
" Move cursor to file when starting in nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" Close NerdTre automatically when you close vim
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
  \ quit | endif

" Fzf 
" Search for file names
map <C-f> <Esc><Esc>:Files!<CR>
" Search for word in same file
inoremap <C-f> <Esc><Esc>:BLines<CR>
" Search for word in whole project direcotry
nnoremap <C-p> :Rg!<Cr>
" Search in files that are added in git
noremap <C-G> :GFiles<CR>

" vim-wintab
let g:wintabs_ui_buffer_name_format = ' %n: %t '

" vim-grepper
let g:grepper={}
let g:grepper.tools=["rg"]

xmap gr <plug>(GrepperOperator)

" vim-sneak
let g:sneak#label = 1
map f <Plug>Sneak_s
map F <Plug>Sneak_S

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

" For sql files
let g:omni_sql_no_default_maps = 1

" Open file in line where you left off
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

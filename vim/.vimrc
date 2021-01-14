call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'zxqfl/tabnine-vim'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'zefei/vim-wintabs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

colorscheme gruvbox

" Support for mouse and global clipboard
set mouse=n
set clipboard+=unnamedplus

" Leader
noremap <Space> <Nop> 
let mapleader=" "

" Line Numbering
set relativenumber
set number

set autoread
set tabstop=2
syntax on

vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Movement between splits
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>

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

" Moving lines up and down like with alt in vscode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Git GitGutter
set updatetime=100
autocmd VimEnter * GitGutterEnable
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
highlight SignColumn guibg=NONE ctermbg=NONE

" NerdTree
autocmd VimEnter * NERDTree
autocmd BufWinEnter * silent NERDTreeMirror
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
map <C-f> <Esc><Esc>:Files!<CR>
inoremap <C-f> <Esc><Esc>:BLines<CR>

" Make vim transparent backgroud, similar to terminal
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE " transparent bg

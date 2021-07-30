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

" Moving lines up and down like with alt in vscode
xnoremap <A-j> :move '>+1<CR>gv-gv
xnoremap <A-k> :move '<-2<CR>gv-gv

" Buffers
set hidden
nnoremap <A-h> :bp<CR>
nnoremap <A-l> :bn<CR>
nnoremap <A-1> :b1<CR>
nnoremap <A-2> :b2<CR>
nnoremap <A-3> :b3<CR>
nnoremap <A-4> :b4<CR>
nnoremap <A-5> :b5<CR>
nnoremap <A-6> :b6<CR>
nnoremap <A-7> :b7<CR>
nnoremap <A-8> :b8<CR>
nnoremap <A-9> :b9<CR>


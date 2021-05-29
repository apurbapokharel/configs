" ######
" #     #
" #     #
" ######
" #     #
" #     # Barun Pradhan
" ######  https://github.com/barunslick

call plug#begin('~/.config/nvim/plugged/')
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'
Plug 'junegunn/vim-easy-align'
Plug 'psliwka/vim-smoothie'
Plug 'tpope/vim-vinegar'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'arcticicestudio/nord-vim'
Plug 'airblade/vim-gitgutter'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'mhinz/vim-grepper'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'nelstrom/vim-visual-star-search'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'rhysd/git-messenger.vim'
Plug 'TaDaa/vimade'
Plug 'sansyrox/vim-python-virtualenv'
" Plug 'neovim/nvim-lspconfig'
" Plug 'anott03/nvim-lspinstall'
" Plug 'kyazdani42/nvim-tree.lua'
" Plug 'itchyny/vim-cursorword'
call plug#end()

set background=dark
colorscheme nord

source ~/configs/vimrc/base_config.vim
source ~/configs/vimrc/statusline.vim
source ~/configs/vimrc/movement.vim
source ~/configs/vimrc/plugins_config.vim

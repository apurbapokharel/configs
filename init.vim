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
Plug 'psliwka/vim-smoothie'
Plug 'tpope/vim-vinegar'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'arcticicestudio/nord-vim'
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
Plug 'pechorin/any-jump.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive' "requirement from benwainwright/fzf-project
Plug 'shaunsingh/nord.nvim'
Plug 'benwainwright/fzf-project'
" Vim Script
call plug#end()


set termguicolors
colorscheme nord

au ColorScheme * hi Normal ctermbg=none guibg=none

source ~/configs/vimrc/base_config.vim
source ~/configs/vimrc/statusline.vim
source ~/configs/vimrc/movement.vim
source ~/configs/vimrc/plugins_config.vim

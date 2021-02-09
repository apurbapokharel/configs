if [ "$TMUX" = "" ]; then tmux; fi
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_DIR_TRUNC=2
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PYENV_SHOW=false
SPACESHIP_RUBY_SHOW=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_NODE_SHOW=false
# SPACESHIP_GIT_SYMBOL=
SPACESHIP_GIT_PREFIX=
SPACESHIP_CHAR_SYMBOL=λ
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_VENV_GENERIC_NAMES=false
SPACESHIP_EXEC_TIME_SHOW=false
SPACESHIP_PROMPT_DEFAULT_PREFIX=""
SPACESHIP_CHAR_COLOR_SUCCESS=#f6830f
SPACESHIP_DIR_COLOR=blue
SPACESHIP_VENV_COLOR=green

export ZSH="/home/barunpradhan/.oh-my-zsh"
ZSH_THEME="spaceship"

plugins=(git
  forgit
	zsh-autosuggestions
  fz
  fzf-tab
)

source $ZSH/oh-my-zsh.sh

function open_with_fzf() {
    fd -t f -H -I | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&-
}

function cd_with_fzf() {
    cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
}

function pacs() {
    sudo pacman -Syy $(pacman -Ssq | fzf -m --preview="pacman -Si {}" --preview-window=:hidden --bind=space:toggle-preview)
}

function fzy() {
    sudo yay -Syy $(yay -Ssq | fzf -m --preview="yay -Si {}" --preview-window=:hidden --bind=space:toggle-preview)
}

function open_vim_after_fzf() {
    cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)" && vim
}

function open_code_after_fzf() {
    cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)" && code
}

# find-in-file(s)
function fif() {
	if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
	rg --ignore-case --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 8 '$1' || rg --ignore-case --pretty --context 8 '$1' {}" --preview-window=right:60%
}

# find in files - open in Vim - go to 1st search result
function vf() {
	local file
	file=$(fif $1)
	if [[ -n $file ]]
	then
		nvim $file -c /$1 -c 'norm! n zz'
	fi

}
function fzf-git-branch() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=-committerdate |
        grep -v HEAD |
        fzf --height 50% --ansi --no-multi --preview-window right:65% \
            --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
        sed "s/.* //"
}

function fzf-git-checkout() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    local branch

    branch=$(fzf-git-branch)
    if [[ "$branch" = "" ]]; then
        echo "No branch selected."
        return
    fi

    # If branch name starts with 'remotes/' then it is a remote branch. By
    # using --track and a remote branch name, it is the same as:
    # git checkout -b branchName --track origin/branchName
    if [[ "$branch" = 'remotes/'* ]]; then
        git checkout --track $branch
    else
        git checkout $branch;
    fi
}

alias gb='fzf-git-branch'
alias gco='fzf-git-checkout'

# Add sudo to current line if not empty else to previous command
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && {
      typeset -a bufs
      bufs=(${(z)BUFFER})
      if (( $+aliases[$bufs[1]] )); then
        bufs[1]=$aliases[$bufs[1]]
      fi
      bufs=(sudo $bufs)
      BUFFER=$bufs
    }
    zle end-of-line
}

zle -N sudo-command-line
bindkey "^s" sudo-command-line

bindkey -s "^F" 'cd_with_fzf^M'
bindkey -s "^T" 'toggle-fzf-tab^M'
bindkey -s "^g" 'ghcal -u barunslick^M'
bindkey -s "^v" 'open_vim_after_fzf^M'
bindkey -s "^e" 'open_code_after_fzf^M'
bindkey -e
# User configuration

# Add new before each promt
precmd() $funcstack[1]() echo

alias trm=trash-put
alias trl=trash-list
alias tre=trash-empty
alias cm=command
alias ls='exa -l --git'
. /home/barunpradhan/.oh-my-zsh/plugins/z/z.sh
. /home/barunpradhan/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:#d0d0d0,hl:#5f87af
 --color=fg+:#d0d0d0,hl+:#5fd7ff
 --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff
 --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'

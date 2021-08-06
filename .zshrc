######  
#     # 
#     # 
######  
#     # 
#     # Barun Pradhan
######  https://github.com/barunslick

export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/configs/runpathfunction:$PATH"
export PATH="$HOME/.local/bin:$PATH"
eval "$(pyenv init -)"
export EDITOR=nvim
export BROWSER=brave
export LC_ALL=en_US.UTF-8

# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Custom sudo prompt for spaceship
SPACESHIP_SUDO_SHOW="${SPACESHIP_SUDO_SHOW=true}"
SPACESHIP_SUDO_PREFIX="${SPACESHIP_SUDO_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_SUDO_SUFFIX="${SPACESHIP_SUDO_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_SUDO_COLOR="${SPACESHIP_SUDO_COLOR="cyan"}"

spaceship_sudo (){
  # If SPACESHIP_SUDO_SHOW is false, don't show foobar section
  [[ $SPACESHIP_SUDO_SHOW == false ]] && return

  # Check if foobar command is available for execution
  spaceship::exists sudo || return

  CAN_I_RUN_SUDO=$(sudo -n uptime 2>&1|grep "load"|wc -l)
	if [ ${CAN_I_RUN_SUDO} -gt 0 ]; then
    sudo_status="su"
  else
    sudo_status=""
  fi

  [[ -z $sudo_status ]] && return

   spaceship::section \
    "$SPACESHIP_SUDO_COLOR" \
    "$SPACESHIP_SUDO_PREFIX" \
    "[$sudo_status]" \
    "$SPACESHIP_SUDO_SUFFIX"
}

# SPACESHIP SETTINS
SPACESHIP_VI_MODE_SHOW=true
SPACESHIP_VI_MODE_COLOR=blue
SPACESHIP_DIR_TRUNC=2
SPACESHIP_PROMPT_SEPARATE_LINE=false
# SPACESHIP_GIT_SYMBOL=
SPACESHIP_GIT_PREFIX=
SPACESHIP_CHAR_SYMBOL=λ
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_VENV_GENERIC_NAMES=false
SPACESHIP_EXEC_TIME_SHOW=true
SPACESHIP_PROMPT_DEFAULT_PREFIX=""
SPACESHIP_CHAR_COLOR_SUCCESS=#f6830f
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_DIR_COLOR=blue
SPACESHIP_VENV_COLOR=green
SPACESHIP_SUDOSHOW=true
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_SUDO_SUFFIX=" "

SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  battery       # Battery level and status
  jobs          # Background jobs indicator
  vi_mode
  sudo
  char          # Prompt character
)


SPACESHIP_RPROMPT_ORDER=(
 exec_time
)

export ZSH="/home/barun/.oh-my-zsh"
ZSH_THEME="spaceship"

plugins=(git
  vi-mode
  forgit
	zsh-autosuggestions
  fz
  fzf-tab
  zsh-syntax-highlighting
  z
)

source $ZSH/oh-my-zsh.sh

function open_with_fzf() {
    fd -t f -H -I | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&-
}

function cd_with_fzf() {
    cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview")"
}

function pacs() {
    sudo pacman -Syy $(pacman -Ssq | fzf -m --preview="pacman -Si {}" --bind=space:toggle-preview)
}

function fzy() {
    sudo yay -Syy $(yay -Ssq | fzf -m --preview="yay -Si {}" --bind=space:toggle-preview)
}

function open_vim_after_fzf() {
    cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" )" && nvim
}

function open_code_after_fzf() {
    cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" )" && code
}

# find-in-file(s)
function fif() {
	if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
	rg --ignore-case --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 8 '$1' || rg --ignore-case --pretty --context 8 '$1' {}" --preview-window=right:60%
}

# Edit and rerun
function edit_and_run() {
	BUFFER="fc"
	zle accept-line
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

# Home - Navigates to the current root workspace
function git_root() {
	BUFFER="cd $(git rev-parse --show-toplevel || echo ".")"
	zle accept-line
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
#
# --- gh cli goodness ---
# select and go to gh issue on web
ghi() {
  local item
  item=$(gh issue list | fzf | awk '{print $1}')
  gh issue view $item --web
}

# select from all PRs and view in vim
ghpr() {
  local prid
  prid=$(gh pr list -L100 | fzf | cut -f1)
  if [[ -n $prid ]]
  then
    gh pr view $prid --web
  fi
}

# select from PRs needing my review and view in vim
ghprr() {
  local prid
  prid=$(gh pr list -L100 --search "is:open is:pr review-requested:@me" | fzf | cut -f1)
  if [[ -n $prid ]]
  then
    gh pr view $prid --web
  fi
}

# view GH issue in browser
ghib() {
  gh issue view --web $1
}

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
bindkey -s "^o" 'open_code_after_fzf^M'
bindkey -s "^k" 'cd ..^M'
zle -N edit_and_run
bindkey "^e" edit_and_run
zle -N git_root
bindkey "^h" git_root

# User configuration/aliases

alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias nv="neovide &"
alias dnv="devour neovide &"
alias dfeh="devour feh --scale-down --auto-zoom"
alias trm=trash-put
alias trl=trash-list
alias tre=trash-empty
alias cm=command
alias ls='exa -l --git'
alias lst='exa -l --tree --git-ignore'
alias sv="source venv/bin/activate"
alias dv="deactivate"
alias dmpv="devour mpv"

# export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules,.git,venv}"'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --ansi
 --color fg:#d0d0d0,hl:#5f87af
 --color fg+:#d0d0d0,hl+:#5fd7ff
 --color info:#afaf87,prompt:#d7005f,pointer:#af5fff
 --color marker:#87ff00,spinner:#af5fff,header:#87afaf'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey -v
eval spaceship_vi_mode_enable
# export KEYTIMEOUT=1
# # Change cursor shape for different vi modes.
# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]] ||
#      [[ $1 = 'block' ]]; then
#     echo -ne '\e[1 q'
#   elif [[ ${KEYMAP} == main ]] ||
#        [[ ${KEYMAP} == viins ]] ||
#        [[ ${KEYMAP} = '' ]] ||
#        [[ $1 = 'beam' ]]; then
#     echo -ne '\e[5 q'
#   fi
# }
# zle -N zle-keymap-select
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
neofetch


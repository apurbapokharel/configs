#
# ~/.bashrc
#

[[ $- != *i* ]] && return

export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/configs/runpathfunction:$PATH"
export PATH="$HOME/.local/bin:$PATH"
eval "$(pyenv init -)"

export EDITOR=nvim
export BROWSER=brave
export LC_ALL=en_US.UTF-8
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export TERMINAL="st"

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color fg:#d0d0d0,hl:#5f87af
 --color fg+:#d0d0d0,hl+:#5fd7ff
 --color info:#afaf87,prompt:#d7005f,pointer:#af5fff
 --color marker:#87ff00,spinner:#af5fff,header:#87afaf'

unset use_color safe_term match_lhs sh

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less


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
alias lsa='exa -l -a --git'
alias lst='exa -l --tree --git-ignore'
alias sv="source venv/bin/activate"
alias dv="deactivate"
alias dmpv="devour mpv"

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend
# Fzf 
open_with_fzf() {
    fd -t f -H -I | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&-
}

cd_with_fzf() {
    cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview")"
}

pacs() {
    sudo pacman -Syy $(pacman -Ssq | fzf -m --preview="pacman -Si {}" --bind=space:toggle-preview)
}

fzy() {
    sudo yay -Syy $(yay -Ssq | fzf -m --preview="yay -Si {}" --bind=space:toggle-preview)
}

open_vim_after_fzf() {
    cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" )" && nvim
}

open_code_after_fzf() {
    cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" )" && code
}

# find-in-file(s)
fif() {
	if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
	rg --ignore-case --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 8 '$1' || rg --ignore-case --pretty --context 8 '$1' {}" --preview-window=right:60%
}


# find in files - open in Vim - go to 1st search result
vf() {
	local file
	file=$(fif $1)
	if [[ -n $file ]]
	then
		nvim $file -c /$1 -c 'norm! n zz'
	fi
}

# Home - Navigates to the current root workspace

fzf-git-branch() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=-committerdate |
        grep -v HEAD |
        fzf --height 50% --ansi --no-multi --preview-window right:65% \
            --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
        sed "s/.* //"
}

fzf-git-checkout() {
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

 # Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo
git_current_branch() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch | sed -nr 's/\*\s(.*)/\1/p')

    [[ ! -z "$BRANCH" ]] && echo "$BRANCH"
  fi
}

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

# bind '"\C-s":"sudo-command-line\n"'
bind '"\C-g":"ghcal -u barunslick\n"'
bind '"\C-v":"open_vim_after_fzf\n"'
bind '"\C-o":"open_code_after_fzf\n"'
bind '"\C-k":"cd ..\n"'
bind '"\C-f":"cd_with_fzf\n"'
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
export PATH="$PATH:/home/barunpradhan/scripts"

# Aliases
alias gb='fzf-git-branch'
alias gc='git commit'
alias gc!='git commit --amend'
alias gco='fzf-git-checkout'
alias ga='git add'
alias gd='git diff' 
alias gdc='git diff --cached' 
alias gl='git log'
alias gp='git pull' 
alias gst='git status' 
alias gcb='git checkout -b'
alias glog='git log --oneline --decorate --graph'
alias ggpull='git pull origin "$(git_current_branch)"'
alias ggpush='git push origin "$(git_current_branch)"'
alias gf='git fetch'
alias gfa='git fetch --all'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.oh-my-zsh/plugins/z/z.sh ] && source ~/.oh-my-zsh/plugins/z/z.sh
[ -f ~/.oh-my-zsh/custom/plugins/forgit/forgit.plugin.sh ] && source ~/.oh-my-zsh/custom/plugins/forgit/forgit.plugin.sh
[ -f /usr/share/git/git-prompt.sh ] && source /usr/share/git/git-prompt.sh
. "$HOME/.cargo/env"

PS1='[\e[0;34m\u@\h \W$(__git_ps1 " (%s)")\e[0;37m]\$ '

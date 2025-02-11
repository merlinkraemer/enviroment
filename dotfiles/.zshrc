#p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#ohmyzsh config
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

source $ZSH/oh-my-zsh.sh

# ---------- BEGIN CUSTOM CONFIG ---------- #

# editor settings for ssh
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi


ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
ENABLE_CORRECTION="false"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-vi-mode) 

source $ZSH/oh-my-zsh.sh

#set vim keybinds
bindkey -v
export EDITOR='nvim'

#sehs binds
function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '^K' sesh-sessions
bindkey -M vicmd '^K' sesh-sessions
bindkey -M viins '^K' sesh-sessions
:
# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# -------
# Aliases
# -------
alias l="ls" # List files in current directory
alias ll="ls -al" # List all files in current directory in long list format
alias c="clear"

# ----------------------
# SSH Aliases
# ----------------------
alias sav="ssh merlinkraemer@sav"
alias stu="ssh merlinkraemer@stu"
alias air="ssh merlinkramer@100.107.77.127"
alias allinkl="ssh ssh-w01bb550@w01bb550.kasserver.com"


# ----------------------
# Path Aliases
# ----------------------


# ----------------------
# Config Aliases
# ----------------------
alias zshconfig="nvim ~/dev/enviroment/dotfiles/.zshrc"
alias i3config="nvim ~/dev/enviroment/dotfiles/.config/i3/config"
alias tmuxconfig="nvim ~/dev/enviroment/dotfiles/.tmux.conf"
alias alacrittyconfig="nvim ~/dev/enviroment/dotfiles/.config/alacritty.toml"

# ----------------------
# Git Aliases
# ----------------------
alias gaa='git add .'
alias gcm='git commit -m'
alias gpsh='git push'
alias gss='git status -s'
alias gs='echo ""; echo "*********************************************"; echo -e "   DO NOT FORGET TO PULL BEFORE COMMITTING"; echo "*********************************************"; echo ""; git status'

# Wake-on-Lan alias
alias wol-stu='ssh merlinkraemer@pi "sudo /usr/local/bin/wol.sh" >/dev/null 2>&1'

# Eza (better ls) Alias
# alias ls="eza --icons=always"

unsetopt CORRECT

#:w xterm colors
export TERM=xterm-256color

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Syntax Highlighting
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Auto Suggestions
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

#vim mode
# source "$HOME/zsh-vim-mode/zsh-vim-mode.plugin.zsh"

# export all Applications in /Applications to PATH
export PATH="$HOME/Applications:$PATH"

# export all scripts in ~/.local/scripts to PATH
# PATH="$PATH":"$HOME/.local/scripts/"

DISABLE_MAGIC_FUNCTIONS=true

#add brew to path
[ -d /home/linuxbrew/.linuxbrew ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

#add zoxide to path
eval "$(zoxide init zsh)"

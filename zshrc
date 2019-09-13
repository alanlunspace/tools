#!/usr/bin/env zsh
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THouEME="robbyrussell"
ZSH_THEME="powerlevel9k/powerlevel9k"
# POWERLEVEL9K_MODE='font-hack-nerd-font'

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  django
  docker
  docker-compose
  dotenv
  git
  git-prompt
  pyenv
  zsh-completions
)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# bash autocomplete
autoload -U +X bashcompinit && bashcompinit
source /usr/local/etc/bash_completion.d/*

# zsh-autocomplete
autoload -U +X compinit && compinit

# zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# powerlevel9k
POWERLEVEL9K_MODE='font-hack-nerd-font'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable vcs pyenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
POWERLEVEL9K_COLOR_SCHEME='dark'
POWERLEVEL9K_DIR_HOME_BACKGROUND='darkblue'
POWERLEVEL9K_DIR_HOME_FOREGROUND='cyan'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='darkblue'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='cyan'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='darkblue'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='cyan'
POWERLEVEL9K_DIR_ETC_BACKGROUND='darkblue'
POWERLEVEL9K_DIR_ETC_FOREGROUND='cyan'

# Customization
# Locale
export LC_ALL=en_US.UTF-8

# iTerm2
## Disable tab history sharing across tabs
unsetopt INC_APPEND_HISTORY
unsetopt SHARE_HISTORY

# Path
## Homebrew
export PATH="/usr/local/sbin:$PATH"
# export PATH="/usr/local/opt/openssl/bin:$PATH"
# export PATH="/usr/local/opt/gettext/bin:$PATH"
## getopt
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
## PRE Tool
export PATH="$PATH:$HOME/Git/pre-tool/bin"

# grep
export GREP_OPTIONS='--color=always'
export GREP_COLOR='1;35;40'

# Alias
alias .='source ${HOME}/.zshrc'
alias c=clear
alias grep='grep -r'
alias ip_public='curl https://ipinfo.io/ip'
alias ipc='ipcalc $(ipconfig getifaddr en8)'
alias jwt='pyjwt decode --no-verify ${TOKEN}|jq'
alias l='ls -G'
alias ll='ls -ahlt'
alias lm='ls -aGhlt'
alias msupdate='/Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app/Contents/MacOS/msupdate -i'
alias mtr='sudo /usr/local/sbin/mtr'
alias nmap='sudo nmap'
alias system_update='pip install --upgrade pip && upgrade_oh_my_zsh && brew update && brew upgrade && msupdate && softwareupdate -ai'
alias vi=vim
## Git
alias gc='git commit -v -m '
alias gca='git commit -v -a -m '
alias gl='git log -p'
alias gls='git log -S '
alias gp='git pull'
alias gs='git status'
git config --global pull.rebase true
git config --global rebase.autoStash true

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#!/usr/bin/env zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=1000
export ZSH_AUTOSUGGEST_USE_ASYNC=true

plugins=(
  # colorize
  # django
  # docker
  # docker-compose
  # docker-machine
  # dotenv
  # git
  # git-prompt
  # nmap
  # pyenv
  # vi-mode
  jump
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

# Bash autocomplete
autoload -U +X bashcompinit && bashcompinit
# source /usr/local/etc/bash_completion.d/*

# zsh-autocomplete
autoload -U +X compinit && compinit

# zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Customization
# Locale
export LC_ALL=en_US.UTF-8

# Editor
export EDITOR='vim'

# grep
export GREP_COLORS='1;35;40'

# Git
git config --global pull.rebase true
git config --global rebase.autoStash true
git config --global pager.branch false
git config --global core.editor 'vim'
# git config --global credential.helper osxkeychain

# iTerm2
## Disable tab history sharing across tabs
unsetopt INC_APPEND_HISTORY
unsetopt SHARE_HISTORY

# Functions
function cft() {
  if [ -n $1 ]; then # True if $1 is not empty
    if [ -n $2 ]; then # True if $2 is not empty
      cf t -o $1 -s $2
      if [ $? -eq 0 ]; then
        export ORG=$1
        export SPACE=$2
      fi
    else # $2 is empty
      delimiter='/'
      if test "${1#*$delimiter}" != $1; then  # True if $1 has / character
        ORG_TEST=$(echo $1 | cut -d$delimiter -f1)
        SPACE_TEST=$(echo $1 | cut -d$delimiter -f2)
        cf t -o $ORG_TEST -s $SPACE_TEST
        if [ $? -eq 0 ]; then
          export ORG=$(echo $1 | cut -d$delimiter -f1)
          export SPACE=$(echo $1 | cut -d$delimiter -f2)
        fi
      else # / character is not in $1
        delimiter=':'
        if test "${1#*$delimiter}" != $1; then # True if $1 has : character
          ORG_TEST=$(echo $1 | cut -d$delimiter -f1)
          SPACE_TEST=$(echo $1 | cut -d$delimiter -f2)
          cf t -o $ORG_TEST -s $SPACE_TEST
          if [ $? -eq 0 ]; then # True if / and : are both not be found
            export ORG=$(echo $1 | cut -d$delimiter -f1)
            export SPACE=$(echo $1 | cut -d$delimiter -f2)
          fi
        else # : character is not in $1
          cf t -o $1
          if [ $? -eq 0 ]; then
            export ORG=$1
            export SPACE=""
          fi
        fi
      fi
    fi
  else # $1 is empty
    cf target
  fi
}

function cf-cli-install-plugins() {
  cf install-plugin -f https://github.com/aegershman/cf-report-usage-plugin/releases/download/3.3.2/cf-report-usage-plugin-darwin
  for plugin in app-autoscaler-plugin StackAuditor autopilot blue-green-deploy buildpack-usage cf-targets get-events log-cache mysql open report-users route-lookup service-use top;
  do
    cf 'install-plugin' $plugin -f
  done
}

# Alias
## MacOS
### Security
#### Create the SSH access group
##### dseditgroup -o create -q com.apple.access_ssh
#### Add admin to the above access group
##### dseditgroup -o edit -a admin -t group com.apple.access_ssh
### System preferences
#### Show all open at login items
###### osascript -e 'tell application "System Events" to get the name of every login item'
#### Add open at login item
##### osascript -e 'tell application "System Events" to make login item at end with properties {path:"/path/to/itemname", hidden:false}'
#### Remove open at login item
##### osascript -e 'tell application "System Events" to delete login item $Application_Name'
#### Ref
##### https://hints.macworld.com/article.php?story=20111226075701552
### Dock
#### Show all hidden files in Finder
##### defaults write com.apple.Finder AppleShowAllFiles true; killall Finder
#### Position immutable
##### defaults write com.apple.Dock position-immutable -bool yes; killall Dock
#### Size immutable
##### defaults write com.apple.Dock size-immutable -bool yes; killall Dock
### Reset to default
#### defaults write com.apple.Dock size-immutable -bool no; killall Dock
### BetterTouchTool
#### defaults write com.apple.dock workspaces-edge-delay -float 2.0; killall Dock
### Mac Gatekeeper (blocking unidentified developer application execution)
#### Disable
##### sudo spctl --master-disable
#### Enable
##### sudo spctl --master-enable
#### Freeze security settings
##### sudo defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool NO
### Default editor for files
#### alias -s {json,py,yml,yaml}=vim

## Shell
alias .='source $HOME/.zshrc'
alias a='alias'
alias awk-add="awk '{ total = total + \$1 } END { print total }'"
alias b='exec bash'
alias brew-backup='pushd $HOME/Dropbox && brew bundle dump -f && popd'
alias brew-restore='pushd $HOME/Dropbox && brew bundle && popd'
alias c='clear'
alias curl-performance="curl -s -w \
  'Response Time of %{url_effective}\n\n \
  Lookup Time:\t\t%{time_namelookup}\n \
  Connect Time:\t\t%{time_connect}\n \
  Pre-transfer Time:\t%{time_pretransfer}\n \
  Start-transfer Time:\t%{time_starttransfer}\n\n \
  Total Time:\t\t%{time_total}\n\' -o /dev/null ${URL_HOSTNAME_or_IP_ADDRESS}"
alias cp='cp -v'
alias diff-color='colordiff -pub'
alias diff-pub='f() { diff -pub $1 $2 };f'
alias dig-all='dig +nocmd \$1 any +multiline +noall +answer'
alias datetime2unixtime="date -j -u -f '%a %b %d %T %Z %Y' \"${DATETIME_STRING}\" '+%s'"
alias dock-reposition='killall Dock'
alias enable-mac-security='sudo spctl --master-enable'
alias disable-mac-security='sudo spctl --master-disable && sudo defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool NO'
alias f='find . -name '
alias dd='dd status=progress'
alias declare-function-info='declare -f '
alias g='ggrep -i --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias gr='ggrep -ir --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias ipcalc-interface='ipcalc $(ipconfig getifaddr $INTERFACE)'
alias ip-dhcp-bootp-getpacket='ipconfig getpacket $INTERFACE'
alias j='jump'
alias jwt='pyjwt decode --no-verify $TOKEN|jq'
alias ssh-known-host-delete="ssh-keygen -R $KNOWN_HOST"
alias l='ls -aGhlt'
alias netstat-all='netstat -arn'
alias nslookup-srv='nslookup -type=SRV "_mongodb._tcp.$HOST"'
alias m='mark'
alias mac-unquarantine-application="sudo xattr -r -d com.apple.quarantine $APPLICATION"
alias md5-private-key='f(){openssl rsa -modulus -noout -in $1 | openssl md5; unset -f f; }; f'
alias md5-ssl-cert='f(){openssl x509 -modulus -noout -in $1 | openssl md5; unset -f f; }; f'
alias mongo-get-collection-names='db.getCollectionNames()'
alias ms='marks'
alias msg-read='python3 -m extract_msg --out $HOME/Desktop '
alias msupdate='/Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app/Contents/MacOS/msupdate -i'
alias mtr='sudo /usr/local/sbin/mtr'
alias mv='mv -v'
alias nc-fast='nc -nvzG 1 '
alias nmap='sudo nmap'
alias p='ping'
alias proxy='ssh -D 8080 -q -C -N -f $IP_ADDRESS'
alias public-ip='curl https://ipinfo.io/ip'
alias unixtime2datetime="date -r "
alias screen-capture-as-gif='/Applications/LICEcap.app/Contents/MacOS/licecap'
alias open-smb-ptg-mount-point='open "smb://10.237.249.20/Users"'
alias sort-numeric='sort -g -k$field_number,${field_number}n; # sort field numeric'
alias sed-replace='sed "" -e '
alias sed-replace-inplace='sed -i "" -e '
alias ssl-info='openssl x509 -noout -issuer -subject -dates -in '
alias ssl-validator="echo -n | openssl s_client -showcerts -connect $ext_haproxy:443 -servername $$DOMAIN | openssl x509 -noout -subject -dates"
# npm upgrade error on 9Jan2020
# alias system-update='npm install -g npm && pyenv update && pip install --upgrade pip && upgrade_oh_my_zsh && brew update && brew upgrade && msupdate && softwareupdate -ai'
alias system-update='sudo cp -p $HOME/.bashrc $HOME/.zshrc $HOME/.p10k.zsh $HOME/Dropbox/; \
  cp -rp $HOME/.oh-my-bash $HOME/.oh-my-zsh $HOME/Dropbox/; \
  cp -rp $HOME/Dropbox/Alfred/Alfred.alfredpreferences $HOME; \
  pyenv update && pip3 install --upgrade pip && oh_my_zsh-reinstall; \
  brew update && brew upgrade && brew-backup; \
  sudo /usr/libexec/locate.updatedb; \
  msupdate && softwareupdate -ai && mackup backup -f'
alias oh_my_zsh-reinstall='pushd "$ZSH" && git reset --hard origin/HEAD && upgrade_oh_my_zsh && popd; \
  for plugin in zsh-autosuggestions zsh-completions zsh-syntax-highlighting; do git clone https://github.com/zsh-users/${plugin}.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/${plugin}; done'
alias t='telnet'
alias tailf='tail -f'
alias troute='traceroute -n'
alias v='vagrant'
alias vi='vim -p'
# alias yaml-validator="python3 -c 'import yaml, sys; print(\"Valid YAML file\" if yaml.safe_load(sys.stdin) else \"Invalid YAML file\")'"
alias yaml-validator='f() { $HOME/Dropbox/yaml-validator.py $1; unset -f f; }; f'
alias z='exec zsh'
alias zmv-replace-filename-space-with-underline='autoload zmv $ zmv "* *" "$f:gs/ /_"'

## Git
alias ga='git add'
alias gb='git branch -a'
alias gc='git commit -v -m'
alias git-change-commit-message-before-push='git commit --amend'
alias gcommit-amend='git commit -v -a -m'
alias gd='git diff -a'
alias gdiff-cached='git diff --cached'
alias gdiff-commit-before-push='git diff --stat --patch HEAD origin/master'
alias gdiff-staged='git diff --staged'
alias gdiffword='git diff --word-diff --histogram'
alias ghistory-file='git log --follow -p --'
alias ghistory-full='git log --all --full-history --'
alias gl='git log'
alias glog-diff='git log -p'
alias glg='git log --graph --pretty="%C(green)%h%C(reset) %C(yellow)%s%C(reset) %C(cyan)%an%C(reset) %ad" --date=format:"%d%b%Y"'
alias gco='git checkout'
alias gorigin='git remote show origin'
alias gp='git pull'
alias grestore-staged='git restore --staged'
alias gs='git status'
alias gstash='git stash'
alias gshow='git show'
alias gstash-list='git stash list'
alias gstash-pop='git stash pop'
alias gsearch='git log -S '
alias gupdate-index='git update-index'
alias gupdate-index-permission='git update-index --chmod=+x '

## PCF
alias cfa='cf app $APP'
alias cfbindings='cf ser'
alias cfbuildpacks='cf buildpacks'
alias cfbu='cf buildpack-usage'
alias cfd='cf domains'
alias cfe='cf events $APP'
alias cfenv='cf env $APP'
alias cfh='cf -h -a'
alias cfl='cf logs $APP'
alias cflookup-route='cf lookup-route'
alias cfm='cf marketplace'
alias cfp='cf plugins'
alias cfq='cf quotas'
alias cf-apps-stat='cf curl /v2/apps/$(cf ${APP:-APP} --guid)/stats | jq'
alias cf-apps-ips="cf curl /v2/apps/$(cf ${APP:-APP} --guid)/stats | jq -r '.host'"
alias cfrename-space='cf-mgmt-config rename-space --org=$ORG --space=$SPACE --new-space='
alias cfs='cf service $SERVICE'
alias cfsa='cf service-access'
alias cfsb='cf service-brokers'
alias cfsk='cf service-keys'
alias cfso='cf service-open $SERVICE'
alias cfsq='cf space-quota $SPACE'
alias cfsqs='cf space-quotas'
alias cfss='cf spaces'
alias cfset-space-role='cf set-space-role $USER $ORG $SPACE SpaceDeveloper'
alias cfsu='cf space-users $ORG $SPACE'
alias cftrace='CF_TRACE=true '

## Concourse
alias fbuilds='fly -t ${TARGET:=prod-main} bs'
alias fbuilds-pipeline='fly -t ${TARGET:=prod-main} bs -p $PIPELINE'
alias fget-pipeline='fly -t ${TARGET:=prod-main} gp -p $PIPELINE'
alias fhelp='fly -h'
alias fpipelines='fly -t ${TARGET:=prod-main} ps'
alias fteams='fly -t ${TARGET:=prod-main} teams -d'
alias ftrigger-job='fly -t ${TARGET:=prod-main} tj -j $PIPELINE/$JOB'
alias ftargets='fly targets'
alias fwatch='fly -t ${TARGET:=prod-main} w -j $PIPELINE/$JOB -b $BUILD'

## Watch has to be the last alias for expansion
alias watch='watch -c -d -n 2 ' # watch with alias expansion; eg. watch ll '| grep sth'

## Programming Languages
### pyenv
#### /etc/paths.d/pyenv
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

### NodeJS
export NODE_PATH='/usr/local/lib/node_modules'

### golang
# export GOROOT="$HOME/go"
export GOROOT="/usr/local/opt/go/libexec/"

### Java
#### Show available versions /usr/libexec/java_home -V
#### export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

## Concourse fly command completion
source <(fly completion --shell bash)

# iTerm2
test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh"

# p10k
## To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme

# Path
## Update in /etc/paths.d/*

## Work Specifics
[[ -f "$HOME/.zshrc-Manulife" ]] && source "$HOME/.zshrc-Manulife"

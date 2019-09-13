#!/usr/bin/env zsh

# cron
crontab -l > cron.txt

# brew | brew cask
brew leaves > brew.txt
brew cask list -1 > brew_cask.txt

# Atom plugins
apm list -b > apm.txt

# Python packages
pip freeze > requirement.txt

#!/usr/bin/env zsh

# cron
crontab cron.txt

# brew | brew cask
xargs brew install < brew.txt
xargs brew cask install < brew_cask.txt

# Atom plugins
apm install --packages-file apm.txt

# pip
pip install -r requirement.txt

#!/usr/bin/env zsh
# System
echo "Backing up mas"
mas list > mas.txt

echo "Backing up crontab"
crontab -l > cron.txt

echo "Backing up zsh configs"
cp ~/.zshrc zshrc

echo "Backing up Homebrew packages"
brew leaves > brew.txt
brew list --cask -1 > brew_cask.txt

echo "Backing up Python pip packages"
pip freeze > requirement.txt
pip3 freeze > requirement3.txt

# Text editors
echo "Backing up Vim configs"
cp ~/.vimrc vimrc

# VS code backup with https://github.com/shanalikhan/code-settings-sync

# Atom (Deprecated)
# echo "Backing up Atom plugins"
# apm list -b > apm.txt

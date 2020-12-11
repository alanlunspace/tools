#!/usr/bin/env zsh
# System
echo "Restoring mas"
mas install $(cut -d' ' -f1 mas.txt)

# echo "Restoring crontab"
# crontab cron.txt

echo "Restoring zsh configs"
cp zshrc ~/.zshrc

echo "Reinstalling Homebrew packages"
xargs brew install < brew.txt
xargs brew cask install < brew_cask.txt

echo "Reinstalling Python pip packages"
pip install -r requirement.txt
pip3 install -r requirement3.txt

echo "Restoring Vim configs"
cp vimrc ~/.vimrc

# Atom (Deprecated)
# echo "Restoring Atom packages"
# apm install --packages-file apm.txt

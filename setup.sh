#!/bin/sh

# Clone repo over https
if [ -d ~/.dotfiles ]; then
    echo "dotfiles directory already exists."; exit 1
else
    git clone --recursive https://github.com/bnjmn/dotfiles.git ~/.dotfiles
fi

# Create symlinks
cd ~/.dotfiles
rm -f ~/.vim ~/.vimrc
ln -s $PWD/vim ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc

rm -f ~/.bashrc ~/.bash_profile
ln -s $PWD/bash/bashrc ~/.bashrc
ln -s $PWD/bash/bash_profile ~/.bash_profile

rm -f ~/.gitconfig ~/.gitignore_global
ln -s $PWD/git/gitconfig ~/.gitconfig
ln -s $PWD/git/gitignore_global ~/.gitignore_global

# install vim plugins
vim +BundleInstall! +qall

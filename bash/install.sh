#!/usr/bin/env bash

# this doesn't matter anymore

############# Nice/pretty printing functions ###############
function e_header() { echo -e "\n\033[1m$@\033[0m"; }   ####
function e_success() { echo -e " \033[1;32m✔\033[0m $@"; } #
function e_error() { echo -e " \033[1;31m✖\033[0m $@"; }  ##
function e_arrow() { echo -e " \033[1;33m➜\033[0m $@"; } ###
############################################################

echo -e '\033[1m    install - dotfiles - bnjmn\033[0m' 

if [[ "$1" == "-h" || "$1" == "--help" ]]; then cat <<HELP
Automated Install Script for these dotfiles. 
Run the following command from anywhere:
    curl http://bnjmn.info/dotfiles | sh
Doesn't get much easier than that.
https://github.com/bnjmn/dotfiles
HELP
exit; fi

# =============================================== #
e_header "Installing bnjmn/dotfiles to ~/.dotfiles"



# Make sure git is installed. We're going to need it
e_arrow "Hello Git?"
if [[ ! "$(type -P git)" ]]; then
    e_arrow "Where are you, Git? Install Git"
    sudo apt-get -qq install git-core || e_error "Something's not right. Abort." && exit 1
fi
e_success "Git is installed"

# Home. Can we go home? Yes, please.
cd ~/

# I like having the option to create a clean install if needed.
if [[ -d ~/.dotfiles ]]; then
    e_arrow "\033[1m Take action User.\033[0m ~/.dotfiles already exists."
    read -N 1 -t 5 -p "Clean install? [y/N] " rm_dotfiles; echo
    if [[ "$rm_dotfiles" =~ [Yy] ]]; then
        e_arrow "Removing dotfiles"
        rm -rf ~/.dotfiles
    else
        e_arrow "Keeping current version."
    fi
fi

if [[ ! -d ~/.dotfiles ]]; then
new_dotfiles_install=1
    e_header "Downloading dotfiles"
    git clone --recursive git@github.com:bnjmn/dotfiles.git ~/.dotfiles || e_error "ssh fail. Trying https.\n" &&
        git clone --recursive https://github.com/bnjmn/dotfiles.git ~/.dotfiles
fi

e_success "Great Success! .dotfiles INSTALLED!"
e_arrow "Finalizing with make..."
cd ~/.dotfiles
make install
e_success "Alright. That should do it. Don't forget to have fun."

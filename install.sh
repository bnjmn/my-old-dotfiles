#!/usr/bin/env bash

install_dotfiles () {
    local dotfiles_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

    # Run the symlink script
    . "$dotfiles_dir/script/symlink_dotfiles.sh"

    # Install Vundle.vim
    mkdir -p "$dotfiles_dir/vim/bundle"
    if [ ! -d "$dotfiles_dir/vim/bundle/Vundle.vim" ]; then
        git clone https://github.com/gmarik/Vundle.vim.git "$dotfiles_dir/vim/bundle/Vundle.vim"
    fi

    # Install Vim Plugins
    if hash vim 2>/dev/null; then
        vim +PluginInstall +qall
    else
        echo "Install VIM!"
    fi
}

install_dotfiles

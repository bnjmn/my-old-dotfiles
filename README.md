dotfiles
--------

Requirements:

- `bash`
- `git`
- `vim`

Install these `dotfiles`:

    git clone https://github.com/bnjmn/dotfiles.git ~/.dotfiles
    git clone https://github.com/gmarik/Vundle.vim.git ~/.dotfiles/vim/bundle/Vundle.vim
    cd ~/.dotfiles && ./install.sh && vim +PluginInstall +qall

    # Activate
    . ~/.bashrc

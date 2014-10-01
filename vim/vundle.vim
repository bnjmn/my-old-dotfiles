" ---------------------------------------------------------------------------
" Vundle.vim, Vim Bundle plugin manager, https://github.com/gmarik/Vundle.vim
" ---------------------------------------------------------------------------

" Required by Vundle
" ---------------------------------------------------------------------------

set nocompatible            " be iMproved, required
filetype off                " required (for vundle)

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" ---------------------------------------------------------------------------
" Plugin Bundles - bnjmn
" ---------------------------------------------------------------------------

" github bundles: user/repo
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'jmcantrell/vim-virtualenv'

" On trial
Bundle 'Raimondi/delimitMate'
Bundle 'scrooloose/nerdcommenter'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'AndrewRadev/linediff.vim'

Bundle 'Shougo/neocomplete'

Bundle 'skammer/vim-css-color'

Bundle 'airblade/vim-gitgutter'

Bundle 'bling/vim-airline'

Bundle 'mileszs/ack.vim'

call vundle#end()
filetype plugin indent on   " required; doubled in .vimrc

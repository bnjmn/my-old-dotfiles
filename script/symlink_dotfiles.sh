#!/usr/bin/env bash

RED=$(tput setaf 1; tput bold)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4; tput bold)
MAGENTA=$(tput setaf 5; tput bold)
CYAN=$(tput setaf 6)
NORMAL=$(tput sgr0)

info () { printf "\r\033[2K [ ${CYAN}..${NORMAL} ] $1\n"; }
user () { printf "\r [ ${YELLOW}?${NORMAL} ] $1 "; }
success () { printf "\r\033[2K [ ${GREEN}OK${NORMAL} ] $1\n"; }
fail () { printf "\r\033[2K [${RED}FAIL${NORMAL} $1\n"; echo ''; exit; }

symlink_please () {
    local origin="$1"
    local target="$2"

    action=":"

    if [ -f "$target" -o -d "$target" -o -L "$target" ]; then
        if [ "$overwrite_all" == false ] && [ "$backup_all" == false ] && [ "$skip_all" == false ]
        then
            oh_what_to_do "$origin" "$target"
        fi

        if [ "$overwrite_all" == true ]; then
            action="overwrite"
        fi
        if [ "$backup_all" == true ]; then
            action="backup"
        fi
        if [ "$skip_all" == true ]; then
            action="skip"
        fi

        $action "$origin" "$target"

    else
        make_link "$origin" "$target"
    fi
}

# ACTIONS 
overwrite () {
    local origin="$1" target="$2"
    rm -f "$target"
    success "removed ${RED}$target${NORMAL}"
    make_link "$origin" "$target"
}
backup () {
    local origin="$1" target="$2"
    local backup_target="${target}.backup"
    if [ ! -L "$target" ]; then
        mv --backup=numbered "$target" "$backup_target" &&
        info "Existing ${YELLOW}$(basename "$target")${NORMAL} backed up to $backup_target"
    else
        rm -f "$target" 
    fi
    make_link "$origin" "$target"
}
skip () {
    local origin="$1" target="$2"
    info "skipped ${YELLOW}$(basename "$origin")${NORMAL}"
}
make_link () {
    local origin="$1" target="$2"
    ln -s "$origin" "$target" &&
    success "linked ${GREEN}$(basename "$origin")${NORMAL} to $target"
}


oh_what_to_do () {
    local origin="$1" target="$2"

    user "Existing:${NORMAL} ${YELLOW}$(basename "$target")${NORMAL}, \
[b]ackup, [s]kip, [o]verwrite, [B]ackup all, [S]kip all, [O]verwrite all?"
    read -n 1 selection

    case "$selection" in
        o ) action="overwrite";;
        O ) overwrite_all=true;;
        b ) action="backup";;
        B ) backup_all=true;;
        s ) action="skip";;
        S ) skip_all=true;;
        x ) echo ''; exit;;
        * ) info "No comprendo..."; oh_what_to_do "$origin" "$target"; return ;;
    esac
}


symlink_all () {
    info "${BLUE}  ... ... ... ... ... ...${NORMAL}"
    info "Symlinking all the dotfiles"
    info "${BLUE}  ... ... ... ... ... ...${NORMAL}"

    local script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    local dotfiles_dir="$(dirname $script_dir)"

    # These must be initialized to false
    local overwrite_all=false
    local backup_all=false
    local skip_all=false

    ###################################################
    # Declare (file|dir) relative to ~/.dotfiles here #
    ###################################################
    local dotfiles=( 
        vim
        bash/bashrc
        bash/bash_profile
        git/gitconfig
        git/gitignore_global
        tmux/tmux.conf 
    )

    local target_dir="$HOME"
    for dot in "${dotfiles[@]}"
    do
        local origin="$dotfiles_dir/$dot"
        local target="$target_dir/.$(basename "$dot")"
        symlink_please "$origin" "$target"
    done
    success "Process complete."
}

symlink_all

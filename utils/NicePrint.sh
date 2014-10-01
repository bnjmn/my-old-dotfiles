#!/bin/bash

# Logging stuff.
function e_header() { echo -e "\n\033[1m$@\033[0m"; }
function e_success() { echo -e " \033[1;32m✔\033[0m $@"; }
function e_error() { echo -e " \033[1;31m✖\033[0m $@"; }
function e_arrow() { echo -e " \033[1;33m➜\033[0m $@"; }

# ===============================================

e_header "This is a header!"
e_success "Success message"
e_error "Error message"
e_arrow "An arrow message"

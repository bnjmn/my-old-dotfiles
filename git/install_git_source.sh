#!/bin/sh
# Install git from source
# alternatively on Ubuntu: apt-get install git

INSTALL_DIR="tmp-git-install"
GIT_VERSION="git-1.8.4.1"

# Dependencies
# sudo apt-get install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev build-essential

mkdir ~/$INSTALL_DIR || (echo "Can't create tmp dir. Check ~/$INSTALL_DIR"; exit 1)
cd ~/$INSTALL_DIR 

wget "https://git-core.googlecode.com/files/$GIT_VERSION.tar.gz"
tar -zxf ~/$INSTALL_DIR/$GIT_VERSION.tar.gz

cd $GIT_VERSION || (echo "Cannot access source code directory."; exit 1)
make prefix=/usr/local all
sudo make prefix=/usr/local install

# clean up
echo "Clean up. Removing install directory."
rm -r ~/$INSTALL_DIR

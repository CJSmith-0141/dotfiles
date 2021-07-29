#!/usr/bin/env bash
echo "installing various things . . ."

sudo apt-get -y update
sudo apt-get -y install neovim

curl https://sh.rustup.rs -sSf | sh -s -- -y

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

gpg --keyserver keyserver.ubuntu.com --recv 0x175751A488C14868

nvim --headless +PlugInstall +qall
nvim --headless +PlugUpdate +qall

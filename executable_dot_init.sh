#!/usr/bin/env bash
echo "installing various things . . ."

sudo apt-get -y install software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get -y update
sudo apt-get -y install neovim 
sudo apt-get -y install cmake
sudo apt-get -y install python-dev python-pip python3-dev python3-pip
sudo apt-get -y install zsh 

chsh -d $(which zsh)

curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

curl https://sh.rustup.rs -sSf | sh -s -- -y

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

gpg --keyserver keyserver.ubuntu.com --recv 0x175751A488C14868

nvim --headless +PlugInstall +qall
nvim --headless +PlugUpdate +qall

git clone https://github.com/jandamm/zgenom.git
git clone git@github.com:unixorn/zsh-quickstart-kit.git

pushd . 
cd zsh-quickstart-kit
stow --target=$HOME zsh

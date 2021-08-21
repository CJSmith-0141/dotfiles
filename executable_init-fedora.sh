#! /usr/bin/bash
sudo dnf -y upgrade --refresh
sudo dnf -y group install "Development Tools"
sudo dnf -y install cmake curl wget openssl openssl-lib openssl-devel
sudo dnf -y install python3 python3-devel
sudo dnf -y install stow
sudo dnf -y install zsh

curl https://sh.rustup.rs -sSf | sh -s -- -y

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/neovim/neovim.git ~/neovim
git clone https://github.com/jandamm/zgenom.git
git clone https://github.com/unixorn/zsh-quickstart-kit.git
git clone https://github.com/alacritty/alacritty.git

gpg --keyserver keyserver.ubuntu.com --recv 0x175751A488C14868

# install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# install gcloud 
sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el8-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
sudo dnf install google-cloud-sdk

# install terraform and packer
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager -y --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf -y install terraform packer

# install docker-ce 
sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf install docker-ce docker-ce-cli containerd.io

sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo systemctl start docker
sudo groupadd docker
sudo usermod -aG docker $USER


# install zsh quickstart
pushd . 
cd zsh-quickstart-kit

stow --target=$HOME zsh
popd

mv p10k.remote.zsh ~/.p10k.zsh


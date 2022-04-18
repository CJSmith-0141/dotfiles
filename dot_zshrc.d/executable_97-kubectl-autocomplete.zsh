#!/bin/zsh
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
source <(kubectl completion zsh)
alias k=kubectl
complete -F __start_kubectl k

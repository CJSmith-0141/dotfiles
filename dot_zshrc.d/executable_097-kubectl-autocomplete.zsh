#!/bin/zsh
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
source <(kubectl completion zsh)
alias k=kubectl
alias kdev='kubectl -n dev'
alias kprod='kubectl -n prod'
complete -F __start_kubectl k
complete -F __start_kubectl kdev
complete -F __start_kubectl kprod

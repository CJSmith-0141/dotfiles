#! /usr/bin/zsh
statusOut=""
if nordvpn status | grep -q "VPN: Connected"
    then statusOut="${statusOut}Work VPN Connected | $(nordvpn status |grep Gateway |sed -n 's/Gateway: //p') "
    else statusOut=$statusOut"Work VPN Offline 🔓"
fi

echo $statusOut

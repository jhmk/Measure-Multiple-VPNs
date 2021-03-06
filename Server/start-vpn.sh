# create file VPNLOGIN.pass with your VPN Provider credentials

#!/bin/bash

# fetch ip address and default gateway.
ip=$( ip addr show dev eth0 |grep "inet " | awk '{print $2}' | cut -d '/' -f 1 )
# default gateway.
dgw=$( ip route |grep "default via " | awk '{print $3}')

ip rule | grep -q "from $ip" || sudo ip rule add from $ip table vpn
ip rule | grep -q 0x1 || sudo ip rule add fwmark 0x1 lookup vpn && sudo ip rule add to 172.16.0.0/12 table vpn
ip route show table vpn |grep -q $dgw || sudo ip route add default via $dgw table vpn && ip route add 172.31.16.0/20 dev eth0 src $ip table vpn

#VPN OVPNs
ovpn=$(find * -type f -name "*.ovpn")

while true; do # Entering one infinite loop
	for conf in $ovpn; do
	timeout $(( 24*3600 ))	sudo openvpn --ping restart --config $conf --auth-user-pass VPNLOGIN.pass --dev tunVPN --script-security 2
	done
done

#!/bin/bash
#
# Make sure iptables is setup by VPN server
sleep 60

# Change this variable to match your private network.
PRIVATE_NETWORK="192.168.10.0/24"
#
# Change this variable to match your public interface - either eth0 or eth1
PUBLIC_NIC="eth0"

# Set PATH to find iptables
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/syno/sbin:/usr/syno/bin

# iptable binary
IPTABLES="iptables"

start() {
	# Log execution time
	date

	# Make sure packet forwarding is enabled.
	echo 1 > /proc/sys/net/ipv4/ip_forward

	# Turn on NAT on the public interface.
	"${IPTABLES}" -t nat -A POSTROUTING -s "${PRIVATE_NETWORK}" -j MASQUERADE -o "${PUBLIC_NIC}"
	RV=$?
	[[ "${RV}" == "0" ]] || {
		echo >&2 "Error: MASQUERADE rules could not be added."
		exit 1
	}

	# Log current nat table
	iptables -L -v -t nat
}

case "$1" in
	start)
		start
		exit
		;;
	*)
		# Help message.
		echo "Usage: $0 start"
		exit 1
		;;
esac


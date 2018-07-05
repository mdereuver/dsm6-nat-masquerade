**Make NAT/MASQUERADE work on Synology DSM 6 NAS with 2 nic's**

For some reason Synology has a special look at iptables....

Let Synology setup iptables by install an configure a VPN server. You don't need to use it, but installing an configure a basic PPTP VPN server, iptables wil be set up for you.

After that open a ssh connection as root with your NAS and check with: <b>iptables -L -v -t nat</b> if it is working. You wil see somthing like:
```
Chain PREROUTING (policy ACCEPT 4984 packets, 356K bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain INPUT (policy ACCEPT 812 packets, 107K bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain OUTPUT (policy ACCEPT 53330 packets, 3771K bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain POSTROUTING (policy ACCEPT 53330 packets, 3771K bytes)
 pkts bytes target     prot opt in     out     source               destination         
57541 4022K DEFAULT_POSTROUTING  all  --  any    any     anywhere             anywhere            

Chain DEFAULT_POSTROUTING (1 references)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 MASQUERADE  all  --  any    any     10.0.0.0/24          anywhere
```
Now place script file <b>iptables_nat.sh</b> in /usr/local/etc/rc.d/ The script will be run at startup and not oveerwritten by a DSM update.

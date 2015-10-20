#!/bin/bash

########################
# Autor: Eduardo Andrade
########################

# Link Internet
externa="eth2"

# Rede Interna
interna="eth0"

            /sbin/depmod -a
            /sbin/modprobe ip_tables
            /sbin/modprobe ip_conntrack
            /sbin/modprobe ip_conntrack_ftp
            /sbin/modprobe ip_conntrack_irc
            /sbin/modprobe iptable_nat
            /sbin/modprobe ip_nat_ftp
            echo "1" > /proc/sys/net/ipv4/ip_forward
            echo "1" > /proc/sys/net/ipv4/ip_dynaddr
            iptables -P INPUT ACCEPT
            iptables -F INPUT
            iptables -P OUTPUT ACCEPT
            iptables -F OUTPUT
            iptables -P FORWARD DROP
            iptables -F FORWARD
            iptables -t nat -F
            iptables -A FORWARD -i $externa -o $interna -m state --state ESTABLISHED,RELATED -j ACCEPT
            iptables -A FORWARD -i $interna -o $externa -j ACCEPT
            iptables -t nat -A POSTROUTING -o $externa -j MASQUERADE
echo " "
echo "          IP_FORWARD"
echo "        `cat /proc/sys/net/ipv4/ip_forward`"
echo " "
echo "          Compartilhamento OK !!!"


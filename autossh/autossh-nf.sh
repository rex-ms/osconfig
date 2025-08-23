#!/bin/bash
IP=$1
autossh -M 2000 -N -f -o "ProxyJump=apple@$IP:22" -D 1080 orange@192.168.1.3

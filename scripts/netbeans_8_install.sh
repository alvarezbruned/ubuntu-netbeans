#!/bin/bash
apt-get install software-properties-common -y
add-apt-repository -y ppa:vajdics/netbeans-installer
apt-get update
apt-get install unzip -y
apt-get install netbeans-installer -y

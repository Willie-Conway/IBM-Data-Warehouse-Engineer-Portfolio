#!/bin/bash

# network_info.sh - A script to display hostname, IP address, and network configuration

LOGFILE="network_report.log"

echo "🖥️  Gathering Network Information..." | tee $LOGFILE
echo "--------------------------------------" | tee -a $LOGFILE

# 1. Hostname
echo -e "\n📛 Hostname:" | tee -a $LOGFILE
hostname | tee -a $LOGFILE

# 2. IP Address
echo -e "\n🌐 IP Address:" | tee -a $LOGFILE
hostname -i | tee -a $LOGFILE

# 3. Check if 'ip' command is available
if ! command -v ip &> /dev/null; then
    echo -e "\n⚠️  'ip' command not found. Attempting to install 'iproute2'..." | tee -a $LOGFILE
    sudo apt update && sudo apt install -y iproute2
fi

# 4. Full network interface configuration
echo -e "\n🧰 Full Network Interface Configuration (ip a):" | tee -a $LOGFILE
ip a | tee -a $LOGFILE

# 5. Ethernet adapter configuration (eth0 or detect alternative)
ETH_IF=$(ip -o link show | awk -F': ' '{print $2}' | grep -E '^(eth0|en|ens|eno)' | head -n 1)

if [ -n "$ETH_IF" ]; then
    echo -e "\n📡 Ethernet Adapter Configuration ($ETH_IF):" | tee -a $LOGFILE
    ip addr show "$ETH_IF" | tee -a $LOGFILE
else
    echo -e "\n⚠️  Ethernet adapter not found (eth0/ens/eno)." | tee -a $LOGFILE
fi

echo -e "\n✅ Network information saved to $(pwd)/$LOGFILE"


# Instructions:

# Save the script as network_info.sh in your desired directory.

# Make it executable:

# chmod +x network_info.sh

# Run the script:

# ./network_info.sh

# This script will:

# Detect your hostname and IP address

# Check if the ip command exists and install it if missing

# Automatically find and display the main Ethernet interface if available

# Save all output to network_report.log
#!/bin/bash

# network_connectivity_test.sh - Show system network info and test connectivity

LOGFILE="network_connectivity_report.log"

echo "🌐 Network Connectivity Test Report" | tee $LOGFILE
echo "--------------------------------------" | tee -a $LOGFILE

# 1. Hostname
echo -e "\n📛 Hostname:" | tee -a $LOGFILE
hostname | tee -a $LOGFILE

# 2. IP Address
echo -e "\n🌍 IP Address:" | tee -a $LOGFILE
hostname -i | tee -a $LOGFILE

# 3. Full network configuration
echo -e "\n🧰 Network Interfaces (ip a):" | tee -a $LOGFILE
ip a | tee -a $LOGFILE

# 4. Connectivity Test - Ping Google
echo -e "\n📡 Pinging www.google.com (5 times):" | tee -a $LOGFILE
ping -c 5 www.google.com | tee -a $LOGFILE

# 5. Result Summary
if [ $? -eq 0 ]; then
    echo -e "\n✅ Internet connectivity confirmed." | tee -a $LOGFILE
else
    echo -e "\n❌ Internet connectivity test failed." | tee -a $LOGFILE
fi

echo -e "\n📁 Report saved to: $(pwd)/$LOGFILE"




# How to Use:

# Create the script file:

# nano network_connectivity_test.sh

# Paste the script, then save (Ctrl+O, Enter) and exit (Ctrl+X).

# Make it executable:

# chmod +x network_connectivity_test.sh

# Run it:

# ./network_connectivity_test.sh
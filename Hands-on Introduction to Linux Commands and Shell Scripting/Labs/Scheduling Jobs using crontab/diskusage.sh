#!/bin/bash
# Script: diskusage.sh
# Purpose: Print current time and disk usage; append to a log file

# Get current timestamp
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print and log
{
  echo "========================================"
  echo "📅 Timestamp: $timestamp"
  echo "💽 Disk Usage:"
  df -h
  echo "========================================"
  echo ""
} >> /home/project/diskusage.log


# How to Use

# Create the file

# In terminal:

# nano /home/project/diskusage.sh

# Paste the code above and save (Ctrl+O → Enter → Ctrl+X)

# Make it executable:

# chmod u+x /home/project/diskusage.sh

# Run it manually (optional test):


# ./diskusage.sh

# Schedule it via crontab -e:


# 0 0 * * * /home/project/diskusage.sh

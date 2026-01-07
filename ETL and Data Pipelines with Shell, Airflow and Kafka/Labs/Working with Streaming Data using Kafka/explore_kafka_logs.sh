#!/bin/bash

# Exercise 5: Explore Kafka directories and log files

# 1. Navigate to Kafka directory
cd kafka_2.13-3.8.0 || {
  echo "Error: Kafka directory not found!"
  exit 1
}

echo "=== Kafka Directory Loaded ==="

# 2. List contents of Kafka installation directory
echo "=== Listing Kafka Root Directory ==="
ls
echo ""

# 3. Explore the KRaft log directory
echo "=== Checking KRaft Combined Logs Directory ==="
LOG_DIR="/tmp/kraft-combined-logs"

if [ -d "$LOG_DIR" ]; then
    echo "Found KRaft log directory at: $LOG_DIR"
else
    echo "KRaft log directory NOT found at $LOG_DIR"
    exit 1
fi

# 4. Explore logs for the 'news' topic
echo "=== Listing logs for topic: news ==="
NEWS_DIR="$LOG_DIR/news-0"

if [ -d "$NEWS_DIR" ]; then
    ls "$NEWS_DIR"
else
    echo "No logs found for topic 'news'. Directory $NEWS_DIR does not exist."
fi




# ✅ How to Use

# 1. Create the script
# nano explore_kafka_logs.sh



# 2. Make it executable
# chmod +x explore_kafka_logs.sh


# 3. Run it
# ./explore_kafka_logs.sh
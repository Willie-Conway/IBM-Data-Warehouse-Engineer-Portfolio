#!/bin/bash

# Exercise 5: Stop Kafka components gracefully

echo "Stopping Kafka server..."
pkill -f kafka.Kafka

echo "Stopping producers..."
pkill -f kafka.console.KafkaConsoleProducer

echo "Stopping consumers..."
pkill -f kafka.console.KafkaConsoleConsumer

echo "All Kafka components have been stopped."

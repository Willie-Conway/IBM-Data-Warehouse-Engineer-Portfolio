#!/usr/bin/env python3
"""
Kafka Python Client Demo
Covers:
- KafkaAdminClient (create topic, describe topic)
- KafkaProducer (send JSON messages)
- KafkaConsumer (consume messages)

Requires:
    pip3 install kafka-python
    Kafka server running at localhost:9092
"""

from kafka.admin import KafkaAdminClient, NewTopic, ConfigResource, ConfigResourceType # type: ignore
from kafka import KafkaProducer, KafkaConsumer # type: ignore
import json
import time

TOPIC_NAME = "bankbranch"
BOOTSTRAP_SERVERS = "localhost:9092"


def create_topic():
    print("\n=== Creating Kafka Topic ===")
    admin_client = KafkaAdminClient(
        bootstrap_servers=BOOTSTRAP_SERVERS,
        client_id='python-admin-client'
    )

    # Create topic object
    topic_list = []
    new_topic = NewTopic(
        name=TOPIC_NAME,
        num_partitions=2,
        replication_factor=1
    )
    topic_list.append(new_topic)

    try:
        admin_client.create_topics(new_topics=topic_list, validate_only=False)
        print(f"Topic '{TOPIC_NAME}' created successfully.")
    except Exception as e:
        print(f"Topic may already exist: {e}")


def describe_topic():
    print("\n=== Describing Topic Configuration ===")
    admin_client = KafkaAdminClient(
        bootstrap_servers=BOOTSTRAP_SERVERS,
        client_id='python-admin-client'
    )

    configs = admin_client.describe_configs(
        config_resources=[ConfigResource(ConfigResourceType.TOPIC, TOPIC_NAME)]
    )

    for resource, config in configs.items():
        print(f"\nTopic: {resource.name}")
        for k, v in config.items():
            print(f"  {k}: {v.value}")


def produce_messages():
    print("\n=== Producing Messages ===")
    producer = KafkaProducer(
        value_serializer=lambda v: json.dumps(v).encode('utf-8'),
        bootstrap_servers=BOOTSTRAP_SERVERS
    )

    messages = [
        {"atmid": 1, "transid": 100},
        {"atmid": 2, "transid": 101}
    ]

    for msg in messages:
        producer.send(TOPIC_NAME, msg)
        print(f"Sent: {msg}")

    producer.flush()
    print("Messages sent.")


def consume_messages():
    print("\n=== Consuming Messages ===")
    consumer = KafkaConsumer(
        TOPIC_NAME,
        bootstrap_servers=BOOTSTRAP_SERVERS,
        auto_offset_reset='earliest'
    )

    print("Waiting for messages...")
    time.sleep(1)

    for msg in consumer:
        print("Received:", msg.value.decode("utf-8"))
        # Stop after receiving both messages
        if b'101' in msg.value:
            break

    consumer.close()


if __name__ == "__main__":
    print("========== Kafka Python Client Demo ==========")
    create_topic()
    describe_topic()
    produce_messages()
    consume_messages()
    print("\n=== Demo Complete ===")



# ✅ How to Run It

# 1. Make sure Kafka is running

# bin/kafka-server-start.sh config/kraft/server.properties

# 2. Install kafka-python

# pip3 install kafka-python

# 3. Run the script

# python3 kafka_python_client_demo.py





# ✅ What This Script Does

# 1. Creates topic bankbranch

# Using:

# KafkaAdminClient()
# NewTopic()

# 2. Describes the topic config

# Equivalent to:

# kafka-topics.sh --describe

# 3. Produces JSON messages

# Equivalent to:

# kafka-console-producer.sh --topic bankbranch

# 4. Consumes all available messages

# Equivalent to:

# kafka-console-consumer.sh --topic bankbranch --from-beginning


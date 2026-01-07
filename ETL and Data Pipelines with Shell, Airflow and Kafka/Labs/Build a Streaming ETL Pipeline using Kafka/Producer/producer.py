import os, time, json, random
from kafka import KafkaProducer # type: ignore

broker = os.environ.get("KAFKA_BROKER","kafka:9092")
topic = os.environ.get("TOPIC","toll")
producer = KafkaProducer(bootstrap_servers=broker,
                         value_serializer=lambda v: json.dumps(v).encode('utf-8'))

vehicle_types = ["car","truck","bus","motorcycle","van"]

def gen_event(i):
    return {
        "timestamp": time.strftime("%Y-%m-%d %H:%M:%S"),
        "vehicle_id": random.randint(1000,9999),
        "vehicle_type": random.choice(vehicle_types),
        "toll_plaza_id": random.randint(1,20)
    }

i=0
while True:
    ev = gen_event(i)
    producer.send(topic, ev)
    print("sent", ev)
    producer.flush()
    i+=1
    time.sleep(1)

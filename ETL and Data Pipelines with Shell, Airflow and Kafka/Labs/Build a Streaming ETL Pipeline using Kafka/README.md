# Kafka → MySQL Streaming ETL (Lab + Production)

This repo contains:

- `lab_run_all.sh` — IBM Skills Network lab automation (KRaft Kafka + downloads).
- `kafka_mysql_stack/` — Docker Compose production-ready stack (Zookeeper, Kafka, MySQL, producer, consumer).

## Lab (use in Theia)

1. Run `chmod +x lab_run_all.sh && ./lab_run_all.sh`
2. Use Theia MySQL UI to get MySQL password & create table `livetolldata` as lab instructs.
3. In new terminals run:
   - `python3 /home/project/toll_traffic_generator.py` (producer)
   - Edit `/home/project/streaming-data-reader.py` with DB credentials, then `python3 /home/project/streaming-data-reader.py` (consumer)

## Production (Docker Compose)

1. `cd kafka_mysql_stack`
2. `docker compose up --build`
3. `docker exec -it kafka_mysql_stack_mysql_1 mysql -uroot -pchangeme -e "USE tolldata; SELECT * FROM livetolldata LIMIT 5;"`

## Files

- `producer/` – simple Python producer
- `consumer/` – Python consumer writes to MySQL
- `docker-compose.yml` – services

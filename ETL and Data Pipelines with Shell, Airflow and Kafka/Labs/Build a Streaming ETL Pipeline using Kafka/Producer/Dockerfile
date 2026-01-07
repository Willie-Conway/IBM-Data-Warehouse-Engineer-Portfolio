# producer/Dockerfile

FROM python:3.10-slim
WORKDIR /app
COPY producer.py /app/producer.py
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
CMD ["python","producer.py"]

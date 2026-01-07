# consumer/Dockerfile

FROM python:3.10-slim
WORKDIR /app
COPY consumer.py /app/consumer.py
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
CMD ["python","consumer.py"]

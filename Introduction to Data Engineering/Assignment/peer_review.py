import csv

# Data - each entry is a tuple (Question, Answer)
data = [
    (
        "There are two types of data repositories – Transactional and Analytical. Transactional systems, also known as Online Transaction Processing (or OLTP) systems, are designed for real-time execution of a large number of database transactions that are taking place simultaneously, typically online. Give two examples of the kind of transactional data for which an OLTP system may be used.",
        """Retail Purchase Transactions: In a retail environment, an OLTP system can handle real-time transactions during customer purchases. When a customer buys items in a store or online, the system records details such as the products purchased, quantities, prices, payment methods, and customer information. These transactions need to be processed quickly to update inventory levels, manage customer orders, and ensure that the data remains current for other activities, such as invoicing and shipping.

Banking Transactions: OLTP systems are also essential in banking applications, where they process numerous financial transactions in real-time. This includes activities like deposits, withdrawals, fund transfers, and loan payments. Each transaction is recorded instantly to maintain accurate account balances, ensure proper funds are available, and keep a detailed log of all actions. Speed and accuracy are crucial for managing customer accounts and preventing errors."""
    ),
    (
        "According to the course material, the architecture of a data platform consists of five layers, each layer responsible for a specific set of tasks. List at least 2 layers in a data platform.",
        """Data Ingestion Layer: This layer is responsible for collecting and importing raw data from various sources into the data platform. It handles the extraction of data from both structured and unstructured sources, such as databases, APIs, logs, or external data providers. This layer may also perform some basic transformations like data cleaning or formatting. The goal is to ensure that data is readily available for further processing and analysis.

Data Storage Layer: Once data is ingested, it needs to be stored in a structured and efficient way for easy retrieval and analysis. The data storage layer typically includes databases, data lakes, or data warehouses. This layer is designed to store large volumes of data, ensure scalability, and provide data durability. Depending on the system, it may support various storage types such as relational databases for structured data or distributed file systems for unstructured data."""
    ),
    (
        "List two factors that you would consider in order to make a decision about the type of data store that meets your organization’s needs for a particular implementation.",
        """Data Structure and Format: One of the key factors in selecting a data store is the type and structure of the data being handled. If the data is highly structured, such as in transactional applications, a relational database (SQL) might be the best choice due to its ability to efficiently manage structured data with predefined schemas. On the other hand, if the data is unstructured or semi-structured (like text, images, or logs), a NoSQL database or data lake may be more appropriate. NoSQL databases such as MongoDB or Cassandra are designed to handle flexible, non-relational data structures.

Scalability and Performance: Another critical factor is the need for scalability and the expected performance requirements. If your organization anticipates handling large volumes of data or high transaction rates, you may require a data store that can scale horizontally (across many servers) and provide low-latency access. In this case, distributed NoSQL databases, cloud data warehouses, or big data solutions like Apache Hadoop or Amazon Redshift might be more suitable compared to traditional SQL databases."""
    ),
]

# Filename for CSV
filename = "data_platform_questions_answers.csv"

# Write to CSV
with open(filename, mode='w', newline='', encoding='utf-8') as file:
    writer = csv.writer(file)
    # Write header
    writer.writerow(["Question", "Answer"])
    
    # Write each question-answer pair
    for question, answer in data:
        writer.writerow([question, answer])

print(f"Data successfully written to {filename}.\n")

# Read back and print to confirm
with open(filename, mode='r', encoding='utf-8') as file:
    reader = csv.reader(file)
    for row in reader:
        print(f"Question:\n{row[0]}\n")
        print(f"Answer:\n{row[1]}\n")
        print("="*80)

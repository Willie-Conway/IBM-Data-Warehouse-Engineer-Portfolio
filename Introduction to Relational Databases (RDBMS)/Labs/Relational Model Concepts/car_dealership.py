# car_dealership.py

class Car:
    def __init__(self, serial_no, model, manufacturer, price):
        self.serial_no = serial_no
        self.model = model
        self.manufacturer = manufacturer
        self.price = price

class Salesperson:
    def __init__(self, salesperson_id, name, phone):
        self.salesperson_id = salesperson_id
        self.name = name
        self.phone = phone

class Sale:
    def __init__(self, sale_id, serial_no, salesperson_id):
        self.sale_id = sale_id
        self.serial_no = serial_no
        self.salesperson_id = salesperson_id

# Tables (relations)
cars = [
    Car("A001", "Model S", "Tesla", 79999),
    Car("A002", "Civic", "Honda", 22000),
    Car("A003", "Mustang", "Ford", 35000),
    Car("A004", "Camry", "Toyota", 27000)
]

salespersons = [
    Salesperson(1, "Alice Johnson", "555-1234"),
    Salesperson(2, "Bob Smith", "555-5678"),
    Salesperson(3, "Charlie Lee", "555-9876")
]

sales = [
    Sale(101, "A001", 1),
    Sale(102, "A002", 2),
    Sale(103, "A003", 1),
    Sale(104, "A002", 3),
    Sale(105, "A004", 2)
]

# Interactive Queries (simulate lab questions)
def lab_summary():
    print("🔍 Car Dealership Lab Summary")
    print(f"Number of relations (tables): {3}")
    print(f"CAR table columns: {['Serial No', 'Model', 'Manufacturer', 'Price']} ➡️ Count: {len(vars(cars[0]))}")
    print(f"SALE table rows (cardinality): {len(sales)}")
    print(f"SALESPERSON table columns (degree): {len(vars(salespersons[0]))}")
    print(f"SALESPERSON attributes: {list(vars(salespersons[0]).keys())}")
    print("✅ All lab questions answered using the simulated data.")

if __name__ == "__main__":
    lab_summary()

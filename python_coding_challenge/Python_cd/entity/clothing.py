# entity/clothing.py
class Clothing:
    def __init__(self, product_id, product_name, description, price, quantity_in_stock, product_type, size, color):
        self.product_id = product_id
        self.product_name = product_name
        self.description = description
        self.price = price
        self.quantity_in_stock = quantity_in_stock
        self.product_type = product_type
        self.size = size
        self.color = color

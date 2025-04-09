class OrderNotFoundException(Exception):
    def __init__(self, message="Order not found in the database."):
        super().__init__(message)

class UserNotFoundException(Exception):
    def __init__(self, message="User not found in the database."):
        super().__init__(message)

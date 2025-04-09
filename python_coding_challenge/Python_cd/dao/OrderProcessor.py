import mysql.connector
from dao.OrderManagementRepository import OrderManagementRepository
from util.DBConnUtil import DBConnUtil
from exception.UserNotFoundException import UserNotFoundException
from exception.OrderNotFoundException import OrderNotFoundException

class OrderProcessor(OrderManagementRepository):

    def __init__(self):
        self.conn = DBConnUtil.get_connection()
        self.cursor = self.conn.cursor(dictionary=True)

    def create_user(self, user):
        self.cursor.execute("SELECT * FROM users WHERE user_id = %s", (user.user_id,))
        if not self.cursor.fetchone():
            self.cursor.execute(
                "INSERT INTO users (user_id, username, password, role) VALUES (%s, %s, %s, %s)",
                (user.user_id, user.username, user.password, user.role)
            )
            self.conn.commit()

    def create_product(self, user, product):
        self.cursor.execute("SELECT * FROM users WHERE user_id = %s AND role = 'Admin'", (user.user_id,))
        if not self.cursor.fetchone():
            raise UserNotFoundException("Admin user not found.")

        self.cursor.execute("SELECT * FROM products WHERE product_id = %s", (product.product_id,))
        if self.cursor.fetchone():
            print("Product already exists.")
            return

        self.cursor.execute(
            "INSERT INTO products (product_id, product_name, description, price, quantity_in_stock, product_type) "
            "VALUES (%s, %s, %s, %s, %s, %s)",
            (product.product_id, product.product_name, product.description,
             product.price, product.quantity_in_stock, product.product_type)
        )

        if product.product_type == "Electronics":
            self.cursor.execute(
                "INSERT INTO electronics (product_id, brand, warranty_period) VALUES (%s, %s, %s)",
                (product.product_id, product.brand, product.warranty_period)
            )
        elif product.product_type == "Clothing":
            self.cursor.execute(
                "INSERT INTO clothing (product_id, size, color) VALUES (%s, %s, %s)",
                (product.product_id, product.size, product.color)
            )

        self.conn.commit()

    def create_order(self, user, product_list):
        self.cursor.execute("SELECT * FROM users WHERE user_id = %s", (user.user_id,))
        if not self.cursor.fetchone():
            self.create_user(user)

        self.cursor.execute("INSERT INTO orders (user_id) VALUES (%s)", (user.user_id,))
        order_id = self.cursor.lastrowid

        for item in product_list:
            self.cursor.execute(
                "INSERT INTO order_items (order_id, product_id, quantity) VALUES (%s, %s, %s)",
                (order_id, item['product_id'], item['quantity'])
            )

        self.conn.commit()
        print(f"Order #{order_id} created for user {user.user_id}")

    def cancel_order(self, user_id, order_id):
        self.cursor.execute("SELECT * FROM users WHERE user_id = %s", (user_id,))
        if not self.cursor.fetchone():
            raise UserNotFoundException()

        self.cursor.execute("SELECT * FROM orders WHERE order_id = %s AND user_id = %s", (order_id, user_id))
        if not self.cursor.fetchone():
            raise OrderNotFoundException()

        self.cursor.execute("DELETE FROM order_items WHERE order_id = %s", (order_id,))
        self.cursor.execute("DELETE FROM orders WHERE order_id = %s", (order_id,))
        self.conn.commit()

    def get_all_products(self):
        self.cursor.execute("SELECT * FROM products")
        return self.cursor.fetchall()

    def get_order_by_user(self, user):
        self.cursor.execute("SELECT * FROM orders WHERE user_id = %s", (user.user_id,))
        orders = self.cursor.fetchall()
        result = []
        for order in orders:
            self.cursor.execute("SELECT * FROM order_items WHERE order_id = %s", (order['order_id'],))
            items = self.cursor.fetchall()
            result.append({'order_id': order['order_id'], 'items': items})
        return result

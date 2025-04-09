from dao.OrderProcessor import OrderProcessor
from entity.user import User
from entity.electronics import Electronics
from entity.clothing import Clothing

def main():
    processor = OrderProcessor()

    while True:
        print("\n===== Order Management System =====")
        print("1. Create User")
        print("2. Create Product")
        print("3. Create Order")
        print("4. Cancel Order")
        print("5. Get All Products")
        print("6. Get Orders by User")
        print("7. Exit")
        choice = input("Enter your choice: ")

        if choice == '1':
            uid = int(input("User ID: "))
            uname = input("Username: ")
            pwd = input("Password: ")
            role = input("Role (Admin/User): ")
            user = User(uid, uname, pwd, role)
            processor.create_user(user)
            print("User created.")

        elif choice == '2':
            uid = int(input("Admin User ID: "))
            user = User(uid, "", "", "Admin")

            pid = int(input("Product ID: "))
            name = input("Product Name: ")
            desc = input("Description: ")
            price = float(input("Price: "))
            qty = int(input("Quantity: "))
            ptype = input("Type (Electronics/Clothing): ")

            if ptype == "Electronics":
                brand = input("Brand: ")
                warranty = int(input("Warranty (months): "))
                product = Electronics(pid, name, desc, price, qty, ptype, brand, warranty)
            elif ptype == "Clothing":
                size = input("Size: ")
                color = input("Color: ")
                product = Clothing(pid, name, desc, price, qty, ptype, size, color)
            else:
                print("Invalid product type!")
                continue

            processor.create_product(user, product)
            print("Product created.")

        elif choice == '3':
            uid = int(input("User ID: "))
            uname = input("Username: ")
            pwd = input("Password: ")
            role = input("Role: ")
            user = User(uid, uname, pwd, role)

            num_items = int(input("Number of products in the order: "))
            products = []
            for _ in range(num_items):
                pid = int(input("Product ID: "))
                qty = int(input("Quantity: "))
                products.append({"product_id": pid, "quantity": qty})

            processor.create_order(user, products)

        elif choice == '4':
            uid = int(input("User ID: "))
            oid = int(input("Order ID: "))
            try:
                processor.cancel_order(uid, oid)
                print("Order cancelled.")
            except Exception as e:
                print(e)

        elif choice == '5':
            products = processor.get_all_products()
            for p in products:
                print(p)

        elif choice == '6':
            uid = int(input("User ID: "))
            uname = input("Username: ")
            pwd = input("Password: ")
            role = input("Role: ")
            user = User(uid, uname, pwd, role)

            orders = processor.get_order_by_user(user)
            for order in orders:
                print(f"Order ID: {order['order_id']}")
                for item in order['items']:
                    print(f"  Product ID: {item['product_id']}, Quantity: {item['quantity']}")

        elif choice == '7':
            print("Exiting Order Management System.")
            break
        else:
            print("Invalid choice. Try again.")

if __name__ == "__main__":
    main()

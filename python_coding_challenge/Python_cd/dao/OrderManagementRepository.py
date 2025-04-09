from abc import ABC, abstractmethod

class OrderManagementRepository(ABC):

    @abstractmethod
    def create_user(self, user):
        pass

    @abstractmethod
    def create_product(self, user, product):
        pass

    @abstractmethod
    def create_order(self, user, product_list):
        pass

    @abstractmethod
    def cancel_order(self, user_id, order_id):
        pass

    @abstractmethod
    def get_all_products(self):
        pass

    @abstractmethod
    def get_order_by_user(self, user):
        pass

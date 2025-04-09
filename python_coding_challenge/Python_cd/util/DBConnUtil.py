import mysql.connector
from util.DBPropertyUtil import DBPropertyUtil

class DBConnUtil:
    @staticmethod
    def get_connection():
        props = DBPropertyUtil.get_connection_string("db.properties")
        conn = mysql.connector.connect(
            host=props["host"],
            user=props["user"],
            password=props["password"],
            database=props["database"]
        )
        return conn

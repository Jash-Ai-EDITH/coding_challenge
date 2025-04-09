import os
import configparser

class DBPropertyUtil:
    @staticmethod
    def get_connection_string(filename):
        config = configparser.ConfigParser()
        # Absolute path to db.properties relative to project root
        full_path = os.path.join(os.path.dirname(__file__), '..', filename)
        config.read(full_path)

        if not config.has_section("mysql"):
            raise Exception("Missing [mysql] section in db.properties")

        return {
            "host": config.get("mysql", "host"),
            "user": config.get("mysql", "user"),
            "password": config.get("mysql", "password"),
            "database": config.get("mysql", "database")
        }

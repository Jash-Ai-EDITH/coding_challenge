import configparser

config = configparser.ConfigParser()
config.read("db.properties")

print("Sections found:", config.sections())

if "mysql" in config:
    print("Host:", config.get("mysql", "host"))
else:
    print("Section [mysql] NOT found.")

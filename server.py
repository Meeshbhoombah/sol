from flask import Flask, request
import sqlite3
import os
import hashlib

app = Flask(__name__)

# Create database in current directory.
path, _ = os.path.split(__file__)
connect = sqlite3.connect(path + '/dns.db', check_same_thread=False)

cursor = connect.cursor()


@app.route('/register-node', methods=['POST'])
def register_node():
    """Register a node to the databse.

    Args:
        url: str -- The node's url.
        location: str -- The node's location.

    Returns: A generated node address.
    """

    # Node to be registered.
    new_node = request.json

    # SQL command to insert new node.
    insert_node = """INSERT INTO nodes VALUES (?, ?)"""
    read_node_address = """SELECT address FROM nodes WHERE url=?"""
    # List of all node addresses joined into one long string.
    # Used to create the new nodes address.

    cursor.execute(insert_node, (new_node['url'], new_node['location']))
    new_node_address = cursor.execute(read_node_address, new_node['url'])
    connect.commit()

    return new_node_address


def create_nodes_table():
    """Create the table that will hold all registered nodes."""
    create_table = """
      CREATE TABLE IF NOT EXISTS nodes (address INTEGER AUTOINCREMENT, url text, location text, address text)
    """

    cursor.execute(create_table)
    connect.commit()


def drop_nodes_table():
    """Drops the table that holds all registered nodes."""
    drop_table = """DROP TABLE IF EXISTS nodes """

    cursor.execute(drop_table)


if __name__ == "__main__":
    create_nodes_table()
    app.run(debug=True)

from flask import Flask, request
import json
import sqlite3
import os
import hashlib

app = Flask(__name__)

path, _ = os.path.split(__file__)
connect = sqlite3.connect('path' + 'dns.db', check_same_thread=False)

cursor = connect.cursor()


@app.route('/register-node', methods=['POST'])
def register_node():
    """Register a node to the databse.

    Args:
        url: str -- The node's url.
        location: str -- The node's location.

    Returns: A generated node address.
    """
    node = request.json

    insert_node = """INSERT INTO nodes VALUES (?, ?, ?)"""
    read_table = """SELECT * FROM nodes"""
    read_node_addresses = """SELECT address FROM nodes"""

    all_node_addresses = "".join(map(str, cursor.execute(read_node_addresses)))

    node_address = hashlib.sha256(all_node_addresses.encode()).hexdigest()
    cursor.execute(insert_node, (node['url'], node_address, node['location']))
    connect.commit()

    return node_address


def create_nodes_table():
    """Create the table that will hold all registered nodes."""
    create_table = """CREATE TABLE IF NOT EXISTS nodes (url text, location text, address text)"""

    cursor.execute(create_table)
    connect.commit()


def drop_nodes_table():
    """Drops the table that holds all registered nodes."""
    drop_table = """DROP TABLE nodes"""

    cursor.execute(drop_table)


if __name__ == "__main__":
    drop_nodes_table()
    create_nodes_table()
    app.run(debug=True)
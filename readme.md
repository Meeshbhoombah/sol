# Simple DNS Server
A Flask server that servers as a registrar for all nodes on the simple blockchain. Allows for 
node's to find other nodes in order to test a distributed network.

## Features
- Register a node
- Find node given an address
- Find nearest node

## To-do
- [ ] Create Flask server
- [ ] Allow a new node to be registered
    - Args = node url, node location
    - Return = a generated node address
    - Save the node url, address, and location to a CSV
- [ ] Find the nearest node given the location of a node
    - Args = node location
    - Return nearest node address


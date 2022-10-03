import socket

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# Binding
server.bind((socket.gethostname, 1234))
# Client Listener
server.listen(5)

# Client Connection List
while True:
    clientsocket, address = server.accept()
    print(f"Connection from {address} has established...")
    clientsocket.send(bytes ("Welcome to the SINGLETHREAD Server", "UTF-8"))
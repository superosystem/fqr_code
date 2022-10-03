import socket

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect((socket.gethostbyname(), 1234))

message = client.recv(1024)
print(message.decode("UTF-8"))
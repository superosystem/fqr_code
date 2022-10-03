from email import message
import socket
from typing import Collection


PORT = 5586
IP = socket.gethostbyname(socket.gethostname())
ADDRS = (IP, PORT)
FORMAT = "UTF-8"
SIZE = 1024
DISCONNECT_MESSAGE = "!DISCONNECT"


def main():
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect(ADDRS)
    print(f"[CONNECTED] Client connected to server at {IP}:{PORT}")

    connected = True
    while connected:
        message = input("> ")
        client.send(message.encode(FORMAT))
        if message == DISCONNECT_MESSAGE:
            connected = False
        else:
            message = client.recv(SIZE).decode(FORMAT)
            print(f"[SEREVR] {message}")


main()

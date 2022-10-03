import socket
from sqlite3 import connect
import threading


# Server Configuration
PORT = 5586
IP = socket.gethostbyname(socket.gethostname())
ADDR = (IP, PORT)
SIZE = 1024
FORMAT = "UTF-8"
DISCONNECT_MESSAGE = "!DISCONNECT"


def handle_client(conn, addr):
    print(f"[OPEN CONNECTION {addr} new connected")

    connected = True
    while connected:
        message = conn.recv(SIZE).decode(FORMAT)
        if message == DISCONNECT_MESSAGE:
            connected = False
        
        print("[{}] {message}")
        message = f"Message received {message}"
        conn.send(message.encode(FORMAT))
    conn.close()


def main():
    print("[STARTING] Server is starting...")
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind(ADDR)
    server.listen()

    while True:
        conn, addr = server.accept()
        thread = threading.Thread(
            Target = handle_client,
            args = (conn, addr)
        )
        thread.start()
        print(f"[ACTIVE CONNTECTIONS] {threading.active_count() - 1}")


main()
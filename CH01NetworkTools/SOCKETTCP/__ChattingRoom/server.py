from datetime import datetime
import socket
import threading

# Data
host = '127.0.0.1'
port = 8080
waktu = datetime.now();
# Server
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind((host, port))
server.listen()
print("[CHAT SERVER] berjalan...")
# Client
clients = []
usernames = []


# Pesan Broadcast
def broadcast(pesan):
    for client in clients:
        client.send(pesan)


# Pesan dari Client
def handle(client):
    while True:
        try:
            # Pesan Broadcast
            pesan = client.recv(1024)
            broadcast(pesan)
        except:
            # Menutup Koneksi Client
            index = clients.index(client)
            clients.remove(client)
            client.close()
            username = usernames[index]
            broadcast('{} keluar!'.format(username).encode('ascii'))
            usernames.remove(username)
            break


# Fungsi R/T
def receive():
    while True:
        # Terima koneksi
        client, address = server.accept()
        print("Terhubung dengan {}".format(str(address)))

        # Username Client
        client.send('NAME'.encode('ascii'))
        username = client.recv(1024).decode('ascii')
        usernames.append(username)
        clients.append(client)

        # Client terhubung
        print("[{}] User : {}".format(waktu, username))
        broadcast("{} bergabung!".format(username).encode('ascii'))
        client.send('Terhubung dengan Server!'.encode('ascii'))

        # Membuat thread
        thread = threading.Thread(target=handle, args=(client,))
        thread.start()

receive()